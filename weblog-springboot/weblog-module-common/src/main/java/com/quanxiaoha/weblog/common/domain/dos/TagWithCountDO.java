// TagWithCountDO.java
package com.quanxiaoha.weblog.common.domain.dos;

import lombok.Data;

@Data
public class TagWithCountDO {
    private Long id;
    private String name;
    private Integer articleCount;
}