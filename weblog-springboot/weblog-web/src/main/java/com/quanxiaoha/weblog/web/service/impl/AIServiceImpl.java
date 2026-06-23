package com.quanxiaoha.weblog.web.service.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.quanxiaoha.weblog.common.Response;
import com.quanxiaoha.weblog.web.model.vo.ai.ArticleReference;
import com.quanxiaoha.weblog.web.service.AIService;
import com.quanxiaoha.weblog.web.service.RAGService;
import com.quanxiaoha.weblog.web.service.StreamCallback;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Slf4j
@Service
public class AIServiceImpl implements AIService {

    @Value("${deepseek.api-key}")
    private String apiKey;

    @Value("${deepseek.api-url:https://api.deepseek.com}")
    private String apiUrl;

    @Value("${deepseek.model:deepseek-chat}")
    private String model;

    @Value("${ai.timeout:60000}")
    private int timeout;

    @Value("${ai.max-tokens:1024}")
    private int maxTokens;

    @Value("${ai.temperature:0.7}")
    private double temperature;

    @Value("${ai.enabled:true}")
    private boolean aiEnabled;

    @Value("${ai.rag.enabled:true}")
    private boolean ragEnabled;

    @Autowired
    private RAGService ragService;

    private final RestTemplate restTemplate;
    private final ExecutorService executorService;
    private final ObjectMapper objectMapper;

    public AIServiceImpl() {
        this.restTemplate = new RestTemplate();
        this.executorService = Executors.newCachedThreadPool();
        this.objectMapper = new ObjectMapper();
    }

    private static final String SYSTEM_PROMPT = "你是博客AI智能助手，回答简洁、准确、使用中文。";
    private static final String RAG_SYSTEM_PROMPT = "你是博客AI智能助手，基于提供的博客文章内容回答用户问题。回答要准确、简洁，并注明引用来源。";

    @Override
    public String chat(String message, List<Map<String, String>> history) {
        if (!aiEnabled) return "AI服务暂未开启";
        if (apiKey == null || apiKey.isEmpty()) return "AI服务未配置";
        if (message == null || message.trim().isEmpty()) return "请输入有效的问题";

        try {
            List<Map<String, String>> messages = new ArrayList<>();

            // 1. 判断是否启用 RAG
            String ragContext = null;
            if (ragEnabled) {
                ragContext = ragService.buildRAGContext(message);
            }

            // 2. 构建系统提示
            String systemPrompt = (ragContext != null) ? RAG_SYSTEM_PROMPT : SYSTEM_PROMPT;
            messages.add(createMessage("system", systemPrompt));

            // 3. 如果有 RAG 上下文，添加到消息中
            if (ragContext != null) {
                log.info("启用 RAG，检索到上下文，问题: {}", message);
                messages.add(createMessage("user", ragContext + "\n\n用户问题：" + message));
            } else {
                // 4. 添加历史消息（只保留最近2轮）
                if (history != null && !history.isEmpty()) {
                    int start = Math.max(0, history.size() - 2);
                    for (int i = start; i < history.size(); i++) {
                        Map<String, String> msg = history.get(i);
                        if (msg != null && msg.get("content") != null) {
                            messages.add(msg);
                        }
                    }
                }
                messages.add(createMessage("user", message));
            }

            Map<String, Object> requestBody = new HashMap<>();
            requestBody.put("model", model);
            requestBody.put("messages", messages);
            requestBody.put("temperature", temperature);
            requestBody.put("max_tokens", maxTokens);
            requestBody.put("stream", false);

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.set("Authorization", "Bearer " + apiKey);

            HttpEntity<Map<String, Object>> request = new HttpEntity<>(requestBody, headers);
            ResponseEntity<Map> response = restTemplate.postForEntity(apiUrl + "/v1/chat/completions", request, Map.class);

            if (response.getBody() != null) {
                Map<String, Object> responseBody = response.getBody();
                List<Map<String, Object>> choices = (List<Map<String, Object>>) responseBody.get("choices");

                if (choices != null && !choices.isEmpty()) {
                    Map<String, Object> messageObj = (Map<String, Object>) choices.get(0).get("message");
                    return cleanResponse((String) messageObj.get("content"));
                }
            }
            return "AI服务返回空响应";

        } catch (Exception e) {
            log.error("DeepSeek 调用失败", e);
            return handleApiError(e);
        }
    }

    @Override
    public Response<String> chat(Map<String, Object> request) {
        try {
            String message = (String) request.get("message");
            List<Map<String, String>> history = (List<Map<String, String>>) request.get("history");
            return Response.success(chat(message, history));
        } catch (Exception e) {
            log.error("聊天请求失败", e);
            return Response.fail("AI服务不可用");
        }
    }

    @Override
    public void chatStream(String message, List<Map<String, String>> history, StreamCallback callback) {
        if (!aiEnabled) {
            callback.onError(new RuntimeException("AI服务未启用"));
            return;
        }
        if (apiKey == null || apiKey.isEmpty()) {
            callback.onError(new RuntimeException("AI服务未配置"));
            return;
        }

        executorService.submit(() -> {
            HttpURLConnection connection = null;
            BufferedReader reader = null;

            try {
                if (message == null || message.trim().isEmpty()) {
                    callback.onError(new IllegalArgumentException("消息不能为空"));
                    return;
                }

                List<Map<String, String>> messages = new ArrayList<>();

                // 流式也支持 RAG
                String ragContext = null;
                if (ragEnabled) {
                    ragContext = ragService.buildRAGContext(message);
                }

                String systemPrompt = (ragContext != null) ? RAG_SYSTEM_PROMPT : SYSTEM_PROMPT;
                messages.add(createMessage("system", systemPrompt));

                if (ragContext != null) {
                    log.info("流式启用 RAG，问题: {}", message);
                    messages.add(createMessage("user", ragContext + "\n\n用户问题：" + message));
                } else {
                    if (history != null && !history.isEmpty()) {
                        int start = Math.max(0, history.size() - 2);
                        for (int i = start; i < history.size(); i++) {
                            Map<String, String> msg = history.get(i);
                            if (msg != null && msg.get("content") != null) {
                                messages.add(msg);
                            }
                        }
                    }
                    messages.add(createMessage("user", message));
                }

                Map<String, Object> requestBody = new HashMap<>();
                requestBody.put("model", model);
                requestBody.put("messages", messages);
                requestBody.put("temperature", temperature);
                requestBody.put("max_tokens", maxTokens);
                requestBody.put("stream", true);

                URL url = new URL(apiUrl + "/v1/chat/completions");
                connection = (HttpURLConnection) url.openConnection();
                connection.setRequestMethod("POST");
                connection.setRequestProperty("Content-Type", "application/json");
                connection.setRequestProperty("Authorization", "Bearer " + apiKey);
                connection.setDoOutput(true);
                connection.setConnectTimeout(timeout);
                connection.setReadTimeout(timeout);

                String jsonInput = objectMapper.writeValueAsString(requestBody);
                connection.getOutputStream().write(jsonInput.getBytes());

                int responseCode = connection.getResponseCode();
                if (responseCode != 200) {
                    throw new RuntimeException("API返回错误码: " + responseCode);
                }

                reader = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));
                String line;

                while ((line = reader.readLine()) != null) {
                    if (line.startsWith("data: ")) {
                        String data = line.substring(6);
                        if ("[DONE]".equals(data)) break;

                        try {
                            Map<String, Object> jsonData = objectMapper.readValue(data, Map.class);
                            List<Map<String, Object>> choices = (List<Map<String, Object>>) jsonData.get("choices");

                            if (choices != null && !choices.isEmpty()) {
                                Map<String, Object> delta = (Map<String, Object>) choices.get(0).get("delta");
                                if (delta != null && delta.containsKey("content")) {
                                    String chunk = (String) delta.get("content");
                                    if (chunk != null && !chunk.isEmpty()) {
                                        callback.onNext(chunk);
                                    }
                                }
                            }
                        } catch (Exception ignored) {}
                    }
                }
                callback.onComplete();

            } catch (Exception e) {
                log.error("流式对话失败", e);
                callback.onError(e);
            } finally {
                try {
                    if (reader != null) reader.close();
                    if (connection != null) connection.disconnect();
                } catch (Exception ignored) {}
            }
        });
    }

    @Override
    public SseEmitter chatStream(String message, List<Map<String, String>> history) {
        SseEmitter emitter = new SseEmitter((long) timeout);

        chatStream(message, history, new StreamCallback() {
            @Override
            public void onNext(String chunk) {
                try {
                    emitter.send(SseEmitter.event().name("message").data(chunk));
                } catch (Exception e) {
                    emitter.completeWithError(e);
                }
            }

            @Override
            public void onComplete() {
                try {
                    emitter.send(SseEmitter.event().name("complete").data("[DONE]"));
                    emitter.complete();
                } catch (Exception e) {
                    emitter.completeWithError(e);
                }
            }

            @Override
            public void onError(Throwable error) {
                emitter.completeWithError(error);
            }
        });

        return emitter;
    }

    @Override
    public String generateSummary(String content) {
        if (!aiEnabled || content == null || content.isEmpty()) return "";
        String prompt = String.format("请为文章生成简短摘要（50字内）：%s", content.length() > 2000 ? content.substring(0, 2000) : content);
        String summary = chat(prompt, null);
        return summary.length() > 100 ? summary.substring(0, 100) + "..." : summary;
    }

    @Override
    public List<Long> recommendArticles(Long articleId) {
        if (!aiEnabled || articleId == null) return Collections.emptyList();

        try {
            String prompt = String.format("根据文章ID %d 推荐5篇相似文章ID，只返回数字，逗号分隔", articleId);
            String response = chat(prompt, null);
            return extractArticleIds(response);
        } catch (Exception e) {
            log.error("推荐文章失败", e);
            return Collections.emptyList();
        }
    }

    @Override
    public boolean isAvailable() {
        if (!aiEnabled || apiKey == null || apiKey.isEmpty()) return false;
        try {
            String test = chat("测试", null);
            return test != null && !test.contains("不可用") && !test.contains("失败");
        } catch (Exception e) {
            return false;
        }
    }

    // ====================== 私有方法 ======================

    private List<Map<String, String>> buildMessages(String message, List<Map<String, String>> history) {
        List<Map<String, String>> messages = new ArrayList<>();
        messages.add(createMessage("system", "你是博客AI智能助手，回答简洁、准确、使用中文。"));

        if (history != null && !history.isEmpty()) {
            int start = Math.max(0, history.size() - 2);
            for (int i = start; i < history.size(); i++) {
                Map<String, String> msg = history.get(i);
                if (msg != null && msg.get("content") != null) {
                    messages.add(msg);
                }
            }
        }

        messages.add(createMessage("user", message));
        return messages;
    }

    private Map<String, String> createMessage(String role, String content) {
        Map<String, String> message = new HashMap<>();
        message.put("role", role);
        message.put("content", content);
        return message;
    }

    private String cleanResponse(String response) {
        return response == null || response.isEmpty() ? "抱歉，我无法回答" : response.trim();
    }

    private String handleApiError(Exception e) {
        String errorMessage = e.getMessage();
        if (errorMessage == null) return "AI服务未知错误";
        if (errorMessage.contains("401") || errorMessage.contains("Unauthorized")) return "API Key 无效";
        if (errorMessage.contains("429")) return "请求过于频繁";
        if (errorMessage.contains("timeout")) return "AI服务响应超时";
        if (errorMessage.contains("Connection refused")) return "无法连接AI服务";
        return "AI服务暂时不可用";
    }

    private List<Long> extractArticleIds(String response) {
        List<Long> ids = new ArrayList<>();
        if (response == null) return ids;

        Pattern pattern = Pattern.compile("\\d+");
        Matcher matcher = pattern.matcher(response);

        while (matcher.find() && ids.size() < 5) {
            try {
                long id = Long.parseLong(matcher.group());
                if (id > 0 && !ids.contains(id)) {
                    ids.add(id);
                }
            } catch (NumberFormatException ignored) {}
        }
        return ids;
    }

}