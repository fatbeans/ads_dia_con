<%@page import="com.jfinal.kit.PropKit"%>
<%@page import="java.util.Properties"%>
<%@page import="com.jfinal.kit.PropKit"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html >
<head>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>信令查询</title>
    <!-- 基础css样式 -->
    <link rel="stylesheet" type="text/css" href="/content/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="/content/css/bootstrap-responsive.css">
    <!-- 页面样式 -->
    <link href="/content/css/content.css" rel="stylesheet">
    <link href="/content/css/animate.css" rel="stylesheet">

    <!--jqgrid样式-->
    <link type="text/css" rel="stylesheet" href="/content/jqGrid/css/jquery-ui-1.7.1.custom.css">
    <link type="text/css" rel="stylesheet" href="/content/jqGrid/css/ui.jqgrid.css">
    <link rel="stylesheet" type="text/css" href="/content/css/Frame.css">
    <script type="text/javascript" src="/content/js/jquery.js"></script>
    <script type="text/javascript" src="/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="/content/js/icheck.min.js"></script>
    <script type="text/javascript" src="/content/js/bootstrap.js"></script>

	<%--<!-- 滚动条模拟组件 -->--%>
	<script type="text/javascript" src="/content/js/mousewheel.js"></script>
	<script type="text/javascript" src="/content/js/easyscroll.js"></script>
	
	<!-- 自定义checkbox样式 -->
	<link href="/content/js/skins/square/blue.css" rel="stylesheet">

	<script type="text/javascript" src="/content/js/artcloudui/artcloudui.dialog.js"></script>
	<link rel="stylesheet" href="/content/js/artcloudui/skins/gray/css/artcloudui.css" >
    <script type="text/javascript" src="/signalling/script/signalling.js"></script>
    <style type="text/css">
    	.panel-tabborder tr.active .bgred{background-color: red;}
    </style>
</head>
<body>
	<%@ include file="/menu.html" %>
	<div class="content" id="content" style="overflow:auto">
		<div class="ml15 mr15 div-open">
			<!-- 页面功能标题-s -->
			<h1 class="page-title borderbottom animated fadeInDown">
				<i class="t-icon mr10"></i><span class="text-blue vm">信令查询</span>
				<i class="uicon ui-dArrow"></i><span class="text-darkblue vm">用户信令回放</span>
			</h1>
			<!-- 页面功能标题-e -->
			<!-- 搜索-s -->
			<div class="mt10 animated fadeInDown pr" style="z-index:101">
				<div class="inlininput mr10">
					<label class="S-label">开始时间</label>
					<span class="add-on"><a href="javascript:void(0)"><i class="icon-calendar"></i></a></span>
					<input id="txtStartDate" type="text" class="w100" placeholder="" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH'})">
				</div>
				<div class="inlininput mr10">
					<label class="S-label">结束时间</label>
					<span class="add-on"><a href="javascript:void(0)"><i class="icon-calendar"></i></a></span>
					<input id="txtEndDate" type="text" class="w100" placeholder="" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH'})">
				</div>
				<div class="inlininput mr10">
					<label class="S-label">用户标识</label>
					<input id="txtPhone" type="text" class="w100" placeholder="" value=""  maxlength="15" style="width:130px;"">
				</div>
				<div id="interfacepanel" class="sel_wrap w150 mb10 mr10 dragdownlist"  style="overflow: visible;">
				    <label>接口类型</label>
					<!--<select class="select" name="">
						<option value="0">选择接口类型</option>
						<option value="11">S1-U</option>
						<option value="5">S1-MME</option>
						<option value="9">SGS</option>
						<option value="7">S11</option>
					</select>-->
					<a class="sel-link"><i class="icon-arrow"></i></a>
					<ul style="display:none;position:absolute;z-index:10000;width:100%;color:#000;border:solid 1px blue;margin-top:-4px;background-color:#fff;max-height: 350px;overflow-y: auto;">
					</ul>
				</div>
				<div id="flowtypepanel" class="sel_wrap w150 mb10 mr10 dragdownlist" style="overflow: visible;">
				    <label style="overflow: hidden;">流程类型</label>
					<a class="sel-link"><i class="icon-arrow"></i></a>
					<ul style="display:none;position:absolute;z-index:10000;width:300px;color:#000;border:solid 1px blue;margin-top:-4px;background-color:#fff;max-height: 350px;overflow-y: auto;">
						<!-- <li style="height:30px;line-height:30px;"><label style="color:#000;"><input type="checkbox" value="" />Attach</label></li>
						<li style="height:30px;line-height:30px;"><label  style="color:#000;"><input type="checkbox" value="" />Sevvice Request</label></li>
						<li style="height:30px;line-height:30px;"><label  style="color:#000;"><input type="checkbox" value="" />Paging</label></li>
						<li style="height:30px;line-height:30px;"><label  style="color:#000;"><input type="checkbox" value="" />TAU</label></li> -->
					</ul>
				</div>
				<a id="btnQuery" href="javascript:void(0)" class="btn btn-search vm mb10">
					<span class="searchicon"><i class="uicon ui-search"></i></span>查询
				</a>
			</div>
			<!-- 搜索-e -->
			<!-- 表格部分-s -->
			<div class="panel panel-default animated fadeInUp">
			  <div class="pl15 pr15 pt10 pb10 clearfix">
			  	  <div class="pull-left"  id="cbStatusPanel">
			  	  	<label id="cbloadPanel" class="mb0 mt3">
				      <input id="cbLoadData" type="checkbox" class="uipinput" ><span class="ml10 vm">只显示失败状态</span>
				    </label>
			  	  </div>
				  <div class="pull-right">
				  	<a id="btnIssue" href="javascript:void(0)" class="btn mr10">问题定界</a>
				  	<a id="btngogis" href="javascript:void(0)"" class="btn mr10">GIS查看</a>
	  				<a href="#" class="btn btn-primary"  style="display:none">导出</a>
				  </div>
			  </div>
			  <!-- 表格数据-s -->
			  <div class="container4 clearfix">
	            <div class="div_scroll">
	                <div style="height:418px;overflow-y: hidden; width:auto">
			  			<table class="table table-striped table-bordered panel-tabborder table-hover">
					        <thead>
					          <tr>
					            <th>#</th>
					            <th>开始时间</th>
					            <th>结束时间</th>
					            <!--<th>用户MSISDN</th>
					            <th>用户IMSI</th>-->
					            <th>XDR ID</th>
					            <th>城市</th>
					            <th>TAC</th>
					            <th>ECI</th>
					            <th>接入类型</th>
					            <th>接口类型</th>
					            <th>流程类型</th>
					            <th>时延</th>
					            <th>源端IP</th>
					            <th>目的端IP</th>
					            <th>流程状态</th>
					            <th>失败原因码</th>
					            <th>协议类型</th>
					          </tr>
					        </thead>
					        <tbody id="signallingBody">
					          
					        </tbody>
					    </table>
					</div>
				</div>
			  </div>
			  <!-- 表格数据-e -->
			  <!-- 分页-s -->
			  <div class="panel-footer clearfix pr">
			  	<div class="pull-left text-lightgray" >&nbsp;</div>
			  	<div class="pagination pa-right ui-pager">
				  <ul id="pagepanel">
				    <!--<li class="disabled"><a href="javascript:void(0)"></a></li>
				    <li class="active pageitems"><a href="javascript:void(0)">1</a></li>
				    <li id="btnnextpage"><a href="javascript:void(0)">></a></li>-->
				  </ul>
				</div>
			  </div>
			  <!-- 分页-e -->
			</div>
			<!-- 表格部分-e -->
			<div class="panel panel-default animated fadeInUp">
				<div class="panel-body">
					<ul id="tabdetail" class="detaillist clearfix">
						
					</ul>
				</div>
			</div>
		</div>
	</div>
</body>
<!-- jqgird -->
<script type="text/javascript" src="/content/js/custom.min.js"></script>
<script type="text/javascript" src="/content/jqGrid/js/i18n/grid.locale-cn.js"></script>
<script type="text/javascript" src="/content/jqGrid/js/jquery.jqGrid.min.js"></script>



<!-- 各页面依托JQ组件 -->
<script type="text/javascript" src="/content/js/plugins.js"></script>

<%@ include file="/footer.html" %>

</html>