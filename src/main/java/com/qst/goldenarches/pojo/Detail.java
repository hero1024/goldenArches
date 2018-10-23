package com.qst.goldenarches.pojo;

/**
 * 订单详细表
 */
public class Detail {
    /**
     * 订单详细表id
     */
    private int id;
    /**
     * 订单总表ID
     */
    private int oid;
    /**
     * 商品ID
     */
    private int pid;
    /**
     * 商品名
     */
    private String pname;
    /**
     * 商品数量
     */
    private int number;

    /**
     * 价格
     */
    private double price;


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOid() {
        return oid;
    }

    public void setOid(int oid) {
        this.oid = oid;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "Detail{" +
                "id=" + id +
                ", oid=" + oid +
                ", pid=" + pid +
                ", pname='" + pname + '\'' +
                ", number=" + number +
                ", price=" + price +
                '}';
    }
}
