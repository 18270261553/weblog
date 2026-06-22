package com.quanxiaoha.weblog.admin.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.quanxiaoha.weblog.admin.model.vo.comment.CommentListRespVO;
import com.quanxiaoha.weblog.admin.model.vo.comment.PublishCommentReqVO;
import com.quanxiaoha.weblog.admin.model.vo.comment.QueryCommentListReqVO;
import com.quanxiaoha.weblog.admin.service.AdminCommentService;
import com.quanxiaoha.weblog.common.Response;
import com.quanxiaoha.weblog.common.constant.RedisKeyConstants;
import com.quanxiaoha.weblog.common.domain.dos.CommentDO;
import com.quanxiaoha.weblog.common.domain.dos.CommentLikeDO;
import com.quanxiaoha.weblog.common.domain.dos.UserDO;
import com.quanxiaoha.weblog.common.domain.mapper.CommentLikeMapper;
import com.quanxiaoha.weblog.common.domain.mapper.CommentMapper;
import com.quanxiaoha.weblog.common.domain.mapper.UserMapper;
import com.quanxiaoha.weblog.common.service.RedisService;
import com.quanxiaoha.weblog.utils.SecurityUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

@Service
@Slf4j
public class AdminCommentServiceImpl implements AdminCommentService {

    @Autowired
    private CommentMapper commentMapper;

    @Autowired
    private CommentLikeMapper commentLikeMapper;

    @Autowired
    private UserMapper userMapper;

    // ========== 新增 Redis 相关 ==========
    @Autowired
    private RedisService redisService;

    private static final String COMMENT_PAGE_LIST_PREFIX = "weblog:comment:page:";
    private static final long COMMENT_CACHE_TTL = 30; // 30分钟

    // ============================================================
    // 写操作：发表评论 → 清除缓存
    // ============================================================

    @Override
    public Response publishComment(PublishCommentReqVO vo) {
        CommentDO commentDO = CommentDO.builder()
                .articleId(vo.getArticleId())
                .userId(vo.getUserId())
                .parentId(vo.getParentId() == null ? 0L : vo.getParentId())
                .content(vo.getContent())
                .createTime(java.time.LocalDateTime.now())
                .updateTime(java.time.LocalDateTime.now())
                .isDeleted(0)
                .build();

        commentMapper.insert(commentDO);

        // ========== 清除评论列表缓存 ==========
        evictCommentListCaches();
        log.info("发表评论成功，已清除评论列表缓存，articleId: {}", vo.getArticleId());

        return Response.success("发表评论成功");
    }

    // ============================================================
    // 读操作：从缓存读取
    // ============================================================

    @Override
    public Response queryCommentList(QueryCommentListReqVO vo) {
        Long current = vo.getCurrent();
        Long size = vo.getSize();
        Long articleId = vo.getArticleId();

        // 生成缓存 Key（包含所有查询参数）
        String cacheKey = COMMENT_PAGE_LIST_PREFIX + current + ":" + size + ":"
                + (articleId != null ? articleId : "null");

        // 1. 先从缓存取
        try {
            Object cached = redisService.get(cacheKey);
            if (cached != null) {
                log.info("从缓存获取评论列表，current: {}, size: {}, articleId: {}", current, size, articleId);
                return Response.success(cached);
            }
        } catch (Exception e) {
            log.warn("Redis 读取评论列表失败，降级查数据库", e);
        }

        // 2. 缓存未命中，查数据库
        LambdaQueryWrapper<CommentDO> wrapper = new LambdaQueryWrapper<>();
        if (articleId != null) {
            wrapper.eq(CommentDO::getArticleId, articleId);
        }
        wrapper.orderByDesc(CommentDO::getCreateTime);

        Page<CommentDO> page = new Page<>(current, size);
        Page<CommentDO> commentPage = commentMapper.selectPage(page, wrapper);

        // 3. 组装 VO + 点赞信息
        Long currentUserId = getCurrentLoginUserId();
        List<CommentListRespVO> respList = new ArrayList<>();

        for (CommentDO comment : commentPage.getRecords()) {
            CommentListRespVO respVO = new CommentListRespVO();
            BeanUtils.copyProperties(comment, respVO);

            // 查询点赞数
            long likeNum = commentLikeMapper.selectCount(new LambdaQueryWrapper<CommentLikeDO>()
                    .eq(CommentLikeDO::getCommentId, comment.getId()));

            // 查询是否点赞
            boolean isLiked = false;
            if (currentUserId != null) {
                isLiked = commentLikeMapper.selectCount(new LambdaQueryWrapper<CommentLikeDO>()
                        .eq(CommentLikeDO::getCommentId, comment.getId())
                        .eq(CommentLikeDO::getUserId, currentUserId)) > 0;
            }

            respVO.setLikeNum((int) likeNum);
            respVO.setIsCommentLiked(isLiked);
            respList.add(respVO);
        }

        // 封装分页结果
        Page<CommentListRespVO> resultPage = new Page<>(page.getCurrent(), page.getSize(), page.getTotal());
        resultPage.setRecords(respList);

        // 4. 写入缓存（30分钟过期）
        try {
            redisService.set(cacheKey, resultPage, COMMENT_CACHE_TTL, TimeUnit.MINUTES);
            log.info("评论列表已缓存，current: {}, size: {}, articleId: {}", current, size, articleId);
        } catch (Exception e) {
            log.warn("Redis 写入评论列表缓存失败", e);
        }

        return Response.success(resultPage);
    }

    // ============================================================
    // 私有方法
    // ============================================================

    /**
     * 获取当前登录用户 ID
     */
    private Long getCurrentLoginUserId() {
        try {
            String username = SecurityUtil.getCurrentUsername();
            UserDO user = userMapper.selectOne(new LambdaQueryWrapper<UserDO>()
                    .eq(UserDO::getUsername, username));
            return user == null ? null : user.getId();
        } catch (Exception e) {
            return null;
        }
    }

    /**
     * 清除所有评论列表缓存
     */
    private void evictCommentListCaches() {
        try {
            redisService.deleteByPrefix(COMMENT_PAGE_LIST_PREFIX);
            log.debug("清除所有评论列表缓存成功");
        } catch (Exception e) {
            log.warn("清除评论列表缓存失败", e);
        }
    }
}