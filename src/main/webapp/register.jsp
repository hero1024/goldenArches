<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<html>
<head>
    <title>注册/充值</title>
    <script src="${APP_PATH}/jquery/jquery-2.1.1.min.js" ></script>
    <script type="text/javascript">
        $(function () {
            $("#submit").click(function () {
                var name = $(":text").eq(0).val();
                var phone = $(":text").eq(1).val();
                var balance = $(":text").eq(2).val();
                var msg = "请再次确认您的信息：\n姓名："+name+"\n手机号："+phone+"\n充值金额："+balance;
                var conf = confirm(msg);
                if(conf == true){
                    $("form").submit();
                }else{
                    return false;
                }
            });
        });
    </script>
</head>
<body>
<hr/>
<form action="${APP_PATH}/addForm" method="post">
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
            <td><label>充值金额: </label></td>
            <td><input type="text" id="balance" name="balance"></td>
        </tr>

        <tr>
            <td></td>
            <td><input id="submit" type="submit" value="注册/充值"></td>
        </tr>
    </table>
</form>

</body>
</html>
