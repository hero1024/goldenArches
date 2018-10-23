/**
 * FileName: PermissionService
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/7 9:25
 * Description:
 */
package com.qst.goldenarches.service;

import com.qst.goldenarches.pojo.Admin;
import com.qst.goldenarches.pojo.Permission;

import java.util.List;

public interface PermissionService {

    /***
     * 获取所有的许可
     * @return
     */
    List<Permission> getAllPermissions();

    /**
     * 根据角色的id获取已经分配的许可
     * @param roleId
     * @return
     */
    List<Integer> getPermissionIdsByRoleId(Integer roleId);

    /**
     * 根据管理员获取许可
     * @param admin 管理员
     * @return
     */
    List<Permission> getPermissionsByAdmin(Admin admin);
}
