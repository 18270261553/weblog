package com.quanxiaoha.weblog.admin.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.quanxiaoha.weblog.admin.model.vo.ArticleLike.ArticleLikeReqVO;
import com.quanxiaoha.weblog.admin.service.AdminArticleLikeService;
import com.quanxiaoha.weblog.common.Response;
import com.quanxiaoha.weblog.common.domain.dos.ArticleLikeDO;
import com.quanxiaoha.weblog.common.domain.dos.UserDO;
import com.quanxiaoha.weblog.common.domain.mapper.ArticleLikeMapper;
import com.quanxiaoha.weblog.common.domain.mapper.UserMapper;
import com.quanxiaoha.weblog.jwt.utils.SecurityUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
public class AdminArticleLikeServiceImpl implements AdminArticleLikeService {

    @Autowired
    private ArticleLikeMapper articleLikeMapper;

    @Autowired
    private UserMapper userMapper;

    /**
     * 文章点赞（基于当前登录用户）
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Response likeArticle(ArticleLikeReqVO vo) {
        // 获取用户名 → 查用户ID
        String username = SecurityUtil.getCurrentUsername();
        UserDO user = userMapper.selectOne(new QueryWrapper<UserDO>().eq("username", username));
        if (user == null) return Response.fail("用户不存在");
        Long userId = user.getId();

        Long articleId = vo.getArticleId();

        QueryWrapper<ArticleLikeDO> wrapper = new QueryWrapper<>();
        wrapper.eq("article_id", articleId);
        wrapper.eq("user_id", userId);

        Long count = articleLikeMapper.selectCount(wrapper);
        if (count > 0) {
            return Response.fail("您已点赞");
        }

        ArticleLikeDO entity = ArticleLikeDO.builder()
                .articleId(articleId)
                .userId(userId)
                .createTime(LocalDateTime.now())
                .build();

        articleLikeMapper.insert(entity);
        return Response.success("点赞成功");
    }

    /**
     * 取消文章点赞
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Response cancelLikeArticle(ArticleLikeReqVO vo) {
        String username = SecurityUtil.getCurrentUsername();
        UserDO user = userMapper.selectOne(new QueryWrapper<UserDO>().eq("username", username));
        if (user == null) return Response.fail("用户不存在");
        Long userId = user.getId();

        QueryWrapper<ArticleLikeDO> wrapper = new QueryWrapper<>();
        wrapper.eq("article_id", vo.getArticleId());
        wrapper.eq("user_id", userId);

        articleLikeMapper.delete(wrapper);
        return Response.success("取消点赞成功");
    }

    /**
     * 获取文章点赞数量
     */
    @Override
    public Response getLikeCount(ArticleLikeReqVO vo) {
        QueryWrapper<ArticleLikeDO> wrapper = new QueryWrapper<>();
        wrapper.eq("article_id", vo.getArticleId());
        Long count = articleLikeMapper.selectCount(wrapper);
        return Response.success(count);
    }

    @Override
    public Response isArticleLiked(ArticleLikeReqVO vo) {
        String username = SecurityUtil.getCurrentUsername();
        UserDO user = userMapper.selectOne(new QueryWrapper<UserDO>().eq("username", username));
        if (user == null) return Response.success(false);
        Long userId = user.getId();

        QueryWrapper<ArticleLikeDO> wrapper = new QueryWrapper<>();
        wrapper.eq("article_id", vo.getArticleId());
        wrapper.eq("user_id", userId);

        Long count = articleLikeMapper.selectCount(wrapper);
        return Response.success(count > 0);
    }
}