/**
 * FileName: TimeUtil
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/5 18:55
 * Description: 获取时间
 */
package com.qst.goldenarches.utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class TimeUtil {

    public static String getLastTimeOfMonth(int year,int month){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        //获取指定年月最后一天 
        Calendar callast= Calendar.getInstance();
        callast.set(Calendar.YEAR, year);
        callast.set(Calendar.MONTH, month);
        callast.set(Calendar.DAY_OF_MONTH, 0);//最后一天 
        String last =sdf.format(callast.getTime());
        return last+" 23:59:59";

    }
    public static String getFirstTimeOfMonth(int year,int month){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        //获取指定年月第一天 
        Calendar calstar= Calendar.getInstance();
        calstar.set(Calendar.YEAR, year);
        calstar.set(Calendar.MONTH, month-1);
        calstar.set(Calendar.DAY_OF_MONTH, 1);//第一天
        String star =sdf.format(calstar.getTime());
        return star+" 00:00:00";
    }
    public static String getCurrentTime() {
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return sdf.format(new Date());
    }
}
