package com.quanxiaoha.weblog.common.domain.mapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.quanxiaoha.weblog.common.domain.dos.ArticleLikeDO;
import org.apache.ibatis.annotations.Param;

public interface ArticleLikeMapper extends BaseMapper<ArticleLikeDO> {

    // 判断是否已点赞
    int selectCountByArticleIdAndIp(@Param("articleId") Long articleId, @Param("ipAddress") String ipAddress);

    // 取消点赞
    int deleteByArticleIdAndIp(@Param("articleId") Long articleId, @Param("ipAddress") String ipAddress);
}