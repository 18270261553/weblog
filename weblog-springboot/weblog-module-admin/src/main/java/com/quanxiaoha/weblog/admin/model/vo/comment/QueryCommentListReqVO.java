package com.quanxiaoha.weblog.admin.model.vo.comment;

import lombok.Data;

import javax.validation.constraints.NotNull;

@Data
public class QueryCommentListReqVO {
    @NotNull(message = "文章ID不能为空")
    private Long articleId;
    private Long current = 1L; // 当前页
    private Long size = 10L;  // 每页条数
}