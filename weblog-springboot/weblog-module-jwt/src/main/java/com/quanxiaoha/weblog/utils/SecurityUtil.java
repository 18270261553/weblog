package com.quanxiaoha.weblog.utils;

import com.quanxiaoha.weblog.common.domain.dos.UserDO;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

public class SecurityUtil {

    /**
     * 获取当前登录用户名
     */
    public static String getCurrentUsername() {
        UserDetails userDetails = getCurrentUserDetails();
        return userDetails != null ? userDetails.getUsername() : null;
    }

    /**
     * 获取当前登录用户ID（需要 UserDO 实现 UserDetails）
     */
    public static Long getCurrentUserId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null) {
            return null;
        }
        Object principal = authentication.getPrincipal();
        if (principal instanceof UserDO) {
            return ((UserDO) principal).getId();
        }
        return null;
    }

    /**
     * 获取当前用户完整信息
     */
    public static UserDetails getCurrentUserDetails() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null) {
            return null;
        }
        Object principal = authentication.getPrincipal();
        if (principal instanceof UserDetails) {
            return (UserDetails) principal;
        }
        return null;
    }
}