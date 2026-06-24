package com.quanxiaoha.weblog.admin.dao.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.quanxiaoha.weblog.admin.dao.MessageDao;
import com.quanxiaoha.weblog.common.domain.dos.MessageDO;
import com.quanxiaoha.weblog.common.domain.mapper.MessageMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;

@Service
@Slf4j
public class MessageDaoImpl implements MessageDao {

    @Autowired
    private MessageMapper messageMapper;

    @Override
    public IPage<MessageDO> queryMessagePageList(Long current, Long size, Integer status, String startDate, String endDate) {
        Page<MessageDO> page = new Page<>(current, size);
        LambdaQueryWrapper<MessageDO> wrapper = new LambdaQueryWrapper<>();

        // 状态筛选
        if (status != null) {
            wrapper.eq(MessageDO::getStatus, status);
        }

        // 日期范围
        if (StringUtils.hasText(startDate)) {
            wrapper.ge(MessageDO::getCreateTime, startDate);
        }
        if (StringUtils.hasText(endDate)) {
            wrapper.le(MessageDO::getCreateTime, endDate);
        }

        // 只查顶级留言（管理端看到回复）
        // 按时间倒序
        wrapper.orderByDesc(MessageDO::getCreateTime);
        wrapper.eq(MessageDO::getIsDeleted, 0);

        return messageMapper.selectPage(page, wrapper);
    }

    @Override
    public int updateStatus(Long id, Integer status) {
        MessageDO messageDO = MessageDO.builder()
                .id(id)
                .status(status)
                .build();
        return messageMapper.updateById(messageDO);
    }

    @Override
    public List<MessageDO> selectTopMessages() {
        LambdaQueryWrapper<MessageDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(MessageDO::getParentId, 0)
                .eq(MessageDO::getStatus, 1)  // 只查已通过的
                .eq(MessageDO::getIsDeleted, 0)
                .orderByDesc(MessageDO::getCreateTime);
        return messageMapper.selectList(wrapper);
    }

    @Override
    public List<MessageDO> selectRepliesByParentId(Long parentId) {
        LambdaQueryWrapper<MessageDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(MessageDO::getParentId, parentId)
                .eq(MessageDO::getStatus, 1)
                .eq(MessageDO::getIsDeleted, 0)
                .orderByAsc(MessageDO::getCreateTime);
        return messageMapper.selectList(wrapper);
    }

    @Override
    public int increaseLikeCount(Long id) {
        return messageMapper.increaseLikeCount(id);
    }
}