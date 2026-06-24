package com.quanxiaoha.weblog.web.controller;

import com.quanxiaoha.weblog.common.Response;
import com.quanxiaoha.weblog.common.aspect.ApiOperationLog;
import com.quanxiaoha.weblog.web.model.vo.message.MessagePublishReqVO;
import com.quanxiaoha.weblog.web.service.MessageService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/message")
@Slf4j
public class MessageController {

    @Autowired
    private MessageService messageService;

    @PostMapping("/publish")
    @ApiOperationLog(description = "发表留言")
    public Response publishMessage(@RequestBody @Validated MessagePublishReqVO reqVO) {
        return messageService.publishMessage(reqVO);
    }

    @GetMapping("/list")
    @ApiOperationLog(description = "获取留言列表")
    public Response getMessageList() {
        return messageService.getMessageList();
    }

    @PostMapping("/like/{id}")
    @ApiOperationLog(description = "留言点赞")
    public Response likeMessage(@PathVariable("id") Long id) {
        return messageService.likeMessage(id);
    }
}