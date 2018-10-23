/**
 * FileName: DigitalUtil
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/5 21:15
 * Description: 数字转换工具类
 */
package com.qst.goldenarches.utils;

import jdk.internal.org.objectweb.asm.tree.TryCatchBlockNode;
import org.apache.ibatis.javassist.bytecode.stackmap.BasicBlock;

public class DigitalUtil {

    /**
     * 将数字向上转换成
     * 最低以十为单位
     * 最高以万为单位
     * @param num
     * @return
     */
    public static Integer convertLeastTenAsUnit( int num){
        if(num<0||num>999999999){//当数字超出范围
            return -1;
        }
        int numOfDigits=0;//数字的位数
        int numTmp =num;
        if (numTmp==0){
            numOfDigits=1;
        }else {
            while (numTmp>0){
                numTmp =numTmp/10;
                numOfDigits++;
            }
        }
        int unit =10;//最低单位
        if(numOfDigits>5){//限制最高以万为单位
            numOfDigits=6;
        }
        if (numOfDigits>2){
            unit =(int)Math.pow(10, numOfDigits-2);
        }
        num =((num/unit)+1)*unit;
        return num;
    }
    public static Integer convertLeastTenAsUnit( double num){
        int n =(int) num;
        return convertLeastTenAsUnit(n);
    }
}
