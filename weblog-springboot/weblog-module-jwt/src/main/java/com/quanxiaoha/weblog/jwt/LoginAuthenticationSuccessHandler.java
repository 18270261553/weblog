package com.quanxiaoha.weblog.jwt;

import com.quanxiaoha.weblog.common.Response;
import com.quanxiaoha.weblog.common.cache.UserCacheService;  // ← 新增
import com.quanxiaoha.weblog.model.CreateTokenRspVO;
import com.quanxiaoha.weblog.utils.ResultUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
@Slf4j
public class LoginAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    @Autowired
    private JwtTokenHelper jwtTokenHelper;

    @Autowired
    private UserCacheService userCacheService;  // ← 新增

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response,
                                        Authentication authentication) throws IOException {
        UserDetails userDetails = (UserDetails) authentication.getPrincipal();

        // 生成 token
        String username = userDetails.getUsername();
        String token = jwtTokenHelper.generateToken(username);

        // ========== 登录成功后立即缓存用户信息 ==========
        userCacheService.cacheUser(userDetails);

        // 返回结果
        CreateTokenRspVO tokenRspDTO = CreateTokenRspVO.builder()
                .token(token)
                .build();

        log.info("==> 用户认证成功，username: {}, token: {}", username, token);
        ResultUtil.ok(response, Response.success(tokenRspDTO));
    }
}