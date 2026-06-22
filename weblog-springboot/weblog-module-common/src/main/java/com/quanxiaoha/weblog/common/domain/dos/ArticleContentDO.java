package com.quanxiaoha.weblog.common.domain.dos;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor  // ← 新增：无参构造方法
@AllArgsConstructor // ← 新增：全参构造方法
@TableName("t_article_content")
public class ArticleContentDO {
    @TableId(type = IdType.AUTO)
    private Long id;
    private Long articleId;
    private String content;
}
