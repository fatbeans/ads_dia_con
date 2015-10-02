<%--
  Created by IntelliJ IDEA.
  User: xinxin
  Date: 2015/7/31
  Time: 17:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>智能诊断-运营</title>
    <!-- 基础css样式 -->
    <link rel="stylesheet" type="text/css" href="content/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="content/css/bootstrap-responsive.css">
    <!-- 页面样式 -->
    <link href="content/css/content.css" rel="stylesheet">
    <link href="content/css/animate.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="content/css/Frame.css">
    <!--jqgrid样式-->
    <link type="text/css" rel="stylesheet" href="content/jqGrid/css/jquery-ui-1.7.1.custom.css">
    <link type="text/css" rel="stylesheet" href="content/jqGrid/css/ui.jqgrid.css">
    <link rel="stylesheet" href="content/js/artcloudui/skins/gray/css/artcloudui.css">

</head>

<body>
<%@ include file="menu.html" %>
<div class="ml15 mr15 div-open content">
    <!-- 页面功能标题-s -->
    <h1 class="page-title borderbottom animated fadeInDown"><i class="t-icon mr10"></i><span
            class="text-blue vm">投诉履历</span>
    </h1>
    <!-- 页面功能标题-e -->
    <!-- 搜索-s -->
    <div class="mt10 animated fadeInDown">
        <div class="inlininput mr10">
            <label class="S-label">开始时间</label>
            <span class="add-on"><a href="#"><i class="icon-calendar"></i></a></span>
            <input type="text" id="sd" class="w100"
                   onClick="WdatePicker({dateFmt:'yyyy/MM/dd HH',maxDate:'#F{$dp.$D(\'ed\')}'})"/>
        </div>
        <div class="inlininput mr10">
            <label class="S-label">结束时间</label>
            <span class="add-on"><a href="#"><i class="icon-calendar"></i></a></span>
            <input type="text" id="ed" class="w100"
                   onClick="WdatePicker({dateFmt:'yyyy/MM/dd HH',minDate:'#F{$dp.$D(\'sd\')}'})"/>
        </div>
        <div class="inlininput mr10">
            <label class="S-label">用户号码</label>
            <input type="text" id="msisdn" class="w100">
        </div>
        <div class="inlininput mr10" style="display: none">

            <label class="S-label">IMSI</label>
            <input id="imsi" type="text" class="w100" style="padding-left: 45px" placeholder="">
        </div>
        <a href="#" id="psb" class="btn btn-search vm mb10" title="无号码则查询时间段内所有设诉数据，且不查询投诉履历">
            <span class="searchicon" ><i class="uicon ui-search" ></i></span> 查询
        </a>
    </div>
    <!-- 搜索-e -->
    <!-- 用户信息-s -->
    <div class="panel panel-default animated fadeInDown">
        <div class="userinfobox clearfix">
            <!-- 用户信息头像-s -->
            <div class="pull-left pr">
                <div class="use-ava pa"><i></i></div>
                <div class="user-infotext hide" id="userInfo">
                    <h1 id="infoMdn">&nbsp;</h1>

                    <p>&nbsp;</p>

                    <p class="mt5"><i class="uicon ui-Signal mr10"></i><span class="text-b1bcc5 vm ">
                    </span><span class="text-b1bcc5 vm" id="infoTeName"> </span></p>
                </div>
            </div>
            <!-- 用户信息头像-e -->
            <!-- 用户信息数据-s -->
            <div class="pull-right">
                <ul class="userinfo-datalist clearfix">
                    <li>
                        <a href="#">
                            <h2 class="pr text-dager" id="cMcnt">0<i class="pa">件</i></h2>

                            <p>本月投诉总次数</p>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <h2 class="pr" id="pMcnt">0<i class="pa">件</i></h2>

                            <p>上月投诉总次数</p>
                        </a>
                    </li>
                </ul>
            </div>
            <!-- 用户信息数据-e -->
        </div>
    </div>
    <!-- 用户信息-e -->
    <!-- 表格部分-s -->
    <div class="panel panel-default animated fadeInUp">
        <div class="panel-heading"><i class="uicon ui-paneltitel mr10"></i>历史投诉及诊断明细</div>
        <div class="pl15 pr15 pt10 pb10 clearfix">
            <ul class="nav nav-tabs ui-tabs mb0" id="myTab">
                <li class="active litab"><a href="#tab1">历史投诉</a></li>
                <li class="litab"><a href="#tab2">诊断明细</a></li>
            </ul>
        </div>
        <div class="tab-content" style="overflow: visible;" id="panel">
            <div class="tab-pane active" id="tab1">
                <table id="hisTab"></table>
                <div id="hisPager"></div>
            </div>
            <div class="tab-pane" id="tab2">
                <table id="detTab"></table>
                <div id="detPager"></div>
            </div>
        </div>
        <div class="panel-footer clearfix pr"></div>
    </div>
    <!-- 表格部分-e -->
</div>


<%@ include file="footer.html" %>
</body>
<!-- JQ与BOOTSTRAP组件库 -->
<script type="text/javascript" src="content/js/jquery.js"></script>
<script type="text/javascript" src="content/js/bootstrap.js"></script>

<!-- 各页面依托JQ组件 -->
<script type="text/javascript" src="content/js/plugins.js"></script>
<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
<!-- jqgird -->
<script type="text/javascript" src="content/js/custom.min.js"></script>
<script type="text/javascript" src="content/jqGrid/js/i18n/grid.locale-cn.js"></script>
<script type="text/javascript" src="content/jqGrid/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="content/js/artcloudui/artcloudui.dialog.js"></script>
<script type="text/javascript">


    $("#hisTab").jqGrid({
        url: 'comp/searchHistory',
        datatype: 'local',
        colNames: ['全量投诉流水号', '客服受理时间', '受理号码', '用户归属地市', '客户级别', '客户品牌', '投诉业务类型', '诉求内容', '重复投诉', '投诉类型', '客服判断是否解决（认可）', '省EOMS流水号', '派单EOMS时间', '工单时限', '最终处理部门'],
        colModel: [
            {name: 'TOTALFLOWID'},
            {name: 'ACCEPT_TIME'},
            {name: 'CALLING_NO'},
            {name: 'PRO_MAN_BELONG'},
            {name: 'PRO_MAN_LEVEL'},
            {name: 'PRO_MAN_SIZEUP'},
            {name: 'BUSINESS_CLASS'},
            {name: 'PRO_CONTENT'},
            {name: 'PROSECUTE_TIMES'},
            {name: 'PROSECUTE_TYPE'},
            {name: 'IS_OVER'},
            {name: 'FLOW_ID'},
            {name: 'START_TIME'},
            {name: 'SHEET_LIMIT'},
            {name: 'DEAL_DEPT_NAME'}
        ],
        loadComplete: function () {
            $.artcloud.loading("close");
        },
        loadError: function () {
            $.artcloud.loading("close");
        },
        gridComplete: function () {
            $.artcloud.loading("close");
        },
        rowNum: 30,
        hidegrid: false,
        rownumbers: true,
        height: 400,
        shrinkToFit: false,
        width: $('#tab1').width() - 2,
        pager: '#hisPager',
        viewrecords: true
    }).navGrid('#hisPager', {edit: false, add: false, del: false, search: false, refresh: false});


    function currencyFmatter(cellvalue, options, rowObject) {
        var sd = rowObject.DIA_START_TIME.substr(0, 13);
        var ed = rowObject.DIA_END_TIME.substr(0, 13);
        var sessionid = cellvalue;
        var mdn = rowObject.MDN;
        var val =
                "<a target='_blank' href='http://10.193.240.11:8806/sv/indexcust?q=true&sd=" + sd + "&ed=" + ed + "&msisdn=" + mdn +
                "&sessionid=" +
                sessionid + "' class='btn btn-small btn-primary'>查看详情</a>";
        return val;
    }

    $("#detTab").jqGrid({
        url: 'comp/searchUsrLog',
        datatype: 'local',
        colNames: ['诊断查询起始时间', '诊断查询结束时间', '诊断操作时间', '诊断操作人员', '操作'],
        colModel: [
            {name: 'DIA_START_TIME'},
            {name: 'DIA_END_TIME'},
            {name: 'PAGE_DIA_TIME'},
            {name: 's'},
            {name: 'SESSION_ID', formatter: currencyFmatter}
        ],
        loadComplete: function () {
            $.artcloud.loading("close");
        },
        loadError: function () {
            $.artcloud.loading("close");
        },
        gridComplete: function () {
            $.artcloud.loading("close");
        },
        autowidth: true,
        rowNum: 30,
        hidegrid: false,
        rownumbers: true,
        height: 400,
        shrinkToFit: false,
        width: $('#tab2').width() - 2,
        pager: '#detPager',
        viewrecords: true,
        pagerpos: 'center'
    }).navGrid('#detPager', {edit: false, add: false, del: false, search: false, refresh: false});

    $("#detPager_left").attr("style", "");

    $(window).resize(function () {//当浏览器大小变化时
        tabresize();
    });

    $(".litab").click(function () {
        tabresize();
    });

    function tabresize() {
        $("#hisTab").jqGrid('setGridWidth', $('#tab1').width() - 4);
        $("#detTab").jqGrid('setGridWidth', $('#tab2').width() - 4);
    }

    $(document).ajaxError(function (e, xhr, opt) {
        $.artcloud.loading("close");
    });

    $("#psb").click(function () {
        if (!checkInput()) {
            return;
        }
        $.artcloud.loading();

        $.ajax({
            type: "POST",
            url: "./comp/seachInfo",
            data: {"sd": $("#sd").val(), "ed": $("#ed").val(), "msisdn": $("#msisdn").val()},
            dataType: "json",
            success: function (d) {
                info(d);
            }
        });

        $("#hisTab").jqGrid('setGridParam', {
            postData: {
                sd: $("#sd").val().replace(/[/]/g, '').replace(' ', ''),
                ed: $("#ed").val().replace(/[/]/g, '').replace(' ', ''),
                msisdn: $("#msisdn").val()
            }, datatype: 'json'
        }).trigger("reloadGrid");
        if ($("#msisdn").val() !== null || $("#msisdn").val() !== undefined || $("#msisdn").val().trim() !== '') {
            $("#detTab").jqGrid('setGridParam', {
                postData: {msisdn: $("#msisdn").val()},
                datatype: 'json'
            }).trigger("reloadGrid");
        }
    });

    function checkInput() {
        if ($("#sd").val() == '') {
            alert("请选择开始时间");
            return false;
        } else if ($("#ed").val() == '') {
            alert("请选择结束时间");
            return false;
//        } else if ($("#msisdn").val() == '' || isNaN($("#msisdn").val())) {
//            alert("请填写正确用户号码");
//            return false;
        } else {
            return true;
        }
    }

    function info(d) {
        if (d == null || typeof (d) == "undefined") {
            return;
        }
        $("#userInfo").show();
        $("#infoMdn").html($("#msisdn").val());
        $("#cMcnt").html(d.thisMonCnt);
        $("#pMcnt").html(d.lastMonCnt);
    }

    tabresize();


    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null)return unescape(r[2]);
        return null;
    }


    if (getQueryString("q") != null) {
        $.artcloud.loading("close");
        $("#sd").val(getQueryString("sd"));
        $("#ed").val(getQueryString("ed"));
        $("#msisdn").val(getQueryString("msisdn"));
        $("#psb").click();
    } else {
        $.artcloud.loading("close");
        var now = new Date();
        var month = now.getMonth() + 1;
        var day = now.getDate();
        $("#sd").val(now.getFullYear() + "/" + (month < 10 ? ("0" + month) : month) + "/" + (day < 10 ? ("0" + day) :
                        day) + " 00");
        $("#ed").val(now.getFullYear() + "/" + (month < 10 ? ("0" + month) : month) + "/" + (day < 10 ? ("0" + day) :
                        day) + " 23");
    }

</script>

</html>
