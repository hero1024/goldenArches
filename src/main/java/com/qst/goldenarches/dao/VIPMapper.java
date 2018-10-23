package com.qst.goldenarches.dao;


import com.qst.goldenarches.pojo.VIP;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface VIPMapper {
    @Select("select vip_id id,vip_name name,vip_phone phone,vip_balance balance,create_time createTime from vip_info where vip_phone = #{phone}")
    VIP selByPhone(String phone);

    @Insert("insert vip_info values(default,#{name},#{phone},#{balance},#{createTime})")
    int insVIP(VIP vip);

    @Update("update vip_info set vip_balance=#{balance} where vip_phone = #{phone}")
    int updVIPByPhone(VIP vip);

}
