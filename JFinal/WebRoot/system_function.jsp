<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>详单查询</title>
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
<div class="ml15 mr15 div-open">
    <!-- 页面功能标题-s -->
    <h1 class="page-title borderbottom animated fadeInDown mb15"><i class="t-icon mr10"></i><span class="text-blue vm">系统功能</span>
    </h1>
    <!-- 页面功能标题-e -->
    <!-- 右边数据-s -->
    <div class="w fr">
        <div class="col-2-r320">
            <div class="panel panel-default animated fadeInRight" id="panel">
                <div class="panel-heading"><i class="uicon ui-paneltitel mr10"></i>模块使用频次统计</div>
                <!-- 搜索-s -->
                <div class="pt10 pl10 searchinpanel borderbottom">
                    <div class="inlininput mr10">
                        <label class="S-label">开始时间</label>
                        <span class="add-on"><a href="#"><i class="icon-calendar"></i></a></span>
                        <input type="text" id="sd" class="w100"
                               onClick="WdatePicker({dateFmt:'yyyy/MM/dd HH',maxDate:'#F{$dp.$D(\'ed\')}'})"/>
                    </div>
                    <div class="inlininput mr10">
                        <label class="S-label">结束时间</label>
                        <span class="add-on"><a href="#"><i class="icon-calendar"></i></a></span>
                        <input type="text" id="ed"
                               onClick="WdatePicker({dateFmt:'yyyy/MM/dd HH',minDate:'#F{$dp.$D(\'sd\')}'})"
                               class="w100"/>
                    </div>
                    <div class="inlininput mr10" id="usrdiv">
                        <label class="S-label">用户名</label>
                        <input type="text" id="usr" class="w100">
                    </div>
                    <div class="inlininput mr10" id="depdiv">
                        <label class="S-label">部门</label>
                        <input type="text" id="dep" class="w100">
                    </div>
                    <a href="javascript:void(0)" class="btn btn-search vm mb10" id="psb">
                        <span class="searchicon"><i class="uicon ui-search"></i></span> 查询
                    </a>
                </div>
                <!-- 搜索-e -->
                <!-- 表格-s -->
                <table id="cnttab" class="table table-striped table-bordered panel-tabborder table-hover">

                </table>
                <div id="pager"></div>
                <!-- 表格-e -->
            </div>
        </div>
    </div>
    <!-- 右边数据-e -->
    <!-- 左边列表-s -->
    <div class="col-2-l320 fr">
        <div class="panel panel-default animated fadeInLeft">
            <div class="panel-heading"><i class="uicon ui-paneltitel mr10"></i>系统使用情况统计</div>
            <div class="div-open pr" style="height:600px;">
                <ul class="villageinfo-list" id="js-villageinfo-list">
                    <li class="nochild active">
                        <a href="javascript:void(0)" onclick="initCntByDepTab()"><i class="v-Circle mr10"></i>模块使用频次统计（按部门）</a>
                        <span class="uicon ui-line pa"><i class="uicon ui-menuarrow"></i></span>
                    </li>
                    <li class="">
                        <a href="javascript:void(0)" onclick="initCntByUsrTab()"><i class="v-Circle mr10"></i>模块使用频次统计（按账号）</a>
                        <span class="uicon ui-line pa"><i class="uicon ui-menuarrow"></i></span>

                        <div class="chi-table">
                            <ul class="S-menulist">
                                <li>
                                    <i class="w-line mr5"></i>
                                    <a href="javascript:void(0)" onclick="initListByUsrTab()" class="vm">
                                        模块使用频次明细（按账号）
                                    </a>
                                    <i class="uicon ui-checked pa"></i>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <li class="nochild">
                        <a href="javascript:void(0)" onclick="initCntByFuncTab()"><i class="v-Circle mr10"></i>模块使用频次统计（按模块）</a>
                        <span class="uicon ui-line pa"><i class="uicon ui-menuarrow"></i></span>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <!-- 左边列表-e -->
</div>
<%@ include file="footer.html" %>
</body>
<!-- JQ与BOOTSTRAP组件库 -->
<script type="text/javascript" src="content/js/jquery.js"></script>

<script type="text/javascript" src="content/js/bootstrap.js"></script>
<script type="text/javascript" src="content/js/custom.min.js"></script>
<script type="text/javascript" src="content/jqGrid/js/i18n/grid.locale-cn.js"></script>
<script type="text/javascript" src="content/jqGrid/js/jquery.jqGrid.min.js"></script>

<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>

<!-- 纵向滚动条 -->
<script type="text/javascript" src="content/js/jquery.slimscroll.min.js"></script>
<!-- 自定义checkbox-js -->
<script src="content/js/icheck.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        <!-- 自定义checkbox-js -->
        $('.uipinput').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square',
            increaseArea: '20%' // optional
        });
        <!-- 纵向滚动条 -->
        $('.VerticalSroll').slimScroll({
            height: '100%',
            color: '#3f414b',
            alwaysVisible: false,
            touchScrollStep: 1000,
            wheelStep: '1px'
        })
        initCntByDepTab();
    });
    function initCntByDepTab() {
        $("#usrdiv").hide();
        $("#depdiv").show();

        $("#cnttab").jqGrid("GridUnload");
        $("#cnttab").jqGrid({
            url: '/syslog/countFuncBydep',
            datatype: "local",
            colNames: ["部门", "详单查询", "投诉履历", "智能诊断", "信令查询", "信令GIS"],
            colModel: [
                {name: "DEP"},
                {name: "XDCX"},
                {name: "TSLL"},
                {name: "ZNZD"},
                {name: "XLCX"},
                {name: "XLGIS"}
            ],
            autowidth: true,
            rowNum: 30,
            hidegrid: false,
            rownumbers: true,
            shrinkToFit: false,
            deepempty: true,
            height: 500,
            pager: '#pager',
            viewrecords: true

        }).navGrid("#pager", {
            edit: false,
            add: false,
            del: false,
            search: false,
            refresh: false
        }).trigger("reloadGrid");
        $("#cnttab").jqGrid('setGridWidth', $('#panel').width() - 4);
        $(window).resize(function () {//当浏览器大小变化时
//        $('.container4 .div_scroll').scroll_absolute({arrows: false});
            $("#cnttab").jqGrid('setGridWidth', $('#panel').width() - 4);
        });
    }

    function initCntByUsrTab() {
        $("#usrdiv").show();
        $("#depdiv").hide();

        $("#cnttab").jqGrid("GridUnload");
        $("#cnttab").jqGrid({
            url: '/syslog/countFuncByUser',
            datatype: "local",
            colNames: ["账户", "详单查询", "投诉履历", "智能诊断", "信令查询", "信令GIS"],
            colModel: [
                {name: "USR"},
                {name: "XDCX"},
                {name: "TSLL"},
                {name: "ZNZD"},
                {name: "XLCX"},
                {name: "XLGIS"}
            ],
            autowidth: true,
            rowNum: 30,
            hidegrid: false,
            rownumbers: true,
            shrinkToFit: false,
            deepempty: true,
            height: 500,
            pager: '#pager',
            viewrecords: true

        }).navGrid("#pager", {
            edit: false,
            add: false,
            del: false,
            search: false,
            refresh: false
        }).trigger("reloadGrid");
        $("#cnttab").jqGrid('setGridWidth', $('#panel').width() - 4);
        $(window).resize(function () {//当浏览器大小变化时
//        $('.container4 .div_scroll').scroll_absolute({arrows: false});
            $("#cnttab").jqGrid('setGridWidth', $('#panel').width() - 4);
        });
    }

    function clearval() {
        $("#usrdiv").val("");
        $("#depdiv").val("");
    }

    function initCntByFuncTab() {
        $("#usrdiv").hide();
        $("#depdiv").hide();

        $("#cnttab").jqGrid("GridUnload");
        $("#cnttab").jqGrid({
            url: '/syslog/countFunc',
            datatype: "local",
            colNames: ["模块", "使用次数"],
            colModel: [
                {name: "FUNC_DESC"},
                {name: "CNT"}
            ],
            autowidth: true,
            rowNum: 30,
            hidegrid: false,
            rownumbers: true,
            shrinkToFit: false,
            deepempty: true,
            height: 500,
            pager: '#pager',
            viewrecords: true

        }).navGrid("#pager", {
            edit: false,
            add: false,
            del: false,
            search: false,
            refresh: false
        }).trigger("reloadGrid");
        $("#cnttab").jqGrid('setGridWidth', $('#panel').width() - 4);
        $(window).resize(function () {//当浏览器大小变化时
            $("#cnttab").jqGrid('setGridWidth', $('#panel').width() - 4);
        });
    }


    function initListByUsrTab() {
        $("#usrdiv").show();
        $("#depdiv").hide();

        $("#cnttab").jqGrid("GridUnload");
        $("#cnttab").jqGrid({
            url: '/syslog/listByUser',
            datatype: "local",
            colNames: ["账户", "操作时间", "操作模块", "投诉用户号码"],
            colModel: [
                {name: "USR"},
                {
                    name: "TIME", formatter: function (cellvalue, options, rowObject) {
                    var val = cellvalue.toString();
                    return (val.substr(0, 4) + "/" + val.substr(4, 2) + "/" + val.substr(6, 2) + " " + val.substr(8, 2) + ":" + val.substr(10, 2) + ":" + val.substr(12, 2));

                }
                },
                {name: "FUNC_DESC"},
                {name: "TEL"}
            ],
            autowidth: true,
            rowNum: 30,
            hidegrid: false,
            rownumbers: true,
            shrinkToFit: false,
            deepempty: true,
            height: 500,
            pager: '#pager',
            viewrecords: true

        }).navGrid("#pager", {
            edit: false,
            add: false,
            del: false,
            search: false,
            refresh: false
        }).trigger("reloadGrid");
        $("#cnttab").jqGrid('setGridWidth', $('#panel').width() - 4);
        $(window).resize(function () {//当浏览器大小变化时
            $("#cnttab").jqGrid('setGridWidth', $('#panel').width() - 4);
        });
    }

    $("#psb").click(function () {
        $("#cnttab").jqGrid('setGridParam', {
            postData: {
                sd: $("#sd").val().replace(/[/]/g, '').replace(' ', ''),
                ed: $("#ed").val().replace(/[/]/g, '').replace(' ', ''),
                usr: $("#usr").val(),
                dep: $("#dep").val()
            }, datatype: 'json'
        }).trigger("reloadGrid");
    });

    if (getQueryString("q") != null) {

        var sd = getQueryString("sd");
        var ed = getQueryString("ed");
        var msisdn = getQueryString("msisdn");

        $("#sd").val(sd.substr(0, 4) + "/" + sd.substr(4, 2) + "/" + sd.substr(6, 2) + " " + sd.substr(8, 2));
        $("#ed").val(ed.substr(0, 4) + "/" + ed.substr(4, 2) + "/" + ed.substr(6, 2) + " " + ed.substr(8, 2));
        $("#msisdn").val(msisdn);
        $("#psb").click();

    } else {
        var now = new Date();
        now.setDate(now.getDate() - 1);
        var month = now.getMonth() + 1;
        var day = now.getDate();
        $("#sd").val(now.getFullYear() + "/" + (month < 10 ? ("0" + month) : month) + "/" + (day < 10 ? ("0" + day) :
                        day) + " 00");
        $("#ed").val(now.getFullYear() + "/" + (month < 10 ? ("0" + month) : month) + "/" + (day < 10 ? ("0" + day) :
                        day) + " 23");
    }

    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null)return unescape(r[2]);
        return null;
    }

</script>
<!-- 各页面依托JQ组件 -->
<script type="text/javascript" src="content/js/plugins.js"></script>

</html>
