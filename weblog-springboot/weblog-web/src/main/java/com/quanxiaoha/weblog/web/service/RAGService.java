package com.quanxiaoha.weblog.web.service;

import com.quanxiaoha.weblog.common.domain.dos.ArticleDO;
import com.quanxiaoha.weblog.web.model.vo.ai.ArticleReference;

import java.util.List;

/**
 * RAG 检索增强生成服务
 * 从博客文章库中检索相关内容，为 AI 提供上下文
 *
 * @author dgq
 */
public interface RAGService {

    /**
     * 根据用户问题构建 RAG 上下文
     *
     * @param query 用户问题
     * @return 构建好的上下文文本，如果未检索到相关文章则返回 null
     */
    String buildRAGContext(String query);

    /**
     * 根据关键词检索相关文章
     *
     * @param query 用户问题
     * @return 相关文章列表（按相关性排序，最多 5 篇）
     */
    List<ArticleDO> retrieveRelevantArticles(String query);

    /**
     * 按关键词列表搜索文章
     *
     * @param keywords 关键词列表
     * @return 匹配的文章列表
     */
    List<ArticleDO> searchByKeywords(List<String> keywords);
    List<ArticleReference> getReferences(String query);
}