package com.quanxiaoha.weblog.admin.controller;

import com.quanxiaoha.weblog.admin.service.AdminArticleLikeService;
import com.quanxiaoha.weblog.admin.model.vo.ArticleLike.ArticleLikeReqVO;
import com.quanxiaoha.weblog.common.Response;
import com.quanxiaoha.weblog.common.aspect.ApiOperationLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/admin/article/like")
public class AdminArticleLikeController {

    @Autowired
    private AdminArticleLikeService articleLikeService;

    @PostMapping("/add")
    @ApiOperationLog(description = "文章点赞")
    public Response likeArticle(@RequestBody ArticleLikeReqVO vo) {
        return articleLikeService.likeArticle(vo);
    }

    @PostMapping("/cancel")
    @ApiOperationLog(description = "取消文章点赞")
    public Response cancelLikeArticle(@RequestBody ArticleLikeReqVO vo) {
        return articleLikeService.cancelLikeArticle(vo);
    }

    @PostMapping("/count")
    @ApiOperationLog(description = "获取文章点赞数")
    public Response getLikeCount(@RequestBody ArticleLikeReqVO vo) {
        return articleLikeService.getLikeCount(vo);
    }
    @PostMapping("/isLike")
    @ApiOperationLog(description = "判断当前用户是否点赞文章")
    public Response isArticleLiked(@RequestBody ArticleLikeReqVO vo) {
        return articleLikeService.isArticleLiked(vo);
    }
}