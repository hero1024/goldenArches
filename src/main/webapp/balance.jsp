<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/9
  Time: 11:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<html>
<head>
    <title>显示余额</title>
    <link href="${APP_PATH}/css/index.css" type="text/css" rel="stylesheet">
</head>
<body>
<hr/>
<table style="margin: 0 auto">
    <tr>
        <th>姓名</th>
        <th>手机号</th>
        <th>余额</th>
    </tr>
    <tr>
        <td>${vip.name}</td>
        <td>${vip.phone}</td>
        <td>${vip.balance}</td>
    </tr>
</table>
</body>
</html>
