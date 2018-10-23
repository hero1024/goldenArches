package com.qst.goldenarches.service;

import com.qst.goldenarches.pojo.VIP;

public interface VIPService {
	/**
	 * 新增或修改VIP信息，根据电话号判断数据库中是否已经存在该用户，若存在则充值，不存在则注册新增
	 * @param vip	传入的是用户输入的3条信息
	 * @return	返回的新增或者修改的行数
	 */
	int addVIP(VIP vip);

	/**
	 * 根据手机号查询余额
	 * @param phone
	 * @return		返回整个会员信息
	 */
	VIP selBalance(String phone);

	/**
	 * 根据手机号修改账户余额，超级管理员的功能
	 * @param phone		手机号
	 * @param balance	修改后的余额
	 * @return			返回修改的行数
	 */
	int updBalance(String phone,double balance);
}
