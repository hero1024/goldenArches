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
					<li><a href="${APP_PATH}/product/index">商品数据</a></li>
				  <li class="active">修改</li>
				</ol>
			<div class="panel panel-default">
              <div class="panel-heading">商品详情<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
			  <div class="panel-body">
				<form id="productForm" role="form">
					<input type="hidden" name="id" value="${product.id}">
					<div class="form-group">
						<label for="exampleInputPassword1">商品名称</label>
						<input type="text" class="form-control" id="name" name="name" value="${product.name}" placeholder="请输入商品名称">
					</div>
					<div class="form-group">
						<label for="exampleInputPassword1">商品价格</label>
						<div class="input-group">
							<span class="input-group-addon">￥</span>
							<input type="text" class="form-control" id="price" name="price"  value="${product.price}" placeholder="请输入商品价格">
						</div>
						<p class="help-block label label-warning">请输入合法的数据, 格式为：25.60</p>
					</div>
					<div class="form-group">
						<label for="exampleInputPassword1">商品库存</label>
						<input type="text" class="form-control" id="inventory" name="inventory"  value="${product.inventory}" placeholder="请输入商品库存" onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onpaste="return false">
					</div>
					<div class="form-group">
						<label >商品状态</label>
						<label>
							<input type="radio"  name="status"  value="1"> 上架
						</label>
						<label>
							<input type="radio"  name="status"  value="0"> 下架
						</label>
					</div>
					<div class="form-group">
						<label for="exampleInputPassword1">商品类别</label>
						<select id ="type_select"class="form-control" name="cid">
						</select>
					</div>
					<div style="display:block">
						<button id="updateFormBtn" type="button" class="btn btn-success"><i class="glyphicon glyphicon-pencil"></i> 修改数据</button>
						<button type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
					</div>
				</form>
			  </div>
				<div class="panel-heading">图片数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"></div></div>
				<div class="panel-body">
					<form id="picForm" enctype="multipart/form-data">
						<div class="form-group">
							<input type="hidden" id="productId" name="id" value="${product.id}">
							<input id="pic"name="pic" onchange="onupload(this)" type="file" accept="image/png, image/jpeg, image/gif, image/jpg" class="btn-info">
							<img style="padding-top: 2px;" id="Img" width="376" height="213" src="${basePath}/img/product/${product.pic}" >
							<div ><p class="help-block label label-warning">仅支持png gif jpg gif jpeg格式</p></div>
							<button id="updatePicBtn" type="button" class="btn btn-success"><i class="glyphicon glyphicon-pencil"></i> 修改图片</button>
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
	<script src="${APP_PATH}/script/docs.min.js"></script>
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
            getTypes("#type_select");
            bindKeyEvent($("#price"));
            $("#productForm input[name=status]").val([${product.status}]);
        });
        $("#resetBtn").click(function(){
            // Jquery[0] ==> DOM
            // $(DOM) ==> Jquery
            $("#productForm")[0].reset();
        });

        $("#updateFormBtn").click(function () {
            var checkResult =checkFrom(true,false);
            if (checkResult!="success"){
                layer.msg(checkResult, {time:2000, icon:5, shift:6}, function(){
                });
                return;
            }
            var datajson=$('#productForm').serializeObject();
            $.ajax({
                type : "POST",
                url  : "${APP_PATH}/product/doUpdateProductData",
                data : datajson,
                beforeSend : function(){
                    loadingIndex = layer.msg('处理中', {icon: 16});
                },
                success : function(result) {
                    console.log(result);
                    layer.close(loadingIndex);
                    if ( result.code==100 ) {
                        layer.msg("商品信息修改成功", {time:2000, icon:6}, function(){});
                    } else {
                        layer.msg("商品信息修改失败", {time:2000, icon:5, shift:6}, function(){});
                    }
                }
            });
        });
        $("#updatePicBtn").click(function () {
            var checkResult =checkFrom(false,true);
            if (checkResult!="success"){
                layer.msg(checkResult, {time:2000, icon:5, shift:6}, function(){
                });
                return;
            }
			var productId =$("#productId").val();
			var datajson ={"id":productId};
            $.ajaxFileUpload({
                url : '${APP_PATH}/product/doUpdateProductPic',
                fileElementId : 'pic',
                type : 'POST',
                data:datajson,
                dataType : 'json',
                success : function(result) {
                    console.log(result);
                    console.log(result.code);
                    if ( result.code==100 ) {
                        layer.msg("商品图片修改成功", {time:1000, icon:6}, function(){
                            window.location.href = "${APP_PATH}/product/index";
                        });
                    } else {
                        layer.msg("商品图片修改失败，请重新操作", {time:2000, icon:5, shift:6}, function(){
                        });
                    }
                }
            });
        });
        /**获取产品类别信息,并表单构建**/
        function getTypes(ele) {
            //清空之前下拉列表的信息
            $(ele).empty();
            $.ajax({
                type:"POST",
                url:"${APP_PATH}/category/getAll",
                success:function (result) {
                    console.log(result);
                    //解析产品分类信息
                    $.each(result.extend.categoryInfo,function() {
                        var id =this.id;
                        var optionEle = $("<option></option>").append(this.name).attr("value",this.id);
                        //数据回显
                        if(this.id==${product.cid}){
                            optionEle.attr("selected","selected");
						}
                        optionEle.appendTo(ele);
                    })
                }
            })
        }
        /**限制只能金额输入**/
        function bindKeyEvent(obj){
            obj.keyup(function () {
                var reg = $(this).val().match(/\d+\.?\d{0,2}/);
                var txt = '';
                if (reg != null) {
                    txt = reg[0];
                }
                $(this).val(txt);
            }).change(function () {
                $(this).keypress();
                var v = $(this).val();
                if (/\.$/.test(v)){
                    $(this).val(v.substr(0, v.length - 1));
                }
            });
        }
        /**选择图片，马上预览 并检查格式**/
        function onupload(file) {
            if(!file.files || !file.files[0]){
                return;
            }
            //判断文件格式
            var picInfo = $("#pic").val();
            if(picInfo.length>0 && picInfo != '') {
                var lodt = picInfo.lastIndexOf(".");
                var ext = picInfo.substring(lodt + 1).toUpperCase();
                if (ext != "PNG" && ext != "GIF"&&  ext != "JPG" && ext != "JPEG"){
                    layer.msg("图片格式不正确", {time:2000, icon:5, shift:6}, function(){
                    });
                    //jquery清空file域
                    var filePic =$("#pic");
                    filePic.after(filePic.clone().val(""));
                    filePic.remove();
                    return ;
                }
            }
            //读取文件过程方法
            var reader = new FileReader();
            reader.onload = function (e) {
                document.getElementById('Img').src = e.target.result;
                //image = e.target.result;
            };
            reader.readAsDataURL(file.files[0]);
        }
        /**将表单数据序列化为json对象**/
        $.fn.serializeObject = function()
        {
            var o = {};
            var a = this.serializeArray();
            $.each(a, function() {
                if (o[this.name] !== undefined) {
                    if (!o[this.name].push) {
                        o[this.name] = [o[this.name]];
                    }
                    o[this.name].push(this.value || '');
                } else {
                    o[this.name] = this.value || '';
                }
            });
            return o;
        };
        /**表单数据是否为空验证**/
        function checkFrom(flag1,flag2){
            //flag1 判断是否检查表单空数据
            if(flag1==true){
                ///检查商品名称
                if($("#name").val()==""){
                    return "商品名称不能为空";
                }
                //检查商品价格
                if($("#price").val()==""){
                    return "商品价格不能为空";
                }
                if($("#inventory").val()==""){
                    return "商品库存不能为空";
                }
                var status =$('input:radio[name="status"]:checked').val();
                if(status!=1 && status!=0){
                    return "请选择商品状态";
                }
                var type =$("#type_select option:selected").val();
                if(type==""){
                    return "请选择商品类别";
                }
			}
            //flag2 判断是否检查图片存在
            if(flag2==true){
                var picInfo = $("#pic").val();
                if(picInfo.length==0 || picInfo == ''){
                    return "请上传图片"
                }
			}
            return "success";
        }
	</script>
  </body>
</html>
