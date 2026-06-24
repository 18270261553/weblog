package com.quanxiaoha.weblog.admin.dao;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.quanxiaoha.weblog.common.domain.dos.MessageDO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MessageDao {

    /**
     * 分页查询留言列表（管理端）
     */
    IPage<MessageDO> queryMessagePageList(
            @Param("current") Long current,
            @Param("size") Long size,
            @Param("status") Integer status,
            @Param("startDate") String startDate,
            @Param("endDate") String endDate
    );

    /**
     * 更新留言状态
     */
    int updateStatus(@Param("id") Long id, @Param("status") Integer status);

    /**
     * 查询顶级留言列表（前台，只查已通过的）
     */
    List<MessageDO> selectTopMessages();

    /**
     * 查询某条留言的回复列表
     */
    List<MessageDO> selectRepliesByParentId(@Param("parentId") Long parentId);

    /**
     * 留言点赞数+1
     */
    int increaseLikeCount(@Param("id") Long id);
}