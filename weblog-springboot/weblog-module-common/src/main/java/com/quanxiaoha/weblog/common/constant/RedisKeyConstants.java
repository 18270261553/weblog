package com.quanxiaoha.weblog.common.constant;

import java.util.concurrent.TimeUnit;

/**
 * Redis Key 常量管理
 */
public class RedisKeyConstants {

    // ========== 用户信息缓存 ==========
    public static final String USER_INFO_PREFIX = "weblog:user:info:";

    // ========== 缓存过期时间 ==========
    public static final long USER_INFO_TTL = 24; // 24小时
    public static final TimeUnit USER_INFO_TTL_UNIT = TimeUnit.HOURS;
}