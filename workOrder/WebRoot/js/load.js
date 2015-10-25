var groupLines = [];
var lineNumber = 3;
var isLoad = false,
	dataPage = 1,
	limit = 30;
	typeKey = 2;
	tableGridFilter = "",
	tableGridData = {total:1,rows:[{}]},
	typeLineItemObj = null,
	typesubLineItemObj = null,
	rangeLineItemsObj = null;
$(document).ready(function(){
	$("#fromDatePick").Date('init', 
		{dateFmt: 'yyyy-MM-dd', defaultValue:getRelativeDay(7)["text"],width:110});
	$("#endDatePick").Date('init', 
		{dateFmt: 'yyyy-MM-dd', defaultValue:getRelativeDay(0)["text"],width:110});
		
	$("#queryButton").bind("click",function(event){
		//submitSearch(dataPage);
		submitSearch(1);
	});
	initLineItems();
	loadTypeItemData();
	loadTypeSubItemData(typeKey);
	initGrid();
	//submitSearch(1);
});
function initLineItems(){
	typeLineItemObj = new LineExpandItem({
		render:$("#typeItems"),
		key:"types",
		name:"业务大类",
		isMulti:false,
		isCancel:false,
		labelField:"value",
		datas:[],
		selectDatas:[{key:typeKey}],
		itemSelectHandle:function(event,itemEl,selData){
			loadTypeSubItemData(selData.key);
		}
	});
	typesubLineItemObj = new LineExpandItem({
		render:$("#typesubItems"),
		key:"typesubs",
		name:"业务小类",
		isMulti:false,
		isCancel:false,
		labelField:"value",
		datas:[],
		selectDatas:[],
		itemSelectHandle:function(event,itemEl,selData){
			typeSubChange(selData);
		}
	});
}
function loadTypeItemData(){
	ajaxPost(fieldsUrl,{type:"type"},function(datas){
		typeLineItemObj.setDatas(datas,[{key:typeKey}]);
	});
}
function loadTypeSubItemData(type){
	ajaxPost(fieldsUrl,{type:"type_sub",parent:type},function(datas){
		if(datas != null || datas.length > 0){
			typesubLineItemObj.setDatas(datas,[datas[0]]);
			typeSubChange(datas[0]);
		}else{
			typesubLineItemObj.setDatas([]);
		}
	});
}
function loadRangesItemData(typesub){
	ajaxPost(fieldsUrl,{type:"range",parent:typesub},function(datas){
		if(datas != null || datas.length > 0){
			rangeLineItemsObj.setDatas(datas,[datas[0]]);
			submitSearch(1);
		}else{
			typesubLineItemObj.setDatas([]);
		}
	});
}
function typeSubChange(typesubObj){
	rangeLineItemsObj = new FilterItem({
			render:$("#rangeItems"),
			key:"ranges",
			name:"问题对象",
			filterName:"问题对象",
			filterHandle:function(filterText){
				submitSearch(1);
			}
		});
	submitSearch(1);
	/*
	if(typesubObj.search == 'LINEITEM'){
		rangeLineItemsObj = new LineExpandItem({
			render:$("#rangeItems"),
			key:"ranges",
			name:"任务场景",
			isMulti:false,
			isCancel:false,
			labelField:"value",
			datas:[],
			selectDatas:[],
			itemSelectHandle:function(event,itemEl,selData){
				submitSearch(1);
			}
		});
		loadRangesItemData(typesubObj.key);
	}else if(typesubObj.search == 'FILTER'){
		rangeLineItemsObj = new FilterItem({
			render:$("#rangeItems"),
			key:"ranges",
			name:"问题对象",
			filterName:"",
			filterHandle:function(filterText){
				submitSearch(1);
			}
		});
	}
	*/
}
var gridColumns = [
		{field:"WO_ID",title:"任务编号",width:80,align:"center",sortable:false,resizable:true},
		{field:"WO_TITLE",title:"任务主题",width:80,align:"center",sortable:false,resizable:true,
			formatter: function(value,row,index){
				return "<span style='color:blue;' onclick='openWorkDetail("+
					row["WO_ID"]+",\""+row["WO_TITLE"]+"\")'>" +
					value+"</span>"
			}},
		{field:"WO_TYPE",title:"任务大类",width:80,align:"center",sortable:false,resizable:true},
		{field:"WO_TYPE_SUB",title:"任务子类",width:90,align:"center",sortable:false,resizable:true},
		{field:"WO_RANGE",title:"任务细分场景",width:120,align:"center",sortable:false,resizable:true},
		{field:"WO_NETYPE",title:"任务处理对象",width:80,align:"center",sortable:false,resizable:true},
		{field:"WO_SEND_WAY",title:"任务派单方式",width:100,align:"center",sortable:false,resizable:true},
		{field:"WO_CREATE_TIME",title:"任务建单时间",width:80,align:"center",sortable:false,resizable:true},
		//{field:"WO_SEND_TIME",title:"任务派单时间",width:90,align:"center",sortable:false,resizable:true},
		//{field:"WO_SEND_DEPARTMENT",title:"任务受理单位",width:120,align:"center",sortable:false,resizable:true},
		//{field:"RECEIVE_USER",title:"任务受理人",width:120,align:"center",sortable:false,resizable:true},
		//{field:"EOMS_ID",title:"EOMS工单编号",width:120,align:"center",sortable:false,resizable:true},
		//{field:"EOMS_STATUS",title:"EOMS工单状态",width:120,align:"center",sortable:false,resizable:true},
		//{field:"WO_CLOSE_TIME",title:"任务结束时间",width:120,align:"center",sortable:false,resizable:true},
		{field:"SEND_STATUS",title:"任务派单状态",width:120,align:"center",sortable:false,resizable:true,
			formatter: function(value,row,index){
				switch(value){
					case "0":return "创建中";
					case "1":return "已创建未派发";
					case "2":return "已派发";
					default : return value;
				}
			}}];
function initGrid(data,pageNumber){
	//初始化表格
	$("#reportGrid").datagrid({
		rownumbers:true,
		pagination:true,
		singleSelect:true,
		fitColumns:true,
		remoteSort:true,
		collapsible:true,
		nowrap: false,
		striped:true,
		height:450,
		fit:false,
		loadMsg:"正在加载数据...",
		pageSize: 30,//每页显示的记录条数，默认为10
		pageList: [30],//可以设置每页记录条数的列表
		pageNumber : Math.max(1,pageNumber != null?pageNumber : 1),
		onBeforeLoad : function(param){
			if(dataPage == param.page){//如果是当前页，不进行加载
				return ;
			}
			dataPage = param.page;
			submitSearch(dataPage);
			setTimeout(function(){$("#reportGrid").datagrid("loading");},10);
		},
		onLoadSuccess:function(){
			if(!isLoad){
				setTimeout(function(){$("#reportGrid").datagrid("loading");},100);
			}
			isLoad = true;
		},
		columns:[gridColumns],
		data:data || []
	});
	var gridPage = $("#reportGrid").datagrid('getPager');//分页  
	gridPage.pagination({
		pageSize : 30,//每页显示的记录条数，默认为10
		pageList : [30],//可以设置每页记录条数的列表
		pageNumber : Math.max(1,pageNumber != null?pageNumber : 1),
		beforePageText: '第',//页数文本框前显示的汉字
		afterPageText: '页	共 {pages} 页',
		displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
	});
}
function openWorkDetail(workId,title){
	$.webox({
		width: 900,
		height: 475,
		bgvisibel: true,
		title: title,
		allscreen: true,		
		iframe: "detail.jsp?workId="+workId
	});
}
//pageNumber 需要定位到第几页 第一页从0开始算
function submitSearch(pageNumber){
	var loadParam = {};
	var startTime = $("#fromDatePick").Date('getRealValue');
	var endTime = $("#endDatePick").Date('getRealValue');
	if(startTime != ""){
		loadParam.fromTime = startTime;
	}
	if(endTime != ""){
		loadParam.endTime = endTime;
	}
	var typeDatas = typeLineItemObj.getSelectDatas();
	var keyArr = [];
	for(var t=0;t<typeDatas.length;t++){
		keyArr.push(typeDatas[t].key);
	}
	if(keyArr.length > 0){
		loadParam.types = keyArr.join(",");
		keyArr = [];
	}
	var typesubDatas = typesubLineItemObj.getSelectDatas();
	for(var t=0;t<typesubDatas.length;t++){
		keyArr.push(typesubDatas[t].key);
	}
	if(keyArr.length > 0){
		loadParam.typesubs = keyArr.join(",");
		keyArr = [];
	}
	var rangeVal = rangeLineItemsObj.getRealValue();
	loadParam.ranges = rangeVal;
	loadReportData(resultsUrl,loadParam,pageNumber);
}
function loadReportData(reportUrl,reportParam,pageNumber){
	var pageParam = {rows:30,page:pageNumber};
	pageParam.taskJson = $.toJSON(reportParam);
	setTimeout(function(){$("#reportGrid").datagrid("loading");},10);
	ajaxPost(reportUrl,
		pageParam,
		function(tableDatas){
			if(tableDatas == null){
				return ;
			}
			initGrid(tableDatas,pageNumber);
		}
	);
}
function getRelativeDay(num){
	var dateObj = {};
	var date = new Date();
	var timeSecondNum = date.getTime() - num*24*3600*1000;
	date.setTime(timeSecondNum);				
	var dayStr = "0"+date.getDate();
	var dayMonth = "0"+(date.getMonth()+1);
	dayStr = dayStr.substring(dayStr.length-2,dayStr.length);
	dayMonth = dayMonth.substring(dayMonth.length-2,dayMonth.length);			
	dateObj["text"] = date.getFullYear()+"-"+dayMonth+"-"+dayStr;
	dateObj["value"] = date.getFullYear()+dayMonth+dayStr;
	return dateObj;
}
function ajaxPost(url,param,callHandler){
	$.ajax({
		type:'post',
		url:url,
		contentType: "application/x-www-form-urlencoded; charset=utf-8",
		data:param,
		dataType:'json',
		success : function(data){
			callHandler(data);
		},
		error : function(){
			
		}
	});
}
function ajaxJsonpPost(url,param,callHandler){
	$.ajax({
		type:'post',
		url:url,
		contentType: "application/x-www-form-urlencoded; charset=utf-8",
		data:param,
		dataType: 'jsonp',
		jsonp: 'jsonpCallback',
		success : function(data){
			callHandler(data);
		},
		error : function(){
			
		}
	});
}