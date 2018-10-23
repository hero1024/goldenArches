<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/5
  Time: 19:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title></title>
</head>
<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js" ></script>
<script type="text/javascript">
    $(function(){
        //某个商品的加号的点击事件
        $(".plus").click(function(){
            //把该商品的减号设置为蓝色可以点击的状态
            $(this).prevAll("img").eq(0).attr("src","/img/minus_blue.png");
            //获取点击商品的id
            var id = $(this).parent("div").prevAll("strong").eq(1).text();
            //获取点击商品的单价
            var price = $(this).parent("div").prevAll("div").eq(0).children("strong").text();
            //先把单价转化为数值类型再加上原来的总价
            totalPrice = totalPrice + parseInt(price);
            //把显示总价的地方的值改变
            $("#total strong").text(totalPrice);
            //判断该id的商品的数量是否为空
            if(map[id] != null){//如果不为空则商品数量加1
                map[id] = map[id] + 1;
                $(this).prevAll("strong").eq(0).text(map[id]);//再把显示商品数量的属性改变
            }else{
                map[id] = 1;//如果为空，则让商品数量为1
                $(this).prevAll("strong").eq(0).text(map[id]);//再把显示商品数量的属性改变
            }
            return false;
        });
        //某个商品的减号的点击事件
        $(".minus").click(function(){
            //获取点击商品的id
            var id = $(this).parent("div").prevAll("strong").eq(1).text();
            //获取点击商品的单价
            var price = $(this).parent("div").prevAll("div").eq(0).children("strong").text();
            //如果该id位置的数量为空或者为0
            if(map[id] == null || map[id] == 0){
                alert("已经为0！");//弹出一个对话框提示已经为0
            }else{//要先确定该商品已添加的数量不为0才能进行之后的操作
                totalPrice = totalPrice - parseInt(price);//商品总价减去当前商品的单价
                $("#total strong").text(totalPrice);//改变商品总价位置的值
                map[id] = map[id] - 1;//商品数量减1
                $(this).nextAll("strong").eq(0).text(map[id]);//改变商品数量位置的值
                if(map[id] == 0){//如果运算减1之后的数量为0，把减号的按钮设置为灰色
                    $(this).attr("src","/img/minus_stop.png");
                }
            }
            return false;
        });

        $.each($(".number"),function (i,n) {
            var id = $(this).prevAll("strong").eq(1).text();
            if(map[id] >= 0){
                $(this).children("strong").text(map[id]);
                $(this).children("img").attr("src","/img/minus_blue.png");
            }
        });
    });
</script>
<body>
<div id="content_0">
    <c:forEach items="${pageInfo.list}" var="product">
        <div class="content_1">
            <img src="/img/product/${product.pic}" alt="" class="shop_img" style="margin-bottom: 5px">
            <strong hidden>${product.id}</strong>
            <strong style="margin-left: 30px">${product.name}</strong><br><br/>
            <div style="margin-left: 25px" class="price">
                ￥<strong>${product.price}</strong>
            </div>
            <div class="number" style="margin-right: 20px;padding-bottom: 10px" >
                <img src="/img/minus_stop.png" style="width: 20px;height: 20px" class="minus">
                <strong style="font-size: 20px">0</strong>
                <img src="/img/plus_blue.png" style="width: 21px;height: 21px" class="plus">
            </div>
        </div>
    </c:forEach>
</div>
</body>
</html>
