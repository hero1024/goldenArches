/**
 * FileName: AdminServiceImpl
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/6 18:01
 * Description: 管理员服务层实现类
 */
package com.qst.goldenarches.service.impl;

import com.qst.goldenarches.dao.AdminMapper;
import com.qst.goldenarches.pojo.Admin;
import com.qst.goldenarches.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminMapper adminMapper;

    public Admin login(Admin admin) {
        return adminMapper.selectAdminByAdmin(admin);
    }

    public List<Admin> getAllAdmin(String queryText) {
        return adminMapper.selectAllAdmin(queryText);
    }

    public boolean validateAccountUnique(String account) {
        return adminMapper.selectAdminByAccount(account)==null?true:false;
    }

    public void addAdmin(Admin admin) {
        adminMapper.insertAdmin(admin);
    }

    public void removeAdmins(Map<String, Object> map) {
        adminMapper.deleteAdmins(map);
    }

    public Admin getAdminById(Integer id) {
        return adminMapper.selectAdminById(id);
    }
    public List<Integer> getRoleIdsByAdminId(Integer id) {
        return adminMapper.selectRoleIdsByAdminId(id);
    }

    public void addAdminRoles(Map<String, Object> map) {
        adminMapper.insertAdminRoles(map);
    }

    public void removeAdminRoles(Map<String, Object> map) {
        adminMapper.deleteAdminRoles(map);
    }

    public void editAdmin(Admin admin) {
        adminMapper.updateAdmin(admin);
    }
}
