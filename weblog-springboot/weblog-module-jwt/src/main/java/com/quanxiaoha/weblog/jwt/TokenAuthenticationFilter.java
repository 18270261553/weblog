package com.quanxiaoha.weblog.jwt;

import com.quanxiaoha.weblog.common.cache.UserCacheService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Slf4j
public class TokenAuthenticationFilter extends OncePerRequestFilter {

    @Autowired
    private JwtTokenHelper jwtTokenHelper;

    @Autowired
    private UserDetailsService userDetailsService;

    @Autowired
    private UserCacheService userCacheService;  // ← 新增

    @Value("${jwt.tokenPrefix}")
    private String tokenPrefix;
    @Value("${jwt.tokenHeaderKey}")
    private String tokenHeaderKey;

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain) throws ServletException, IOException {
        String header = request.getHeader(tokenHeaderKey);
        if (StringUtils.startsWith(header, String.format("%s ", tokenPrefix))) {
            String token = StringUtils.substring(header, 7);
            log.info("token: {}", token);

            if (StringUtils.isNotBlank(token) && jwtTokenHelper.validateToken(token)) {
                String username = jwtTokenHelper.getUsernameByToken(token);

                if (StringUtils.isNotBlank(username)) {
                    UserDetails userDetails = null;

                    // ========== 1. 优先从 Redis 获取用户信息 ==========
                    userDetails = userCacheService.getCachedUser(username);

                    // ========== 2. 缓存未命中，从数据库加载 ==========
                    if (userDetails == null) {
                        log.info("缓存未命中，从数据库加载用户信息，username: {}", username);
                        userDetails = userDetailsService.loadUserByUsername(username);
                        // 加载后存入 Redis（下次直接用）
                        if (userDetails != null) {
                            userCacheService.cacheUser(userDetails);
                        }
                    } else {
                        log.info("从缓存获取用户信息成功，username: {}", username);
                    }

                    // ========== 3. 设置到 SecurityContextHolder ==========
                    if (userDetails != null) {
                        UsernamePasswordAuthenticationToken authentication =
                                new UsernamePasswordAuthenticationToken(
                                        userDetails,
                                        null,
                                        userDetails.getAuthorities()
                                );
                        authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                        SecurityContextHolder.getContext().setAuthentication(authentication);
                    }
                }
            }
        }
        filterChain.doFilter(request, response);
    }
}