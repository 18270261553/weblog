package com.quanxiaoha.weblog.admin.model.vo.article;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 用于前台页文章搜索专用
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class QueryIndexArticlePageListReqVO {
    private Long current = 1L;
    private Long size = 10L;
    private String searchKey;
}
