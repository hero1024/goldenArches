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
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 订单数据列表</h3>
			  </div>
			  <div class="panel-body">
<form class="form-inline" role="form" style="float:left;">
  <div class="form-group has-feedback">
    <div class="input-group">
      <div class="input-group-addon">搜索条件</div>
      <input id="queryText" class="form-control has-success" type="text" placeholder="关键词：会员手机号\会员名">
    </div>
  </div>
  <button id="queryBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 搜索</button>
</form>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <form id="orderForm">
            <table class="table table-bordered">
              <thead>
                <tr >
                    <th width="50">#</th>
                    <th>订单ID</th>
                    <th>会员手机号</th>
                    <th>会员名</th>
                    <th ><a class="btn" style="padding: 0px;font-weight: bold" onclick="amountClick()">总金额</a></th>
                    <th ><a class="btn" style="padding: 0px;font-weight: bold" onclick="createTimeClick()">订单时间</a></th>
                    <th width="100">订单详情</th>
                </tr>
              </thead>
              
              <tbody id="orderData">
                  
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
    <%--订单详情模态框--%>
    <div class="modal fade" id="orderDetailModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="orderDetailTitle">New message</h4>
                </div>
                <div class="modal-body" style="padding-bottom: 0px;padding-top: 5px">
                    <table class="table ">
                        <thead>
                        <tr >
                            <th>#</th>
                            <th>商品ID</th>
                            <th>商品名</th>
                            <th>价格</th>
                            <th>数量</th>
                            <th>金额</th>
                        </tr>
                        </thead>
                        <tbody id="orderDetailData">
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer" id="all_money" style="padding: 10px">
                    <%--<span class="glyphicon glyphicon-yen" aria-hidden="true">:</span>--%>
                    <%--<p class="btn" style="padding: 0px;font-weight: bold;padding-right: 15px">总金额</p>--%>
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
        var amountFlag=false;
        var cdescflag=true;
        var adescflag=true;
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
        });

        /**根据订单时间排序**/
        function createTimeClick() {
            amountFlag=false;
            cdescflag=!cdescflag;
            pageQuery(1);
        }
        /**根据订单金额额排序**/
        function amountClick() {
            amountFlag =true;
            adescflag=!adescflag;
            pageQuery(1);
        }
        /***分页查询构建表格***/
        function pageQuery( pageno ) {
            var loadingIndex = null;
            var jsonData = {"pageno" : pageno};
            if(amountFlag){
                if (adescflag){
                    jsonData.orderIndex=2;
                }else {
                    jsonData.orderIndex=1;
                }
            }else {
                if(cdescflag){
                    jsonData.orderIndex=4;
                }else{
                    jsonData.orderIndex=3;
                }
            }
            if ( searchFlag == true ) {
                jsonData.queryText = $("#queryText").val();
            }

            $.ajax({
                type : "POST",
                url  : "${APP_PATH}/order/getAll",
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
                        var orders=result.extend.pageInfo.list;
                        $.each(orders, function(i, order){
                            tableContent += '<tr>';
                            tableContent += '  <td>'+(i+1)+'</td>';
                            tableContent += '  <td>'+order.id+'</td>';
                            if (order.vip!=null){
                                tableContent += '  <td>'+order.vip.phone+'</td>';
                                tableContent += '  <td>'+order.vip.name+'</td>';
                            }else {
                                tableContent += '  <td></td>';
                                tableContent += '  <td>非会员</td>';
                            }
                            tableContent += '  <td>'+order.amount+'</td>';
                            tableContent += '  <td>'+order.createTime+'</td>';
                            tableContent += '  <td>';
                            tableContent += '     &nbsp;&nbsp;<button  type="button" onclick="alertModelWindow('+order.id+', \''+order.amount+'\')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-list-alt"></i></button>';
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

                        $("#orderData").html(tableContent);
                        $(".pagination").html(pageContent);
                    } else {
                        layer.msg("商品信息查询失败", {time:2000, icon:5, shift:6}, function(){

                        });
                    }
                }
            });
        }
        /***查看该商品的详情**/
        function alertModelWindow(id,amount) {
            //加载订单详情
            buildOrderDetail(id,amount);
            //弹出模态框
            $("#orderDetailModal").modal({});
        }
        //
        function buildOrderDetail(id,amount) {
            $.ajax({
                type : "POST",
                url  : "${APP_PATH}/detail/orderIdDetails",
                data : {"id":id},
                success : function(result) {
                    console.log(result);
                    if ( result.code==100 ) {
                        // 局部刷新页面数据
                        var tableContent = "";
                        var details=result.extend.details;
                        $.each(details, function(i, detail){
                            var price = parseFloat(detail.price);
                            var num = parseInt(detail.number);
                            var total_price = price*num;
                            tableContent += '<tr>';
                            tableContent += '  <td>'+(i+1)+'</td>';
                            tableContent += '  <td>'+detail.pid+'</td>';
                            tableContent += '  <td>'+detail.pname+'</td>';
                            tableContent += '  <td>'+detail.price+'</td>';
                            tableContent += '  <td>'+detail.number+'</td>';
                            tableContent += '  <td>'+total_price+'</td>';
                            tableContent += '</tr>';
                        });
                        $("#orderDetailData").html(tableContent);
                        $("#orderDetailTitle").html("ID "+id+" 订单详情");
                        var allMoney ="";
                        allMoney += '   <span class="glyphicon glyphicon-yen" aria-hidden="true">:</span>';
                        allMoney += '  <p class="btn" style="padding: 0px;font-weight: bold;padding-right: 40px">'+amount+'</p>';
                        $("#all_money").html(allMoney)
                    } else {
                        layer.msg("商品信息查询失败", {time:2000, icon:5, shift:6}, function(){

                        });
                    }
                }
            });
        }
    </script>
  </body>
</html>
