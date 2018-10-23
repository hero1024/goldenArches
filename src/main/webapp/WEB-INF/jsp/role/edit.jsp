<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

	<link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
	<link rel="stylesheet" href="${APP_PATH}/css/main.css">
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	</style>
  </head>

  <body>

    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<%@include file="/WEB-INF/jsp/common/header.jsp"%>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
			<div class="tree">
				<%@include file="/WEB-INF/jsp/common/menu.jsp"%>
			</div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<ol class="breadcrumb">
				  <li><a href="${APP_PATH}/admin/main">首页</a></li>
				  <li><a href="${APP_PATH}/role/index">角色数据</a></li>
				  <li class="active">修改</li>
				</ol>
			<div class="panel panel-default">
              <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"></i></div></div>
			  <div class="panel-body">
				<form id="roleForm">
					<div class="form-group">
						<label >角色</label>
						<input type="text" class="form-control" id="name" name="name" value="${role.name}" placeholder="请输入角色名称">
						<span class="help-block"></span>
					</div>
					<div style="display:block">
						<button id="updateFormBtn" type="button" class="btn btn-success"><i class="glyphicon glyphicon-pencil"></i> 修改</button>
						<button id="resetBtn" type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
					</div>
				</form>

			</div>
        </div>
      </div>
    </div>
	</div>
    <script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
	<script src="${APP_PATH}/layer/layer.js"></script>
	<script src="${APP_PATH}/script/ajaxfileupload.js"></script>
	<script type="text/javascript">
        $(function () {
            $(".list-group-item").click(function(){
                if ( $(this).find("ul") ) {
                    $(this).toggleClass("tree-closed");
                    if ( $(this).hasClass("tree-closed") ) {
                        $("ul", this).hide("fast");
                    } else {
                        $("ul", this).show("fast");
                    }
                }
            });
        });
        $("#resetBtn").click(function(){
            // Jquery[0] ==> DOM
            // $(DOM) ==> Jquery
            $("#roleForm")[0].reset();
        });

        /**校验用户账户的唯一性**/
        $("#name").change(function () {
            var name = this.value;
            $.ajax({
                url:"${APP_PATH}/role/uniqueName",
                type:"POST",
                data:{"name":name},
                success:function (result) {
                    if(100 == result.code){
                        show_validate_msg("#name","success","账户可用");
                        $("#updateFormBtn").attr("ajax-va","success");
                        return true;
                    }else {
                        show_validate_msg("#name","error",result.extend.va_msg);
                        $("#updateFormBtn").attr("ajax-va","error");
                    }
                }
            })
        });
        /**显示校验结果的提示信息**/
        function show_validate_msg(ele,status,msg){
            //清除当前元素的校验状态
            $(ele).parent().removeClass("has-success has-error");
            $(ele).next("span").text("");

            if("success"==status){
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg);
            }else if("error" == status){
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
            }
        }
        $("#updateFormBtn").click(function () {
            if("error" == $(this).attr("ajax-va")){
                return false;
            }
            var roleName =$("#name").val();
            if (roleName ==""){
                layer.msg("商品类型名称不能为空", {time:2000, icon:5, shift:6}, function(){});
                return;
            }
            $.ajax({
                type : "POST",
                url  : "${APP_PATH}/role/doEdit",
                data : {id:${role.id},name:roleName},
                beforeSend : function(){
                    loadingIndex = layer.msg('处理中', {icon: 16});
                },
                success : function(result) {
                    console.log(result);
                    layer.close(loadingIndex);
                    if ( result.code==100 ) {
                        layer.msg("角色信息修改成功", {time:1000, icon:6}, function(){
                            window.location.href = "${APP_PATH}/role/index";
						});
                    } else {
                        layer.msg("角色信息修改失败", {time:2000, icon:5, shift:6}, function(){});
                    }
                }
            });
        });
	</script>
  </body>
</html>
