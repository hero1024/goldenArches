/**
 * FileName: AdminService
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/6 18:01
 * Description:
 */
package com.qst.goldenarches.service;

import com.qst.goldenarches.pojo.Admin;

import java.util.List;
import java.util.Map;

public interface AdminService {
    /**
     * 管理员登录
     * @param admin
     * @return
     */
    Admin login(Admin admin);

    /**
     * 获取所有管理员列表
     * @param queryText
     * @return
     */
    List<Admin> getAllAdmin(String queryText);

    /**
     * 检验账号的唯一性
     * @param account
     * @return 唯一：true
     */
    boolean validateAccountUnique(String account);

    /**
     * 增加管理员
     * @param admin
     */
    void addAdmin(Admin admin);

    /**
     * 根据id删除管理员
     * @param map
     */
    void removeAdmins(Map<String, Object> map);

    /**
     * 根据id获取
     * @param id
     * @return
     */
    Admin getAdminById(Integer id);

    /**
     * 获取角色的id，根据管理员id
     * @param id 管理员id
     * @return
     */
    List<Integer> getRoleIdsByAdminId(Integer id);

    /**
     * 为管理员增加角色
     * @param map
     */
    void addAdminRoles(Map<String, Object> map);

    /**
     * 删除管理员的角色
     * @param map
     */
    void removeAdminRoles(Map<String, Object> map);

    /**
     * 修改管理员信息
     * @param admin
     */
    void editAdmin(Admin admin);
}
