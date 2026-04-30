package com.quanxiaoha.weblog.admin.controller;

import com.quanxiaoha.weblog.admin.model.dto.UserRegisterReqDTO;
import com.quanxiaoha.weblog.admin.service.AdminUserService;
import com.quanxiaoha.weblog.common.Response;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class AdminUserRegisterController {

    private final AdminUserService adminUserService;

    @PostMapping("/register")
    public Response<Object> register(@RequestBody UserRegisterReqDTO dto) {
        return adminUserService.register(dto);
    }
}
