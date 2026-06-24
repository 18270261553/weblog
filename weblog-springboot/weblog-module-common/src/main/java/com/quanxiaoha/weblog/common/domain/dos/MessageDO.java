package com.quanxiaoha.weblog.common.domain.dos;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 留言板实体类
 *
 * @author dgq
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@TableName("t_message")
public class MessageDO implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 留言ID
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 用户ID（0=游客）
     */
    private Long userId;

    /**
     * 留言人名称
     */
    private String username;

    /**
     * 邮箱（可选）
     */
    private String email;

    /**
     * 留言内容
     */
    private String content;

    /**
     * 父留言ID（0=顶级留言）
     */
    private Long parentId;

    /**
     * 状态：0-待审核，1-已通过，2-已拒绝
     */
    private Integer status;

    /**
     * IP地址
     */
    private String ipAddress;

    /**
     * 头像URL（扩展字段，可选）
     */
    private String avatar;

    /**
     * 个人网站（扩展字段，可选）
     */
    private String website;

    /**
     * 点赞数
     */
    private Integer likeCount;

    /**
     * 创建时间
     */
    private LocalDateTime createTime;

    /**
     * 更新时间
     */
    private LocalDateTime updateTime;

    /**
     * 删除标志位：0-未删除，1-已删除
     */
    private Integer isDeleted;
}