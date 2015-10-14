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
    <%--loading--%>
    <link rel="stylesheet" href="/content/js/artcloudui/skins/gray/css/artcloudui.css">
    <script type="text/javascript" src="content/js/jquery.js"></script>
</head>
<body>
<%@ include file="menu.html" %>
<div class="ml15 mr15 content">
    <!-- 页面功能标题-s -->
    <h1 class="page-title borderbottom"><i class="t-icon mr10"></i><span class="text-blue vm">详单查询</span><i
            class="uicon ui-dArrow"></i><span class="text-darkblue vm">诊断结论统计（按结论）</span></h1>
    <!-- 页面功能标题-e -->
    <!-- 搜索-s -->
    <div class="mt10">
        <div class="inlininput mr10">
            <label class="S-label">开始时间</label>
            <span class="add-on"><a href="#"><i class="icon-calendar"></i></a></span>
            <input type="text" id="sd" class="w100"
                   onClick="WdatePicker({dateFmt:'yyyyMM'})"/>
        </div>

        <div class="sel_wrap w150 mb10 mr10">
            <label>一级结论</label>
            <select class="select" id="lv1_con_id">

            </select>
            <a class="sel-link"><i class="icon-arrow"></i></a>
        </div>
        <div class="sel_wrap w150 mb10 mr10">
            <label id="lv2_con_id_label">二级结论</label>
            <select class="select" id="lv2_con_id">
                <option value="-1">二级结论</option>

            </select>
            <a class="sel-link"><i class="icon-arrow"></i></a>
        </div>

        <a href="#" id="psb" class="btn btn-search vm mb10">
            <span class="searchicon"><i class="uicon ui-search"></i></span>
            搜索
        </a>

        <a href="#" id="paidan" class="btn vm mb10">
            <span class="searchicon"><i class="uicon ui-search"></i></span>
            派单
        </a>

    </div>
    <!-- 搜索-e -->
    <!-- 表格部分-s -->
    <div class="panel panel-default animated fadeInUp">
        <div class="panel-heading"><i class="uicon ui-paneltitel mr10"></i>结论列表</div>

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
<%--loading--%>
<script type="text/javascript" src="/content/js/artcloudui/artcloudui.dialog.js"></script>

<script type="text/javascript">

    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null)return unescape(r[2]);
        return null;
    }


    function showHideCol() {
        var $jqgrid = $("#contab").jqGrid();
        if ($("#lv1_con_id").val() == 2) {
            $jqgrid.showCol(['TCNT', 'TIMEPERCENT']);
            $jqgrid.setLabel('NENAME', '网元名称');
        }
        if ($("#lv1_con_id").val() == 1) {
            if ($("#lv2_con_id").val() == 10020005 || $("#lv2_con_id").val() == 10020006 || $("#lv2_con_id").val() == 10020007 || $("#lv2_con_id").val() == 10030008 || $("#lv2_con_id").val() == 10020005 || $("#lv2_con_id").val() == 10020005) {
                $jqgrid.hideCol(['TCNT', 'TIMEPERCENT']);
                $jqgrid.setLabel('NENAME', '网元名称');
            } else {
                $jqgrid.showCol(['TCNT', 'TIMEPERCENT']);
                $jqgrid.setLabel('NENAME', '网元名称');
            }
        }
        if ($("#lv1_con_id").val() == 3) {
            $jqgrid.setLabel("NENAME", "SP IP");
            $jqgrid.hideCol(["TCNT", "TIMEPERCENT"]);

        }


    }

    $("#contab").jqGrid({
        multiselect: true,
        url: 'conc/concUnder',
        datatype: 'local',
        colNames: ['网元类型', '网元名称', '网元归属地市', '诊断问题', '影响人次', '问题时段数', '问题时段占比%', '解决措施'],
        colModel: [
            {name: 'NETYPE', width: 150},
            {name: 'NENAME', width: 150},
            {name: 'NECITY', width: 150},
            {name: 'LV2_CON_NAME', width: 150},
            {name: 'SCNT', width: 150},
            {name: 'TCNT', width: 150},
            {name: 'TIMEPERCENT', width: 150, formatter: timePrecentFormatter},
            {name: 'SOLWAY', width: 150}
        ],
        autowidth: true,
        rowNum: 30,
        hidegrid: false,
        rownumbers: true,
        shrinkToFit: false,
        deepempty: true,
        height: 500,
        pager: '#pager',
        viewrecords: true,
        loadComplete: function () {
            $.artcloud.loading("close");
        },
        loadError: function () {
            $.artcloud.loading("close");
        },
        gridComplete: function () {
            $.artcloud.loading("close");
        }
    }).navGrid('#pager', {edit: false, add: false, del: false, search: false, refresh: false});
    $("#contab").jqGrid('setGridWidth', $('#panel').width() - 4);
    $(window).resize(function () {//当浏览器大小变化时
        $("#contab").jqGrid('setGridWidth', $('#panel').width() - 4);
    });


    $("#paidan").click(function () {
        var grid = $("#contab");

        var id = grid.jqGrid('getGridParam', 'selarrrow');
        var data = new Array();

        for (var i = 0; i < id.length; i++) {
            data[i] = grid.jqGrid('getRowData', id[i]);
        }
        $.artcloud.loading("派单文件生成中...");
        $.ajax({
            url: "conc/initEomsExcel",
            data: {
                "data": JSON.stringify(data)
            },
            type: "POST",
            dataType: "text",
            error: function (event, xhr) {
                $.artcloud.loading("close");
                alert("生成工单文件出错");
            },
            success: function (fileName) {
                $.artcloud.loading("close");
                var wo_netype = "";
                var lv2_con_id = $("#lv2_con_id").val();

//        DNS服务器出错 DNS域名服务器不支持请求的类型 DNS拒绝服务
                if (lv2_con_id == 10020005 || lv2_con_id == 10020006 || lv2_con_id == 10020007 || lv2_con_id == 10030008 || lv2_con_id == 10020008) {
                    wo_netype = "DNS";
                }
//        核心侧·质量问题 核心侧·高负荷 核心侧·核查参数
                else if (lv2_con_id == 10020002 || lv2_con_id == 10020001 || lv2_con_id == 10020009) {
                    wo_netype = "MME";
                }
//        弱覆盖 质差小区 高负荷
                else if (lv2_con_id == 10010001 || lv2_con_id == 10010002 || lv2_con_id == 10010003) {
                    wo_netype = "小区";
                }
//        业务属网外资源
                else if (lv2_con_id == 10050001) {
                    wo_netype = "sp";
                }
                var url = "http://10.223.235.16:8804/eoms/eomsorder.jsp?typeId=2" +
                        "&typeSubId=7&eomsOrderTitle=客户感知溯源工单" +
                        "&neType=" + wo_netype + "&sendWay=人工派单&fileName=" + fileName +
                        "&typeName=专题分析结论&typeSubName=客户感知溯源";
                window.open(encodeURI(url));
            }
        });

    });


    $("#psb").click(function () {
        if (getQueryString("test") == "true") {
            test();
            return;
        }
        if (!checkInput()) {
            return;
        }
        $.artcloud.loading();
        $("#contab").jqGrid('setGridParam', {
            postData: {
                sd: $("#sd").val().replace(/[/]/g, '').replace(' ', ''),
                lv2_con_id: $("#lv2_con_id").val()
            }, datatype: 'json'
        }).trigger("reloadGrid");

        showHideCol();
    });

    function test() {
        $("#contab").jqGrid('setGridParam', {
            url: "./concTestData.json",
            datatype: 'json'
        }).trigger("reloadGrid");
    }


    function checkInput() {
        if ($("#sd").val() == '') {
            alert("请选择时间");
            return false;
        } else if ($("#lv1_con_id").val() == -1) {
            alert("请选择一级结论");
            return false;
        } else if ($("#lv2_con_id").val() == -1) {
            alert("请选择二级结论");
            return false;
        } else {
            return true;
        }
    }

    $.ajax({
        type: "POST",
        url: "concStatSel.json",
        dataType: "json",
        success: function (d) {
            conData = d;
            initLv1ConSel();
        }
    });

    function timePrecentFormatter(cellvalue, options, rowObject) {
        var d = $("#sd").val();
        var day = new Date(d.substr(0, 4), d.substr(4, 2), 0);
        var daycount = day.getDate();
        return rowObject.TCNT / daycount / 24 * 100;
    }

    var conData;

    function initLv1ConSel() {
        var lv1html = "";
        var lv1List = new Array();
        for (var i = 0; i < conData.length; i++) {
            var lv1 = conData[i];
            var contains = false;
            for (var j = 0; j < lv1List.length; j++) {
                if (lv1List[j] == lv1.lv1_con_id) {
                    contains = true;
                    break;
                }
            }
            if (!contains) {
                lv1html += '<option value="' + lv1.lv1_con_id + '">' + lv1.lv1_con_name + '</option>';
                lv1List.push(lv1.lv1_con_id);
            }
        }
        $("#lv1_con_id").html('<option value="-1">一级结论</option>' + lv1html);
        $("#lv1_con_id").change(function () {
            initLv2ConSel();
        });
    }

    $("#lv2_con_id").click(function () {
        if ($("#lv1_con_id").val() == -1) {
            alert("请选择一级结论");
        }
    });

    function initLv2ConSel() {

        var lv2html = "";
        for (var i = 0; i < conData.length; i++) {
            var lv2 = conData[i];
            if ($("#lv1_con_id").val() == lv2.lv1_con_id) {
                lv2html += '<option value="' + lv2.lv2_con_id + '">' + lv2.lv2_con_name + '</option>';
            }
        }
        $("#lv2_con_id").html('<option value="-1">二级结论</option>' + lv2html);
        $("#lv2_con_id").val("-1");
        $("#lv2_con_id_label").html("二级结论");
    }

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
        $("#sd").val(now.getFullYear() + "" + (month < 10 ? ("0" + month) : month));
    }


</script>
<!-- 各页面依托JQ组件 -->
<script type="text/javascript" src="content/js/plugins.js"></script>


</html>