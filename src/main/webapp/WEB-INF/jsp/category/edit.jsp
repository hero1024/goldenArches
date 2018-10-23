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
					<li><a href="${APP_PATH}/category/index">商品类别数据</a></li>
				  <li class="active">修改</li>
				</ol>
			<div class="panel panel-default">
              <div class="panel-heading">类别详情<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
			  <div class="panel-body">
				<form id="categoryForm">
					<div class="form-group">
						<label >商品类别</label>
						<input type="text" class="form-control" id="name" name="name" value="${category.name}" placeholder="请输入商品名称">
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
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
		<div class="modal-content">
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
			<h4 class="modal-title" id="myModalLabel">帮助</h4>
		  </div>
		  <div class="modal-body">
			<div class="bs-callout bs-callout-info">
				<h4>测试标题1</h4>
				<p>测试内容1，测试内容1，测试内容1，测试内容1，测试内容1，测试内容1</p>
			  </div>
			<div class="bs-callout bs-callout-info">
				<h4>测试标题2</h4>
				<p>测试内容2，测试内容2，测试内容2，测试内容2，测试内容2，测试内容2</p>
			  </div>
		  </div>
		  <!--
		  <div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			<button type="button" class="btn btn-primary">Save changes</button>
		  </div>
		  -->
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
            $("#categoryForm")[0].reset();
        });

        $("#updateFormBtn").click(function () {
            var categoryName =$("#name").val();
            if (categoryName ==""){
                layer.msg("商品类型名称不能为空", {time:2000, icon:5, shift:6}, function(){});
                return;
            }
            $.ajax({
                type : "POST",
                url  : "${APP_PATH}/category/doEdit",
                data : {id:${category.id},name:categoryName},
                beforeSend : function(){
                    loadingIndex = layer.msg('处理中', {icon: 16});
                },
                success : function(result) {
                    console.log(result);
                    layer.close(loadingIndex);
                    if ( result.code==100 ) {
                        layer.msg("商品类别信息修改成功", {time:1000, icon:6}, function(){
                            window.location.href = "${APP_PATH}/category/index";
						});
                    } else {
                        layer.msg("商品类别信息修改失败", {time:2000, icon:5, shift:6}, function(){});
                    }
                }
            });
        });
	</script>
  </body>
</html>
