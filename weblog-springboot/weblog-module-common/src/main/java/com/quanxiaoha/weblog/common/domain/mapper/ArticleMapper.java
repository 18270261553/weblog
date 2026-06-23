package com.quanxiaoha.weblog.common.domain.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.quanxiaoha.weblog.common.domain.dos.ArticleCountDO;
import com.quanxiaoha.weblog.common.domain.dos.ArticleDO;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface ArticleMapper extends BaseMapper<ArticleDO> {

    @Select("SELECT DATE(create_time) AS date, COUNT(*) AS count\n" +
            "FROM t_article\n" +
            "WHERE create_time >= #{startDate} AND create_time <= #{endDate}\n" +
            "GROUP BY DATE(create_time)\n" +
            "ORDER BY DATE(create_time)")
    List<ArticleCountDO> selectArticleCount(@Param("startDate") String startDate, @Param("endDate") String endDate);
    /**
     * 按关键词列表搜索文章（RAG 检索）
     * 由于 MyBatis-Plus 注解不支持动态 foreach，使用 XML 方式
     */
    List<ArticleDO> searchByKeywords(@Param("keywords") List<String> keywords);
}
