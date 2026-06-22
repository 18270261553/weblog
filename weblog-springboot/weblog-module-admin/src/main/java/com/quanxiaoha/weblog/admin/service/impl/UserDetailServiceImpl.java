package com.quanxiaoha.weblog.admin.service.impl;

import com.quanxiaoha.weblog.admin.dao.AdminUserDao;
import com.quanxiaoha.weblog.admin.dao.AdminUserRoleDao;
import com.quanxiaoha.weblog.common.domain.dos.UserDO;
import com.quanxiaoha.weblog.common.domain.dos.UserRoleDO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Slf4j
public class UserDetailServiceImpl implements UserDetailsService {

    @Autowired
    private AdminUserDao userDao;
    @Autowired
    private AdminUserRoleDao userRoleDao;

    @Override
    public UserDetails loadUserByUsername(String username) {
        // 1. 查询用户
        UserDO userDO = userDao.selectByUsername(username);
        if (userDO == null) {
            throw new UsernameNotFoundException("该用户不存在");
        }

        // 2. 查询用户角色
        List<UserRoleDO> roleDOS = userRoleDao.selectByUsername(username);
        if (!CollectionUtils.isEmpty(roleDOS)) {
            List<String> roles = roleDOS.stream()
                    .map(UserRoleDO::getRole)
                    .collect(Collectors.toList());
            userDO.setRoles(roles);  // ← 关键：设置角色列表
        }

        log.info("用户登录成功，username: {}, roles: {}", userDO.getUsername(), userDO.getRoles());

        return userDO;
    }
}