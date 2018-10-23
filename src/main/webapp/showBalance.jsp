<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/9
  Time: 10:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<html>
<head>
    <title>查询余额</title>
</head>
<body>
<hr/>
<form action="/showBalance" method="post">
    <table style="margin: 0 auto">
        <tr>
            <td><label>姓名: </label></td>
            <td><input type="text" id="name" name="name"></td>
        </tr>
        <tr>
            <td><label>手机号: </label></td>
            <td><input type="text" id="phone" name="phone"></td>
        </tr>

        <tr>
            <td></td>
            <td><input id="submit" type="submit" value="查询"></td>
        </tr>
    </table>
</form>
</body>
</html>
