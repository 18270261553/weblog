package com.quanxiaoha.weblog.common.cache;

import com.quanxiaoha.weblog.common.constant.RedisKeyConstants;
import com.quanxiaoha.weblog.common.service.RedisService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

/**
 * 用户缓存服务
 */
@Slf4j
@Service
public class UserCacheService {

    @Autowired
    private RedisService redisService;

    /**
     * 缓存用户信息
     */
    public void cacheUser(UserDetails userDetails) {
        if (userDetails == null || userDetails.getUsername() == null) {
            return;
        }
        String key = RedisKeyConstants.USER_INFO_PREFIX + userDetails.getUsername();
        try {
            redisService.set(key, userDetails, RedisKeyConstants.USER_INFO_TTL, RedisKeyConstants.USER_INFO_TTL_UNIT);
            log.info("✅ 用户信息已缓存，username: {}", userDetails.getUsername());
        } catch (Exception e) {
            log.error("❌ 缓存用户信息失败，username: {}", userDetails.getUsername(), e);
        }
    }

    /**
     * 获取缓存的用户信息
     */
    public UserDetails getCachedUser(String username) {
        if (username == null) {
            return null;
        }
        String key = RedisKeyConstants.USER_INFO_PREFIX + username;
        try {
            Object obj = redisService.get(key);
            if (obj != null && obj instanceof UserDetails) {
                log.info("✅ 从缓存获取用户信息成功，username: {}", username);
                return (UserDetails) obj;
            }
        } catch (Exception e) {
            log.error("❌ 获取缓存用户信息失败，username: {}", username, e);
        }
        return null;
    }

    /**
     * 删除用户缓存
     */
    public void evictUser(String username) {
        if (username == null) {
            return;
        }
        String key = RedisKeyConstants.USER_INFO_PREFIX + username;
        try {
            redisService.delete(key);
            log.info("✅ 用户缓存已删除，username: {}", username);
        } catch (Exception e) {
            log.error("❌ 删除用户缓存失败，username: {}", username, e);
        }
    }
}