/**
 * FileName: Admin
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/6 17:52
 * Description: 管理员实体类
 */
package com.qst.goldenarches.pojo;

public class Admin {

    /**
     * 管理员id
     */
    private int id;
    /**
     * 管理员名字
     */
    private String name;
    /**
     * 管理员账户
     */
    private String account;
    /**
     * 管理员密码
     */
    private String password;
    /**
     * 管理员创建时间
     */
    private String createTime;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    @Override
    public String toString() {
        return "Admin{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", account='" + account + '\'' +
                ", password='" + password + '\'' +
                ", createTime='" + createTime + '\'' +
                '}';
    }
}
