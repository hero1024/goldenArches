/**
 * FileName: PermissionServiceImpl
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/7 9:26
 * Description:
 */
package com.qst.goldenarches.service.impl;

import com.qst.goldenarches.dao.PermissionMapper;
import com.qst.goldenarches.pojo.Admin;
import com.qst.goldenarches.pojo.Permission;
import com.qst.goldenarches.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PermissionServiceImpl implements PermissionService {

    @Autowired
    private PermissionMapper permissionMapper;

    public List<Permission> getAllPermissions() {
        return permissionMapper.selectAllPermission();
    }

    public List<Integer> getPermissionIdsByRoleId(Integer roleId) {
        return permissionMapper.getPermissionIdsByRoleId(roleId);
    }

    public List<Permission> getPermissionsByAdmin(Admin admin) {
        return permissionMapper.selectPermissionsByAdmin(admin);
    }
}
