/**
 * FileName: ChartServiceImpl
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/6 14:18
 * Description:
 */
package com.qst.goldenarches.service.impl;

import com.qst.goldenarches.dao.CategoryMapper;
import com.qst.goldenarches.dao.DetailMapper;
import com.qst.goldenarches.dao.OrderMapper;
import com.qst.goldenarches.pojo.Category;
import com.qst.goldenarches.service.ChartService;
import com.qst.goldenarches.utils.DigitalUtil;
import com.qst.goldenarches.utils.TimeUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ChartServiceImpl implements ChartService {

    @Autowired
    private CategoryMapper categoryMapper;

    @Autowired
    private DetailMapper detailMapper;

    @Autowired
    private OrderMapper orderMapper;

    public List<Map> getEveryProTypeSaleNum() {
        //获得所有的商品类别
        List<Category> categories =categoryMapper.selectAll(null);
        List<Map> datas =new ArrayList<Map>();
        for (Category c:categories){
            //根据cid 查询该类商品的销售数量 从订单详情表里面查询
            Integer count =detailMapper.selectSaleNumByCid(c.getId());
            if (count!=null){
                Map<String,Object> data = new HashMap<String, Object>();
                data.put("name",c.getName());
                data.put("value",count);
                datas.add(data);
            }
        }
        return  datas;
    }

    public Map<String, Object> getEveryMonthBarData(int year, int month) {
        Integer maxCount =0;//保存所有月份中最高销售数量
        List<Map> series =new ArrayList<Map>();
        List<String> itemList =new ArrayList<String>();
        //获取所有的类别
        List<Category> categories =categoryMapper.selectAll(null);
        //遍历每个类别
        for (Category c:categories) {
            //用于保存该类别下的每个月份的销售情况
            List<Integer> dataList =new ArrayList<Integer>();
            for(int i=1;i<=month;i++){
                String firstTime = TimeUtil.getFirstTimeOfMonth(year,i);
                String lastTime =TimeUtil.getLastTimeOfMonth(year,i);
                Map<String,Object> queryCriteria = new HashMap<String, Object>();
                queryCriteria.put("cid",c.getId());
                queryCriteria.put("fTime",firstTime);
                queryCriteria.put("lTime",lastTime);
                Integer count =detailMapper.selectCountOfProTypeSale(queryCriteria);
                if (count!=null){
                    if (count>maxCount){
                        maxCount=count;
                    }
                    dataList.add(count);
                }else {
                    dataList.add(0);
                }
            }
            //将该类的数据封装成对象
            Map<String,Object> data =new HashMap<String, Object>();
            data.put("name",c.getName());
            data.put("type","bar");//柱状图
            data.put("data",dataList);
            series.add(data);

            itemList.add(c.getName());
        }

        //获取每个月的销售金额
        double saleMax =0;//保存最高销售金额
        List<Double> dataList =new ArrayList<Double>();
        //查询每个月的销销售金额
        for(int i=1;i<=month;i++){
            String firstTime = TimeUtil.getFirstTimeOfMonth(year,i);
            String lastTime =TimeUtil.getLastTimeOfMonth(year,i);
            Map<String,Object> queryCriteria = new HashMap<String, Object>();
            queryCriteria.put("fTime",firstTime);
            queryCriteria.put("lTime",lastTime);
            double totalSaleOfMonth = orderMapper.selectAmountOfMonth(queryCriteria);
            if (totalSaleOfMonth>saleMax){
                saleMax=totalSaleOfMonth;
            }
            dataList.add(totalSaleOfMonth);
        }

        Map<String,Object> data =new HashMap<String, Object>();
        data.put("name","销售金额");
        data.put("type","line");//折线图
        data.put("yAxisIndex",1);
        data.put("data",dataList);
        series.add(data);

        itemList.add("销售金额");

        //分别对Max最低十为单位取整，用于构建Y轴最大值
        Map<String,Integer> YAxisMax=new HashMap<String, Integer>();
        YAxisMax.put("maxCount", DigitalUtil.convertLeastTenAsUnit(maxCount));
        YAxisMax.put("saleMax",DigitalUtil.convertLeastTenAsUnit(saleMax));

        Map<String,Object> barChartData=new HashMap<String, Object>();
        barChartData.put("seriesData",series);
        barChartData.put("items",itemList);
        barChartData.put("YAxis",YAxisMax);
        return barChartData;
    }
}
