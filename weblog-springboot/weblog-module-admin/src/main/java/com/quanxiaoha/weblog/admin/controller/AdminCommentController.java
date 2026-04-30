package com.quanxiaoha.weblog.admin.controller;

import com.quanxiaoha.weblog.admin.service.AdminCommentService;
import com.quanxiaoha.weblog.admin.model.vo.comment.PublishCommentReqVO;
import com.quanxiaoha.weblog.admin.model.vo.comment.QueryCommentListReqVO;
import com.quanxiaoha.weblog.common.Response;
import com.quanxiaoha.weblog.common.aspect.ApiOperationLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/admin/comment")
public class AdminCommentController {

    @Autowired
    private AdminCommentService commentService;

    @PostMapping("/publish")
    @ApiOperationLog(description = "发表评论")
    public Response publishComment(@RequestBody @Validated PublishCommentReqVO vo) {
        return commentService.publishComment(vo);
    }

    @PostMapping("/list")
    @ApiOperationLog(description = "查询评论列表")
    public Response queryCommentList(@RequestBody QueryCommentListReqVO vo) {
        return commentService.queryCommentList(vo);
    }
}