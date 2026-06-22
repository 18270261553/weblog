package com.quanxiaoha.weblog.common.domain.dos;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.Date;

@Data
@Builder
@NoArgsConstructor  // ← 新增：无参构造方法
@AllArgsConstructor // ← 新增：全参构造方法
@TableName("t_article")
public class ArticleDO {
    @TableId(type = IdType.AUTO)
    private Long id;
    private String title;
    private String titleImage;
    private String description;
    private Date createTime;
    private Date updateTime;
    private Boolean isDeleted;
    private Long readNum;
}
