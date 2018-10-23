/**
 * FileName: CategoryMapper
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/9/30 17:07
 * Description:
 */
package com.qst.goldenarches.dao;

import com.qst.goldenarches.pojo.Category;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface CategoryMapper {

    List<Category> selectAll(@Param("queryText") String queryText);

    int insertCategory(Category category);

    int updateCategory(Category category);

    int deleteCategory(Integer id);

    int deleteCategories(Map<String, Object> map);

    List<Category> selectHaveProductCategories(Map<String, Object> map);
}
