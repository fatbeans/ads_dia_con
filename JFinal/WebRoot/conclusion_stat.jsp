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
                   onClick="WdatePicker({dateFmt:'yyyy/MM/dd',maxDate:'#F{$dp.$D(\'ed\')}'})"/>
        </div>
        <div class="inlininput mr10">
            <label class="S-label">结束时间</label>
            <span class="add-on"><a href="#"><i class="icon-calendar"></i></a></span>
            <input type="text" id="ed" class="w100"
                   onClick="WdatePicker({dateFmt:'yyyy/MM/dd',minDate:'#F{$dp.$D(\'sd\')}'})"/>
        </div>
        <div class="inlininput mr10">
            <label class="S-label">用户号码</label>
            <input type="text" id="msisdn" class="w100">
        </div>
        <div class="sel_wrap w150 mb10 mr10">
            <label>网元归属</label>
            <select class="select" id="citySel">
            </select>
            <a class="sel-link"><i class="icon-arrow"></i></a>
        </div>

        <div class="sel_wrap w150 mb10 mr10">
            <label id="lv1_con_id_label">一级结论</label>
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
        &nbsp;
        <a href="#" id="paidan" class="btn btn-info vm mb10" style="padding: 6px 20px 6px 20px">
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

    <div class="panel panel-default animated fadeInUp">
        <img src="content/images/lcpic.png">
    </div>

    <input type="hidden" value="1" id="provIdInDB"/>
    <input type="hidden" value="-1" id="provIdInView">

    <form id="workOrderFrom" action="/eoms/eomsorder.jsp" method="post" target="_blank">
        <input type="hidden" id="ftypeId" name="ftypeId" value="2"/>
        <input type="hidden" id="ftypeSubId" name="ftypeSubId" value="7"/>
        <input type="hidden" id="feomsOrderTitle" name="feomsOrderTitle" value="客户感知溯源工单"/>
        <input type="hidden" id="fneType" name="fneType"/>
        <input type="hidden" id="fcityName" name="fcityName"/>
        <input type="hidden" id="fcityKey" name="fcityKey"/>
        <input type="hidden" id="sendWay" name="sendWay" value="人工派单"/>
        <input type="hidden" id="ffileName" name="ffileName"/>
        <input type="hidden" id="ftypeName" name="ftypeName" value="专题分析结论"/>
        <input type="hidden" id="ftypeSubName" name="ftypeSubName" value="客户感知溯源"/>
        <input type="hidden" id="neName" name="neName"/>
    </form>

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

    var provIdInDB = $("#provIdInDB").val();
    var provIdInView = $("#provIdInView").val();

    var host = window.location.host;
    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null)return decodeURIComponent(r[2]);
        return null;

    }



    function statusFormat(ccc, options, rowObject) {
        cellvalue = rowObject.SEND_STATUS;
        if (cellvalue == 0) {
            var s = "<a style='color:blue' href='http://" + host + "/eoms/eomsorder.jsp?wo_id=" + rowObject.WO_ID +
                    "' target='_blank'>" + "草稿" + "</a>";
            return s
        } else if (cellvalue == 1) {
            return "<a style='color:blue' href='http://" + host + "/eoms/eomsorder.jsp?wo_id=" + rowObject.WO_ID + "' target='_blank'>" + "创建未派发" + "</a>";
        } else if (cellvalue == 2) {
            return "<a style='color:blue' href='http://" + host + "/eoms/eomsorder.jsp?wo_id=" + rowObject.WO_ID + "' target='_blank'>" + "创建已派发" + "</a>";
        } else {
            return "未创建";
        }
    }

    $(document).ajaxSuccess(function () {
        var sendStatusArray = $("#contab").jqGrid("getCol", "SEND_STATUS", true);
        for (var i = 0; i < sendStatusArray.length; i++) {
            if (sendStatusArray[i].value.indexOf("未创建") == -1) {
                var ckb = $("#jqg_contab_" + sendStatusArray[i].id);
                ckb.attr("disabled", "disabled");
            }
        }
    });

    $("#contab").jqGrid({
        multiselect: true,
        beforeSelectRow: function (rowid, e) {
            var $myGrid = $(this),
                    i = $.jgrid.getCellIndex($(e.target).closest('td')[0]),
                    cm = $myGrid.jqGrid('getGridParam', 'colModel');
            return (cm[i].name === 'cb');
        },
        onSelectAll: function (aRowids, status) {

            for (var i = 0; i < aRowids.length; i++) {
                if ($("#jqg_contab_" + aRowids[i]).attr("disabled") == "disabled") {
                    $("#jqg_contab_" + aRowids[i]).removeAttr("checked");
                    $("#contab").jqGrid().setSelection(	aRowids,false);
                }
            }
        },

        url: 'conc/concUnder',
        datatype: 'local',
        colNames: ['网元类型', '网元名称', '网元归属地市', '诊断问题', '影响人次', '工单创建状态', '工单处理状态'],
        colModel: [
            {name: 'NETYPE', width: 150},
            {name: 'NENAME', width: 150},
            {name: 'NECITY', width: 150},
            {name: 'LV2_CON_NAME', width: 150},
            {name: 'SCNT', width: 150},
            {name: 'SEND_STATUS', width: 150, formatter: statusFormat},
            {name: 'EOMS_STATUS', width: 150}
        ],

        autowidth: true,
        rowNum: 30,
        hidegrid: false,
        rownumbers: true,
        shrinkToFit: false,
        deepempty: true,
        height: 250,
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
                var ids = grid.jqGrid('getGridParam', 'selarrrow');
                var wo_netype = grid.jqGrid('getRowData', ids[0]).NETYPE;
                var neNames = "";
                for (var i = 0; i < ids.length; i++) {
                    neNames += grid.jqGrid('getRowData', ids[i]).NENAME + ",";
                }

                var cityKey = $("#citySel").val();

                var cityName = $("#citySel option:selected").html();


                $("#fneType").val(wo_netype);
                $("#fcityName").val(cityName);
                $("#fcityKey").val(cityKey);
                $("#ffileName").val(fileName);
                $("#neName").val(neNames);
                $("#workOrderFrom").submit();

//                var url = "http://" + host + "/eoms/eomsorder.jsp?typeId=2" +
//                        "&typeSubId=7&eomsOrderTitle=客户感知溯源工单" +
//                        "&neType=" + wo_netype + "&cityName=" + cityName + "&cityKey=" + cityKey +
//                        "&sendWay=人工派单&fileName=" + fileName +
//                        "&typeName=专题分析结论&typeSubName=客户感知溯源&neName=" + neNames;
//                windowOpen(encodeURI(url), "_blank");
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
                ed: $("#ed").val().replace(/[/]/g, '').replace(' ', ''),
                lv2_con_id: $("#lv2_con_id").val(),
                cityId: ciSel.val(),
                msisdn: $("#msisdn").val()
            }, datatype: 'json'
        }).trigger("reloadGrid");

        showHideCol();
    });
    $(document).ajaxError(function (event, XMLHttpRequest) {

        if (XMLHttpRequest.status == 488) {
            alert("未能查找到号码" + $("#msisdn").val() + "对应的IMSI");
        }
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

    $.artcloud.loading("加载下拉数据");
    var cityAjaxsecc = false;
    var lvAjaxsecc = false;
    var lvData;
    var ciSel = $("#citySel");
    var lv1Sel = $("#lv1_con_id");
    var lv2Sel = $("#lv2_con_id");

    var citySelStatus = -2;

    function selChange() {
        if (cityAjaxsecc == false || lvAjaxsecc == false) {
            return;
        } else {
            var provData = new Array();
            var cityData = new Array();

            for (var i = 0; i < lvData.length; i++) {
                if (lvData[i].lv1id == 1001) {
                    cityData.push(lvData[i]);
                } else {
                    provData.push(lvData[i]);
                }
            }

            lv1Sel.click(function () {
                if (ciSel.val() == -2) {
                    alert("请先选择地市");
                }
            });
            lv2Sel.click(function () {
                if (ciSel.val() == -2) {
                    alert("请先选择地市");
                }
            });
            ciSel.change(function () {
                if (ciSel.val() == -2) {
                    citySelStatus = -2;
                    lv1Sel.html('<option value="-1">一级结论</option>');
                    lv2Sel.html('<option value="-1">二级结论</option>');
                    $("#lv1_con_id_label").html("一级结论");
                    $("#lv2_con_id_label").html("二级结论");
                } else if (ciSel.val() == 0) {
                    if (citySelStatus == -2) {
                        initLv1ConSel(provData);
                        citySelStatus = 0;
                    }
                } else {
                    if (citySelStatus != 0) {
                        initLv1ConSel(cityData);
                        citySelStatus = 1;
                    }
                }
            });
        }
    }

    function initCitySel(d) {
        var cityhtml = "";
        for (var i = 0; i < d.length; i++) {
            var city = d[i];

            cityhtml += '<option value="' + (city.id) + '">' + city.name + '</option>';
        }
        ciSel.html('<option value="-2">网元归属</option>' + cityhtml);
    }

    function initLv1ConSel(data) {
        var lv1html = "";
        var lv1List = new Array();
        for (var i = 0; i < data.length; i++) {
            var lv1 = data[i];
            var contains = false;
            for (var j = 0; j < lv1List.length; j++) {
                if (lv1List[j] == lv1.lv1id) {
                    contains = true;
                    break;
                }
            }
            if (!contains) {
                lv1html += '<option value="' + lv1.lv1id + '">' + lv1.lv1name + '</option>';
                lv1List.push(lv1.lv1id);
            }
        }
        lv1Sel.html('<option value="-1">一级结论</option>' + lv1html);
        lv1Sel.val("-1");
        $("#lv1_con_id_label").html("一级结论");
        $("#lv2_con_id_label").html("二级结论");

        lv1Sel.change(function () {
            initLv2ConSel(data);
        });


    }

    function windowOpen(url, target) {
        var a = document.createElement("a");
        a.setAttribute("href", url);
        if (target == null) {
            target = '';
        }

        a.setAttribute("target", target);
        document.body.appendChild(a);
        if (a.click) {
            a.click();
        } else {
            try {
                var evt = document.createEvent('Event');
                a.initEvent('click', true, true);
                a.dispatchEvent(evt);
            } catch (e) {
                window.open(url);
            }
        }
        document.body.removeChild(a);
    }


    $.ajax({
        type: "POST",
        url: "conc/getConCfg",
        dataType: "json",
        success: function (d) {
            lvAjaxsecc = true;
            if (cityAjaxsecc == true) {
                $.artcloud.loading("close");
            }
            lvData = d;
            selChange();
        },
        error: function () {
            $.artcloud.loading("close");
            alert("加载结论下拉框数据出错");
        }
    });
    $.ajax({
        type: "POST",
        url: "conc/getCity",
        dataType: "json",
        success: function (d) {
            cityAjaxsecc = true;
            if (lvAjaxsecc == true) {
                $.artcloud.loading("close");
            }
            initCitySel(d);
            selChange();
        },
        error: function () {
            $.artcloud.loading("close");
            alert("加载地市下拉框数据出错");
        }
    });

    function timePrecentFormatter(cellvalue, options, rowObject) {
        var d = $("#sd").val();
        var day = new Date(d.substr(0, 4), d.substr(4, 2), 0);
        var daycount = day.getDate();
        return rowObject.TCNT / daycount / 24 * 100;
    }

    var conData;


    $("#lv2_con_id").click(function () {
        if ($("#lv1_con_id").val() == -1) {
            alert("请选择一级结论");
        }
    });

    function initLv2ConSel(d) {

        var lv2html = "";
        for (var i = 0; i < d.length; i++) {
            var lv2 = d[i];
            if ($("#lv1_con_id").val() == lv2.lv1id) {
                lv2html += '<option value="' + lv2.lv2id + '">' + lv2.lv2name + '</option>';
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

        $("#sd").val(sd.substr(0, 4) + "/" + sd.substr(4, 2) + "/" + sd.substr(6, 2));
        $("#ed").val(ed.substr(0, 4) + "/" + ed.substr(4, 2) + "/" + ed.substr(6, 2));
        $("#msisdn").val(msisdn);

    } else {
        var now = new Date();
        var month = now.getMonth() + 1;
        var day = now.getDate();
        $("#sd").val(now.getFullYear() + "/" + (month < 10 ? ("0" + month) : month) + "/01");
        $("#ed").val(now.getFullYear() + "/" + (month < 10 ? ("0" + month) : month) + "/" + now.getDate());
    }


</script>
<!-- 各页面依托JQ组件 -->
<script type="text/javascript" src="content/js/plugins.js"></script>


</html>
