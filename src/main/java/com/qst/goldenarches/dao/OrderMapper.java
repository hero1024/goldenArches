/**
 * FileName: OrderMapper
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/4 22:23
 * Description:
 */
package com.qst.goldenarches.dao;

import com.qst.goldenarches.pojo.Detail;
import com.qst.goldenarches.pojo.Order;
import com.qst.goldenarches.pojo.Product;
import com.qst.goldenarches.pojo.VIP;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;

public interface OrderMapper {

    List<Order> selectAll(Map<String, String> map);

    /**
     * 查询一个月的总销售金额
     * @param queryCriteria fTime月份开始时间 lTime月份结束时间
     * @return
     */
    double selectAmountOfMonth(Map<String, Object> queryCriteria);


    @Insert("insert order_master values(default,#{bid},#{amount},#{createTime})")
    public int insOrder(Order order);

    @Insert("insert order_detail values(default,#{oid},#{pid},#{pname},#{price},#{number})")
    public int insDetail(Detail detail);

    @Update("update vip_info set vip_balance = #{balance} where vip_phone = #{phone}")
    public int updVIP(VIP vip);

    @Update("update product_info set product_inventory = product_inventory - #{number} where product_id = #{pid}")
    public int updProduct(Detail detail);

    @Select("select LAST_INSERT_ID()")
    public int selLastInsId();

    @Select("select vip_id id,vip_name name,vip_phone phone,vip_balance balance from vip_info where vip_phone = #{phone}")
    public VIP selAllByPhone(String phone);

    @Select("select product_id id,product_name name,product_price price,product_inventory inventory,product_status status,category_id cid from product_info where product_id = #{pid}")
    public Product selAllByPid(int pid);
}
