$(function () {
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
                location.href = "/show";
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
                //location.href = "/show?category=" + $(this).text();
                category = $(this).text();
                $.each($(".menu_1"),function (i,n) {
                    $(this).css("font-weight","500");
                    $(this).css("color","");
                });
                $(this).css("font-weight","900");
                $(this).css("color","red");
                $.get("/refresh",{"category":category},
                    function(data){
                        $("#content_0").html(data);
                    },"html");
            }
        });
    });

    //上一页的点击事件
    $("#last_page").click(function () {
        pageNum = parseInt(pageNum) - 1;//页码减1，需要先转换成数值类型
        if(pageNum >= 1){//如果运算之后的页码大于等于1，页面跳转到上一页
            //location.href="/show?pageNum="+pageNum +"&category="+ category;
            $.post("/refresh",{"pageNum":pageNum,"category":category},
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
            //location.href="/show?pageNum="+pageNum +"&category="+ category;
            $.post("/refresh",{"pageNum":pageNum,"category":category},
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
            location.href = "/vipPay?phone="+phone+"&jsonStr="+jsonStr;
        }
        return false;
    });
    //普通结账的点击事件
    $("#user_pay").click(function(){
        var jsonStr = JSON.stringify(map);
        if(jsonStr.length <= 2){
            alert("请先添加商品再结账！");
        }else{
            var phone = prompt("请输入您要付款的手机号。")
            while(phone.length == 0){
                phone = prompt("您输入为空，请输入你的手机号。");
            }
            location.href = "/userPay?phone="+phone+"&jsonStr="+jsonStr;
        }
        return false;
    });
});