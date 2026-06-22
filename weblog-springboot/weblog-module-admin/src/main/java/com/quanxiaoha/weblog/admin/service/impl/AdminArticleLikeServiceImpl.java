package com.quanxiaoha.weblog.admin.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.quanxiaoha.weblog.admin.model.vo.ArticleLike.ArticleLikeReqVO;
import com.quanxiaoha.weblog.admin.service.AdminArticleLikeService;
import com.quanxiaoha.weblog.common.Response;
import com.quanxiaoha.weblog.common.constant.RedisKeyConstants;
import com.quanxiaoha.weblog.common.domain.dos.ArticleLikeDO;
import com.quanxiaoha.weblog.common.domain.dos.UserDO;
import com.quanxiaoha.weblog.common.domain.mapper.ArticleLikeMapper;
import com.quanxiaoha.weblog.common.domain.mapper.UserMapper;
import com.quanxiaoha.weblog.common.service.RedisService;
import com.quanxiaoha.weblog.utils.SecurityUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.concurrent.TimeUnit;

@Slf4j
@Service
public class AdminArticleLikeServiceImpl implements AdminArticleLikeService {

    @Autowired
    private ArticleLikeMapper articleLikeMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private RedisService redisService;  // ← 新增

    // ===================== Key 常量 =====================
    private static final String ARTICLE_LIKE_COUNT_PREFIX = "weblog:article:like:count:";
    private static final String ARTICLE_USER_LIKED_PREFIX = "weblog:article:liked:";
    private static final long LIKE_CACHE_TTL = 30; // 30分钟

    // ============================================================
    // 写操作：点赞/取消点赞 → 清除缓存
    // ============================================================

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Response likeArticle(ArticleLikeReqVO vo) {
        // 获取用户名 → 查用户ID
        String username = SecurityUtil.getCurrentUsername();
        UserDO user = userMapper.selectOne(new QueryWrapper<UserDO>().eq("username", username));
        if (user == null) return Response.fail("用户不存在");
        Long userId = user.getId();
        Long articleId = vo.getArticleId();

        // 检查是否已点赞
        QueryWrapper<ArticleLikeDO> wrapper = new QueryWrapper<>();
        wrapper.eq("article_id", articleId);
        wrapper.eq("user_id", userId);

        Long count = articleLikeMapper.selectCount(wrapper);
        if (count > 0) {
            return Response.fail("您已点赞");
        }

        // 保存点赞记录
        ArticleLikeDO entity = ArticleLikeDO.builder()
                .articleId(articleId)
                .userId(userId)
                .createTime(LocalDateTime.now())
                .build();
        articleLikeMapper.insert(entity);

        // ========== 清除点赞相关缓存 ==========
        evictLikeCaches(articleId, userId);

        log.info("用户 {} 点赞文章 {} 成功", username, articleId);
        return Response.success("点赞成功");
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Response cancelLikeArticle(ArticleLikeReqVO vo) {
        String username = SecurityUtil.getCurrentUsername();
        UserDO user = userMapper.selectOne(new QueryWrapper<UserDO>().eq("username", username));
        if (user == null) return Response.fail("用户不存在");
        Long userId = user.getId();
        Long articleId = vo.getArticleId();

        QueryWrapper<ArticleLikeDO> wrapper = new QueryWrapper<>();
        wrapper.eq("article_id", articleId);
        wrapper.eq("user_id", userId);
        articleLikeMapper.delete(wrapper);

        // ========== 清除点赞相关缓存 ==========
        evictLikeCaches(articleId, userId);

        log.info("用户 {} 取消点赞文章 {} 成功", username, articleId);
        return Response.success("取消点赞成功");
    }

    // ============================================================
    // 读操作：从缓存读取
    // ============================================================

    @Override
    public Response getLikeCount(ArticleLikeReqVO vo) {
        Long articleId = vo.getArticleId();
        String cacheKey = ARTICLE_LIKE_COUNT_PREFIX + articleId;

        // 1. 先从缓存取
        try {
            Object cached = redisService.get(cacheKey);
            if (cached != null) {
                Long count = Long.valueOf(cached.toString());
                log.debug("从缓存获取文章点赞数，articleId: {}, count: {}", articleId, count);
                return Response.success(count);
            }
        } catch (Exception e) {
            log.warn("Redis 读取点赞数失败，降级查数据库，articleId: {}", articleId, e);
        }

        // 2. 缓存未命中，查数据库
        QueryWrapper<ArticleLikeDO> wrapper = new QueryWrapper<>();
        wrapper.eq("article_id", articleId);
        Long count = articleLikeMapper.selectCount(wrapper);

        // 3. 写入缓存（30分钟过期）
        try {
            redisService.set(cacheKey, count, LIKE_CACHE_TTL, TimeUnit.MINUTES);
        } catch (Exception e) {
            log.warn("Redis 写入点赞数缓存失败，articleId: {}", articleId, e);
        }

        return Response.success(count);
    }

    @Override
    public Response isArticleLiked(ArticleLikeReqVO vo) {
        String username = SecurityUtil.getCurrentUsername();
        UserDO user = userMapper.selectOne(new QueryWrapper<UserDO>().eq("username", username));
        if (user == null) return Response.success(false);

        Long userId = user.getId();
        Long articleId = vo.getArticleId();
        String cacheKey = ARTICLE_USER_LIKED_PREFIX + articleId + ":" + userId;

        // 1. 先从缓存取
        try {
            Object cached = redisService.get(cacheKey);
            if (cached != null) {
                boolean liked = Boolean.parseBoolean(cached.toString());
                log.debug("从缓存获取用户点赞状态，articleId: {}, userId: {}, liked: {}", articleId, userId, liked);
                return Response.success(liked);
            }
        } catch (Exception e) {
            log.warn("Redis 读取点赞状态失败，降级查数据库，articleId: {}, userId: {}", articleId, userId, e);
        }

        // 2. 缓存未命中，查数据库
        QueryWrapper<ArticleLikeDO> wrapper = new QueryWrapper<>();
        wrapper.eq("article_id", articleId);
        wrapper.eq("user_id", userId);
        Long count = articleLikeMapper.selectCount(wrapper);
        boolean liked = count > 0;

        // 3. 写入缓存（30分钟过期）
        try {
            redisService.set(cacheKey, String.valueOf(liked), LIKE_CACHE_TTL, TimeUnit.MINUTES);
        } catch (Exception e) {
            log.warn("Redis 写入点赞状态缓存失败，articleId: {}, userId: {}", articleId, userId, e);
        }

        return Response.success(liked);
    }

    // ============================================================
    // 私有方法：统一清除缓存
    // ============================================================

    /**
     * 清除文章点赞相关缓存
     */
    private void evictLikeCaches(Long articleId, Long userId) {
        try {
            // 清除点赞数缓存
            redisService.delete(ARTICLE_LIKE_COUNT_PREFIX + articleId);
            // 清除用户点赞状态缓存
            redisService.delete(ARTICLE_USER_LIKED_PREFIX + articleId + ":" + userId);
            log.debug("清除点赞缓存成功，articleId: {}, userId: {}", articleId, userId);
        } catch (Exception e) {
            log.warn("清除点赞缓存失败，articleId: {}, userId: {}", articleId, userId, e);
        }
    }
}