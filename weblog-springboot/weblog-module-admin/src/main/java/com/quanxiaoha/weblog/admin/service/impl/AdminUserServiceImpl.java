package com.quanxiaoha.weblog.admin.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.quanxiaoha.weblog.admin.dao.AdminUserDao;
import com.quanxiaoha.weblog.admin.dao.AdminUserRoleDao;
import com.quanxiaoha.weblog.admin.model.dto.UserRegisterReqDTO;
import com.quanxiaoha.weblog.admin.model.vo.user.UpdateAdminPasswordReqVO;
import com.quanxiaoha.weblog.admin.service.AdminUserService;
import com.quanxiaoha.weblog.common.Response;
import com.quanxiaoha.weblog.common.domain.dos.UserDO;
import com.quanxiaoha.weblog.common.domain.dos.UserRoleDO;
import com.quanxiaoha.weblog.common.domain.mapper.UserMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
 * @author: dgq   
 * @date: 2023-04-17 12:08
 * @description: TODO
 **/
@Service
@Slf4j
public class AdminUserServiceImpl extends ServiceImpl<UserMapper, UserDO> implements AdminUserService {

    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private AdminUserDao userDao;
    @Autowired
    private AdminUserRoleDao userRoleDao;

    @Override
    public Response updateAdminPassword(UpdateAdminPasswordReqVO updateAdminPasswordReqVO) {
        UserDO userDO = UserDO.builder()
                .password(passwordEncoder.encode(updateAdminPasswordReqVO.getNewPassword()))
                .updateTime(new Date())
                .build();
        userDao.updateAdminPassword(userDO);
        return Response.success();
    }

    @Override
    public Response register(UserRegisterReqDTO dto) {
        // 1. 两次密码是否一致
        if (!dto.getPassword().equals(dto.getRepeatPassword())) {
            return Response.fail("两次密码输入不一致");
        }

        // 2. 判断用户名是否已存在
        UserDO existUser = userDao.selectByUsername(dto.getUsername());
        if (existUser != null) {
            return Response.fail("用户名已存在");
        }

        // 3. 密码加密
        String encodePwd = passwordEncoder.encode(dto.getPassword());


        // 4. 构建用户实体
        UserDO user = UserDO.builder()
                .username(dto.getUsername())
                .password(encodePwd)
                .createTime(new Date())
                .updateTime(new Date())
                .isDeleted(false)
                .build();
        // 5. 插入用户表
        baseMapper.insert(user);
        // 6. 分配默认角色 ROLE_USER
        UserRoleDO userRole = UserRoleDO.builder()
                .username(dto.getUsername())
                .role("ROLE_USER")
                .createTime(new Date())
                .build();
        userRoleDao.insert(userRole);
        return Response.success("注册成功");
    }
}
