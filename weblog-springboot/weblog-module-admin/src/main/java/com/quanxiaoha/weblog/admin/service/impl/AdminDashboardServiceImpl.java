package com.quanxiaoha.weblog.admin.service.impl;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.quanxiaoha.weblog.admin.dao.AdminArticleDao;
import com.quanxiaoha.weblog.admin.dao.AdminCategoryDao;
import com.quanxiaoha.weblog.admin.dao.AdminTagDao;
import com.quanxiaoha.weblog.admin.dao.AdminStatisticsArticlePVDao;
import com.quanxiaoha.weblog.admin.model.vo.dashboard.QueryDashboardArticleStatisticsRspVO;
import com.quanxiaoha.weblog.admin.model.vo.dashboard.QueryDashboardPVStatisticsRspVO;
import com.quanxiaoha.weblog.admin.service.AdminDashboardService;
import com.quanxiaoha.weblog.common.Response;
import com.quanxiaoha.weblog.common.constant.Constants;
import com.quanxiaoha.weblog.common.domain.dos.ArticleCountDO;
import com.quanxiaoha.weblog.common.domain.dos.StatisticsArticlePVDO;
import com.quanxiaoha.weblog.common.service.RedisService;  // ← 新增
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.TimeUnit;  // ← 新增
import java.util.stream.Collectors;

@Service
@Slf4j
public class AdminDashboardServiceImpl implements AdminDashboardService {

    @Autowired
    private AdminArticleDao articleDao;
    @Autowired
    private AdminCategoryDao categoryDao;
    @Autowired
    private AdminTagDao tagDao;
    @Autowired
    private AdminStatisticsArticlePVDao statisticsArticlePVDao;

    // ========== 新增 Redis 相关 ==========
    @Autowired
    private RedisService redisService;

    private static final String DASHBOARD_ARTICLE_STATISTICS_KEY = "weblog:dashboard:article:statistics";
    private static final String DASHBOARD_PUBLISH_ARTICLE_KEY = "weblog:dashboard:publish:article";
    private static final String DASHBOARD_PV_STATISTICS_KEY = "weblog:dashboard:pv:statistics";
    private static final long DASHBOARD_CACHE_TTL = 10; // 10分钟（统计数据变化慢，可以设置较长缓存）

    // ============================================================
    // 三个统计方法：全部加缓存
    // ============================================================

    @Override
    public Response queryDashboardArticleStatisticsInfo() {
        // 1. 先从缓存取
        try {
            Object cached = redisService.get(DASHBOARD_ARTICLE_STATISTICS_KEY);
            if (cached != null) {
                log.info("从缓存获取仪表盘文章统计信息");
                return Response.success(cached);
            }
        } catch (Exception e) {
            log.warn("Redis 读取仪表盘文章统计失败，降级查数据库", e);
        }

        // 2. 缓存未命中，查数据库
        Long articleTotalCount = articleDao.selectTotalCount();
        Long categoryTotalCount = categoryDao.selectTotalCount();
        Long tagTotalCount = tagDao.selectTotalCount();

        // 总浏览量
        List<StatisticsArticlePVDO> pvCounts = statisticsArticlePVDao.selectAllPVCount();
        Long pvTotalCount = pvCounts.stream().mapToLong(StatisticsArticlePVDO::getPvCount).sum();

        QueryDashboardArticleStatisticsRspVO rsp = QueryDashboardArticleStatisticsRspVO.builder()
                .articleTotalCount(Objects.isNull(articleTotalCount) ? 0 : articleTotalCount)
                .categoryTotalCount(Objects.isNull(categoryTotalCount) ? 0 : categoryTotalCount)
                .tagTotalCount(Objects.isNull(tagTotalCount) ? 0 : tagTotalCount)
                .pvTotalCount(pvTotalCount)
                .build();

        // 3. 写入缓存（10分钟过期）
        try {
            redisService.set(DASHBOARD_ARTICLE_STATISTICS_KEY, rsp, DASHBOARD_CACHE_TTL, TimeUnit.MINUTES);
            log.info("仪表盘文章统计信息已缓存");
        } catch (Exception e) {
            log.warn("Redis 写入仪表盘文章统计缓存失败", e);
        }

        return Response.success(rsp);
    }

    @Override
    public Response queryDashboardPublishArticleStatisticsInfo() {
        // 1. 先从缓存取
        try {
            Object cached = redisService.get(DASHBOARD_PUBLISH_ARTICLE_KEY);
            if (cached != null) {
                log.info("从缓存获取仪表盘文章发布统计信息");
                return Response.success(cached);
            }
        } catch (Exception e) {
            log.warn("Redis 读取仪表盘文章发布统计失败，降级查数据库", e);
        }

        // 2. 缓存未命中，查数据库
        int currYear = LocalDate.now().getYear();
        LocalDate firstDayOfYear = LocalDate.of(currYear, 1, 1);
        String firstDayStr = firstDayOfYear.format(Constants.DATE_TIME_FORMATTER);

        String currDayStr = LocalDate.now().format(Constants.DATE_TIME_FORMATTER);

        List<ArticleCountDO> articleCountDOS = articleDao.selectArticleCount(firstDayStr, currDayStr);

        Map<String, Long> map = null;
        if (!CollectionUtils.isEmpty(articleCountDOS)) {
            Map<String, Long> dateCountMap = articleCountDOS.stream()
                    .collect(Collectors.toMap(ArticleCountDO::getDate, ArticleCountDO::getCount));

            map = Maps.newLinkedHashMap();

            LocalDate currDate = LocalDate.now();
            for (LocalDate date = firstDayOfYear; date.isBefore(currDate) || date.isEqual(currDate); date.plusDays(1)) {
                String key = date.format(Constants.DATE_TIME_FORMATTER);
                map.put(key, Objects.isNull(dateCountMap.get(key)) ? 0L : dateCountMap.get(key));
                date = date.plusDays(1);
            }
        }

        // 3. 写入缓存（10分钟过期）
        try {
            redisService.set(DASHBOARD_PUBLISH_ARTICLE_KEY, map, DASHBOARD_CACHE_TTL, TimeUnit.MINUTES);
            log.info("仪表盘文章发布统计信息已缓存");
        } catch (Exception e) {
            log.warn("Redis 写入仪表盘文章发布统计缓存失败", e);
        }

        return Response.success(map);
    }

    @Override
    public Response queryDashboardPVStatisticsInfo() {
        // 1. 先从缓存取
        try {
            Object cached = redisService.get(DASHBOARD_PV_STATISTICS_KEY);
            if (cached != null) {
                log.info("从缓存获取仪表盘PV统计信息");
                return Response.success(cached);
            }
        } catch (Exception e) {
            log.warn("Redis 读取仪表盘PV统计失败，降级查数据库", e);
        }

        // 2. 缓存未命中，查数据库
        List<StatisticsArticlePVDO> statisticsArticlePVDOS = statisticsArticlePVDao.selectLatestWeekRecords();

        List<String> pvDates = Lists.newArrayList();
        List<Long> pvCounts = Lists.newArrayList();

        LocalDate minus7date = LocalDate.now().minusDays(7);

        for (int i = 1; i < 8; i++) {
            LocalDate plusDate = minus7date.plusDays(i);
            String dateStr = plusDate.format(DateTimeFormatter.ofPattern("MM-dd"));
            pvDates.add(dateStr);
        }

        QueryDashboardPVStatisticsRspVO rsp = QueryDashboardPVStatisticsRspVO.builder()
                .pvDates(pvDates)
                .build();

        if (!CollectionUtils.isEmpty(statisticsArticlePVDOS)) {
            DateFormat dateFormat = new SimpleDateFormat("MM-dd");
            Map<String, Long> pvDateCountMap = statisticsArticlePVDOS.stream()
                    .collect(Collectors.toMap(p -> {
                        Date date = p.getPvDate();
                        return dateFormat.format(date);
                    }, StatisticsArticlePVDO::getPvCount));

            pvDates.forEach(pvDate -> {
                pvCounts.add(Objects.isNull(pvDateCountMap.get(pvDate)) ? 0 : pvDateCountMap.get(pvDate));
            });

            rsp.setPvCounts(pvCounts);
        }

        // 3. 写入缓存（10分钟过期）
        try {
            redisService.set(DASHBOARD_PV_STATISTICS_KEY, rsp, DASHBOARD_CACHE_TTL, TimeUnit.MINUTES);
            log.info("仪表盘PV统计信息已缓存");
        } catch (Exception e) {
            log.warn("Redis 写入仪表盘PV统计缓存失败", e);
        }

        return Response.success(rsp);
    }
}