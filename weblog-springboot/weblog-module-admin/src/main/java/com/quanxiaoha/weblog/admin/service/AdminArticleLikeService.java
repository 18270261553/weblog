package com.quanxiaoha.weblog.admin.service;

import com.quanxiaoha.weblog.admin.model.vo.ArticleLike.ArticleLikeReqVO;
import com.quanxiaoha.weblog.common.Response;

public interface AdminArticleLikeService {
    Response likeArticle(ArticleLikeReqVO vo);
    Response cancelLikeArticle(ArticleLikeReqVO vo);
    Response getLikeCount(ArticleLikeReqVO vo);
    // 判断是否已点赞
    Response isArticleLiked(ArticleLikeReqVO vo);
}
