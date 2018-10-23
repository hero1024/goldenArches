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
	table tbody tr:nth-child(odd){background:#F4F4F4;}
	table tbody td:nth-child(even){color:#FF6600;}
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
			<div class="panel panel-default">
			  <div class="panel-heading">
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 商品数据</h3>
			  </div>
			  <div class="panel-body">
<form class="form-inline" role="form" style="float:left;">
  <div class="form-group has-feedback">
    <div class="input-group">
      <div class="input-group-addon">查询条件</div>
      <input id="queryText" class="form-control has-success" type="text" placeholder="请输入查询条件">
    </div>
  </div>
  <button id="queryBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<button type="button" class="btn btn-danger" onclick="deleteProducts()" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='${APP_PATH}/product/add'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <form id="productForm">
            <table class="table table-bordered">
              <thead>
                <tr >
                    <th width="30">#</th>
				    <th width="30"><input type="checkbox" id="allSelBox"></th>
                    <th width="45">商品图片</th>
                    <th>商品名称</th>
                    <th>商品价格</th>
                    <th>商品库存</th>
                    <th>商品状态</th>
                    <th>商品类别</th>
                    <th width="100">操作</th>
                </tr>
              </thead>
              
              <tbody id="productData">
                  
              </tbody>
              
			  <tfoot>
			     <tr >
				     <td colspan="9" align="center">
						<ul class="pagination"></ul>
					 </td>
				 </tr>

			  </tfoot>
            </table>
            </form>
          </div>
			  </div>
			</div>
        </div>
      </div>
    </div>
    <script src="${APP_PATH}/jquery/jquery-2.1.1.min.js" ></script>
    <script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
	<script src="${APP_PATH}/script/docs.min.js"></script>
	<script src="${APP_PATH}/layer/layer.js"></script>
    <script type="text/javascript">
        var searchFlag = false;
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
            /**分页查询**/
            pageQuery(1);

            /**为查询按钮添加点击事件,判断内容是否为空，进行模糊查询**/
            $("#queryBtn").click(function(){
                var queryText = $("#queryText").val();
                if ( queryText == "" ) {
                    searchFlag = false;
                } else {
                    searchFlag = true;
                }
                pageQuery(1);
            });

            /***为总单选按钮添加check 选择则全部选中**/
            $("#allSelBox").click(function(){
                var flg = this.checked;

                $("#productData :checkbox").each(function(){
                    this.checked = flg;
                });
            });

            /**为单个check_item添加点击事件**/
            $(document).on("click",".check_item",function(){
                //判断当前选择中的元素是否全选，如果是则选中总标签
                var flag = $(".check_item:checked").length==$(".check_item").length;
                $("#allSelBox").prop("checked",flag);
            });
        });

        /***分页查询构建表格***/
        function pageQuery( pageno ) {
            var loadingIndex = null;

            var jsonData = {"pageno" : pageno};
            if ( searchFlag == true ) {
                jsonData.queryText = $("#queryText").val();
            }

            $.ajax({
                type : "POST",
                url  : "${APP_PATH}/product/getAll",
                data : jsonData,
                beforeSend : function(){
                    loadingIndex = layer.msg('处理中', {icon: 16});
                },
                success : function(result) {
                    layer.close(loadingIndex);
                    console.log(result.extend.pageInfo); ///测试，t
                    if ( result.code==100 ) {
                        // 局部刷新页面数据
                        var tableContent = "";
                        var pageContent = "";
                        var pages =result.extend.pageInfo.pages;
                        var products=result.extend.pageInfo.list;
                        $.each(products, function(i, product){
                            tableContent += '<tr>';
                            tableContent += '  <td>'+(i+1)+'</td>';
                            tableContent += '  <td><input type="checkbox" name="productid" value="'+product.id+'" class="check_item"></td>';
                            tableContent += '  <td><img src="${APP_PATH}/img/product/'+product.pic+'" class="img-rounded" style="width:80px;height:45px"/></td>';
                            tableContent += '  <td>'+product.name+'</td>';
                            tableContent += '  <td>'+product.price+'</td>';
                            tableContent += '  <td>'+product.inventory+'</td>';
                            if (product.status==1){
                                tableContent += '  <td>上架</td>';
                            }else {
                                tableContent += '  <td>下架</td>';
                            }
                            tableContent += '  <td>'+product.category.name+'</td>';
                            tableContent += '  <td>';
                            tableContent += '     <button type="button" onclick="goUpdatePage('+product.id+')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
                            tableContent += '	  <button type="button" onclick="deleteProduct('+product.id+', \''+product.name+'\')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
                            tableContent += '  </td>';
                            tableContent += '</tr>';
                        });

                        if ( pageno > 1 ) {
                            pageContent += '<li><a href="#" onclick="pageQuery('+(pageno-1)+')">上一页</a></li>';
                        }

                        for ( var i = 1; i <= pages; i++ ) {
                            if ( i == pageno ) {
                                pageContent += '<li class="active"><a  href="#">'+i+'</a></li>';
                            } else {
                                pageContent += '<li ><a href="#" onclick="pageQuery('+i+')">'+i+'</a></li>';
                            }
                        }

                        if ( pageno < pages ) {
                            pageContent += '<li><a href="#" onclick="pageQuery('+(pageno+1)+')">下一页</a></li>';
                        }

                        $("#productData").html(tableContent);
                        $(".pagination").html(pageContent);
                    } else {
                        layer.msg("商品信息查询失败", {time:2000, icon:5, shift:6}, function(){

                        });
                    }
                }
            });
        }
        /**跳转到商品修改页**/
        function goUpdatePage(id) {
            window.location.href = "${APP_PATH}/product/edit?id="+id;
        }
        /***批量删除商品信息***/
        function deleteProducts() {
            var checkedlength = $(".check_item:checked").length;
            if ( checkedlength == 0 ) {
                layer.msg("请选择需要删除的商品信息", {time:2000, icon:5, shift:6}, function(){});
            } else {
                layer.confirm("确认删除已选择的商品信息, 是否继续",  {icon: 3, title:'提示'}, function(cindex){
                    // 删除已选择的商品信息
                    $.ajax({
                        type : "POST",
                        url  : "${APP_PATH}/product/deleteBatch",
                        data : $("#productForm").serialize(),
                        success : function(result) {
                            if ( result.code ==100 ) {
                                layer.msg("商品信息删除成功", {time:2000, icon:6}, function(){});
                                pageQuery(1);
                            } else {
                                layer.msg("商品信息删除失败", {time:2000, icon:5, shift:6}, function(){});
                            }
                        }
                    });

                    layer.close(cindex);
                }, function(cindex){
                    layer.close(cindex);
                });
            }
        }
        /**删除单个商品信息**/
        function deleteProduct( id, proName ) {
            layer.confirm("删除商品信息【"+proName+"】, 是否继续",  {icon: 3, title:'提示'}, function(cindex){
                // 删除单个商品信息
                $.ajax({
                    type : "POST",
                    url  : "${APP_PATH}/product/deleteOne",
                    data : { id : id },
                    success : function(result) {
                        if ( result.code==100 ) {
                            layer.msg("商品信息删除成功", {time:2000, icon:6}, function(){});
                            pageQuery(1);
                        } else {
                            layer.msg("商品信息删除失败", {time:2000, icon:5, shift:6}, function(){});
                        }
                    }
                });
                layer.close(cindex);
            }, function(cindex){
                layer.close(cindex);
            });
        }
    </script>
  </body>
</html>
