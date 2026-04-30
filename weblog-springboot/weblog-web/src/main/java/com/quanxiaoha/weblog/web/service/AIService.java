package com.quanxiaoha.weblog.web.service;

import com.quanxiaoha.weblog.common.Response;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;
import java.util.List;
import java.util.Map;

public interface AIService {

    String chat(String message, List<Map<String, String>> history);

    Response<String> chat(Map<String, Object> request);

    void chatStream(String message, List<Map<String, String>> history, StreamCallback callback);

    SseEmitter chatStream(String message, List<Map<String, String>> history);

    String generateSummary(String content);

    List<Long> recommendArticles(Long articleId);

    boolean isAvailable();
}