<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
	<link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
	<link rel="stylesheet" href="${APP_PATH}/css/login.css">
	<style>
    </style>
  </head>
  <body>
    <nav class="navbar navbar-inverse navbar-fixed-top" style="background-color: #393C3D;border-bottom-color:#666868" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <div><a class="navbar-brand" href="${APP_PATH}/product/show" style="font-size:32px;">点餐平台</a></div>
        </div>
      </div>
    </nav>

    <div class="container" style="padding-top: 110px">
      <form id="loginForm" action="doLogin" method="post" class="form-signin" role="form">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-user"></i> 管理员登录</h2>
		  <div class="form-group has-success has-feedback">
			<input type="text" class="form-control" id="account" name="account" placeholder="请输入登录账号" autofocus>
			<span class="glyphicon glyphicon-user form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<input type="password" class="form-control" id="password" name="password" placeholder="请输入登录密码" style="margin-top:10px;">
			<span class="glyphicon glyphicon-lock form-control-feedback"></span>
		  </div>
        <a class="btn btn-lg btn-success btn-block" onclick="dologin()" > 登录</a>
          <a class="btn btn-lg btn-success btn-block" onclick="testTomianAjax()" > ceshiyisbu</a>
      </form>
    </div>
    <script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
    <script src="${APP_PATH}/layer/layer.js"></script>
    <script>
    function dologin() {
        // 非空校验
        var account = $("#account").val();
        if ( account == "" ) {
            layer.msg("账号不能为空", {time:2000, icon:5, shift:6}, function(){});
        	return;
        }
        var password = $("#password").val();
        if ( password == "" ) {
            layer.msg("密码不能为空", {time:2000, icon:5, shift:6}, function(){});
        	return;
        }
        var loadingIndex = null;
        $.ajax({
        	type : "POST",
        	url  : "${APP_PATH}/admin/doLogin",
        	data : $("#loginForm").serialize(),
        	beforeSend : function(){
        		loadingIndex = layer.msg('处理中', {icon: 16});
        	},
        	success : function(result) {
        		layer.close(loadingIndex);
        		if (result.code==100) {
        			window.location.href = "${APP_PATH}/admin/main";
        		} else {
                    layer.msg("账号或密码不正确，请重新输入", {time:2000, icon:5, shift:6}, function(){});
        		}
        	}
        });
    }
    function testToMainAjax(){
        $.ajax({
            type : "POST",
            url  : "${APP_PATH}/admin/main",
            data : $("#loginForm").serialize(),
            success : function(result) {
                console.log(result);
                if (result.code==100) {
                    window.location.href = "${APP_PATH}/admin/main";
                } else {
                    layer.msg("账号或密码不正确，请重新输入", {time:2000, icon:5, shift:6}, function(){});
                }
            }
        });
    };
    </script>
  </body>
</html>