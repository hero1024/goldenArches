/**
 * FileName: CategoryController
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/9/30 17:04
 * Description:
 */
package com.qst.goldenarches.controller;

import com.github.pagehelper.PageHelper;
import com.qst.goldenarches.pojo.Category;
import com.qst.goldenarches.pojo.Msg;
import com.qst.goldenarches.pojo.Product;
import com.qst.goldenarches.service.CategoryService;
import com.sun.org.apache.regexp.internal.RE;
import com.sun.org.apache.xml.internal.security.keys.keyresolver.implementations.PrivateKeyResolver;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/category")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    /***
     * 商品类别：获取类别
     * 根据传入的商品类别id获取有商品的商品类别
     * @param categoryid
     * @return
     */
    @ResponseBody
    @RequestMapping("getCategories")
    public Msg getHaveProductCategories(Integer[] categoryid){
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("categoryids", categoryid);
        List<Category> categories =categoryService.getHaveProductCategories(map);
        return  Msg.success().add("categoryList",categories);
    }

    /***
     * 商品类别：批量删除商品类别
     * @param categoryid
     * @returns
     */
    @ResponseBody
    @RequestMapping("deleteBatch")
    public Msg deleteBatch(Integer[] categoryid){
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("categoryids", categoryid);
            if (!categoryService.deleteProducts(map)){
                return Msg.fail();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return Msg.fail();
        }
        return Msg.success();
    }
    /**
     * 商品类别：执行单个删除商品类别
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("deleteOne")
    public Msg deleteOne(Integer id){
        try {

            if(!categoryService.reomveCategory(id)){
                return Msg.fail();
            }
        }catch (Exception e){
            e.printStackTrace();
            return Msg.fail();
        }
        return Msg.success();
    }
    /**
     * 商品类别：执行商品信息修改方法
     * @param category
     * @return
     */
    @ResponseBody
    @RequestMapping("doEdit")
    public Msg doEdit(Category category){
        try {
            if(!categoryService.editCategory(category)){
                return Msg.fail();
            }
        }catch (Exception e){
            e.printStackTrace();
            return Msg.fail();
        }
        return Msg.success();
    }
    /**
     * 商品类别：跳转方法
     * 跳转到商品类别修改界面
     * @return
     */
    @RequestMapping("edit")
    public String toEdit(Category category, Model model){
        model.addAttribute("category", category);
        return "category/edit";
    }

    /**
     * 商品类别：添加商品类别
     * @param category
     * @return
     */
    @ResponseBody
    @RequestMapping("doAdd")
    public Msg doAdd(Category category){
        Boolean flag =categoryService.addCategory(category);
        if (flag){
            return Msg.success().add("category",category);
        }
        return Msg.fail();
    }
    /***
     * 商品类别：跳转方法
     * 跳转到商品类别添加界面
     * @return
     */
    @RequestMapping("add")
    public String toAdd(){
        return "category/add";
    }
    /**
     * 商品类别：分页查找
     * 查询全部商品类别并分页显示
     * @param pn 页码
     * @return json数据 Msg
     */
    @ResponseBody
    @RequestMapping("pagedGetAll")
    public Msg pagedGetAll(@RequestParam(value = "pageno",defaultValue = "1") Integer pn, String queryText){
        PageHelper.startPage(pn,5);
        List<Category> categories =categoryService.getAll(queryText);
        com.github.pagehelper.PageInfo<Category> categoryPageInfo =new com.github.pagehelper.PageInfo<Category>(categories,5);
        return Msg.success().add("pageInfo",categoryPageInfo);
    }

    /**
     * 商品后台：跳转方法
     * 跳转至商品类别主页
     * @return
     */
    @RequestMapping("index")
    public String toIndex(){
        return "category/index";
    }
    /***
     * 商品后台：获取全部商品类别
     * @return
     */
    @ResponseBody
    @RequestMapping("/getAll")
    public Msg getAll(){
        List<Category> categories =categoryService.getAll(null);
        return Msg.success().add("categoryInfo",categories);
    }

}
