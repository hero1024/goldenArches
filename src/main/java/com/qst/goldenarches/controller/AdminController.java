/**
 * FileName: AdminController
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/6 17:59
 * Description: 管理员控制类
 */
package com.qst.goldenarches.controller;
import com.github.pagehelper.PageHelper;
import com.qst.goldenarches.pojo.*;
import com.qst.goldenarches.service.AdminService;
import com.qst.goldenarches.service.PermissionService;
import com.qst.goldenarches.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    @Autowired
    private RoleService roleService;

    @Autowired
    private PermissionService permissionService;


    /**
     * 跳转到错误页面(权限不足)
     * @return
     */
    @RequestMapping("error")
    public String error() {
        return "admin/error";
    }

    /**
     * 删除管理员的角色
     * @param adminId
     * @param assignRoleIds
     * @return
     */
    @ResponseBody
    @RequestMapping("doUnAssign")
    public Object dounAssign( Integer adminId, Integer[] assignRoleIds ) {
        try {
            // 删除关系表数据
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("adminId", adminId);
            map.put("roleIds", assignRoleIds);
            adminService.removeAdminRoles(map);
            return Msg.success();
        } catch ( Exception e ) {
            e.printStackTrace();
            return Msg.fail();
        }
    }
    /**
     * 为管理员分配角色
     * @param adminId
     * @param unassignRoleIds
     * @return
     */
    @ResponseBody
    @RequestMapping("doAssign")
    public Object doAssign( Integer adminId, Integer[] unassignRoleIds ) {
        try {
            // 增加admin_role关系表数据
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("adminId", adminId);
            map.put("roleIds", unassignRoleIds);
            adminService.addAdminRoles(map);
            return Msg.success();
        } catch ( Exception e ) {
            e.printStackTrace();
            return Msg.fail();
        }
    }
    /**
     * 页面跳转：
     * 跳转到管理员角色分配页面
     * 数据回显，显示已经分配的角色
     * 和没有分配的角色
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("/assign")
    public String assign( Integer id, Model model ) {

        Admin admin = adminService.getAdminById(id);
        model.addAttribute("admin", admin);

        List<Role> roles = roleService.getAllRoles(null);

        List<Role> assingedRoles = new ArrayList<Role>();
        List<Role> unassignRoles = new ArrayList<Role>();

        // 获取关系表的数据
        List<Integer> roleids = adminService.getRoleIdsByAdminId(id);
        for ( Role role : roles ) {
            if ( roleids.contains(role.getId()) ) {
                assingedRoles.add(role);
            } else {
                unassignRoles.add(role);
            }
        }
        model.addAttribute("assingedRoles", assingedRoles);
        model.addAttribute("unassignRoles", unassignRoles);
        return "admin/assign";
    }
    /**
     * 根据id删除管理员
     * @param adminid
     * @return
     */
    @ResponseBody
    @RequestMapping("/deletes")
    public Msg deletes( Integer[] adminid ) {
        try {
            if (adminid.length>0){
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("adminids", adminid);
                adminService.removeAdmins(map);
                return Msg.success();
            }
            return  Msg.fail();
        } catch ( Exception e ) {
            e.printStackTrace();
             return Msg.fail();
        }
    }
    /**
     * 实现用户修改业务逻辑
     * @param admin
     * @return
     */
    @ResponseBody
    @RequestMapping("/doEdit")
    public Msg update(HttpSession session, Admin admin ) {
        try {
            Admin sessionAdmin =(Admin) session.getAttribute("loginAdmin");
            if(sessionAdmin.getId()==admin.getId()){
                adminService.editAdmin(admin);
                session.setAttribute("loginAdmin",admin);
                return Msg.success();
            }
            return Msg.fail();
        } catch ( Exception e ) {
            e.printStackTrace();
             return Msg.fail();
        }
    }

    /**
     * 跳转到修改个人信息(admin)界面
     * @param model
     * @return
     */
    @RequestMapping("/edit")
    public String edit(HttpSession session,Model model ) {
        Admin admin =(Admin) session.getAttribute("loginAdmin");
        model.addAttribute("admin",admin);
        return "admin/edit";
    }

    /**
     * 新增界面实现新增业务
     * @param admin
     * @return
     */
    @ResponseBody
    @RequestMapping("doAdd")
    public Msg doAdd( Admin admin ) {
        try {
            if (adminService.validateAccountUnique(admin.getAccount())){
                admin.setPassword("1234");//默认密码
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                admin.setCreateTime(sdf.format(new Date()));
                adminService.addAdmin(admin);
                return Msg.success();
            }
            return Msg.fail();
        } catch ( Exception e ) {
            e.printStackTrace();
             return Msg.fail();
        }

    }

    /**
     * 检验用户账户唯一性
     * @param account
     * @return
     */
    @RequestMapping("uniqueAcct")
    @ResponseBody
    public Msg validateAccountUnique(String account,HttpSession session){
        try {
            if(account!=null) {
                boolean flag = adminService.validateAccountUnique(account);
                if (flag){
                    return Msg.success();
                }
            }
            return Msg.fail().add("va_msg","账户已存在");
        }catch (Exception e){
            e.printStackTrace();
            return Msg.fail().add("va_mag","服务异常,稍后重试");
        }
    }
    /**
     * 跳转到新增界面
     * @return
     */
    @RequestMapping("add")
    public String toAdd(){
        return "admin/add";
    }

    /**
     *
     * @param pn
     * @param pagesize
     * @param queryText
     * @return
     */
    @ResponseBody
    @RequestMapping("/pageQuery")
    public Msg pageQuery( @RequestParam(value = "pageno",defaultValue = "1") Integer pn,
                          @RequestParam(value = "pagesize",defaultValue = "10")Integer pagesize , String queryText) {
        try {
            PageHelper.startPage(pn,pagesize);
            List<Admin> admins =adminService.getAllAdmin(queryText);

            com.github.pagehelper.PageInfo<Admin> adminPageInfo =
                    new com.github.pagehelper.PageInfo<Admin>(admins,5);
            return Msg.success().add("pageInfo",adminPageInfo);
        } catch ( Exception e ) {
            e.printStackTrace();
             return Msg.fail();
        }
    }
    /**
     * 页面跳转
     * 管理员列表主界面
     * @return
     */
    @RequestMapping("/index")
    public String index(){
        return "admin/index";
    }

    /***
     * 管理员退出
     * @param session
     * @return
     */
    @RequestMapping("logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:/admin/login";
    }
    /**
     * 跳转到登陆后的主页面，
     * 也是数据分析主页面
     * @return
     */
    @RequestMapping("main")
    public String toMain(){
        return "admin/main";
    }
    /**
     * 执行管理员登陆
     * @param admin
     * @param session
     * @return
     */
    @ResponseBody
    @RequestMapping("/doLogin")
    public Msg doLogin(Admin admin, HttpSession session){

        Admin dbAdmin =adminService.login(admin);
        if (dbAdmin!=null){
            session.setAttribute("loginAdmin",dbAdmin);

            // 获取用户权限信息
            List<Permission> permissions = permissionService.getPermissionsByAdmin(dbAdmin);
            Map<Integer, Permission> permissionMap = new HashMap<Integer, Permission>();
            Permission root = null;
            Set<String> uriSet = new HashSet<String>();
            for ( Permission permission : permissions ) {
                permissionMap.put(permission.getId(), permission);
                if ( permission.getUrl() != null && !"".equals(permission.getUrl()) ) {
                    uriSet.add(session.getServletContext().getContextPath() + permission.getUrl());
                }
            }
            session.setAttribute("authUriSet", uriSet);
            for ( Permission permission : permissions ) {
                Permission child = permission;
                if ( child.getPid() == 0 ) {
                    root = permission;
                } else {
                    Permission parent = permissionMap.get(child.getPid());
                    parent.getChildren().add(child);
                }
            }
            session.setAttribute("rootPermission", root);
            return Msg.success();
        }else {
            return Msg.fail();
        }
    }
    /**
     * 跳转到登陆页面
     * @return
     */
    @RequestMapping("login")
    public String toLogin(){
        return "admin/login";
    }
}
