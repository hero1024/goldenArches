<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/5
  Time: 9:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>麦当劳</title>
    <link rel="stylesheet" type="text/css" href="${APP_PATH}/css/mainfront.css">
    <script src="${APP_PATH}/jquery/jquery-2.1.1.min.js" ></script>
    <script type="text/javascript">
        $(function () {
           $("button").eq(0).click(function () {
               location.href="${APP_PATH}/product/show";
           });
            $("button").eq(1).click(function () {
                location.href="${APP_PATH}/register.jsp";
            });
            $("button").eq(2).click(function () {
                location.href="${APP_PATH}/showBalance.jsp";
            });
            <%--$("button").eq(3).click(function () {--%>
                <%--&lt;%&ndash;location.href="${APP_PATH}/admin/main";&ndash;%&gt;--%>
                <%--window.open('${APP_PATH}/admin/main','_top');--%>
            <%--});--%>
        });
    </script>
</head>
<body>
<!-- 头部导航栏 -->
<div id="header">
    <!-- Logo -->
    <div id="u40">
        <img id="u40_img"src="/img/logo.png"/>
        <div id="u40_text" >
            <p><span>logo</span></p>
        </div>
    </div>
    <!-- 店名 -->
    <div id="u41">
        <div id="u41_div"></div>
        <div id="u41_text">
            <p><span>麦当劳(店名)</span></p>
        </div>
    </div>
    <!-- 索引菜单栏 -->
    <div id="index">
        <button>返回首页</button>
        <button>注册/充值</button>
        <button>查询余额</button>
        <a target="_blank" href="${APP_PATH}/admin/main"><button>后台管理</button></a>
    </div>
</div>
</body>
</html>

