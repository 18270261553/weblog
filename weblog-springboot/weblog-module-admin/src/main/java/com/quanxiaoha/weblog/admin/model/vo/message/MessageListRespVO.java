package com.quanxiaoha.weblog.admin.model.vo.message;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MessageListRespVO {
    private Long id;
    private Long userId;
    private String username;
    private String email;
    private String content;
    private Long parentId;
    private Integer status;
    private String ipAddress;
    private Integer likeCount;
    private String createTime;
}