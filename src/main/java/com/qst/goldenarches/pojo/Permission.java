/**
 * FileName: PermissionController
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/7 9:16
 * Description: 权限实体类，用于封装许可数据
 */
package com.qst.goldenarches.pojo;

import java.util.ArrayList;
import java.util.List;

public class Permission {
    /**
     * 许可的id
     */
    private Integer id;
    /**
     * 许可的名字
     */
    private String name;
    /**
     * 许可的链接地址
     */
    private String url;
    /**
     * 许可的上级许可id
     */
    private Integer pid;
    /**
     * 封装ztree，默认是否打开
     */
    private boolean open = true;
    /**
     * ztree,默认是否选中
     */
    private boolean checked = false;
    /**
     * 许可的图标
     */
    private String icon;
    /**
     * 该许可下的子菜单
     */
    private List<Permission> children = new ArrayList<Permission>();

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public boolean isOpen() {
        return open;
    }

    public void setOpen(boolean open) {
        this.open = open;
    }

    public boolean isChecked() {
        return checked;
    }

    public void setChecked(boolean checked) {
        this.checked = checked;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public List<Permission> getChildren() {
        return children;
    }

    public void setChildren(List<Permission> children) {
        this.children = children;
    }
}
