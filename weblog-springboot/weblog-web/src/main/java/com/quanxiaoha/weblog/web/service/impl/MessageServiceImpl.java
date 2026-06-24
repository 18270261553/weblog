package com.quanxiaoha.weblog.web.service.impl;

import com.quanxiaoha.weblog.admin.dao.MessageDao;
import com.quanxiaoha.weblog.common.Response;
import com.quanxiaoha.weblog.common.domain.dos.MessageDO;
import com.quanxiaoha.weblog.common.domain.mapper.MessageMapper;
import com.quanxiaoha.weblog.utils.SecurityUtil;
import com.quanxiaoha.weblog.web.model.vo.message.MessageListRspVO;
import com.quanxiaoha.weblog.web.model.vo.message.MessagePublishReqVO;
import com.quanxiaoha.weblog.web.service.MessageService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Slf4j
public class MessageServiceImpl implements MessageService {

    @Autowired
    private MessageMapper messageMapper;

    @Autowired
    private MessageDao messageDao;

    @Autowired
    private HttpServletRequest request;

    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Response publishMessage(MessagePublishReqVO reqVO) {
        // 获取当前登录用户
        Long userId = 0L;
        String username = reqVO.getUsername();
        String email = reqVO.getEmail();

        try {
            String currentUsername = SecurityUtil.getCurrentUsername();
            if (currentUsername != null) {
                // 已登录用户，使用系统用户名
                userId = SecurityUtil.getCurrentUserId() != null ? SecurityUtil.getCurrentUserId() : 0L;
                username = currentUsername;
                // 如果用户有邮箱，可以从用户信息中获取
            }
        } catch (Exception e) {
            // 未登录用户，使用前端传过来的昵称
            log.debug("用户未登录，使用游客模式");
        }

        // 获取IP地址
        String ipAddress = getClientIP(request);

        MessageDO messageDO = MessageDO.builder()
                .userId(userId)
                .username(username)
                .email(email)
                .content(reqVO.getContent())
                .parentId(reqVO.getParentId() != null ? reqVO.getParentId() : 0L)
                .status(0)  // 待审核
                .ipAddress(ipAddress)
                .likeCount(0)
                .createTime(LocalDateTime.now())
                .updateTime(LocalDateTime.now())
                .isDeleted(0)
                .build();

        int result = messageMapper.insert(messageDO);
        if (result > 0) {
            log.info("留言发表成功，id: {}", messageDO.getId());
            return Response.success("留言发表成功，等待审核");
        }
        return Response.fail("留言发表失败");
    }

    @Override
    public Response getMessageList() {
        // 1. 获取所有顶级留言（已通过的）
        List<MessageDO> topMessages = messageDao.selectTopMessages();

        if (CollectionUtils.isEmpty(topMessages)) {
            return Response.success(new ArrayList<>());
        }

        // 2. 转换为 VO
        List<MessageListRspVO> voList = topMessages.stream()
                .map(this::convertToRspVO)
                .collect(Collectors.toList());

        // 3. 查询每个顶级留言的回复
        for (MessageListRspVO vo : voList) {
            List<MessageDO> replies = messageDao.selectRepliesByParentId(vo.getId());
            if (!CollectionUtils.isEmpty(replies)) {
                List<MessageListRspVO> replyVOs = replies.stream()
                        .map(this::convertToRspVO)
                        .collect(Collectors.toList());
                vo.setReplies(replyVOs);
            }
        }

        return Response.success(voList);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Response likeMessage(Long messageId) {
        int result = messageDao.increaseLikeCount(messageId);
        if (result > 0) {
            return Response.success("点赞成功");
        }
        return Response.fail("点赞失败");
    }

    /**
     * 转换为响应 VO
     */
    private MessageListRspVO convertToRspVO(MessageDO messageDO) {
        return MessageListRspVO.builder()
                .id(messageDO.getId())
                .userId(messageDO.getUserId())
                .username(messageDO.getUsername())
                .content(messageDO.getContent())
                .likeCount(messageDO.getLikeCount())
                .createTime(messageDO.getCreateTime() != null
                        ? messageDO.getCreateTime().format(DATE_FORMATTER)
                        : null)
                .build();
    }

    /**
     * 获取客户端 IP 地址
     */
    private String getClientIP(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }
}