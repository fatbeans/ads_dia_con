<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>诊断结论统计（按结论）</title>
    <!-- 基础css样式 -->
    <link rel="stylesheet" type="text/css" href="content/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="content/css/bootstrap-responsive.css">
    <!-- 页面样式 -->
    <link href="content/css/content.css" rel="stylesheet">
    <link href="content/css/animate.css" rel="stylesheet">

    <!--jqgrid样式-->
    <link type="text/css" rel="stylesheet" href="content/jqGrid/css/jquery-ui-1.7.1.custom.css">
    <link type="text/css" rel="stylesheet" href="content/jqGrid/css/ui.jqgrid.css">
    <link rel="stylesheet" type="text/css" href="content/css/Frame.css">
    <script type="text/javascript" src="content/js/jquery.js"></script>
</head>
<body>
<%@ include file="menu.html" %>
<div class="ml15 mr15 content">
    <!-- 页面功能标题-s -->
    <h1 class="page-title borderbottom"><i class="t-icon mr10"></i><span class="text-blue vm"></span><i
            class="uicon ui-dArrow"></i><span class="text-darkblue vm">结论下钻</span></h1>
    <!-- 页面功能标题-e -->
    <!-- 搜索-s -->

    <!-- 搜索-e -->
    <!-- 表格部分-s -->
    <div class="panel panel-default animated fadeInUp">
        <div class="panel-heading"><i class="uicon ui-paneltitel mr10"></i>下钻列表</div>

        <div id="panel" class="tab-content">
            <div class="tab-pane active" id="LTE">

                <table id="contab" class="table table-striped table-bordered panel-tabborder table-hover">

                </table>
                <div id="pager"></div>
            </div>
        </div>
    </div>

    <!-- 表格部分-e -->
</div>
<%@ include file="footer.html" %>
</body>
<!-- JQ与BOOTSTRAP组件库 -->

<script type="text/javascript" src="content/js/bootstrap.js"></script>

<%--<!-- 滚动条模拟组件 -->--%>
<%--<script type="text/javascript" src="../js/mousewheel.js"></script>--%>
<%--<script type="text/javascript" src="../js/easyscroll.js"></script>--%>

<!-- jqgird -->
<script type="text/javascript" src="content/js/custom.min.js"></script>
<script type="text/javascript" src="content/jqGrid/js/i18n/grid.locale-cn.js"></script>
<script type="text/javascript" src="content/jqGrid/js/jquery.jqGrid.min.js"></script>


<!--js引用-->
<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>


<script type="text/javascript">

    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null)return unescape(r[2]);
        return null;
    }

    //    if (getQueryString("SERVER_IP") == null) {
    //        alert("没SERVER_IP");
    //    } else if (
    //            getQueryString("LV2_CON_ID") == null) {
    //        alert("没二级结论ID");
    //    }
    //    else if (
    //            getQueryString("SESSION_ID") == null) {
    //        alert("没会话ID");
    //    }

    var id = getQueryString("LV2_CON_ID");

    var colN;
    var colM;
    var postD;
    if (id == "10040002" || id == "10050001" || id == "10060001") {
        postD =
        {
            server_ip: getQueryString("SERVER_IP"),
            lv2_con_id: getQueryString("LV2_CON_ID"),
            session_id: getQueryString("SESSION_ID")
        };
        colN = ['用户号码', '连接开始时间', '连接结束时间', '小区名称',
            '网络制式', 'LAC', 'CI', '终端标识', '终端名称', '客户端IP', '服务端IP',
            'SGW/SGSN标识',
            'SGW/SGSN名称', 'SGW/SGSNIP', '状态', '错误码', '失败场景', '失败场景英文', '解释口径', '上行流量(Byte）',
            '下行流量(Byte）', '平均响应时间（ms）', '总响应(ms）', '业务大类名称',
            '业务小类名称', '服务端IP归属国家', '服务端IP归属省', '服务端IP归属运营商'];
        colM = [
            {name: '用户号码', width: 150},
            {name: '连接开始时间', width: 150},
            {name: '连接结束时间', width: 150},
            {name: '小区名称', width: 150},
            {name: '网络制式', width: 150},
            {name: 'LAC', width: 150},
            {name: 'CI', width: 150},
            {name: '终端标识', width: 150},
            {name: '终端名称', width: 150},
            {name: '客户端IP', width: 150},
            {name: '服务端IP', width: 150},
            {name: 'SGW/SGSN标识', width: 150},
            {name: 'SGW/SGSN名称', width: 150},
            {name: 'SGW/SGSNIP', width: 150},
            {name: '状态', width: 150},
            {name: '错误码', width: 150},
            {name: '失败场景', width: 150},
            {name: '失败场景英文', width: 150},
            {name: '解释口径', width: 150},
            {name: '上行流量(Byte）', width: 150},
            {name: '下行流量(Byte）', width: 150},
            {name: '平均响应时间（ms）', width: 150},
            {name: '总响应(ms）', width: 150},
            {name: '业务大类名称', width: 150},
            {name: '业务小类名称', width: 150},
            {name: '服务端IP归属国家', width: 150},
            {name: '服务端IP归属省', width: 150},
            {name: '服务端IP归属运营商', width: 150}
        ]
    } else if (id == "10040005") {
        postD =
        {
            lv2_con_id: getQueryString("LV2_CON_ID"),
            session_id: getQueryString("SESSION_ID")
        };
        colN = ['imsi', '手机号码', '连接开始时间', '连接结束时间', '状态', '错误码', '上行流量（byte）', '下行流量（byte）', '平均响应时间（ms）', '总响应（ms）'];
        colM = [
            {name: 'imsi', width: 150},
            {name: '手机号码', width: 150},
            {name: '连接开始时间', width: 150},
            {name: '连接结束时间', width: 150},
            {name: '状态', width: 150},
            {name: '错误码', width: 150},
            {name: '上行流量（byte）', width: 150},
            {name: '下行流量（byte）', width: 150},
            {name: '平均响应时间（ms）', width: 150},
            {name: '总响应（ms）', width: 150}
        ];
    } else if (id == "10030001") {
        postD =
        {
            lv2_con_id: getQueryString("LV2_CON_ID"),
            session_id: getQueryString("SESSION_ID"),
            error_code: getQueryString("ERROR_CODE")
        };
        colN = ['imsi', '手机号码', '连接开始时间', '连接结束时间', '终端名称', '状态', '错误码', '上行流量（byte）', '下行流量（byte）', '平均响应时间（ms）', '总响应（ms）'];
        colM = [
            {name: 'imsi', width: 150},
            {name: '手机号码', width: 150},
            {name: '连接开始时间', width: 150},
            {name: '连接结束时间', width: 150},
            {name: '终端名称', width: 150},
            {name: '状态', width: 150},
            {name: '错误码', width: 150},
            {name: '上行流量（byte）', width: 150},
            {name: '下行流量（byte）', width: 150},
            {name: '平均响应时间（ms）', width: 150},
            {name: '总响应（ms）', width: 150}
        ];
    }

    $("#contab").jqGrid({
        url: 'home/concUnder',
        postData: postD,
        datatype: 'json',
        colNames: colN,
        colModel: colM,
        autowidth: true,
        rowNum: 30,
        hidegrid: false,
        rownumbers: true,
        shrinkToFit: false,
        deepempty: true,
        height: 500,
        pager: '#pager',
        viewrecords: true
    }).navGrid('#pager', {edit: false, add: false, del: false, search: false, refresh: false});
    $("#contab").jqGrid('setGridWidth', $('#panel').width() - 4);
    $(window).resize(function () {//当浏览器大小变化时
//        $('.container4 .div_scroll').scroll_absolute({arrows: false});
        $("#contab").jqGrid('setGridWidth', $('#panel').width() - 4);
    });



</script>
<!-- 各页面依托JQ组件 -->
<script type="text/javascript" src="content/js/plugins.js"></script>


</html>