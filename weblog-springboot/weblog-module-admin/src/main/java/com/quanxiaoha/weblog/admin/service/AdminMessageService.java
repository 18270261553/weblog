package com.quanxiaoha.weblog.admin.service;

import com.quanxiaoha.weblog.admin.model.vo.message.MessageDeleteReqVO;
import com.quanxiaoha.weblog.admin.model.vo.message.MessageListRespVO;
import com.quanxiaoha.weblog.admin.model.vo.message.MessageStatusReqVO;
import com.quanxiaoha.weblog.common.PageResponse;
import com.quanxiaoha.weblog.common.Response;

public interface AdminMessageService {

    /**
     * 分页查询留言列表（管理端）
     */
    PageResponse queryMessagePageList(Long current, Long size, Integer status, String startDate, String endDate);

    /**
     * 更新留言状态（审核通过/拒绝）
     */
    Response updateMessageStatus(MessageStatusReqVO reqVO);

    /**
     * 删除留言
     */
    Response deleteMessage(MessageDeleteReqVO reqVO);
}