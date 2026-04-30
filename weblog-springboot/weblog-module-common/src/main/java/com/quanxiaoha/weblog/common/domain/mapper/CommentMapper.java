package com.quanxiaoha.weblog.common.domain.mapper;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import com.quanxiaoha.weblog.common.domain.dos.CommentDO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CommentMapper extends BaseMapper<CommentDO> {

    // 根据文章 ID 查询评论
     default List<CommentDO> selectByArticleId(@Param("articleId") Long articleId) {
        LambdaQueryWrapper<CommentDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(CommentDO::getArticleId, articleId);
        return selectList(wrapper);
    }
}