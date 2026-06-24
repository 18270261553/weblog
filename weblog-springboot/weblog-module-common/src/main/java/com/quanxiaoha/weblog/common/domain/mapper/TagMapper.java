package com.quanxiaoha.weblog.common.domain.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.quanxiaoha.weblog.common.domain.dos.TagDO;
import com.quanxiaoha.weblog.common.domain.dos.TagWithCountDO;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface TagMapper extends BaseMapper<TagDO> {
    @Select("SELECT " +
            "t.id, " +
            "t.name, " +
            "COUNT(atr.article_id) AS article_count " +
            "FROM t_tag t " +
            "LEFT JOIN t_article_tag_rel atr ON t.id = atr.tag_id " +
            "LEFT JOIN t_article a ON atr.article_id = a.id AND a.is_deleted = 0 " +
            "WHERE t.is_deleted = 0 " +
            "GROUP BY t.id, t.name " +
            "ORDER BY article_count DESC, t.create_time DESC")
    List<TagWithCountDO> selectTagWithArticleCount();
}
