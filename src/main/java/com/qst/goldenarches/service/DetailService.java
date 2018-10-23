/**
 * FileName: DetailService
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/5 8:55
 * Description:
 */
package com.qst.goldenarches.service;

import com.qst.goldenarches.pojo.Detail;

import java.util.List;

public interface DetailService {
    List<Detail> getDetailsByOid(Integer id);
}
