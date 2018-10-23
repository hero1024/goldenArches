/**
 * FileName: ProductService
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/9/29 21:28
 * Description:
 */
package com.qst.goldenarches.service;

import com.qst.goldenarches.pojo.Category;
import com.qst.goldenarches.pojo.PageInfo;
import com.qst.goldenarches.pojo.Product;

import java.util.List;
import java.util.Map;

public interface ProductService {
    List<Product> getAll(String text);

    boolean addProduct(Product product);

    Product getProductById(Integer id);

    boolean editProductData(Product product);

    boolean editProductPic(Product product);

    void removeProduct(Integer id);

    void deleteProducts(Map<String, Object> map);

    boolean isTypeHaveProduct(Integer id);

    /**
     * 分页分类型展示页面
     * @param pageNumStr    当前页码
     * @param category      当前类型
     * @return      返回的是整个分页类对象，用于往客户端传递
     */
    PageInfo showPage(String pageNumStr, Integer categoryId);

    /**
     * 获取数据库中所有的类型，用于类型展示
     * @return  返回类型的集合
     */
    List<Category> getCategory();
}
