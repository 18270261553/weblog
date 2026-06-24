// TagServiceImpl.java
package com.quanxiaoha.weblog.web.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.quanxiaoha.weblog.common.Response;
import com.quanxiaoha.weblog.common.domain.mapper.TagMapper;
import com.quanxiaoha.weblog.common.domain.dos.TagDO;
import com.quanxiaoha.weblog.common.domain.dos.TagWithCountDO;
import com.quanxiaoha.weblog.web.dao.TagDao;
import com.quanxiaoha.weblog.web.model.vo.tag.QueryTagListItemRspVO;
import com.quanxiaoha.weblog.web.service.TagService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Slf4j
public class TagServiceImpl extends ServiceImpl<TagMapper, TagDO> implements TagService {

    @Autowired
    private TagDao tagDao;

    @Override
    public Response queryTagList() {
        // 调用新方法，获取带文章数量的标签列表
        List<TagWithCountDO> tagList = tagDao.selectTagWithArticleCount();

        List<QueryTagListItemRspVO> list = null;
        if (!CollectionUtils.isEmpty(tagList)) {
            list = tagList.stream()
                    .map(p -> QueryTagListItemRspVO.builder()
                            .id(p.getId())
                            .name(p.getName())
                            .articleCount(p.getArticleCount())  //  返回文章数量
                            .build())
                    .collect(Collectors.toList());
        }
        return Response.success(list);
    }
}