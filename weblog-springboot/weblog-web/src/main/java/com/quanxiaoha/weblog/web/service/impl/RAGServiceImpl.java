package com.quanxiaoha.weblog.web.service.impl;

import com.quanxiaoha.weblog.common.domain.dos.ArticleDO;
import com.quanxiaoha.weblog.common.domain.mapper.ArticleMapper;
import com.quanxiaoha.weblog.web.model.vo.ai.ArticleReference;
import com.quanxiaoha.weblog.web.service.RAGService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Service
public class RAGServiceImpl implements RAGService {

    @Autowired
    private ArticleMapper articleMapper;

    private static final int TOP_K = 5;
    private static final int MAX_SUMMARY_LENGTH = 300;

    @Override
    public String buildRAGContext(String query) {
        List<String> keywords = extractKeywords(query);
        if (keywords.isEmpty()) {
            return null;
        }

        List<ArticleDO> articles = articleMapper.searchByKeywords(keywords);
        if (CollectionUtils.isEmpty(articles)) {
            return null;
        }

        log.info("检索到 {} 篇相关文章，keywords: {}", articles.size(), keywords);

        StringBuilder context = new StringBuilder();
        context.append("以下是博客中与问题相关的文章内容，请基于这些信息回答：\n\n");

        for (int i = 0; i < articles.size(); i++) {
            ArticleDO article = articles.get(i);
            context.append("【文章").append(i + 1).append("】")
                    .append(article.getTitle()).append(" (ID: ").append(article.getId()).append(")\n");
            String summary = article.getDescription();
            if (summary != null && summary.length() > MAX_SUMMARY_LENGTH) {
                summary = summary.substring(0, MAX_SUMMARY_LENGTH) + "...";
            }
            context.append(summary != null ? summary : "暂无摘要").append("\n\n");
        }

        context.append("---\n");
        context.append("请基于以上文章内容回答用户的问题。回答时**必须**在引用来源中注明文章ID，格式如：引用自《文章标题》(ID: 数字)。\n");
        context.append("例如：引用自《Redis 缓存三大问题解决方案》(ID: 29)\n");
        context.append("---\n");
        context.append("⚠️ 重要：回复时必须遵守以下格式：\n");
        context.append("1. 引用文章时必须包含文章ID，格式为：引用自《文章标题》(ID: 数字)\n");
        context.append("2. 不要使用表格，不要使用列表，直接自然语言回答\n");
        context.append("3. 示例回复：根据博客文章《Spring Boot 入门指南》(ID: 12)，Spring Boot 是...\n");
        context.append("如果文章中没有相关信息，请如实告知。");
        context.append("回答时请注明引用来源（文章标题）。");

        return context.toString();
    }

    @Override
    public List<ArticleReference> getReferences(String query) {
        List<String> keywords = extractKeywords(query);
        if (keywords.isEmpty()) {
            return Collections.emptyList();
        }

        List<ArticleDO> articles = articleMapper.searchByKeywords(keywords);
        if (CollectionUtils.isEmpty(articles)) {
            return Collections.emptyList();
        }

        return articles.stream()
                .map(article -> ArticleReference.builder()
                        .id(article.getId())
                        .title(article.getTitle())
                        .build())
                .collect(Collectors.toList());
    }

    @Override
    public List<ArticleDO> retrieveRelevantArticles(String query) {
        List<String> keywords = extractKeywords(query);
        if (keywords.isEmpty()) {
            return Collections.emptyList();
        }
        return articleMapper.searchByKeywords(keywords);
    }

    @Override
    public List<ArticleDO> searchByKeywords(List<String> keywords) {
        if (CollectionUtils.isEmpty(keywords)) {
            return Collections.emptyList();
        }
        return articleMapper.searchByKeywords(keywords);
    }

    // ===================== 私有方法 =====================

    private List<String> extractKeywords(String query) {
        if (query == null || query.trim().isEmpty()) {
            return Collections.emptyList();
        }

        String cleaned = query.replaceAll("[，,。.？?！!、；;：:（）()]", " ");
        String[] words = cleaned.split("\\s+");

        Set<String> stopWords = getStopWords();
        return Arrays.stream(words)
                .filter(w -> w.length() > 1)
                .filter(w -> !stopWords.contains(w))
                .limit(10)
                .collect(Collectors.toList());
    }

    private Set<String> getStopWords() {
        Set<String> stopWords = new HashSet<>();
        stopWords.add("的");
        stopWords.add("了");
        stopWords.add("是");
        stopWords.add("在");
        stopWords.add("和");
        stopWords.add("与");
        stopWords.add("或");
        stopWords.add("等");
        stopWords.add("有");
        stopWords.add("我");
        stopWords.add("你");
        stopWords.add("他");
        stopWords.add("她");
        stopWords.add("它");
        stopWords.add("们");
        stopWords.add("什么");
        stopWords.add("怎么");
        stopWords.add("如何");
        stopWords.add("为什么");
        stopWords.add("哪个");
        stopWords.add("哪些");
        stopWords.add("哪");
        stopWords.add("这");
        stopWords.add("那");
        stopWords.add("吧");
        stopWords.add("呢");
        stopWords.add("吗");
        stopWords.add("啊");
        stopWords.add("呀");
        stopWords.add("哦");
        return stopWords;
    }
}