package com.quanxiaoha.weblog.admin.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.quanxiaoha.weblog.admin.model.vo.comment.CommentLikeReqVO;
import com.quanxiaoha.weblog.admin.service.AdminCommentLikeService;
import com.quanxiaoha.weblog.common.Response;
import com.quanxiaoha.weblog.common.constant.RedisKeyConstants;
import com.quanxiaoha.weblog.common.domain.dos.CommentLikeDO;
import com.quanxiaoha.weblog.common.domain.dos.UserDO;
import com.quanxiaoha.weblog.common.domain.mapper.CommentLikeMapper;
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
public class AdminCommentLikeServiceImpl implements AdminCommentLikeService {

    @Autowired
    private CommentLikeMapper commentLikeMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private RedisService redisService;  // ← 新增

    // ===================== Key 常量 =====================
    private static final String COMMENT_LIKE_COUNT_PREFIX = "weblog:comment:like:count:";
    private static final String COMMENT_USER_LIKED_PREFIX = "weblog:comment:liked:";
    private static final long LIKE_CACHE_TTL = 30; // 30分钟

    // ============================================================
    // 写操作：点赞/取消点赞 → 清除缓存
    // ============================================================

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Response likeComment(CommentLikeReqVO vo) {
        String username = SecurityUtil.getCurrentUsername();
        UserDO user = userMapper.selectOne(new QueryWrapper<UserDO>().eq("username", username));
        if (user == null) return Response.fail("用户不存在");
        Long userId = user.getId();
        Long commentId = vo.getCommentId();

        // 查询是否已经点赞
        QueryWrapper<CommentLikeDO> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("comment_id", commentId);
        queryWrapper.eq("user_id", userId);

        int count = Math.toIntExact(commentLikeMapper.selectCount(queryWrapper));
        if (count > 0) {
            return Response.fail("您已点赞过");
        }

        // 保存
        CommentLikeDO likeDO = CommentLikeDO.builder()
                .commentId(commentId)
                .userId(userId)
                .ipAddress(vo.getIpAddress())
                .createTime(LocalDateTime.now())
                .build();

        commentLikeMapper.insert(likeDO);

        // ========== 清除点赞相关缓存 ==========
        evictLikeCaches(commentId, userId);

        log.info("用户 {} 点赞评论 {} 成功", username, commentId);
        return Response.success("点赞评论成功");
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Response cancelLikeComment(CommentLikeReqVO vo) {
        String username = SecurityUtil.getCurrentUsername();
        UserDO user = userMapper.selectOne(new QueryWrapper<UserDO>().eq("username", username));
        if (user == null) return Response.fail("用户不存在");
        Long userId = user.getId();
        Long commentId = vo.getCommentId();

        QueryWrapper<CommentLikeDO> wrapper = new QueryWrapper<>();
        wrapper.eq("comment_id", commentId);
        wrapper.eq("user_id", userId);
        commentLikeMapper.delete(wrapper);

        // ========== 清除点赞相关缓存 ==========
        evictLikeCaches(commentId, userId);

        log.info("用户 {} 取消点赞评论 {} 成功", username, commentId);
        return Response.success("取消评论点赞成功");
    }

    // ============================================================
    // 读操作：从缓存读取
    // ============================================================

    @Override
    public Response getCommentLikeCount(Long commentId) {
        String cacheKey = COMMENT_LIKE_COUNT_PREFIX + commentId;

        // 1. 先从缓存取
        try {
            Object cached = redisService.get(cacheKey);
            if (cached != null) {
                Long count = Long.valueOf(cached.toString());
                log.debug("从缓存获取评论点赞数，commentId: {}, count: {}", commentId, count);
                return Response.success(count);
            }
        } catch (Exception e) {
            log.warn("Redis 读取评论点赞数失败，降级查数据库，commentId: {}", commentId, e);
        }

        // 2. 缓存未命中，查数据库
        QueryWrapper<CommentLikeDO> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("comment_id", commentId);
        Long count = commentLikeMapper.selectCount(queryWrapper);

        // 3. 写入缓存（30分钟过期）
        try {
            redisService.set(cacheKey, count, LIKE_CACHE_TTL, TimeUnit.MINUTES);
            log.debug("评论点赞数已缓存，commentId: {}, count: {}", commentId, count);
        } catch (Exception e) {
            log.warn("Redis 写入评论点赞数缓存失败，commentId: {}", commentId, e);
        }

        return Response.success(count);
    }

    @Override
    public Response isCommentLiked(Long commentId) {
        String username = SecurityUtil.getCurrentUsername();
        UserDO user = userMapper.selectOne(new QueryWrapper<UserDO>().eq("username", username));
        if (user == null) return Response.success(false);

        Long userId = user.getId();
        String cacheKey = COMMENT_USER_LIKED_PREFIX + commentId + ":" + userId;

        // 1. 先从缓存取
        try {
            Object cached = redisService.get(cacheKey);
            if (cached != null) {
                boolean liked = Boolean.parseBoolean(cached.toString());
                log.debug("从缓存获取用户点赞状态，commentId: {}, userId: {}, liked: {}", commentId, userId, liked);
                return Response.success(liked);
            }
        } catch (Exception e) {
            log.warn("Redis 读取用户点赞状态失败，降级查数据库，commentId: {}, userId: {}", commentId, userId, e);
        }

        // 2. 缓存未命中，查数据库
        QueryWrapper<CommentLikeDO> wrapper = new QueryWrapper<>();
        wrapper.eq("comment_id", commentId);
        wrapper.eq("user_id", userId);
        Long count = commentLikeMapper.selectCount(wrapper);
        boolean liked = count > 0;

        // 3. 写入缓存（30分钟过期）
        try {
            redisService.set(cacheKey, String.valueOf(liked), LIKE_CACHE_TTL, TimeUnit.MINUTES);
            log.debug("用户点赞状态已缓存，commentId: {}, userId: {}, liked: {}", commentId, userId, liked);
        } catch (Exception e) {
            log.warn("Redis 写入用户点赞状态缓存失败，commentId: {}, userId: {}", commentId, userId, e);
        }

        return Response.success(liked);
    }

    // ============================================================
    // 私有方法：统一清除缓存
    // ============================================================

    /**
     * 清除评论点赞相关缓存
     */
    private void evictLikeCaches(Long commentId, Long userId) {
        try {
            // 清除点赞数缓存
            redisService.delete(COMMENT_LIKE_COUNT_PREFIX + commentId);
            // 清除用户点赞状态缓存
            redisService.delete(COMMENT_USER_LIKED_PREFIX + commentId + ":" + userId);
            log.debug("清除评论点赞缓存成功，commentId: {}, userId: {}", commentId, userId);
        } catch (Exception e) {
            log.warn("清除评论点赞缓存失败，commentId: {}, userId: {}", commentId, userId, e);
        }
    }
}