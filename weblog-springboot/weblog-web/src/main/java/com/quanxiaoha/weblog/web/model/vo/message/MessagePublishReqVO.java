package com.quanxiaoha.weblog.web.model.vo.message;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

/**
 * 前台 VO 类
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MessagePublishReqVO {

    @NotBlank(message = "昵称不能为空")
    @Size(max = 60, message = "昵称不能超过60个字符")
    private String username;

    @Size(max = 100, message = "邮箱不能超过100个字符")
    private String email;

    @NotBlank(message = "内容不能为空")
    @Size(max = 500, message = "内容不能超过500个字符")
    private String content;

    private Long parentId;  // 回复的留言ID
}