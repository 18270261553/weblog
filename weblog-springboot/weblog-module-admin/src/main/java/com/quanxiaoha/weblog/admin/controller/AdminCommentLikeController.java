package com.quanxiaoha.weblog.admin.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.quanxiaoha.weblog.admin.model.vo.ArticleLike.ArticleLikeReqVO;
import com.quanxiaoha.weblog.admin.service.AdminCommentLikeService;
import com.quanxiaoha.weblog.admin.model.vo.comment.CommentLikeReqVO;
import com.quanxiaoha.weblog.common.Response;
import com.quanxiaoha.weblog.common.aspect.ApiOperationLog;
import com.quanxiaoha.weblog.common.domain.dos.ArticleLikeDO;
import com.quanxiaoha.weblog.common.domain.dos.CommentLikeDO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/admin/comment/like")
public class AdminCommentLikeController {

    @Autowired
    private AdminCommentLikeService commentLikeService;

    @PostMapping("/add")
    @ApiOperationLog(description = "评论点赞")
    public Response likeComment(@RequestBody @Validated CommentLikeReqVO vo) {
        return commentLikeService.likeComment(vo);
    }

    @PostMapping("/cancel")
    @ApiOperationLog(description = "取消评论点赞")
    public Response cancelLikeComment(@RequestBody @Validated CommentLikeReqVO vo) {
        return commentLikeService.cancelLikeComment(vo);
    }

    @PostMapping("/count")
    @ApiOperationLog(description = "获取评论点赞数")
    public Response getCommentLikeCount(@RequestBody Long commentId) {
        return commentLikeService.getCommentLikeCount(commentId);
    }
    @PostMapping("/isLike")
    @ApiOperationLog(description = "判断当前用户是否点赞评论")
    public Response isCommentLiked(@RequestBody CommentLikeReqVO vo) {
        return commentLikeService.isCommentLiked(vo.getCommentId());
    }
}