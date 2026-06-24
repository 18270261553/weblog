package com.quanxiaoha.weblog.common.domain.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.quanxiaoha.weblog.common.domain.dos.CategoryDO;
import com.quanxiaoha.weblog.common.domain.dos.CategoryWithCountDO;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface CategoryMapper extends BaseMapper<CategoryDO> {
    //  新增：查询分类及其文章数量
    @Select("SELECT " +
            "c.id, " +
            "c.name, " +
            "COUNT(acr.article_id) AS article_count " +
            "FROM t_category c " +
            "LEFT JOIN t_article_category_rel acr ON c.id = acr.category_id " +
            "LEFT JOIN t_article a ON acr.article_id = a.id AND a.is_deleted = 0 " +
            "WHERE c.is_deleted = 0 " +
            "GROUP BY c.id, c.name " +
            "ORDER BY c.create_time DESC")
    List<CategoryWithCountDO> selectCategoryWithArticleCount();
}
