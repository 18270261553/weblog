package com.quanxiaoha.weblog.admin.service;

import com.quanxiaoha.weblog.admin.model.vo.comment.PublishCommentReqVO;
import com.quanxiaoha.weblog.admin.model.vo.comment.QueryCommentListReqVO;
import com.quanxiaoha.weblog.common.Response;

public interface AdminCommentService {
    Response publishComment(PublishCommentReqVO vo);
    Response queryCommentList(QueryCommentListReqVO vo);
}