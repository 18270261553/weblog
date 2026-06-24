package com.quanxiaoha.weblog.web.service;

import com.quanxiaoha.weblog.common.PageResponse;
import com.quanxiaoha.weblog.common.Response;
import com.quanxiaoha.weblog.web.model.vo.message.MessagePublishReqVO;

public interface MessageService {

    /**
     * 发表留言
     */
    Response publishMessage(MessagePublishReqVO reqVO);

    /**
     * 获取留言列表（前台）
     */
    Response getMessageList();

    /**
     * 留言点赞
     */
    Response likeMessage(Long messageId);
}