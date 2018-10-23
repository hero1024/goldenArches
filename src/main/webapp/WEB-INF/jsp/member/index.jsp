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
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 会员数据列表</h3>
			  </div>
			  <div class="panel-body">
          <div class="table-responsive">
            <form id="memberForm">
            <table class="table ">
              <thead>
                <tr >
                    <th width="50">#</th>
                    <th>会员名</th>
                    <th>手机号</th>
                    <th ><a class="btn" style="padding: 0px;font-weight: bold" onclick="balanceClick()">账户余额</a></th>
                    <th ><a class="btn" style="padding: 0px;font-weight: bold" onclick="createTimeClick()">创建时间</a></th>
                    <th>修改余额</th>
                </tr>
              </thead>
              
              <tbody id="memberData">
                  
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
    <!-- Small modal button-->
    <button type="button" class="btn btn-primary" data-toggle="modal" data-target=".bs-example-modal-sm">Small modal</button>
    <!-- Small modal -->
    <div id="balance_update_modal" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">余额修改</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <input type="hidden" name="id" class="form-control" id="member_id">
                        <div class="form-group">
                            <label for="balance_update_input" class="col-sm-1 control-label"></label>
                            <div class="col-sm-10">
                                <input type="text" name="balance" class="form-control" id="balance_update_input">
                                <span class="help-block"></span>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="balance_save_btn">保存</button>
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
        var balanceFlag=false;
        var cdescflag=true;
        var bdescflag=true;
        var current_page_no=1;
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
            /**分页查询**/
            pageQuery(1);
        });
        /**根据创建时间排序**/
        function createTimeClick() {
            balanceFlag=false;
            cdescflag=!cdescflag;
            pageQuery(1);
        }
        /**根据账户余额排序**/
        function balanceClick() {
            balanceFlag =true;
            bdescflag=!bdescflag;
            pageQuery(1);
        }
        /***分页查询构建表格***/
        function pageQuery( pageno ) {
            current_page_no =pageno;//存储当前页
            var loadingIndex = null;
            var jsonData = {"pageno" : pageno};
            if(balanceFlag){
                if (bdescflag){
                    jsonData.orderIndex=6;
                }else {
                    jsonData.orderIndex=5;
                }
            }else {
                if(cdescflag){
                    jsonData.orderIndex=8;
                }else{
                    jsonData.orderIndex=7;
                }
            }
            $.ajax({
                type : "POST",
                url  : "${APP_PATH}/member/getAll",
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
                        var members=result.extend.pageInfo.list;
                        $.each(members, function(i, member){
                            tableContent += '<tr>';
                            tableContent += '  <td>'+(i+1)+'</td>';
                            tableContent += '  <td>'+member.name+'</td>';
                            tableContent += '  <td>'+member.phone+'</td>';
                            tableContent += '  <td>'+member.balance+'</td>';
                            tableContent += '  <td>'+member.createTime+'</td>';
                            tableContent += '  <td>';
                            tableContent += '     <button type="button" onclick="goUpdatePage('+member.id+', \''+member.balance+'\')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
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

                        $("#memberData").html(tableContent);
                        $(".pagination").html(pageContent);
                    } else {
                        layer.msg("信息查询失败", {time:2000, icon:5, shift:6}, function(){

                        });
                    }
                }
            });
        }

        /**点击按钮弹出更新模态框**/
        function goUpdatePage(id,balance) {
            $("#member_id").val(id);
            $("#balance_update_input").val(balance);
            //弹出模态框
            $("#balance_update_modal").modal({
                backdrop:"static"
            });
            //alert($("#balance_update_modal form").serialize());
        }
        /**保存信息**/
        $("#balance_save_btn").click(function () {
//            //校验数据合法性
//            if(!validate_add_emp()){
//                return false;
//            }
            //alert($("#balance_update_modal form").serialize());
            $.ajax({
                url:"${APP_PATH}/member/doEdit",
                type:"POST",
                data:$("#balance_update_modal form").serialize(),
                success:function (result) {
                    $("#balance_update_modal").modal('hide');//关闭模态框
                    if (result.code!=null){
                        if ( result.code ==100 ) {
                            layer.msg("金额修改成功", {time:1000, icon:6}, function(){
                                pageQuery(current_page_no);//跳转到修改的那一页
                            });
                        } else {
                            layer.msg("金额修改失败", {time:2000, icon:5, shift:6}, function(){});
                        }
                    }else {
                        layer.msg("权限不足", {time:2000, icon:5, shift:6}, function(){});
                    }
                }
            });
        });
    </script>
  </body>
</html>
