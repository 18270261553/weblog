package com.quanxiaoha.weblog.admin.service;

import com.quanxiaoha.weblog.admin.model.vo.comment.CommentLikeReqVO;
import com.quanxiaoha.weblog.common.Response;

public interface AdminCommentLikeService {
    Response likeComment(CommentLikeReqVO vo);
    Response cancelLikeComment(CommentLikeReqVO vo);
    Response getCommentLikeCount(Long commentId);
    // 判断是否点赞评论
    Response isCommentLiked(Long commentId);
}