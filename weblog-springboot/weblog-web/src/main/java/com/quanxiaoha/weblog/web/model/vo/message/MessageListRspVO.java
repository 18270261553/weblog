package com.quanxiaoha.weblog.web.model.vo.message;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MessageListRspVO {
    private Long id;
    private Long userId;
    private String username;
    private String content;
    private Integer likeCount;
    private String createTime;

    // 子回复列表（楼中楼）
    private List<MessageListRspVO> replies;
}