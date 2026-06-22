package com.quanxiaoha.weblog.common.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.Set;
import java.util.concurrent.TimeUnit;

/**
 * Redis 操作服务
 */
@Slf4j
@Service
public class RedisService {

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    /**
     * 设置值（带过期时间）
     */
    public void set(String key, Object value, long timeout, TimeUnit unit) {
        try {
            redisTemplate.opsForValue().set(key, value, timeout, unit);
            log.debug("Redis 设置值成功，key: {}", key);
        } catch (Exception e) {
            log.error("Redis 设置值失败，key: {}", key, e);
        }
    }

    /**
     * 获取值
     */
    public Object get(String key) {
        try {
            return redisTemplate.opsForValue().get(key);
        } catch (Exception e) {
            log.error("Redis 获取值失败，key: {}", key, e);
            return null;
        }
    }

    /**
     * 删除 key
     */
    public Boolean delete(String key) {
        try {
            return redisTemplate.delete(key);
        } catch (Exception e) {
            log.error("Redis 删除 key 失败，key: {}", key, e);
            return false;
        }
    }

    /**
     * 判断 key 是否存在
     */
    public Boolean hasKey(String key) {
        try {
            return redisTemplate.hasKey(key);
        } catch (Exception e) {
            log.error("Redis 检查 key 失败，key: {}", key, e);
            return false;
        }
    }
    /**
     * 按前缀批量删除缓存
     * @param prefix Key 前缀
     */
    public void deleteByPrefix(String prefix) {
        try {
            Set<String> keys = redisTemplate.keys(prefix + "*");
            if (keys != null && !keys.isEmpty()) {
                redisTemplate.delete(keys);
                log.debug("批量删除缓存成功，前缀: {}, 数量: {}", prefix, keys.size());
            }
        } catch (Exception e) {
            log.error("批量删除缓存失败，前缀: {}", prefix, e);
        }
    }
}