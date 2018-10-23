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
				  <li class="active">新增</li>
				</ol>
			<div class="panel panel-default">
              <div class="panel-heading">类别详情<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
			  <div class="panel-body">
				<form id="ProductForm"  method="post" enctype="multipart/form-data">
					<div class="form-group">
						<label for="exampleInputPassword1">商品类别</label>
						<input type="text" class="form-control" id="name" name="name" placeholder="请输入商品类别名称">
					</div>
					<div style="display:block">
						<button id="insertBtn" type="button" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 新增</button>
						<button type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
					</div>
				</form>
			  </div>
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
    <script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
	<script src="${APP_PATH}/layer/layer.js"></script>
	<script type="text/javascript">
        $(function () {
            $(".list-group-item").click(function () {
                if ($(this).find("ul")) {
                    $(this).toggleClass("tree-closed");
                    if ($(this).hasClass("tree-closed")) {
                        $("ul", this).hide("fast");
                    } else {
                        $("ul", this).show("fast");
                    }
                }
            });
        });

        /**提交表单**/
        $("#insertBtn").click(function(){
            var categoryName =$("#name").val();
            if (categoryName ==""){
                layer.msg("商品类型名称不能为空", {time:2000, icon:5, shift:6}, function(){});
                return;
			}
            $.ajax({
                type : "POST",
                url  : "${APP_PATH}/category/doAdd",
                data : { name : categoryName },
                success : function(result) {
                    if ( result.code==100 ) {
                        layer.msg("商品类型添加成功:"+result.extend.category.name, {time:1500, icon:6}, function(){});
                    } else {
                        layer.msg("商品类型添加失败，请重新操作", {time:2000, icon:5, shift:6}, function(){
                        });
                    }
                }
            });

        });

        /**表单数据是否为空验证**/
        function checkFrom(){
            ///检查商品名称
			if($("#name").val()==""){
			    return "商品名称不能为空";
			}
            return "success";
		}
	</script>
  </body>
</html>
