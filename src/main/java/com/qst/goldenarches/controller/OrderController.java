/**
 * FileName: OrderController
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/4 22:17
 * Description: 后台：订单控制器
 */
package com.qst.goldenarches.controller;

import com.github.pagehelper.PageHelper;
import com.qst.goldenarches.pojo.Detail;
import com.qst.goldenarches.pojo.Msg;
import com.qst.goldenarches.pojo.Order;
import com.qst.goldenarches.service.OrderService;
import com.qst.goldenarches.utils.OrderByEnumUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    /**
     * 订单后台：分页查找
     * 查询全部订单并分页显示
     * @param pn 页码
     * @return json数据 Msg
     */
    @ResponseBody
    @RequestMapping("/getAll")
    public Msg getAll(@RequestParam(value = "pageno",defaultValue = "1") Integer pn, Integer orderIndex,String queryText){
        Map<String,String> map =new HashMap<String, String>();
        map.put("orderText", OrderByEnumUtil.getCondition(orderIndex));
        map.put("queryText",queryText);
        PageHelper.startPage(pn,10);
        List<Order> orders =orderService.getAll(map);
        com.github.pagehelper.PageInfo<Order> orderPageInfo =new com.github.pagehelper.PageInfo<Order>(orders,5);
        return Msg.success().add("pageInfo",orderPageInfo);
    }

    /***
     * 订单后台：跳转方法
     * 跳转到订单详情主页
     * @return
     */
    @RequestMapping("index")
    public String index(){
        return "order/index";
    }



    @RequestMapping("vipPay")
    public String vipPay(String jsonStr, String phone, HttpServletRequest request, HttpServletResponse response){
        try {
            jsonStr =URLDecoder.decode(jsonStr, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        Map<String,Integer> map = (Map<String, Integer>) com.alibaba.fastjson.JSON.parse(jsonStr);

        //最开始先判断手机号是否是vip
        if(orderService.judgeVip(phone) == true){
            //再判断库存是否充足，返回库存不充足商品的name
            String name = orderService.judgeInventory(map, phone);
            if(name == "nomal"){
                //再判断余额是否充足
                if(orderService.judgeBalance(map, phone) == true){
                    //再从会员卡中扣钱
                    int vipIndex = orderService.updVIP(map,phone);
                    //然后创建订单表，返回创建的订单表id
                    int lastInsId = orderService.insOrder(map, phone);
                    //最后创建订单详细表
                    List<Detail> list = orderService.insDetail(map,phone,lastInsId);
                    request.setAttribute("successDetail",list);
                    return "forward:/paySuccess.jsp";
                }else{
                    //System.out.println("余额不足！");
                    request.setAttribute("message","您余额不足！");
                    return "forward:/product/show";
                }
            }else{
                //System.out.println(name+"库存不足！");
                request.setAttribute("message",name+"库存不足！");
                return "forward:/product/show";
            }
        }else{
            //System.out.println("用户不是vip！");
            request.setAttribute("message","您不是vip！");
            return "forward:/product/show";
        }
    }
    @RequestMapping("userPay")
    public String userPay(String jsonStr, String phone, HttpServletRequest request, HttpServletResponse response){
        try {
           jsonStr =URLDecoder.decode(jsonStr, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        Map<String,Integer> map = (Map<String, Integer>) com.alibaba.fastjson.JSON.parse(jsonStr);

        //先判断库存是否充足，返回库存不充足商品的name
        String name = orderService.judgeInventory(map, phone);
        if(name == "nomal"){
            //弹出一个页面付款，获取其是否付款成功
            int paySuccess = 1;//是否付款成功的参数，先定义为成功
            if(paySuccess == 1){
                //然后创建订单表，返回创建的订单表id
                int lastInsId = orderService.insOrder(map, phone);
                //最后创建订单详细表
                List<Detail> list = orderService.insDetail(map,phone,lastInsId);
                request.setAttribute("successDetail",list);
                return "forward:/paySuccess.jsp";
            }else{
                request.setAttribute("message","付款失败！");
                return "forward:/product/show";
            }
        }else{
            request.setAttribute("message",name+"库存不足！");
            return "forward:/product/show";
        }
    }
}
