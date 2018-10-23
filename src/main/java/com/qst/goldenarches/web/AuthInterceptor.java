/**
 * FileName: ServerStartupListener
 * Author:   SAMSUNG-PC 孙中军
 * Date:     2018/10/7 9:20
 * Description:用于处理资源路径问题
 */
package com.qst.goldenarches.web;


import com.qst.goldenarches.pojo.Permission;
import com.qst.goldenarches.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashSet;
import java.util.List;
import java.util.Set;


public class AuthInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	private PermissionService permissionService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// 获取用户的请求地址
		String uri = request.getRequestURI();
		String path = request.getSession().getServletContext().getContextPath();
		//System.out.println(" AuthInterceptor path---------------------->"+path);
		// 判断当前路径是否需要进行权限验证。
		// 查询所有需要验证的路径集合
		List<Permission> permissions = permissionService.getAllPermissions();
		Set<String> uriSet = new HashSet<String>();
		for ( Permission permission : permissions ) {
			if ( permission.getUrl() != null && !"".equals(permission.getUrl()) ) {
				uriSet.add(path + permission.getUrl());
			}
		}
		
		if ( uriSet.contains(uri) ) {
			// 权限验证
			// 判断当前用户是否拥有对应的权限
			Set<String> authUriSet = (Set<String>)request.getSession().getAttribute("authUriSet");
			if ( authUriSet.contains(uri) ) {
				return true;
			} else {
				//需要 '/error'
				response.sendRedirect(path + "/admin/error");
				return false;
			}
		} else {
			return true;
		}
	}

}
