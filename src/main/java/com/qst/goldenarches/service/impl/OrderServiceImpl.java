/**
 * FileName: OrderServiceImpl
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/4 22:22
 * Description:
 */
package com.qst.goldenarches.service.impl;

import com.qst.goldenarches.dao.OrderMapper;
import com.qst.goldenarches.pojo.Detail;
import com.qst.goldenarches.pojo.Order;
import com.qst.goldenarches.pojo.VIP;
import com.qst.goldenarches.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderMapper orderMapper;

    public List<Order> getAll(Map<String, String> map) {
        return orderMapper.selectAll(map);
    }


    public int insOrder(Map<String, Integer> map,String phone) {
        Order order = new Order();
        int vipId ;
        double amount = getAmount(map);//原价
        if(orderMapper.selAllByPhone(phone) == null){
            //当买家不是会员，用手机尾号后4位做ID，若不足4位，用所有手机号做ID
            if(phone.length() >= 4){
                vipId = Integer.parseInt(phone.substring(phone.length() - 4,phone.length()));
            }else{
                vipId = Integer.parseInt(phone);
            }
        } else{
            vipId = orderMapper.selAllByPhone(phone).getId();//根据电话号查找ID
            amount = amount * 0.8;//会员八折优惠
        }

        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String createTime =sdf.format(new Date());//获取当前时间并转换格式

        order.setCreateTime(createTime);
        order.setBid(vipId);
        order.setAmount(amount);//存的是优惠后的价格
        orderMapper.insOrder(order);//新增订单表

        int lastInsId = orderMapper.selLastInsId();//查询最后一次插入操作插入的ID
        return lastInsId;//返回最后一次插入操作的id，不返回插入订单的行数
    }


    public List<Detail> insDetail(Map<String, Integer> map, String phone, int lastInsId) {
        List<Detail> list = new ArrayList<Detail>();//用于接收本次订单所有的订单详细对象
        for (Map.Entry<String, Integer> entry : map.entrySet()) {
            int pid = Integer.parseInt(entry.getKey());//商品id
            int number = entry.getValue();//商品数量
            Detail detail = new Detail();
            detail.setOid(lastInsId);
            detail.setPid(pid);
            detail.setNumber(number);
            detail.setPname(orderMapper.selAllByPid(pid).getName());
            if(orderMapper.selAllByPhone(phone) == null){//判断买家是否是会员
                detail.setPrice(orderMapper.selAllByPid(pid).getPrice());
            } else{
                detail.setPrice(orderMapper.selAllByPid(pid).getPrice()*0.8);
            }
            //detail.setPrice(orderMapper.selAllByPid(pid).getPrice());
            orderMapper.insDetail(detail);//订单详细表的新增
            orderMapper.updProduct(detail);//商品库存的减少
            if(number != 0)//必须把数量为0的去掉
                list.add(detail);//再把单个订单详细对象添加进集合
        }
        return list;//返回整个集合
    }


    public String judgeInventory(Map<String, Integer> map, String phone) {
        for (Map.Entry<String, Integer> entry : map.entrySet()) {
            int pid = Integer.parseInt(entry.getKey());//商品id
            int number = entry.getValue();//商品数量
            /**
             * 如果商品库存不足，则返回库存不足的name
             */
            if(orderMapper.selAllByPid(pid).getInventory() < number){
                return orderMapper.selAllByPid(pid).getName();
            }
        }
        return "nomal";
    }


    public boolean judgeBalance(Map<String, Integer> map, String phone) {
        double amount = getAmount(map);//本次订单商品总价
        /**
         * 如果商品总价大于会员卡余额，则返回false
         */
        if(amount > orderMapper.selAllByPhone(phone).getBalance()){
            return false;
        }
        return true;
    }


    public boolean judgeVip(String phone) {
        if(orderMapper.selAllByPhone(phone) == null)
            return false;
        else
            return true;
    }


    public double getAmount(Map<String, Integer> map) {
        double amount = 0;//本次订单商品总价
        for (Map.Entry<String, Integer> entry : map.entrySet()) {
            int pid = Integer.parseInt(entry.getKey());//商品id
            int number = entry.getValue();//商品数量
            double price = orderMapper.selAllByPid(pid).getPrice();//商品单价
            amount= amount + price * number;//加上单件商品总价
        }
        return amount;
    }


    public int updVIP(Map<String, Integer> map, String phone) {
        double amount = getAmount(map);
        double newAmount = amount * 0.8;//会员八折优惠
        //先把最终会员卡的余额算出来然后直接存进去
        double newBalance = orderMapper.selAllByPhone(phone).getBalance() - newAmount;
        VIP vip = new VIP();
        vip.setBalance(newBalance);
        vip.setPhone(phone);
        int index = orderMapper.updVIP(vip);
        return index;
    }
}
