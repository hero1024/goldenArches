package com.qst.goldenarches.pojo;

/**
 * 商品类型表
 */
public class Category {
    /**
     * 商品类型ID
     */
    private int id;
    /**
     * 商品类型名
     */
    private String name;

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

    @Override
    public String toString() {
        return "Category{" +
                "id=" + id +
                ", name='" + name + '\'' +
                '}';
    }
}
