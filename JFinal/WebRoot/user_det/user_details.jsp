<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>详单查询</title>
    <!-- 基础css样式 -->
    <link rel="stylesheet" type="text/css" href="../content/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../content/css/bootstrap-responsive.css">
    <!-- 页面样式 -->
    <link href="../content/css/content.css" rel="stylesheet">
    <link href="../content/css/animate.css" rel="stylesheet">

    <!--jqgrid样式-->
    <link type="text/css" rel="stylesheet" href="../content/jqGrid/css/jquery-ui-1.7.1.custom.css">
    <link type="text/css" rel="stylesheet" href="../content/jqGrid/css/ui.jqgrid.css">
    <link rel="stylesheet" type="text/css" href="../content/css/Frame.css">
    <script type="text/javascript" src="../content/js/jquery.js"></script>
</head>
<body>
<%@ include file="../menu.html" %>
<div class="ml15 mr15 content">
    <!-- 页面功能标题-s -->
    <h1 class="page-title borderbottom"><i class="t-icon mr10"></i><span class="text-blue vm">详单查询</span><i
            class="uicon ui-dArrow"></i><span class="text-darkblue vm">用户详单查询</span></h1>
    <!-- 页面功能标题-e -->
    <!-- 搜索-s -->
    <div class="mt10">
        <div class="inlininput mr10">
            <label class="S-label">开始时间</label>
            <span class="add-on"><a href="#"><i class="icon-calendar"></i></a></span>
            <input type="text" id="sd" class="w100"
                   onClick="WdatePicker({dateFmt:'yyyy/MM/dd HH',maxDate:'#F{$dp.$D(\'ed\')}'})" />
        </div>
        <div class="inlininput mr10">
            <label class="S-label">结束时间</label>
            <span class="add-on"><a href="#"><i class="icon-calendar"></i></a></span>
            <input type="text" id="ed"
                   onClick="WdatePicker({dateFmt:'yyyy/MM/dd HH',minDate:'#F{$dp.$D(\'sd\')}'})"
                   class="w100" />
        </div>
        <div class="inlininput mr10">
            <label class="S-label">用户号码</label>
            <input type="text" id="msisdn" class="w100" >
        </div>

        <a href="#" id="psb" class="btn btn-search vm mb10">
            <span class="searchicon"><i class="uicon ui-search"></i></span>
            搜索
        </a>
    </div>
    <!-- 搜索-e -->
    <!-- 表格部分-s -->
    <div class="panel panel-default animated fadeInUp">
        <div class="panel-heading"><i class="uicon ui-paneltitel mr10"></i>详单列表</div>
        <div class="pl15 pr15 pt10 pb10 clearfix borderbottom">
            <ul class="nav nav-tabs ui-tabs pull-left mb0" id="myTab">
                <li><a href="#2-3G">2/3G</a></li>
                <li class="active"><a href="#LTE">LTE</a></li>
            </ul>
            <div class="pull-right">
                <a href="#" id="export" class="btn btn-primary">导出</a>
            </div>
        </div>
        <div id="panel" class="tab-content">
            <div class="tab-pane " id="2-3G">
                <div class="onbuild">
                    <h6>2/3G功能正在建设中...</h6>
                    <p>即将开放，敬请期待！</p>
                </div>

            </div>
            <div class="tab-pane active" id="LTE">

                <table id="ltetab" class="table table-striped table-bordered panel-tabborder table-hover">

                </table>
                <div id="pager"></div>
            </div>
        </div>

    </div>

    <!-- 表格部分-e -->
</div>
</body>
<!-- JQ与BOOTSTRAP组件库 -->

<script type="text/javascript" src="../content/js/bootstrap.js"></script>

<%--<!-- 滚动条模拟组件 -->--%>
<%--<script type="text/javascript" src="../js/mousewheel.js"></script>--%>
<%--<script type="text/javascript" src="../js/easyscroll.js"></script>--%>

<!-- jqgird -->
<script type="text/javascript" src="../content/js/custom.min.js"></script>
<script type="text/javascript" src="../content/jqGrid/js/i18n/grid.locale-cn.js"></script>
<script type="text/javascript" src="../content/jqGrid/js/jquery.jqGrid.min.js"></script>


<!--js引用-->
<script type="text/javascript" src="../My97DatePicker/WdatePicker.js"></script>


<script type="text/javascript">
    var now = new Date();
    now.setDate(now.getDate() - 1);
    $("#sd").val(now.getFullYear()+"/"+(now.getMonth()+1)+"/"+now.getDate()+" 00");
    $("#ed").val(now.getFullYear()+"/"+(now.getMonth()+1)+"/"+now.getDate()+" 23");
//    $('.container4 .div_scroll').scroll_absolute({arrows: false});
    $(window).resize(function () {//当浏览器大小变化时
//        $('.container4 .div_scroll').scroll_absolute({arrows: false});
        $("#ltetab").jqGrid('setGridWidth', $('#panel').width() - 2);
    });


    $("#ltetab").jqGrid({
        url: '../user_det/searchLTE',
        datatype: 'local',
        colNames: ['手机号码', '开始时间', '结束时间', '终端型号', '终端厂家', '业务大类', '业务小类', '访问站点', '详细站点',
            '状态', '错误码', '上行流量(B)', '下行流量(B)', '平均响应时间(ms)', 'APN', '网络类型', '服务小区'],
        colModel: [
            {name: 'msisdn' ,width:150},
            {name: 'procedure_starttime_ms',width:150},
            {name: 'procedure_endtime_ms',width:150},
            {name: 'tactype',width:150},
            {name: 'tacbrnd',width:150},
            {name: 'app_type_name',width:150},
            {name: 'app_sub_type_name',width:150},
            {name: 'host',width:150},
            {name: 'uri',width:150},
            {name: 'status_code',width:150},
            {name: 'error_code',width:150},
            {name: 'ul_data',width:150},
            {name: 'dl_data',width:150},
            {name: 'bus_lantency',width:150},
            {name: 'apn',width:150},
            {name: 'rat_code',width:150},
            {name: 'cell_name',width:150}
        ],
        autowidth:true,
            rowNum: 15,
            hidegrid: false,
            rownumbers: true,
            shrinkToFit: false,
            width:  $('#panel').width() - 2,
            deepempty : true,
            height: 500,
            pager: '#pager',
            viewrecords: true,
    }).navGrid('#pager', {edit: false, add: false, del: false, search: false, refresh: false});


    $("#export").click(function () {
        if (!checkInput()) {

        }else{

            var sd = $("#sd").val().replace(/[/]/g, '').replace(' ', '');
            var ed = $("#ed").val().replace(/[/]/g, '').replace(' ', '');
            var msisdn = $("#msisdn").val();
            window.open("../export.jsp?sd="+sd+"&ed="+ed+"&msisdn="+msisdn, "导出文件",
                    "height=300, width=600, toolbar =no, top=300, left=300 menubar=no, scrollbars=no, resizable=no, location=no, status=no");

        }
    });

    $("#psb").click(function () {
        if (!checkInput()) {
            return;
        }

        $("#ltetab").jqGrid('setGridParam', {
            postData: {
                sd: $("#sd").val().replace(/[/]/g, '').replace(' ', ''),
                ed: $("#ed").val().replace(/[/]/g, '').replace(' ', ''),
                msisdn: $("#msisdn").val()
            }, datatype: 'json'
        }).trigger("reloadGrid");
    });

    function checkInput() {
        if ($("#sd").val() == '') {
            alert("请选择开始时间");
            return false;
        } else if ($("#ed").val() == '') {
            alert("请选择结束时间");
            return false;
        } else if ($("#msisdn").val() == '') {
            alert("请填写用户号码");
            return false;
        } else {
            return true;
        }
    }

</script>
<!-- 各页面依托JQ组件 -->
<script type="text/javascript" src="../content/js/plugins.js"></script>

<%@ include file="../footer.html" %>

</html>