/**
 * FileName: ChartService
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/6 14:17
 * Description:
 */
package com.qst.goldenarches.service;

import java.util.List;
import java.util.Map;

public interface ChartService {
    /**
     * 获得每个商品类别的的销售总数
     * @return
     */
    List<Map> getEveryProTypeSaleNum();

    /***
     * 获取某年只某月为止的每月的
     * 每类商品的卖出的数量
     * 和每一个季度销售总额
     * @param year 年份
     * @param month 截止月份
     * @return
     */
    Map<String, Object> getEveryMonthBarData(int year, int month);
}
