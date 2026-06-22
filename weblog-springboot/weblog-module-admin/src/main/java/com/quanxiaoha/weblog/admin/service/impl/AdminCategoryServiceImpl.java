package com.quanxiaoha.weblog.admin.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.quanxiaoha.weblog.admin.dao.AdminCategoryDao;
import com.quanxiaoha.weblog.common.domain.dos.ArticleDO;
import com.quanxiaoha.weblog.common.domain.mapper.CategoryMapper;
import com.quanxiaoha.weblog.common.domain.dos.CategoryDO;
import com.quanxiaoha.weblog.admin.model.vo.category.AddCategoryReqVO;
import com.quanxiaoha.weblog.admin.model.vo.category.DeleteCategoryReqVO;
import com.quanxiaoha.weblog.admin.model.vo.category.QueryCategoryPageListReqVO;
import com.quanxiaoha.weblog.admin.model.vo.category.QueryCategoryPageListRspVO;
import com.quanxiaoha.weblog.admin.service.AdminCategoryService;
import com.quanxiaoha.weblog.common.PageResponse;
import com.quanxiaoha.weblog.common.Response;
import com.quanxiaoha.weblog.common.enums.ResponseCodeEnum;
import com.quanxiaoha.weblog.common.model.vo.QuerySelectListRspVO;
import com.quanxiaoha.weblog.common.service.RedisService;  // ← 新增
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.TimeUnit;  // ← 新增
import java.util.stream.Collectors;

/**
 * 分类管理 Service
 */
@Service
@Slf4j
public class AdminCategoryServiceImpl extends ServiceImpl<CategoryMapper, CategoryDO> implements AdminCategoryService {

    @Autowired
    private AdminCategoryDao categoryDao;

    // ========== 新增 Redis 相关 ==========
    @Autowired
    private RedisService redisService;

    private static final String CATEGORY_PAGE_LIST_PREFIX = "weblog:category:page:";
    private static final String CATEGORY_SELECT_LIST_PREFIX = "weblog:category:select:list";
    private static final long CATEGORY_CACHE_TTL = 30; // 30分钟

    // ============================================================
    // 写操作：新增/删除 → 清除缓存
    // ============================================================

    @Override
    public Response addCategory(AddCategoryReqVO addCategoryReqVO) {
        String categoryName = addCategoryReqVO.getName();
        try {
            CategoryDO categoryDO = CategoryDO.builder()
                    .name(categoryName.trim())
                    .createTime(new Date())
                    .updateTime(new Date())
                    .build();
            save(categoryDO);
            // ========== 清除分类缓存 ==========
            evictCategoryCaches();
            log.info("新增分类成功，分类名: {}", categoryName);
            return Response.success();
        } catch (DuplicateKeyException e) {
            log.error("==> 该分类已经存在：{}", categoryName, e);
            return Response.fail(ResponseCodeEnum.DUPLICATE_CATEGORY_ERROR);
        }
    }

    @Override
    public Response deleteCategory(DeleteCategoryReqVO deleteCategoryReqVO) {
        Long categoryId = deleteCategoryReqVO.getCategoryId();
        removeById(categoryId);
        // ========== 清除分类缓存 ==========
        evictCategoryCaches();
        log.info("删除分类成功，categoryId: {}", categoryId);
        return Response.success();
    }

    // ============================================================
    // 读操作：从缓存读取
    // ============================================================

    @Override
    public PageResponse queryCategoryPageList(QueryCategoryPageListReqVO queryCategoryPageListReqVO) {
        Long current = queryCategoryPageListReqVO.getCurrent();
        Long size = queryCategoryPageListReqVO.getSize();
        String categoryName = queryCategoryPageListReqVO.getCategoryName();
        Date startDate = queryCategoryPageListReqVO.getStartDate();
        Date endDate = queryCategoryPageListReqVO.getEndDate();

        // 生成缓存 Key（包含所有查询参数）
        String cacheKey = CATEGORY_PAGE_LIST_PREFIX + current + ":" + size + ":"
                + (categoryName != null ? categoryName : "null") + ":"
                + (startDate != null ? startDate.getTime() : "null") + ":"
                + (endDate != null ? endDate.getTime() : "null");

        // 1. 先从缓存取
        try {
            Object cached = redisService.get(cacheKey);
            if (cached != null) {
                log.info("从缓存获取分类列表，current: {}, size: {}", current, size);
                return (PageResponse) cached;
            }
        } catch (Exception e) {
            log.warn("Redis 读取分类列表失败，降级查数据库", e);
        }

        // 2. 缓存未命中，查数据库
        Page<CategoryDO> page = new Page<>(current, size);
        QueryWrapper<CategoryDO> wrapper = new QueryWrapper<>();

        wrapper.lambda()
                .like(Objects.nonNull(categoryName), CategoryDO::getName, categoryName)
                .ge(Objects.nonNull(startDate), CategoryDO::getCreateTime, startDate)
                .le(Objects.nonNull(endDate), CategoryDO::getCreateTime, endDate)
                .orderByDesc(CategoryDO::getCreateTime);

        Page<CategoryDO> categoryDOPage = page(page, wrapper);

        List<CategoryDO> categoryDOS = categoryDOPage.getRecords();
        List<QueryCategoryPageListRspVO> queryCategoryPageListRspVOS = null;
        if (!CollectionUtils.isEmpty(categoryDOS)) {
            queryCategoryPageListRspVOS = categoryDOS.stream()
                    .map(p -> QueryCategoryPageListRspVO.builder()
                            .id(p.getId())
                            .name(p.getName())
                            .createTime(p.getCreateTime())
                            .build())
                    .collect(Collectors.toList());
        }

        PageResponse pageResponse = PageResponse.success(categoryDOPage, queryCategoryPageListRspVOS);

        // 3. 写入缓存（30分钟过期）
        try {
            redisService.set(cacheKey, pageResponse, CATEGORY_CACHE_TTL, TimeUnit.MINUTES);
            log.info("分类列表已缓存，current: {}, size: {}", current, size);
        } catch (Exception e) {
            log.warn("Redis 写入分类列表缓存失败", e);
        }

        return pageResponse;
    }

    @Override
    public Response queryCategorySelectList() {
        // 1. 先从缓存取
        try {
            Object cached = redisService.get(CATEGORY_SELECT_LIST_PREFIX);
            if (cached != null) {
                log.info("从缓存获取分类下拉列表");
                return Response.success(cached);
            }
        } catch (Exception e) {
            log.warn("Redis 读取分类下拉列表失败，降级查数据库", e);
        }

        // 2. 缓存未命中，查数据库
        List<CategoryDO> categoryDOList = categoryDao.selectAllCategory();
        List<QuerySelectListRspVO> list = null;
        if (!CollectionUtils.isEmpty(categoryDOList)) {
            list = categoryDOList.stream()
                    .map(p -> QuerySelectListRspVO.builder()
                            .label(p.getName())
                            .value(p.getId())
                            .build())
                    .collect(Collectors.toList());
        }

        // 3. 写入缓存（30分钟过期）
        try {
            redisService.set(CATEGORY_SELECT_LIST_PREFIX, list, CATEGORY_CACHE_TTL, TimeUnit.MINUTES);
            log.info("分类下拉列表已缓存");
        } catch (Exception e) {
            log.warn("Redis 写入分类下拉列表缓存失败", e);
        }

        return Response.success(list);
    }

    // ============================================================
    // 私有方法：统一清除缓存
    // ============================================================

    /**
     * 清除所有分类缓存
     */
    private void evictCategoryCaches() {
        try {
            // 清除分类分页列表缓存（按前缀批量删除）
            redisService.deleteByPrefix(CATEGORY_PAGE_LIST_PREFIX);
            // 清除分类下拉列表缓存
            redisService.delete(CATEGORY_SELECT_LIST_PREFIX);
            log.info("清除所有分类缓存成功");
        } catch (Exception e) {
            log.warn("清除分类缓存失败", e);
        }
    }
}