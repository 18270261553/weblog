package com.quanxiaoha.weblog.admin.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.quanxiaoha.weblog.admin.dao.MessageDao;
import com.quanxiaoha.weblog.admin.model.vo.message.MessageDeleteReqVO;
import com.quanxiaoha.weblog.admin.model.vo.message.MessageListRespVO;
import com.quanxiaoha.weblog.admin.model.vo.message.MessageStatusReqVO;
import com.quanxiaoha.weblog.admin.service.AdminMessageService;
import com.quanxiaoha.weblog.common.PageResponse;
import com.quanxiaoha.weblog.common.Response;
import com.quanxiaoha.weblog.common.domain.dos.MessageDO;
import com.quanxiaoha.weblog.common.domain.mapper.MessageMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Slf4j
public class AdminMessageServiceImpl extends ServiceImpl<MessageMapper, MessageDO> implements AdminMessageService {

    @Autowired
    private MessageDao messageDao;

    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    @Override
    public PageResponse queryMessagePageList(Long current, Long size, Integer status, String startDate, String endDate) {
        IPage<MessageDO> page = messageDao.queryMessagePageList(current, size, status, startDate, endDate);

        List<MessageDO> records = page.getRecords();
        List<MessageListRespVO> respVOList = null;

        if (!CollectionUtils.isEmpty(records)) {
            respVOList = records.stream()
                    .map(this::convertToRespVO)
                    .collect(Collectors.toList());
        }

        return PageResponse.success(page, respVOList);
    }

    @Override
    public Response updateMessageStatus(MessageStatusReqVO reqVO) {
        int result = messageDao.updateStatus(reqVO.getId(), reqVO.getStatus());
        if (result > 0) {
            log.info("留言状态更新成功，id: {}, status: {}", reqVO.getId(), reqVO.getStatus());
            return Response.success();
        }
        return Response.fail("更新失败");
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Response deleteMessage(MessageDeleteReqVO reqVO) {
        Long id = reqVO.getId();

        // 软删除留言
        MessageDO updateDO = MessageDO.builder()
                .id(id)
                .isDeleted(1)
                .build();
        int result = baseMapper.updateById(updateDO);

        if (result > 0) {
            log.info("留言删除成功，id: {}", id);
            return Response.success();
        }
        return Response.fail("删除失败");
    }

    /**
     * 转换为响应 VO
     */
    private MessageListRespVO convertToRespVO(MessageDO messageDO) {
        return MessageListRespVO.builder()
                .id(messageDO.getId())
                .userId(messageDO.getUserId())
                .username(messageDO.getUsername())
                .email(messageDO.getEmail())
                .content(messageDO.getContent())
                .parentId(messageDO.getParentId())
                .status(messageDO.getStatus())
                .ipAddress(messageDO.getIpAddress())
                .likeCount(messageDO.getLikeCount())
                .createTime(messageDO.getCreateTime() != null
                        ? messageDO.getCreateTime().format(DATE_FORMATTER)
                        : null)
                .build();
    }
}