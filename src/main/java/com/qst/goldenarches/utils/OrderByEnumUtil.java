/**
 * FileName: OrderByEnumUtil
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/19 14:24
 * Description: 查询排序依据
 */
package com.qst.goldenarches.utils;

public enum OrderByEnumUtil {
    //订单总金额排序条件
    TOTAL_AMOUNT_ASC("total_amount",1),
    TOTAL_AMOUNT_DESC("total_amount desc",2),
    //订单时间排序条件
    ORDER_CREATE_TIME_ASC("order_master.create_time",3),
    ORDER_CREATE_TIME_DESC("order_master.create_time desc",4),
    //会员余额排序条件
    VIP_BALANCE_ASC("vip_balance",5),
    VIP_BALANCE_DESC("vip_balance desc",6),
    //会员创建时间排序条件
    VIP_CREATE_TIME_ASC("vip_info.create_time",7),
    VIP_CREATE_TIME_DESC("vip_info.create_time desc",8);

    private String Condition;
    private Integer index;

    OrderByEnumUtil(String condition, Integer index) {
        Condition = condition;
        this.index = index;
    }

    public static String getCondition(int index) {
        for (OrderByEnumUtil c : OrderByEnumUtil.values()) {
            if (c.getIndex() == index) {
                return c.Condition;
            }
        }
        return null;
    }

    private Integer getIndex() {
        return index;
    }
}
