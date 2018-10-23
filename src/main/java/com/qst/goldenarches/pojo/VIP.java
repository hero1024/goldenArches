package com.qst.goldenarches.pojo;

/**
 * VIP会员表
 */
public class VIP {
    /**
     * 会员id
     */
    private int id;
    /**
     * 会员名
     */
    private String name;
    /**
     * 会员卡号（手机号）
     */
    private String phone;
    /**
     * 会员账号余额
     */
    private Double balance;

    /**
     * 账户创建时间
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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Double getBalance() {
        return balance;
    }

    public void setBalance(Double balance) {
        this.balance = balance;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    @Override
    public String toString() {
        return "VIP{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", phone='" + phone + '\'' +
                ", balance=" + balance +
                ", createTime='" + createTime + '\'' +
                '}';
    }
}
