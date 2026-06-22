package com.quanxiaoha.weblog.admin.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.google.common.collect.Lists;
import com.quanxiaoha.weblog.admin.dao.*;
import com.quanxiaoha.weblog.common.domain.dos.*;
import com.quanxiaoha.weblog.admin.model.vo.article.*;
import com.quanxiaoha.weblog.admin.service.AdminArticleService;
import com.quanxiaoha.weblog.common.Response;
import com.quanxiaoha.weblog.common.constant.RedisKeyConstants;
import com.quanxiaoha.weblog.common.service.RedisService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionTemplate;
import org.springframework.util.CollectionUtils;

import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@Service
@Slf4j
public class AdminArticleServiceImpl implements AdminArticleService {

    @Autowired
    private AdminArticleDao articleDao;
    @Autowired
    private AdminArticleContentDao articleContentDao;
    @Autowired
    private AdminArticleCategoryRelDao articleCategoryRelDao;
    @Autowired
    private AdminTagDao tagDao;
    @Autowired
    private AdminArticleTagRelDao articleTagRelDao;

    // ========== 新增 Redis 相关 ==========
    @Autowired
    private RedisService redisService;

    private static final String ARTICLE_DETAIL_PREFIX = "weblog:article:detail:";
    private static final String ARTICLE_PAGE_LIST_PREFIX = "weblog:article:page:";
    private static final long ARTICLE_CACHE_TTL = 30; // 30分钟

    private final TransactionTemplate transactionTemplate;

    @Autowired
    public AdminArticleServiceImpl(PlatformTransactionManager transactionManager) {
        this.transactionTemplate = new TransactionTemplate(transactionManager);
    }

    // ============================================================
    // 写操作：发布/更新/删除 → 清除缓存
    // ============================================================

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Response publishArticle(PublishArticleReqVO publishArticleReqVO) {
        boolean isExecuteSuccess = transactionTemplate.execute(status -> {
            ArticleDO articleDO = ArticleDO.builder()
                    .title(publishArticleReqVO.getTitle())
                    .titleImage(publishArticleReqVO.getTitleImage())
                    .description(publishArticleReqVO.getDescription())
                    .build();
            articleDao.insertArticle(articleDO);

            Long articleId = articleDO.getId();

            ArticleContentDO articleContentDO = ArticleContentDO.builder()
                    .articleId(articleId)
                    .content(publishArticleReqVO.getContent())
                    .build();
            articleContentDao.insertArticleContent(articleContentDO);

            ArticleCategoryRelDO articleCategoryRelDO = ArticleCategoryRelDO.builder()
                    .articleId(articleId)
                    .categoryId(publishArticleReqVO.getCategoryId())
                    .build();
            articleCategoryRelDao.insert(articleCategoryRelDO);

            List<String> publishTags = publishArticleReqVO.getTags();
            handleTagBiz(articleId, publishTags);
            return true;
        });

        if (isExecuteSuccess) {
            // ========== 清除文章列表缓存 ==========
            evictArticleListCaches();
            log.info("发布文章成功，已清除文章列表缓存");
        }

        return isExecuteSuccess ? Response.success() : Response.fail();
    }

    // ============================================================
    // 读操作：从缓存读取
    // ============================================================

    @Override
    public Response queryArticleDetail(QueryArticleDetailReqVO queryArticleDetailReqVO) {
        Long articleId = queryArticleDetailReqVO.getArticleId();
        String cacheKey = ARTICLE_DETAIL_PREFIX + articleId;

        // 1. 先从缓存取
        try {
            Object cached = redisService.get(cacheKey);
            if (cached != null) {
                log.info("从缓存获取文章详情，articleId: {}", articleId);
                return Response.success(cached);
            }
        } catch (Exception e) {
            log.warn("Redis 读取文章详情失败，降级查数据库，articleId: {}", articleId, e);
        }

        // 2. 缓存未命中，查数据库
        ArticleDO articleDO = articleDao.queryByArticleId(articleId);
        if (articleDO == null) {
            return Response.fail("文章不存在");
        }

        // 文章内容 判空
        ArticleContentDO articleContentDO = articleContentDao.queryByArticleId(articleId);
        String content = articleContentDO == null ? "" : articleContentDO.getContent();

        // 分类 判空
        ArticleCategoryRelDO articleCategoryRelDO = articleCategoryRelDao.selectByArticleId(articleId);
        Long categoryId = articleCategoryRelDO == null ? null : articleCategoryRelDO.getCategoryId();

        // 标签
        List<ArticleTagRelDO> articleTagRelDOS = articleTagRelDao.selectByArticleId(articleId);
        List<Long> tagIds = CollectionUtils.isEmpty(articleTagRelDOS)
                ? Lists.newArrayList()
                : articleTagRelDOS.stream().map(ArticleTagRelDO::getTagId).collect(Collectors.toList());

        QueryArticleDetailRspVO rsp = QueryArticleDetailRspVO.builder()
                .id(articleDO.getId())
                .title(articleDO.getTitle())
                .titleImage(articleDO.getTitleImage())
                .content(content)
                .categoryId(categoryId)
                .tagIds(tagIds)
                .description(articleDO.getDescription())
                .build();

        // 3. 写入缓存（30分钟过期）
        try {
            redisService.set(cacheKey, rsp, ARTICLE_CACHE_TTL, TimeUnit.MINUTES);
            log.info("文章详情已缓存，articleId: {}", articleId);
        } catch (Exception e) {
            log.warn("Redis 写入文章详情缓存失败，articleId: {}", articleId, e);
        }

        return Response.success(rsp);
    }

    @Override
    public Response queryArticlePageList(QueryArticlePageListReqVO queryArticlePageListReqVO) {
        Long current = queryArticlePageListReqVO.getCurrent();
        Long size = queryArticlePageListReqVO.getSize();
        Date startDate = queryArticlePageListReqVO.getStartDate();
        Date endDate = queryArticlePageListReqVO.getEndDate();
        String searchTitle = queryArticlePageListReqVO.getSearchTitle();

        // 生成缓存 Key（包含所有查询参数）
        String cacheKey = ARTICLE_PAGE_LIST_PREFIX + current + ":" + size + ":"
                + (startDate != null ? startDate.getTime() : "null") + ":"
                + (endDate != null ? endDate.getTime() : "null") + ":"
                + (searchTitle != null ? searchTitle : "null");

        // 1. 先从缓存取
        try {
            Object cached = redisService.get(cacheKey);
            if (cached != null) {
                log.info("从缓存获取文章列表，current: {}, size: {}", current, size);
                return Response.success(cached);
            }
        } catch (Exception e) {
            log.warn("Redis 读取文章列表失败，降级查数据库", e);
        }

        // 2. 缓存未命中，查数据库
        Page<ArticleDO> articleDOPage = articleDao.queryArticlePageList(current, size, startDate, endDate, searchTitle);

        // 3. 写入缓存（30分钟过期）
        try {
            redisService.set(cacheKey, articleDOPage, ARTICLE_CACHE_TTL, TimeUnit.MINUTES);
            log.info("文章列表已缓存，current: {}, size: {}", current, size);
        } catch (Exception e) {
            log.warn("Redis 写入文章列表缓存失败", e);
        }

        return Response.success(articleDOPage);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Response deleteArticle(DeleteArticleReqVO deleteArticleReqVO) {
        Long articleId = deleteArticleReqVO.getArticleId();
        articleDao.deleteById(articleId);
        articleContentDao.deleteByArticleId(articleId);
        articleCategoryRelDao.deleteByArticleId(articleId);
        articleTagRelDao.deleteByArticleId(articleId);

        // ========== 清除缓存 ==========
        evictArticleCaches(articleId);

        log.info("删除文章成功，articleId: {}", articleId);
        return Response.success();
    }

    @Override
    public Response updateArticle(UpdateArticleReqVO updateArticleReqVO) {
        boolean isExecuteSuccess = transactionTemplate.execute(status -> {
            Long articleId = updateArticleReqVO.getId();

            ArticleDO articleDO = ArticleDO.builder()
                    .id(articleId)
                    .title(updateArticleReqVO.getTitle())
                    .titleImage(updateArticleReqVO.getTitleImage())
                    .description(updateArticleReqVO.getDescription())
                    .updateTime(new Date())
                    .build();
            articleDao.updateById(articleDO);

            ArticleContentDO articleContentDO = ArticleContentDO.builder()
                    .articleId(articleId)
                    .content(updateArticleReqVO.getContent())
                    .build();
            articleContentDao.updateByArticleId(articleContentDO);

            articleCategoryRelDao.deleteByArticleId(articleId);
            ArticleCategoryRelDO articleCategoryRelDO = ArticleCategoryRelDO.builder()
                    .articleId(articleId)
                    .categoryId(updateArticleReqVO.getCategoryId())
                    .build();
            articleCategoryRelDao.insert(articleCategoryRelDO);

            articleTagRelDao.deleteByArticleId(articleId);
            List<String> publishTags = updateArticleReqVO.getTags();
            handleTagBiz(articleId, publishTags);
            return true;
        });

        if (isExecuteSuccess) {
            // ========== 清除缓存 ==========
            evictArticleCaches(updateArticleReqVO.getId());
            log.info("更新文章成功，已清除缓存，articleId: {}", updateArticleReqVO.getId());
        }

        return isExecuteSuccess ? Response.success() : Response.fail();
    }

    public void handleTagBiz(Long articleId, List<String> publishTags) {
        List<TagDO> tagDOS = tagDao.selectAll();

        List<String> noExistTags = null;
        List<String> existTags = null;
        if (!CollectionUtils.isEmpty(tagDOS)) {
            List<String> tagIds = tagDOS.stream().map(p -> String.valueOf(p.getId())).collect(Collectors.toList());
            noExistTags = publishTags.stream().filter(p -> !tagIds.contains(p)).collect(Collectors.toList());
            existTags = publishTags.stream().filter(p -> tagIds.contains(p)).collect(Collectors.toList());
        }

        if (!CollectionUtils.isEmpty(noExistTags)) {
            List<ArticleTagRelDO> articleTagRelDOS = Lists.newArrayList();
            noExistTags.forEach(noExistTag -> {
                TagDO tagDO = TagDO.builder()
                        .name(noExistTag)
                        .createTime(new Date())
                        .updateTime(new Date())
                        .build();

                tagDao.insert(tagDO);
                Long tagId = tagDO.getId();

                ArticleTagRelDO articleTagRelDO = ArticleTagRelDO.builder()
                        .articleId(articleId)
                        .tagId(tagId)
                        .build();
                articleTagRelDOS.add(articleTagRelDO);
            });
            articleTagRelDao.insertBatch(articleTagRelDOS);
        }

        if (!CollectionUtils.isEmpty(existTags)) {
            List<ArticleTagRelDO> articleTagRelDOS = Lists.newArrayList();
            existTags.forEach(existTagId -> {
                ArticleTagRelDO articleTagRelDO = ArticleTagRelDO.builder()
                        .articleId(articleId)
                        .tagId(Long.valueOf(existTagId))
                        .build();
                articleTagRelDOS.add(articleTagRelDO);
            });
            articleTagRelDao.insertBatch(articleTagRelDOS);
        }
    }

    // ============================================================
    // 私有方法：统一清除缓存
    // ============================================================

    /**
     * 清除单个文章的缓存
     */
    private void evictArticleCaches(Long articleId) {
        try {
            // 清除文章详情缓存
            redisService.delete(ARTICLE_DETAIL_PREFIX + articleId);
            // 清除文章列表缓存（所有分页）
            evictArticleListCaches();
            log.info("清除文章缓存成功，articleId: {}", articleId);
        } catch (Exception e) {
            log.warn("清除文章缓存失败，articleId: {}", articleId, e);
        }
    }

    /**
     * 清除所有文章列表缓存（按前缀批量删除）
     */
    private void evictArticleListCaches() {
        try {
            redisService.deleteByPrefix(ARTICLE_PAGE_LIST_PREFIX);
            log.info("清除所有文章列表缓存成功");
        } catch (Exception e) {
            log.warn("清除文章列表缓存失败", e);
        }
    }
}