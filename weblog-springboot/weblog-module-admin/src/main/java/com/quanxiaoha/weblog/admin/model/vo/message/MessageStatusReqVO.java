package com.quanxiaoha.weblog.admin.model.vo.message;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MessageStatusReqVO {
    private Long current;
    private Long size;
    private Long id;          // 留言ID
    private Integer status;   // 状态
    private String startDate;
    private String endDate;
}