/**
 * FileName: CategoryServiceImpl
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/9/30 17:06
 * Description:
 */
package com.qst.goldenarches.service.impl;

import com.qst.goldenarches.dao.CategoryMapper;
import com.qst.goldenarches.pojo.Category;
import com.qst.goldenarches.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    private CategoryMapper categoryMapper;

    public List<Category> getAll(String queryText) {
       return categoryMapper.selectAll(queryText);
    }

    public boolean addCategory(Category category) {
        return categoryMapper.insertCategory(category)==1?true:false;
    }

    public boolean editCategory(Category category) {
        return categoryMapper.updateCategory(category)==1?true:false;
    }

    public boolean reomveCategory(Integer id) {
        return categoryMapper.deleteCategory(id)==1?true:false;
    }

    public boolean deleteProducts(Map<String, Object> map) {
        return categoryMapper.deleteCategories(map)==0?false:true;
    }

    public List<Category> getHaveProductCategories(Map<String, Object> map) {
        return categoryMapper.selectHaveProductCategories(map);
    }
}
