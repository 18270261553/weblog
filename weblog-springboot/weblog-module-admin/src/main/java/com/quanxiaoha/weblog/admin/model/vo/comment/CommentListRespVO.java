package com.quanxiaoha.weblog.admin.model.vo.comment;

import lombok.Data;

import java.time.LocalDateTime;
//评论列表请求查询类
@Data
public class CommentListRespVO {
    private Long id;
    private Long articleId;
    private Long userId;
    private Long parentId;
    private String content;
    private Integer likeNum;
    private Boolean isCommentLiked;
}
