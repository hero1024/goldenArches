/**
 * FileName: PermissionMapper
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/7 9:27
 * Description:
 */
package com.qst.goldenarches.dao;

import com.qst.goldenarches.pojo.Admin;
import com.qst.goldenarches.pojo.Permission;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface PermissionMapper {
    /**
     * 查询全部的许可数据
     * @return
     */
    @Select("SELECT * FROM t_permission")
    List<Permission> selectAllPermission();

    @Select("SELECT permission_id FROM t_role_permission WHERE role_id =#{0}")
    List<Integer> getPermissionIdsByRoleId(Integer roleId);

    List<Permission> selectPermissionsByAdmin(Admin admin);
}
