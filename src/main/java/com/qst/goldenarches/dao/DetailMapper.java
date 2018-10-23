/**
 * FileName: DetailMapper
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/5 8:57
 * Description:
 */
package com.qst.goldenarches.dao;

import com.qst.goldenarches.pojo.Detail;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface DetailMapper {
    List<Detail> selectDetailsByOid(@Param("Oid") Integer id);

    /**
     * 根据商品的类别id查询该类别下销售的总数
     * @param id
     * @return
     */
    Integer selectSaleNumByCid(int id);

    /***
     * 根据商品的类别id查询一个月该类别下销售的总量
     * @param queryCriteria
     * @return
     */
    Integer selectCountOfProTypeSale(Map<String, Object> queryCriteria);
}
