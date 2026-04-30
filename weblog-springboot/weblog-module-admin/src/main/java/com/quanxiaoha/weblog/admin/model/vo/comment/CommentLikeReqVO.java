package com.quanxiaoha.weblog.admin.model.vo.comment;

import lombok.Data;

import javax.validation.constraints.NotNull;

@Data
public class CommentLikeReqVO {
    @NotNull(message = "评论ID不能为空")
    private Long commentId;

    private Long userId;
    private String ipAddress;
}