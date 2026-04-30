package com.quanxiaoha.weblog.admin.model.vo.ArticleLike;

import lombok.Data;

import javax.validation.constraints.NotNull;

@Data
public class ArticleLikeReqVO {
    @NotNull(message = "文章ID不能为空")
    private Long articleId;

    private Long userId;
    private String ipAddress;
}