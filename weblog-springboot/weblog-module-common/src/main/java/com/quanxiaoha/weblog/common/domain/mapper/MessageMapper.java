package com.quanxiaoha.weblog.common.domain.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.quanxiaoha.weblog.common.domain.dos.MessageDO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface MessageMapper extends BaseMapper<MessageDO> {
    /**
     * 留言点赞数 +1
     */
    @Update("UPDATE t_message SET like_count = like_count + 1 WHERE id = #{id}")
    int increaseLikeCount(@Param("id") Long id);
}