package com.qst.goldenarches.service.impl;

import javax.annotation.Resource;

import com.qst.goldenarches.dao.VIPMapper;
import com.qst.goldenarches.pojo.VIP;
import com.qst.goldenarches.service.VIPService;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;

@Service("vipService")
public class VIPServiceImpl implements VIPService {

	@Resource
	private VIPMapper vipMapper;

	public int addVIP(VIP vip) {
		int index = 0;//返回的行数
		VIP dbVIP = vipMapper.selByPhone(vip.getPhone());//根据手机号查询数据库是否已经存在该用户
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String createTime =sdf.format(new Date());//获取当前时间并转换格式
		vip.setCreateTime(createTime);
		if(dbVIP == null){
			index = vipMapper.insVIP(vip);
		}else{
			vip.setBalance(vip.getBalance() + dbVIP.getBalance());//余额为原会员卡余额加上充值的金额
			index = vipMapper.updVIPByPhone(vip);
		}
		return index;
	}

	public VIP selBalance(String phone) {
		return vipMapper.selByPhone(phone);
	}

	public int updBalance(String phone,double balance) {
		VIP vip = new VIP();
		vip.setPhone(phone);
		vip.setBalance(balance);
		int index = vipMapper.updVIPByPhone(vip);
		return index;
	}

}
