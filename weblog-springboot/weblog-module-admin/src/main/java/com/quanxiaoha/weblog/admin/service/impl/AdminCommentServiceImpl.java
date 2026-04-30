package com.quanxiaoha.weblog.admin.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.quanxiaoha.weblog.admin.model.vo.comment.CommentListRespVO;
import com.quanxiaoha.weblog.admin.model.vo.comment.PublishCommentReqVO;
import com.quanxiaoha.weblog.admin.model.vo.comment.QueryCommentListReqVO;
import com.quanxiaoha.weblog.admin.service.AdminCommentService;
import com.quanxiaoha.weblog.common.domain.dos.CommentDO;
import com.quanxiaoha.weblog.common.domain.dos.CommentLikeDO;
import com.quanxiaoha.weblog.common.domain.dos.UserDO;
import com.quanxiaoha.weblog.common.domain.mapper.CommentLikeMapper;
import com.quanxiaoha.weblog.common.domain.mapper.CommentMapper;
import com.quanxiaoha.weblog.common.domain.mapper.UserMapper;
import com.quanxiaoha.weblog.common.Response;
import com.quanxiaoha.weblog.jwt.utils.SecurityUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
public class AdminCommentServiceImpl implements AdminCommentService {

    @Autowired
    private CommentMapper commentMapper;

    @Autowired
    private CommentLikeMapper commentLikeMapper;

    @Autowired
    private UserMapper userMapper;

    @Override
    public Response publishComment(PublishCommentReqVO vo) {
        // 你的原有代码，不动
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
        return Response.success("发表评论成功");
    }

    @Override
    public Response queryCommentList(QueryCommentListReqVO vo) {
        // 1. 查询评论分页
        LambdaQueryWrapper<CommentDO> wrapper = new LambdaQueryWrapper<>();
        if (vo.getArticleId() != null) {
            wrapper.eq(CommentDO::getArticleId, vo.getArticleId());
        }
        wrapper.orderByDesc(CommentDO::getCreateTime);

        Page<CommentDO> page = new Page<>(vo.getCurrent(), vo.getSize());
        Page<CommentDO> commentPage = commentMapper.selectPage(page, wrapper);

        // 2. 获取当前登录用户 ID
        Long currentUserId = getCurrentLoginUserId();

        // 3. 组装 VO + 点赞信息
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

        // 4. 封装分页结果返回
        Page<CommentListRespVO> resultPage = new Page<>(page.getCurrent(), page.getSize(), page.getTotal());
        resultPage.setRecords(respList);

        return Response.success(resultPage);
    }

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
}