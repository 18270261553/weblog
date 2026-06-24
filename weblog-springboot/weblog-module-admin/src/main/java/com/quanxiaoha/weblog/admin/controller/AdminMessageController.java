package com.quanxiaoha.weblog.admin.controller;

import com.quanxiaoha.weblog.admin.model.vo.message.MessageDeleteReqVO;
import com.quanxiaoha.weblog.admin.model.vo.message.MessageStatusReqVO;
import com.quanxiaoha.weblog.admin.service.AdminMessageService;
import com.quanxiaoha.weblog.common.PageResponse;
import com.quanxiaoha.weblog.common.Response;
import com.quanxiaoha.weblog.common.aspect.ApiOperationLog;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/admin/message")
@Slf4j
public class AdminMessageController {

    @Autowired
    private AdminMessageService adminMessageService;

    @PostMapping("/list")
    @ApiOperationLog(description = "查询留言列表")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public PageResponse queryMessagePageList(
            @RequestBody MessageStatusReqVO reqVO) {
        return adminMessageService.queryMessagePageList(
                reqVO.getCurrent(),
                reqVO.getSize(),
                reqVO.getStatus(),
                reqVO.getStartDate(),
                reqVO.getEndDate()
        );
    }

    @PostMapping("/status/update")
    @ApiOperationLog(description = "更新留言状态")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response updateMessageStatus(@RequestBody @Validated MessageStatusReqVO reqVO) {
        return adminMessageService.updateMessageStatus(reqVO);
    }

    @PostMapping("/delete")
    @ApiOperationLog(description = "删除留言")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Response deleteMessage(@RequestBody @Validated MessageDeleteReqVO reqVO) {
        return adminMessageService.deleteMessage(reqVO);
    }
}