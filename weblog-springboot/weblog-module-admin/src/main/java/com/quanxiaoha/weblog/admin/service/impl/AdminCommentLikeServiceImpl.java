package com.quanxiaoha.weblog.admin.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.quanxiaoha.weblog.admin.service.AdminCommentLikeService;
import com.quanxiaoha.weblog.admin.model.vo.comment.CommentLikeReqVO;
import com.quanxiaoha.weblog.common.domain.dos.CommentLikeDO;
import com.quanxiaoha.weblog.common.domain.dos.UserDO;
import com.quanxiaoha.weblog.common.domain.mapper.CommentLikeMapper;
import com.quanxiaoha.weblog.common.domain.mapper.UserMapper;
import com.quanxiaoha.weblog.common.Response;
import com.quanxiaoha.weblog.jwt.utils.SecurityUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
@Slf4j
public class AdminCommentLikeServiceImpl implements AdminCommentLikeService {

    @Autowired
    private CommentLikeMapper commentLikeMapper;

    @Autowired
    private UserMapper userMapper;

    // ===================== 1. 点赞评论 =====================
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Response likeComment(CommentLikeReqVO vo) {
        String username = SecurityUtil.getCurrentUsername();
        UserDO user = userMapper.selectOne(new QueryWrapper<UserDO>().eq("username", username));
        Long userId = user.getId();

        // 查询是否已经点赞
        QueryWrapper<CommentLikeDO> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("comment_id", vo.getCommentId());
        queryWrapper.eq("user_id", userId);

        int count = Math.toIntExact(commentLikeMapper.selectCount(queryWrapper));
        if (count > 0) {
            return Response.fail("您已点赞过");
        }

        // 保存
        CommentLikeDO likeDO = CommentLikeDO.builder()
                .commentId(vo.getCommentId())
                .userId(userId) // 这里用查到的真实ID
                .ipAddress(vo.getIpAddress())
                .createTime(LocalDateTime.now())
                .build();

        commentLikeMapper.insert(likeDO);
        return Response.success("点赞评论成功");
    }

    // ===================== 2. 取消点赞 =====================
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Response cancelLikeComment(CommentLikeReqVO vo) {
        // ========== 你要的逻辑：获取用户名 → 查ID ==========
        String username = SecurityUtil.getCurrentUsername();
        UserDO user = userMapper.selectOne(new QueryWrapper<UserDO>().eq("username", username));
        Long userId = user.getId();

        QueryWrapper<CommentLikeDO> wrapper = new QueryWrapper<>();
        wrapper.eq("comment_id", vo.getCommentId());
        wrapper.eq("user_id", userId);
        commentLikeMapper.delete(wrapper);

        return Response.success("取消评论点赞成功");
    }

    // ===================== 3. 点赞数量（不动） =====================
    @Override
    public Response getCommentLikeCount(Long commentId) {
        QueryWrapper<CommentLikeDO> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("comment_id", commentId);
        Long count = commentLikeMapper.selectCount(queryWrapper);
        return Response.success(count);
    }

    // ===================== 4. 查询是否点赞 =====================
    @Override
    public Response isCommentLiked(Long commentId) {
        // ========== 你要的逻辑：获取用户名 → 查ID ==========
        String username = SecurityUtil.getCurrentUsername();
        UserDO user = userMapper.selectOne(new QueryWrapper<UserDO>().eq("username", username));
        Long userId = user.getId();

        QueryWrapper<CommentLikeDO> wrapper = new QueryWrapper<>();
        wrapper.eq("comment_id", commentId);
        wrapper.eq("user_id", userId);

        Long count = commentLikeMapper.selectCount(wrapper);
        return Response.success(count > 0);
    }
}