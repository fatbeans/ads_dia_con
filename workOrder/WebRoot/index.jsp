<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/jslib/jq_easyui/themes/default/easyui.css" type="text/css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/jslib/jq_easyui/themes/default/datagrid.css" type="text/css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/jslib/jq_webbox/css/jquery-webox.css" type="text/css"/>
<link rel="stylesheet" href="css/bootstrap.css"/>
<link rel="stylesheet" href="css/todc-bootstrap.css"/>
<link rel="stylesheet" href="css/body-layout.css"/>
<link rel="stylesheet" href="css/style.css"/>
<link rel="stylesheet" href="css/component.css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery/jquery-min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery/jquery.json.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/js_juicer/src/juicer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/js_searchComponent/Combobox.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/js_searchComponent/jquery.inputlabel.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/js_searchComponent/InputGray.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/js_searchComponent/Date.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/js_my97datepicker/WdatePicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jq_easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jq_webbox/jquery-webox.js"></script>
<script type="text/javascript" src="js/component.js" ></script>
<script type="text/javascript" src="js/load.js"></script>
<script type="text/javascript" src="js/jquery.json-2.4.min.js"></script>
<style type="text/css">
#fromDatePick input{width:100px;border: 1px solid #e1e1e1;}
#endDatePick input{width:100px;border: 1px solid #e1e1e1;}
.datagrid-cell, .datagrid-cell-group, .datagrid-header-rownumber, .datagrid-cell-rownumber {
    font-size: 12px;
    line-height: 18px;
    white-space: normal;
    word-wrap: normal;
}
</style>
<script type="text/javascript">
var loadUrl = "${pageContext.request.contextPath}";
var fieldsUrl = loadUrl + "/plugins/taskwork/getWorkFields.ilf";
var resultsUrl = loadUrl + "/plugins/taskwork/getTasks.ilf";
</script>
<title>任务管理</title>
</head>
<body>
<div style="padding:10px;">
	<div style="display:block;">
		<div style="width: 100%; vertical-align: middle;display:inline-block;
			background-color: #f9fafe;border-color:#dfe8f1;border-radius: 2px;
			box-shadow: 0 1px 2px 00 1px 2px 0 #ffffff;padding:5px 0;" class="search">
			<div id="searchComponent" style="display:block;float:left;position:relative;">
				<div style="float:left;margin-left:10px">时间：</div>
				<div id="fromDatePick" style="width:105px;float:left;margin-left:3px"></div>
				<div style="display:inline-block;width:10px;height:10px;margin:0px 3px;float:left;"> ~ </div>
				<div id="endDatePick" style="width:100px;float:left;"></div>
				<div style="float:left;margin-left:10px;"><a id="queryButton" href="javascript:void(0);" 
					style="height: 26px;line-height:26px;width: 60px;
					background-color:#4b8cf7;color:#FFFFFF;
					font-weight: bold;padding:5px 14px;"> 查 询 </a></div>
			</div>
		</div>
		<div style="display:block;">
			<div id="typeItems" style="display:block;">
				
			</div>
			<div id="typesubItems" style="display:block;">
				
			</div>
			<div id="rangeItems" style="display:block;">
				
			</div>
		</div>
	</div>
	<div style="margin-top:10px;">
		<table id="reportGrid"></table>
	</div>
</div>
</body>
</html>