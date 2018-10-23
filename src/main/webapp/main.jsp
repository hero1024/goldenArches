<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/5
  Time: 9:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>麦当劳</title>
    <link rel="stylesheet" type="text/css" href="${APP_PATH}/css/mainfront.css">
    <script src="${APP_PATH}/jquery/jquery-2.1.1.min.js" ></script>
    <%--<script src="/js/main.js" type="text/javascript"></script>--%>
    <script type="text/javascript">
        //为什么都接收字符串？如果不接收字符串会报空指针异常（可能是空指针），反正会报异常
        var pageNum = "${pageInfo.pageNum}";//获取当前页数
        var total = "${pageInfo.total}";//总共有几页
        var message = "${message}";//控制器返回的信息，判断是否是会员、余额是否充足等信息
        var category = "${pageInfo.category}";//当前显示的商品类别
        var categoryId;
        var map = {};//把添加的商品的id和数量以键值对的方式存入map集合中
        var totalPrice = 0;//已添加商品总价
        var hint = "${hint}";//判断主页面是否已经请求了show控制器

        $(function () {

            //如果为空，说明还未请求，就直接转到show控制器
            if (hint == ""){
                location.href="${APP_PATH}/product/show";
            }
            //判断接收的信息是否为空，不为空则弹出提示框提醒。
            if(message != ""){
                alert(message);
            }
            //循环左边所有的类型菜单
            $.each($(".menu_1"),function (i,n) {
                //如果当前循环的类型和控制器获取的类型相同，则改变类型字体大小和颜色
                if($(this).text() == category){
                    $(this).css("font-weight","900");
                    $(this).css("color","red");
                }
                //某个类型的点击事件
                $(this).click(function () {
                    if($(this).text() == "菜单"){//如果当前循环的是“菜单”，则展示默认菜单
                        location.href = "${APP_PATH}/product/show";
                        /*$.each($(".menu_1"),function (i,n) {
                            $(this).css("font-weight","500");
                            $(this).css("color","");
                        });
                        $(".menu_1").eq(1).css("font-weight","900");
                        $(".menu_1").eq(1).css("color","red");
                        $.get("/refresh",{"category":"商家推荐"},
                            function(data){
                                $("#content_0").html(data);
                            },"html");*/
                    }else{//否则根据点击的类型传入控制器
                        //location.href = "/product/show?category=" + $(this).text();
                        category = $(this).text();
                        //alert($(this).attr("categoryId"));
                       categoryId =$(this).attr("categoryId");
                        $.each($(".menu_1"),function (i,n) {
                            $(this).css("font-weight","500");
                            $(this).css("color","");
                        });
                        $(this).css("font-weight","900");
                        $(this).css("color","red");
                        $.get("${APP_PATH}/product/refresh",{"categoryId":categoryId},
                            function(data){
                                total = "${pageInfo.total}";
                                pageNum = "1";
                                $("#content_0").html(data);
                            },"html");
                    }
                });
            });

            //上一页的点击事件
            $("#last_page").click(function () {
                pageNum = parseInt(pageNum) - 1;//页码减1，需要先转换成数值类型
                if(pageNum >= 1){//如果运算之后的页码大于等于1，页面跳转到上一页
                    //location.href="/product/show?pageNum="+pageNum +"&category="+ category;
                    $.post("${APP_PATH}/product/refresh",{"pageNum":pageNum,"categoryId":categoryId},
                        function(data){
                            $("#content_0").html(data);
                        },"html");
                }else{//如果运算之后的页码小于1（为0），说明已经是第一页，把页码恢复为1，页面不改变，点击事件无效
                    pageNum = 1;
                }
                return false;//必须加，让跳转页面不起作用，必须按照指定的方式跳转
            });
            //下一页的点击事件
            $("#next_page").click(function(){
                pageNum = parseInt(pageNum) + 1;//页码加1
                total = parseInt(total);//把总页数转换成数值类型
                if(pageNum <= total){//如果运算之后的页数小于等于总页数，页面跳转到下一页
                    //location.href="/product/show?pageNum="+pageNum +"&category="+ category;
                    $.post("${APP_PATH}/product/refresh",{"pageNum":pageNum,"categoryId":categoryId},
                        function(data){
                            $("#content_0").html(data);
                        },"html");
                }else{//如果运算之后的页数大于总页数，说明已经是最后一页，页码恢复为最后一页，页面不改变
                    pageNum = total;
                }
                return false;
            });

            //会员支付的点击事件
            $("#vip_pay").click(function(){
                //把map集合转化为json字符串再进行传递
                var jsonStr = JSON.stringify(map);

                //判断是否添加了商品，不添加商品json字符串的长度为2
                if(jsonStr.length <= 2){//如果小于2，说明未添加商品，弹出提示框
                    alert("请先添加商品再结账！");
                }else{
                    //弹出一个输入框输入买家的手机号
                    var phone = prompt("请输入您要付款的手机号。");
                    //循环判断买家的手机号输入是否为空，为空则弹出输入框
                    while(phone.length == 0){
                        phone = prompt("您输入为空，请输入你的手机号。");
                    }
                    //转向控制器进行订单之类的操作
                    location.href = "${APP_PATH}/order/vipPay?phone="+phone+"&jsonStr="+myencodeURI(jsonStr);
                }
                return false;
            });
            //普通结账的点击事件
            $("#user_pay").click(function(){
                var jsonStr = JSON.stringify(map);

                //alert("====>"+myencodeURI(jsonStr));
                if(jsonStr.length <= 2){
                    alert("请先添加商品再结账！");
                }else{
                    var phone = prompt("请输入您要付款的手机号。")
                    while(phone.length == 0){
                        phone = prompt("您输入为空，请输入你的手机号。");
                    }
                    location.href = "${APP_PATH}/order/userPay?phone="+phone+"&jsonStr="+myencodeURI(jsonStr);
                }
                return false;
            });
        });
        /**
         * 对json数据进行编码
         * @param str
         * @returns {string}
         */
        function myencodeURI(str){
            return  encodeURIComponent(encodeURIComponent(str));
        }
        function showProC(categoryId) {
            alert(categoryId);
            $.get("${APP_PATH}/product/show",{"categoryId":categoryId},
                function(data){});
        }
    </script>
</head>
<body style="width: 1350px">
<div id="all">
<hr/>
<div id="menu">
    <div id="menu_0">
        <div class="menu_1"><strong>菜单</strong></div>
        <c:forEach items="${category}" var="category">
            <div class="menu_1" categoryId="${category.id}">${category.name}</div>
        </c:forEach>
        <%--<div class="menu_1">商家推荐</div>--%>
        <%--<div class="menu_1">超值套餐</div>--%>
        <%--<div class="menu_1">小食</div>--%>
        <%--<div class="menu_1">甜品</div>--%>
        <%--<div class="menu_1">饮品</div>--%>
        <%--<div class="menu_1">开心乐园餐</div>--%>
    </div>
</div>
<div id="content">
    <c:import url="shop.jsp"></c:import>
    <div id="right">
        <img src="/img/right.png" alt="">
    </div>
    <div id="content_page">
        <button id="last_page">上一页</button>
        <button id="next_page">下一页</button>
    </div>
    <div id="total">
        总计：￥<strong>0</strong>
    </div>
    <div id="pay">
        <button id="vip_pay">会员结账</button>
        <button id="user_pay">普通结账</button>
    </div>

</div>
</div>
</body>
</html>
