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
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jq_easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jq_webbox/jquery-webox.js"></script>
<script type="text/javascript" src="js/jquery.json-2.4.min.js"></script>
<title>工单详情</title>
<script type="text/javascript">
var localUrl = "${pageContext.request.contextPath}";
var workId = <%=request.getParameter("workId") %>;
var workOneUrl = localUrl+"/plugins/taskwork/getTaskOne.ilf";
var downFileUrl = localUrl+"/plugins/taskwork/downfile.ilf";
var WorkOrder = null;
$(document).ready(function(){
	if(workId != null && workId != ""){
		loadWorkById(workId);
	}
	$("#FileName").click(function(){
		if(downFileUrl != null && downFileUrl != ""){
			var _formEl = $("<form method='post' action='"+downFileUrl+
					"?workId="+workId+"'></form>").appendTo(document.body);
			_formEl[0].submit();
			setTimeout(function(){_formEl.remove();},20);
		}
	});
	$("#detailName").click(function(){
		if(WorkOrder["DETAIL_URL"] != null){
			$.webox({
				width: 900,
				height: 475,
				bgvisibel: true,
				title: '数据详情',
				allscreen: true,		
				iframe: WorkOrder["DETAIL_URL"]
			});
		}
	});
});
function loadWorkById(workKey){
	$.ajax({
		type : 'post',
		url : workOneUrl,
		contentType : "application/x-www-form-urlencoded; charset=utf-8",
		data : {workId : workKey},
		dataType : 'json',
		success : function(data){
			if(data != null){
				WorkOrder = data;
				initWorkOrder();
			}
		},
		error : function(){
			
		}
	});
}
function initWorkOrder(){
	$("#workTitle").html(WorkOrder["WO_TITLE"]);
	
	$("#CityName").html(WorkOrder["CITY"]);
	$("#TypeName").html(WorkOrder["WO_TYPE"]);
	$("#TypeSubName").html(WorkOrder["WO_TYPE_SUB"]);
	
	$("#RangeName").html(WorkOrder["WO_RANGE"]);
	$("#NeType").html(WorkOrder["WO_NETYPE"]);
	$("#SendWay").html(WorkOrder["WO_SEND_WAY"]);
	
	$("#Content").val(WorkOrder["WO_CONTENT"]);
	$("#sendStatus").html(WorkOrder["SEND_STATUS"] == "0"?"创建中":
			(WorkOrder["SEND_STATUS"]=="1"?"已创建未派发":
			(WorkOrder["SEND_STATUS"]=="2"?"已派发":WorkOrder["SEND_STATUS"])));
	$("#FileName").html(WorkOrder["FILE_NAME"]);
	
	$("#sendTime").html(WorkOrder["WO_SEND_TIME"]);
	$("#sendDepartment").html(WorkOrder["WO_SEND_DEPARTMENT"]);
	$("#receiveUser").html(WorkOrder["RECEIVE_USER"]);
	
	$("#eomsId").html(WorkOrder["EOMS_ID"]);
	$("#eomsStatus").html(WorkOrder["EOMS_STATUS"]);
	$("#closeTime").html(WorkOrder["WO_CLOSE_TIME"]);
}
</script>
</head>
<body>
<div style="display:block;">
	<table class="conditionTable" style="width:100%;">
		<tr>
			<td class="title" colspan="6" style="text-align:left;font-weight:bold;">工单信息</td>
		</tr>
		<tr>
			<td class="title">任务主题:</td>
			<td colspan="5"><span id="workTitle" style="width: 508px;" ></span></td>
		</tr>
		<tr>
			<td class="title">地市:</td>
			<td><span id="CityName" style="width: 200px;"></span></td>
			<td class="title">任务大类:</td>
			<td><span id="TypeName" style="width: 200px;"></span></td>
			<td class="title">任务子类:</td>
			<td><span id="TypeSubName" style="width: 200px;"></span></td>
		<tr>
		<tr>
			<td class="title">问题对象:</td>
			<td><span id="RangeName" style="width: 200px;"></span></td>
			<td class="title">任务处理对象:</td>
			<td><span id="NeType" style="width: 200px;"></span></td>
			<td class="title">派单方式:</td>
			<td><span id="SendWay" style="width: 200px;"></span></td>
		<tr>
		<tr>
			<td class="title">派单内容:</td>
			<td colspan="5"><textarea id="Content" name="Content" readOnly="readOnly" 
					style="width:600px;height:60px;"></textarea></td>
		</tr>
		<tr>
			<td class="title">派单状态:</td>
			<td><span id="sendStatus" style="width: 200px;"></span></td>
			<td class="title">附件名称:</td>
			<td colspan="3">
				<span id="FileName" style="width: 200px;color:blue;cursor:pointer;"></span>
				<span id="detailName" style="width: 80px;color:blue;cursor:pointer;float:right;">数据详情</span>
			</td>
		<tr>
		<tr>
			<td class="title" colspan="6" style="text-align:left;font-weight:bold;">派单信息</td>
		</tr>
		<tr>
			<td class="title">派单时间:</td>
			<td><span id="sendTime" style="width: 200px;"></span></td>
			<td class="title">任务受理单位:</td>
			<td><span id="sendDepartment" style="width: 200px;"></span></td>
			<td class="title">任务受理人:</td>
			<td><span id="receiveUser" style="width: 200px;"></span></td>
		<tr>
		<tr>
			<td class="title">EOMS工单编号:</td>
			<td><span id="eomsId" style="width: 200px;"></span></td>
			<td class="title">EOMS工单状态:</td>
			<td><span id="eomsStatus" style="width: 200px;"></span></td>
			<td class="title">任务结束时间:</td>
			<td><span id="closeTime" style="width: 200px;"></span></td>
		<tr>
	</table>
</div>
<!-- 
<div style="width:100%">
	<iframe id="reportIFrame" src="" width="100%" frameborder="0" style="border:0px;height:520px;"></iframe>
</div>
 -->
</body>
</html>