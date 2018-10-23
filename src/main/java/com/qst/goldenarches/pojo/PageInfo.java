package com.qst.goldenarches.pojo;
import java.util.List;
/**
 * 分页用的类
 */
public class PageInfo {
    /**
     * 每页多少条数据
     */
    private int pageSize;
    /**
     * 当前第几页
     */
    private int pageNum;
    /**
     * 总共多少页
     */
    private int total;
    /**
     * 当前页所有数据的集合
     */
    private List<?> list;
    /**
     * 当前页起始行
     */
    private int pageStart;
    /**
     * 商品类型,需要根据商品类型分页
     */
    private String category;

    public String getCategory() {
        return category;
    }
    public void setCategory(String category) {
        this.category = category;
    }
    public int getPageSize() {
        return pageSize;
    }
    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }
    public int getPageNum() {
        return pageNum;
    }
    public void setPageNum(int pageNum) {
        this.pageNum = pageNum;
    }
    public int getTotal() {
        return total;
    }
    public void setTotal(int total) {
        this.total = total;
    }
    public List<?> getList() {
        return list;
    }
    public void setList(List<?> list) {
        this.list = list;
    }
    public int getPageStart() {
        return pageStart;
    }
    public void setPageStart(int pageStart) {
        this.pageStart = pageStart;
    }
}
