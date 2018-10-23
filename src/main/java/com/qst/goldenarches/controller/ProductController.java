/**
 * FileName: ProductController
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/9/29 20:45
 * Description:
 */
package com.qst.goldenarches.controller;


import com.github.pagehelper.PageHelper;
import com.qst.goldenarches.pojo.Category;
import com.qst.goldenarches.pojo.Msg;
import com.qst.goldenarches.pojo.PageInfo;
import com.qst.goldenarches.pojo.Product;
import com.qst.goldenarches.service.ProductService;
import com.qst.goldenarches.utils.ImageUtil;
import org.apache.ibatis.annotations.Update;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private ProductService productService;

    /**
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("isProductExist")
    public Msg getProductById(Integer id){
        if(productService.isTypeHaveProduct(id)){
            return Msg.success();
        }else{
            return Msg.fail();
        }
    }
    /***
     * 商品后台：批量删除商品
     * @param productid
     * @return
     */
    @ResponseBody
    @RequestMapping("deleteBatch")
    public Msg deleteBatch(Integer[] productid) {
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("productids", productid);
            productService.deleteProducts(map);
        } catch (Exception e) {
            e.printStackTrace();
           return Msg.fail();
        }
        return Msg.success();
    }
    /**
     * 商品后台：单个商品删除
     * @return
     */
    @ResponseBody
    @RequestMapping("deleteOne")
    public Msg deleteOne(Integer id){
        try {
            productService.removeProduct(id);
        }catch (Exception e){
            return Msg.fail();
        }
        return Msg.success();
    }
    /**
     * 商品后台：商品图片修改
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("doUpdateProductPic")
    public Msg doUpdateProductPic(HttpServletRequest request){
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        MultipartFile mFile = multipartRequest.getFile("pic");
        String img = ImageUtil.upload(request,mFile);
        if (img!=null){
            Product product =new Product();
            product.setId(Integer.parseInt(request.getParameter("id")));
            product.setPic(img);
            //System.out.println("img=====>"+product);
            //删除硬盘上的图片
            String imgName=productService.getProductById(product.getId()).getPic();
            if (imgName!=null &&!"".equals(imgName)){
                ImageUtil.dropPic(request,imgName);
            }
            try {
                boolean flag=productService.editProductPic(product);
                if(flag){
                    return Msg.success();
                }
            }catch (Exception e){
                return  Msg.fail();
            }
        }
        return Msg.fail();
    }
    /**
     * 商品后台：商品数据修改
     * @param product
     * @return
     */
    @ResponseBody
    @RequestMapping("doUpdateProductData")
    public Msg doUpdateProductData(Product product){
        boolean flag =productService.editProductData(product);
        if (flag){
            return Msg.success();
        }
        return Msg.fail();
    }
    /**
     * 商品后台：跳转方法
     * 跳转至商品商品修改界面,并回显
     * @return 页面地址 product/add
     */
    @RequestMapping("edit")
    public String goEdit(Integer id, Model model){
        Product product =productService.getProductById(id);
        //将原节点数据传递
        model.addAttribute("product", product);
        return "product/edit";
    }
    /**
     * 商品后台：商品添加方法
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "doAdd", method = RequestMethod.POST)
    public Msg doAdd(HttpServletRequest request){
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        MultipartFile mFile = multipartRequest.getFile("pic");
        String img = ImageUtil.upload(request,mFile);
        if (img!=null){
            Product product =new Product();
            product.setName(request.getParameter("name"));
            product.setPrice(Double.parseDouble(request.getParameter("price")));
            product.setInventory(Integer.parseInt(request.getParameter("inventory")));
            product.setStatus(Integer.parseInt(request.getParameter("status")));
            product.setCid(Integer.parseInt(request.getParameter("cid")));
            product.setPic(img);
            boolean flag =productService.addProduct(product);
            if (flag){
                return Msg.success();
            }
        }
        return Msg.fail();
    }
    /**
     * 商品后台：跳转方法
     * 跳转至商品商品添加
     * @return 页面地址 product/add
     */
    @RequestMapping("/add")
    public String add(){
        return "product/add";
    }
    /**
     * 商品后台：分页查找
     * 查询全部商品并分页显示
     * @param pn 页码
     * @return json数据 Msg
     */
    @ResponseBody
    @RequestMapping("/getAll")
    public Msg getAll(@RequestParam(value = "pageno",defaultValue = "1") Integer pn,String queryText){
        PageHelper.startPage(pn,10);
        List<Product> products =productService.getAll(queryText);
        com.github.pagehelper.PageInfo<Product> productPageInfo =new com.github.pagehelper.PageInfo<Product>(products,5);
        return Msg.success().add("pageInfo",productPageInfo);
    }
    /**
     * 商品后台：跳转方法
     * 跳转至商品显示主界面
     * @return 页面地址 /product/index
     */
    @RequestMapping("/index")
    public String index(){
        return "/product/index";
    }


    /**
     * 展示页面
     * 2018/10/18 修改 category ==>categoryId
     * @param pageNum
     * @param categoryId 类别id
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/show")
    public String show(@RequestParam(value = "pageNum",defaultValue = "1")String pageNum, Integer categoryId,HttpServletRequest request, HttpServletResponse response) {
        response.setContentType("text/html;charset=UTF-8");
        PageInfo pageInfo = productService.showPage(pageNum,categoryId);
        /*PageHelper.startPage(Integer.parseInt(pageNum),6);
        List<Product> products =productService.getAll(null);
        pageInfo.setList(products);*/
        request.setAttribute("pageInfo",pageInfo);
        request.setAttribute("category",productService.getCategory());
        request.setAttribute("hint","notFist");
        return "forward:/main.jsp";
    }

    /**
     * 刷新页面
     * 2018/10/18 修改 category ==>categoryId
     * @param pageNum
     * @param categoryId 类别id
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/refresh")
    public String refresh(@RequestParam(value = "pageNum",defaultValue = "1")String pageNum,Integer categoryId,HttpServletRequest request, HttpServletResponse response) {
        response.setContentType("text/html;charset=UTF-8");
        PageInfo pageInfo = productService.showPage(pageNum,categoryId);
        /*PageHelper.startPage(Integer.parseInt(pageNum),6);
        List<Product> products =productService.getAll(null);
        pageInfo.setList(products);*/
        request.setAttribute("pageInfo",pageInfo);
        request.setAttribute("category",productService.getCategory());
        return "forward:/shop.jsp";
    }
}
