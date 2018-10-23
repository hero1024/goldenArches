/**
 * FileName: DetailServiceImpl
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/5 8:56
 * Description:
 */
package com.qst.goldenarches.service.impl;

import com.qst.goldenarches.dao.DetailMapper;
import com.qst.goldenarches.pojo.Detail;
import com.qst.goldenarches.service.DetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DetailServiceImpl implements DetailService {

    @Autowired
    private DetailMapper detailMapper;

    public List<Detail> getDetailsByOid(Integer id) {
        return detailMapper.selectDetailsByOid(id);
    }
}
