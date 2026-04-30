package com.quanxiaoha.weblog.common.utils;

import com.quanxiaoha.weblog.common.enums.ResponseCodeEnum;
import com.quanxiaoha.weblog.common.exception.BizException;
import lombok.extern.slf4j.Slf4j;
import org.lionsoul.ip2region.xdb.Searcher;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.InetAddress;
import java.net.UnknownHostException;


/**
 * @author yjf
 * @description 访客IP归属地工具类
 */
@Slf4j
public class AgentRegionUtils {

    /**
     * 获取http请求ip
     * @param request 请求
     * @return ipAddress
     */
    public static String getIpAddress(HttpServletRequest request) {
        String ipAddress;
        try {
            ipAddress = request.getHeader("x-forwarded-for");
            if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
                ipAddress = request.getHeader("Proxy-Client-IP");
            }
            if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
                ipAddress = request.getHeader("WL-Proxy-Client-IP");
            }
            if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
                ipAddress = request.getRemoteAddr();
                if ("127.0.0.1".equals(ipAddress)) {
                    // 根据网卡取本机配置的IP
                    InetAddress inet = null;
                    try {
                        inet = InetAddress.getLocalHost();
                    } catch (UnknownHostException e) {
                        e.printStackTrace();
                    }
                    assert inet != null;
                    ipAddress = inet.getHostAddress();
                }
            }
            // 对于通过多个代理的情况，第一个IP为客户端真实IP,多个IP按照','分割 "***.***.***.***".length()
            if (ipAddress != null && ipAddress.length() > 15) {
                // = 15
                if (ipAddress.indexOf(",") > 0) {
                    ipAddress = ipAddress.substring(0, ipAddress.indexOf(","));
                }
            }
        } catch (Exception e) {
            ipAddress = "";
        }
        return ipAddress;
    }

    /**
     * 根据ip 获取归属地
     * @param ip 访问ip
     * @return 返回归属地结果
     */
    public static String getIpRegion(String ip, String xdbPath) {
        if (ip == null || ip.isEmpty()) {
            return "未知";
        }
        
        if (ip.contains(":")) {
            log.debug("IPv6 address detected: {}, skipping region lookup", ip);
            return "本地访问";
        }
        
        String actualXdbPath = xdbPath;
        
        if (xdbPath != null && xdbPath.startsWith("classpath:")) {
            try {
                String resourcePath = xdbPath.substring("classpath:".length());
                InputStream inputStream = AgentRegionUtils.class.getClassLoader().getResourceAsStream(resourcePath);
                if (inputStream == null) {
                    log.error("failed to find xdb file from classpath: {}", xdbPath);
                    return "外太空";
                }
                
                File tempFile = File.createTempFile("ip2region_", ".xdb");
                tempFile.deleteOnExit();
                
                try (FileOutputStream outputStream = new FileOutputStream(tempFile)) {
                    byte[] buffer = new byte[4096];
                    int bytesRead;
                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);
                    }
                }
                inputStream.close();
                actualXdbPath = tempFile.getAbsolutePath();
                log.debug("extracted xdb file from classpath to: {}", actualXdbPath);
            } catch (IOException e) {
                log.error("failed to extract xdb file from classpath: {}", xdbPath, e);
                return "外太空";
            }
        }
        
        String country = "中国";
        String hdu = "0";
        Searcher searcher;
        try {
            searcher = Searcher.newWithFileOnly(actualXdbPath);
        } catch (IOException e) {
            log.error("failed to create searcher with {}: {}\n", actualXdbPath, e);
            return "外太空";
        }

        try {
            String region = searcher.search(ip);
            region = region.replace("|", " ");
            String[] cityList = region.split(" ");
            if (cityList.length > 0) {
                if (country.equals(cityList[0])) {
                    if (cityList.length > 1) {
                        log.info(cityList[0]+"-"+cityList[2]+"-"+cityList[3]+"-"+cityList[4]);
                        return cityList[0]+"-"+cityList[2]+"-"+cityList[3]+"-"+cityList[4];
                    }
                } else if (hdu.equals(cityList[0])) {
                    return "中国-浙江省-杭州市-HDU";
                } else {
                    if (cityList.length > 1) {
                        return cityList[0]+"-"+cityList[2];
                    }
                }

            }
        } catch (Exception e) {
            log.error("failed to search({}): {}\n", ip, e);
            return "未知";
        } finally {
            try {
                searcher.close();
            } catch (IOException e) {
                log.error("failed to close searcher:", e);
            }
        }

        return "未知";
    }
}
