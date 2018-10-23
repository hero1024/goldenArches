/**
 * FileName: ProductMapper
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/9/29 21:30
 * Description:
 */
package com.qst.goldenarches.dao;

import com.qst.goldenarches.pojo.Category;
import com.qst.goldenarches.pojo.Product;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

public interface ProductMapper {


    List<Product> selectAll(@Param("text") String text);

    int insertProduct(Product product);

    Product selectProductById(Integer id);

    int updateProductByProduct(Product product);

    int updateProductPicByProduct(Product product);

    @Delete("DELETE FROM product_info WHERE product_id =#{0}")
    void deleteProductById(Integer id);

    void deleteProducts(Map<String, Object> map);

    @Select("SELECT COUNT(*) FROM product_info WHERE category_id =#{cid}")
    int countProductByCid(Integer id);



    //@Select("select product_id id,product_name name,product_price price,product_inventory inventory,product_status status,p.category_id cid,c.category_id `category.id`,category_name `category.name`,product_pic pic from product_info p join product_category c on p.category_id = c.category_id  where category_name = #{category} limit #{pageStart},#{pageSize}")
    public List<Product> selByPage(Map<String, Integer> map);

   // @Select("select count(*) from product_info p join product_category c on p.category_id = c.category_id where category_name = #{0}")
    //@Select("select count(*) from product_info where category_id = #{0}")
    public int selCount(@Param("categoryId") Integer categoryId);

    @Select("select category_id id,category_name name from product_category where category_id=#{0}")
    public Category selById(int id);

    @Select("select category_id id,category_name name from product_category")
    public List<Category> selAllCategory();

}
