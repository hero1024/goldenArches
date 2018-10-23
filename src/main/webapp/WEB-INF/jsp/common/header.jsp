<%--
  Created by IntelliJ IDEA.
  User: SAMSUNG-PC
  Date: 2018/10/6
  Time: 21:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<nav class="navbar navbar-inverse navbar-fixed-top" style="background-color: #393C3D;" role="navigation">
<div class="container-fluid">
    <div class="navbar-header">
        <div><a href="${APP_PATH}/admin/main" class="navbar-brand" style="font-size:32px;">点餐平台 - 后台管理</a></div>
    </div>
    <div id="navbar" class="navbar-collapse collapse">
        <ul class="nav navbar-nav navbar-right">
            <li style="padding-top:8px;">
                <div class="btn-group">
                    <button type="button" class="btn btn-default btn-success dropdown-toggle" data-toggle="dropdown">
                        <i class="glyphicon glyphicon-user"></i> ${loginAdmin.name} <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="${APP_PATH}/admin/edit"><i class="glyphicon glyphicon-cog"></i> 个人设置</a></li>
                        <li class="divider"></li>
                        <li><a href="${APP_PATH}/admin/logout"><i class="glyphicon glyphicon-off"></i> 退出系统</a></li>
                    </ul>
                </div>
            </li>
            <li style="margin-left:10px;padding-top:8px;margin-right: 25px">
                <button type="button" class="btn btn-default btn-danger">
                    <span class="glyphicon glyphicon-question-sign"></span> 帮助
                </button>
            </li>
        </ul>
    </div>
</div>
</nav>