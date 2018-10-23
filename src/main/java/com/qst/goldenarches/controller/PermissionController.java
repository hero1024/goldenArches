/**
 * FileName: PermissionController
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/7 9:14
 * Description: 权限许可控制
 */
package com.qst.goldenarches.controller;


import com.qst.goldenarches.pojo.Permission;
import com.qst.goldenarches.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("permission")
public class PermissionController {

    @Autowired
    private PermissionService permissionService;


    /**
     *  为带复选框的树获取数据，
     *  并传入角色id,为该角色勾选已分配的许可
     * @param roleid
     * @return
     */
    @ResponseBody
    @RequestMapping("/loadAssignData")
    public Object loadAssignData( Integer roleid ) {
        List<Permission> permissions = new ArrayList<Permission>();
        List<Permission> ps = permissionService.getAllPermissions();

        // 获取当前角色已经分配的许可信息
        List<Integer> permissionids = permissionService.getPermissionIdsByRoleId(roleid);

        Map<Integer, Permission> permissionMap = new HashMap<Integer, Permission>();
        //根据角色已经分配的许可信息，判断是否勾选复选框
        for (Permission p : ps) {
            if ( permissionids.contains(p.getId()) ) {
                p.setChecked(true);
            } else {
                p.setChecked(false);
            }
            permissionMap.put(p.getId(), p);
        }
        for ( Permission p : ps ) {
            Permission child = p;
            if ( child.getPid() == 0 ) {
                permissions.add(p);
            } else {
                Permission parent = permissionMap.get(child.getPid());
                parent.getChildren().add(child);
            }
        }
        return permissions;
    }
}
