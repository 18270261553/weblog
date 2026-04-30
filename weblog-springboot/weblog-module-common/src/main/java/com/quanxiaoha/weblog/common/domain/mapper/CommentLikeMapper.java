package com.quanxiaoha.weblog.common.domain.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.quanxiaoha.weblog.common.domain.dos.CommentLikeDO;
import org.apache.ibatis.annotations.Param;

public interface CommentLikeMapper extends BaseMapper<CommentLikeDO> {

    int selectCountByCommentIdAndIp(@Param("commentId") Long commentId, @Param("ipAddress") String ipAddress);

    int deleteByCommentIdAndIp(@Param("commentId") Long commentId, @Param("ipAddress") String ipAddress);
}