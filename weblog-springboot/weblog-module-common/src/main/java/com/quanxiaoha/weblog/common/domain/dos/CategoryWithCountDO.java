// CategoryWithCountDO.java
package com.quanxiaoha.weblog.common.domain.dos;

import lombok.Data;

@Data
public class CategoryWithCountDO {
    private Long id;
    private String name;
    private Integer articleCount;  // 文章数量
}