package com.qst.goldenarches.pojo;

/**
 * 订单表
 */
public class Order {
    /**
     * 订单ID
     */
    private int id;
    /**
     * 商品购买者ID
     * 若是会员则是会员id
     * 若不是会员可以为空
     */
    private int bid;
    /**
     * 本次订单总金额
     */
    private double amount;

    /***
     * 创建时间
     */
    private String createTime;
    /**
     * 会员对象
     */
    private VIP vip;



    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getBid() {
        return bid;
    }

    public void setBid(int bid) {
        this.bid = bid;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public VIP getVip() {
        return vip;
    }

    public void setVip(VIP vip) {
        this.vip = vip;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", bid=" + bid +
                ", amount=" + amount +
                ", vip=" + vip +
                ", createTime='" + createTime + '\'' +
                '}';
    }
}
