package com.quanxiaoha.weblog.admin.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.quanxiaoha.weblog.admin.dao.AdminTagDao;
import com.quanxiaoha.weblog.admin.model.vo.tag.SearchTagReqVO;
import com.quanxiaoha.weblog.common.domain.mapper.TagMapper;
import com.quanxiaoha.weblog.common.domain.dos.TagDO;
import com.quanxiaoha.weblog.admin.model.vo.tag.AddTagReqVO;
import com.quanxiaoha.weblog.admin.model.vo.tag.DeleteTagReqVO;
import com.quanxiaoha.weblog.admin.model.vo.tag.QueryTagPageListReqVO;
import com.quanxiaoha.weblog.admin.service.AdminTagService;
import com.quanxiaoha.weblog.common.Response;
import com.quanxiaoha.weblog.common.enums.ResponseCodeEnum;
import com.quanxiaoha.weblog.common.model.vo.QuerySelectListRspVO;
import com.quanxiaoha.weblog.common.service.RedisService;  // ← 新增
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;  // ← 新增
import java.util.stream.Collectors;

@Service
@Slf4j
public class AdminTagServiceImpl extends ServiceImpl<TagMapper, TagDO> implements AdminTagService {

    @Autowired
    private AdminTagDao tagDao;

    // ========== 新增 Redis 相关 ==========
    @Autowired
    private RedisService redisService;

    private static final String TAG_PAGE_LIST_PREFIX = "weblog:tag:page:";
    private static final String TAG_SEARCH_LIST_PREFIX = "weblog:tag:search:";
    private static final String TAG_SELECT_LIST_PREFIX = "weblog:tag:select:list";
    private static final long TAG_CACHE_TTL = 30; // 30分钟

    // ============================================================
    // 写操作：新增/删除 → 清除缓存
    // ============================================================

    @Override
    public Response addTags(AddTagReqVO addTagReqVO) {
        List<TagDO> tags = addTagReqVO.getTags().stream()
                .map(tagName -> TagDO.builder()
                        .name(tagName.trim())
                        .createTime(new Date())
                        .updateTime(new Date())
                        .build())
                .collect(Collectors.toList());
        try {
            saveBatch(tags);
            // ========== 清除标签缓存 ==========
            evictTagCaches();
            log.info("新增标签成功，标签数量: {}", tags.size());
            return Response.success();
        } catch (DuplicateKeyException e) {
            log.error("==> 含有重复标签名", e);
            return Response.fail(String.format("%s: %s", ResponseCodeEnum.DUPLICATE_TAG_ERROR.getErrorMessage(), e.getMessage()));
        }
    }

    @Override
    public Response deleteTag(DeleteTagReqVO deleteTagReqVO) {
        removeById(deleteTagReqVO.getTagId());
        // ========== 清除标签缓存 ==========
        evictTagCaches();
        log.info("删除标签成功，tagId: {}", deleteTagReqVO.getTagId());
        return Response.success();
    }

    // ============================================================
    // 读操作：从缓存读取
    // ============================================================

    @Override
    public Response queryTagPageList(QueryTagPageListReqVO queryTagPageListReqVO) {
        Long current = queryTagPageListReqVO.getCurrent();
        Long size = queryTagPageListReqVO.getSize();
        Date startDate = queryTagPageListReqVO.getStartDate();
        Date endDate = queryTagPageListReqVO.getEndDate();
        String tagName = queryTagPageListReqVO.getTagName();

        // 生成缓存 Key（包含所有查询参数）
        String cacheKey = TAG_PAGE_LIST_PREFIX + current + ":" + size + ":"
                + (startDate != null ? startDate.getTime() : "null") + ":"
                + (endDate != null ? endDate.getTime() : "null") + ":"
                + (tagName != null ? tagName : "null");

        // 1. 先从缓存取
        try {
            Object cached = redisService.get(cacheKey);
            if (cached != null) {
                log.info("从缓存获取标签列表，current: {}, size: {}", current, size);
                return Response.success(cached);
            }
        } catch (Exception e) {
            log.warn("Redis 读取标签列表失败，降级查数据库", e);
        }

        // 2. 缓存未命中，查数据库
        Page<TagDO> tagDOPage = tagDao.queryTagPageList(current, size, startDate, endDate, tagName);

        // 3. 写入缓存（30分钟过期）
        try {
            redisService.set(cacheKey, tagDOPage, TAG_CACHE_TTL, TimeUnit.MINUTES);
            log.info("标签列表已缓存，current: {}, size: {}", current, size);
        } catch (Exception e) {
            log.warn("Redis 写入标签列表缓存失败", e);
        }

        return Response.success(tagDOPage);
    }

    @Override
    public Response searchTags(SearchTagReqVO searchTagReqVO) {
        String key = searchTagReqVO.getKey();
        String cacheKey = TAG_SEARCH_LIST_PREFIX + (key != null ? key : "all");

        // 1. 先从缓存取
        try {
            Object cached = redisService.get(cacheKey);
            if (cached != null) {
                log.info("从缓存获取搜索标签结果，key: {}", key);
                return Response.success(cached);
            }
        } catch (Exception e) {
            log.warn("Redis 读取搜索标签失败，降级查数据库，key: {}", key, e);
        }

        // 2. 缓存未命中，查数据库
        List<TagDO> tagDOS = tagDao.searchTags(key);
        List<QuerySelectListRspVO> selectListRspVOS = null;
        if (!CollectionUtils.isEmpty(tagDOS)) {
            selectListRspVOS = tagDOS.stream()
                    .map(p -> QuerySelectListRspVO.builder()
                            .label(p.getName())
                            .value(p.getId())
                            .build())
                    .collect(Collectors.toList());
        }

        // 3. 写入缓存（30分钟过期）
        try {
            redisService.set(cacheKey, selectListRspVOS, TAG_CACHE_TTL, TimeUnit.MINUTES);
            log.info("搜索标签结果已缓存，key: {}", key);
        } catch (Exception e) {
            log.warn("Redis 写入搜索标签缓存失败，key: {}", key, e);
        }

        return Response.success(selectListRspVOS);
    }

    @Override
    public Response queryTagSelectList() {
        // 1. 先从缓存取
        try {
            Object cached = redisService.get(TAG_SELECT_LIST_PREFIX);
            if (cached != null) {
                log.info("从缓存获取标签下拉列表");
                return Response.success(cached);
            }
        } catch (Exception e) {
            log.warn("Redis 读取标签下拉列表失败，降级查数据库", e);
        }

        // 2. 缓存未命中，查数据库
        List<TagDO> tagDOS = tagDao.selectAll();
        List<QuerySelectListRspVO> list = null;
        if (!CollectionUtils.isEmpty(tagDOS)) {
            list = tagDOS.stream()
                    .map(p -> QuerySelectListRspVO.builder()
                            .label(p.getName())
                            .value(p.getId())
                            .build())
                    .collect(Collectors.toList());
        }

        // 3. 写入缓存（30分钟过期）
        try {
            redisService.set(TAG_SELECT_LIST_PREFIX, list, TAG_CACHE_TTL, TimeUnit.MINUTES);
            log.info("标签下拉列表已缓存");
        } catch (Exception e) {
            log.warn("Redis 写入标签下拉列表缓存失败", e);
        }

        return Response.success(list);
    }

    // ============================================================
    // 私有方法：统一清除缓存
    // ============================================================

    /**
     * 清除所有标签缓存
     */
    private void evictTagCaches() {
        try {
            // 清除标签分页列表缓存（按前缀批量删除）
            redisService.deleteByPrefix(TAG_PAGE_LIST_PREFIX);
            // 清除标签搜索缓存（按前缀批量删除）
            redisService.deleteByPrefix(TAG_SEARCH_LIST_PREFIX);
            // 清除标签下拉列表缓存
            redisService.delete(TAG_SELECT_LIST_PREFIX);
            log.info("清除所有标签缓存成功");
        } catch (Exception e) {
            log.warn("清除标签缓存失败", e);
        }
    }
}