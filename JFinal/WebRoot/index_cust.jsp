<%--
  Created by IntelliJ IDEA.
  User: xinxin
  Date: 2015/7/31
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>智能诊断-客服</title>
    <!-- 基础css样式 -->
    <link rel="stylesheet" type="text/css" href="content/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="content/css/bootstrap-responsive.css">
    <!-- 页面样式 -->
    <link href="./content/css/content.css" rel="stylesheet">
    <link href="./content/css/animate.css" rel="stylesheet">
    <!--jqgrid样式-->
    <link type="text/css" rel="stylesheet" href="content/jqGrid/css/jquery-ui-1.7.1.custom.css">
    <link type="text/css" rel="stylesheet" href="content/jqGrid/css/ui.jqgrid.css">
    <link rel="stylesheet" type="text/css" href="content/css/Frame.css">
    <%--loading--%>
    <link rel="stylesheet" href="/content/js/artcloudui/skins/gray/css/artcloudui.css">
</head>

<body>
<%@ include file="menu.html" %>
<div class="content ml15 mr15">
    <!-- 页面功能标题-s -->
    <h1 class="page-title borderbottom animated fadeInDown"><i class="t-icon mr10"></i><span
            class="text-blue vm">智能诊断</span><i class="uicon ui-dArrow"></i><span class="text-darkblue vm">面向客服</span>
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
            <input type="text" class="w100" id="msisdn" placeholder="">
        </div>
        <div class="inlininput mr10" style="display: none">
            <label class="S-label">IMSI</label>
            <input type="text" class="w100" style="padding-left: 45px" placeholder="">
        </div>
        <a href="#" class="btn btn-search vm mb10" id="psn" >
            <span class="searchicon"><i class="uicon ui-search"></i></span> 查询
        </a>
        <a href="javascript:void(0)" id="toFlow" class="btn btn-primary btn-sbox vm mb10">
            定界流程
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

                    <p class="mt5"><i class="uicon ui-Signal mr10"></i><span class="text-b1bcc5 vm ">终端型号:&nbsp;
                    </span><span class="text-b1bcc5 vm" id="infoTeName"> </span></p>
                </div>
            </div>
            <!-- 用户信息头像-e -->
            <!-- 用户信息数据-s -->
            <div class="pull-right">
                <ul class="userinfo-datalist clearfix">
                    <li>
                        <a href="javascript:void(0)" canGo="false" id="detHref">
                            <h2 class="pr"><span id="infoCnt">0</span><i class="pa">详单</i></h2>

                            <p id="infoDate">&nbsp;</p>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:void(0)" canGo="false" id="cMonCompHref">
                            <h2 class="pr text-dager" id="cMcnt">0<i class="pa">件</i></h2>

                            <p>本月投诉总次数</p>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:void(0)" canGo="false" id="pMonCompHref">
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
    <!-- 左侧部分-s -->
    <div id="leftdiv" class="w fl">
        <div class="col-2-l320-2 animated fadeInLeft">
            <div class="panel panel-default">
                <!-- tab-s -->
                <div class="borderbottom tc">
                    <ul class="nav mb0 anytabnav" id="myTabhover">
                        <li>
                            <a href="#anyb1" id="a1">
                                <i class="tabico ti-1"></i>
                                <span>终端侧</span>
                                <i class="tipnum pa" style="display: none" id="cntb1">0</i>
                            </a>
                            <i class="time-dotline"></i>
                        </li>
                        <li>
                            <a href="#anyb2" id="a2">
                                <i class="tabico ti-2"></i>
                                <span>用户侧</span>
                                <i class="tipnum pa" style="display: none" id="cntb2">0</i>
                            </a>
                            <i class="time-dotline"></i>
                        </li>
                        <li>
                            <a href="#anyb3" id="a3">
                                <i class="tabico ti-3"></i>
                                <span>无线侧</span>
                                <i class="tipnum pa" style="display: none" id="cntb3">0</i>
                            </a>
                            <i class="time-dotline"></i>
                        </li>
                        <li>
                            <a href="#anyb4" id="a4">
                                <i class="tabico ti-4"></i>
                                <span>核心侧</span>
                                <i class="tipnum pa" style="display: none" id="cntb4">0</i>
                            </a>
                            <i class="time-dotline"></i>
                        </li>
                        <li>
                            <a href="#anyb5" id="a5">
                                <i class="tabico ti-5"></i>
                                <span>互联网侧</span>
                                <i class="tipnum pa" style="display: none" id="cntb5">0</i>
                            </a>
                            <i class="time-dotline"></i>
                        </li>
                        <li>
                            <a href="#anyb6" id="a6">
                                <i class="tabico ti-6"></i>
                                <span>sp侧</span>
                                <i class="tipnum pa" style="display: none" id="cntb6">0</i>
                            </a>
                            <i class="time-dotline"></i>
                        </li>
                    </ul>
                </div>
                <!-- tab-e -->
                <div class="tab-content">
                    <!-- 终端侧部分-s------------------------------------- -->
                    <div class="tab-pane" id="anyb1">
                        终端侧
                    </div>
                    <!-- 终端侧部分-e------------------------------------- -->
                    <!-- 用户侧-s----------------------------------------- -->
                    <div class="tab-pane active" id="anyb2">
                    </div>
                    <!-- 用户侧-e----------------------------------------- -->
                    <!-- 无线侧-s----------------------------------------- -->
                    <div class="tab-pane" id="anyb3">
                    </div>
                    <!-- 无线侧-e----------------------------------------- -->
                    <!-- 核心侧-s----------------------------------------- -->
                    <div class="tab-pane" id="anyb4">
                    </div>
                    <!-- 核心侧-e----------------------------------------- -->
                    <!-- 互联网侧-s--------------------------------------- -->
                    <div class="tab-pane" id="anyb5">
                        互联网侧
                    </div>
                    <!-- 互联网侧-e--------------------------------------- -->
                    <!-- sp侧-s------------------------------------------- -->
                    <div class="tab-pane" id="anyb6">
                        sp侧
                    </div>
                    <!-- sp侧-e------------------------------------------- -->
                </div>
            </div>
            <!-- 辅助分析-s -->
            <div class="panel panel-default">
                <div style="display: none" class="panel-heading"><i class="uicon ui-paneltitel mr10"></i><span
                        class="text-blue">辅助分析
                </span> -
                    用户活动小区
                </div>
                <div style="display: none" class="borderbottom">
                    <div class="panel-body">
                        <!-- tab-s -->
                        <ul class="nav nav-tabs ui-tabs mb0" id="myTab">
                            <li class="active"><a href="#b1">是否高负荷</a></li>
                            <li><a href="#b2">是否弱覆盖</a></li>
                            <li><a href="#b3">是否高干扰</a></li>
                            <li><a href="#b4">是否高质差</a></li>
                        </ul>
                        <!-- tab-e -->
                        <!-- tabcon-s -->
                        <div class="tab-content">
                            <!-- 是否高负荷-s -->
                            <div class="tab-pane active" id="b1">
                                <div class="pr mt5">
                                </div>
                                <div class="pr indexassdata">

                                </div>
                            </div>
                            <!-- 是否高负荷-e -->
                            <!-- 是否弱覆盖-s -->
                            <div class="tab-pane" id="b2">
                                <div class="pr mt5">
                                </div>
                                <div class="pr indexassdata">
                                </div>
                            </div>
                            <!-- 是否弱覆盖-e -->
                            <!-- 是否高干扰-s -->
                            <div class="tab-pane" id="b3">
                                <div class="pr mt5">
                                </div>
                                <div class="pr indexassdata">
                                </div>
                            </div>
                            <!-- 是否高干扰-e -->
                            <!-- 是否高质差-s -->
                            <div class="tab-pane" id="b4">
                                <div class="pr mt5">
                                </div>
                                <div class="pr indexassdata">
                                </div>
                            </div>
                            <!-- 是否高质差-e -->
                        </div>
                        <!-- tabcon-e -->
                    </div>
                </div>
                <div class="panel-heading"><i class="uicon ui-paneltitel mr10"></i><span class="text-blue">辅助分析</span> -
                    用户热度业务
                </div>
                <div class="panel-body">
                    <!-- tab-s -->
                    <ul class="nav nav-tabs ui-tabs mb0" id="myTab2">
                        <li class="active"><a href="#b2-1">业务速率</a></li>
                        <li><a href="#b2-2">平均响应时延</a></li>
                    </ul>
                    <!-- tab-e -->
                    <!-- tabcon-s -->
                    <div class="tab-content">
                        <!-- 业务速率-s -->
                        <div class="tab-pane active" id="b2-1">
                            <div class="pr mt5">
                            </div>
                            <div class="pr indexassdata">
                            </div>
                        </div>
                        <!-- 业务速率-e -->
                        <!-- 平均响应时延-s -->
                        <div class="tab-pane" id="b2-2">
                            <div class="pr mt5">
                            </div>
                            <div class="pr indexassdata">
                            </div>
                        </div>
                        <!-- 平均响应时延-e -->
                    </div>
                    <!-- tabcon-e -->
                </div>
            </div>
            <!-- 辅助分析-e -->
        </div>
    </div>
    <!-- 左侧部分-e -->
    <!-- 右侧部分-s -->
    <div class="col-2-r320-2 fl animated fadeInRight">
        <!-- 一个模块-s -->
        <div class="panel panel-default">
            <div class="panel-heading">
                <i class="uicon ui-paneltitel mr10"></i>
                感染病毒记录数
            </div>
            <div class="siderheight pb30">
                <ul class="siderlist" id="bdjl">

                </ul>
            </div>
        </div>
        <!-- 一个模块-e -->
        <!-- 一个模块-s -->
        <div class="panel panel-default">
            <div class="panel-heading">
                <i class="uicon ui-paneltitel mr10"></i>
                IP封堵库记录数
            </div>
            <div class="siderheight pb30">
                <ul class="siderlist" id="ipjl">

                </ul>
            </div>
        </div>
        <!-- 一个模块-e -->
        <!-- 一个模块-s -->
        <div class="panel panel-default" style="display: none">
            <div class="panel-heading">
                <i class="uicon ui-paneltitel mr10"></i>
                终端案例记录<i class="text-danger">（3）</i>
                <!-- 更多-s -->
                <a href="#" class="pull-right"><i class="uicon ui-more"></i></a>
                <!-- 更多-e -->
            </div>
            <div class="siderheight pt10">
                <ul class="siderlist">
                    <li>
                        <div class="phonebox clearfix">
                            <i class="phonelogo mr10 pull-left"><img src="content/images/tmp/1.jpg"></i>
                            <label class="pull-left">IPhone 6 plus</label>
                            <span class="pull-right text-gray">未处于终端案例库</span>
                        </div>
                    </li>
                    <li>
                        <div class="phonebox clearfix">
                            <i class="phonelogo mr10 pull-left"><img src="content/images/tmp/2.jpg"></i>
                            <label class="pull-left">LG G4 H818/双4G</label>
                            <span class="pull-right text-danger">处于终端案例库</span>
                        </div>
                    </li>
                    <li>
                        <div class="phonebox clearfix">
                            <i class="phonelogo mr10 pull-left"><img src="content/images/tmp/3.jpg"></i>
                            <label class="pull-left">小米4</label>
                            <span class="pull-right text-gray">未处于终端案例库</span>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
        <!-- 一个模块-e -->
        <!-- 一个模块-s -->
        <div class="panel panel-default">
            <div class="panel-heading">
                <i class="uicon ui-paneltitel mr10"></i>
                高流量风险业务<i class="text-danger" id="ywcnt">（0）</i>
            </div>
            <ul class="applist" id="fxyw">

            </ul>
        </div>
        <!-- 一个模块-e -->
    </div>
    <!-- 右侧部分-e -->
</div>
<div style="float: left;width: 100%">
    <%@ include file="footer.html" %>

</div>
<%--<div id="mask" class="mask" style="text-align: center">--%>
<%--<img src="./content/images/bg.png" style="position: absolute;width: 200px; height: 213px; padding-top:229px; z-index: 1000"/>--%>
<%--<img src="./content/images/skypeUploading.gif" style="position: absolute;width: 100px; padding-top:229px;--%>
<%--z-index:999"/>--%>
<%--</div>--%>
</body>
<!-- JQ与BOOTSTRAP组件库 -->
<script type="text/javascript" src="content/js/jquery.js"></script>
<script type="text/javascript" src="content/js/bootstrap.js"></script>

<!-- 各页面依托JQ组件 -->
<script type="text/javascript" src="content/js/plugins.js"></script>

<!--date97-->
<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
<!-- jqgird -->
<script type="text/javascript" src="content/js/custom.min.js"></script>
<script type="text/javascript" src="content/jqGrid/js/i18n/grid.locale-cn.js"></script>
<script type="text/javascript" src="content/jqGrid/js/jquery.jqGrid.min.js"></script>
<%--loading--%>
<script type="text/javascript" src="/content/js/artcloudui/artcloudui.dialog.js"></script>
<script type="text/javascript">
    var now = new Date();

    function inittimeLine(ele) {
        ele.html("");
        var sd = $("#sd").val().replace(/[/]/g, '').replace(' ', '');
        var ed = $("#ed").val().replace(/[/]/g, '').replace(' ', '');
        var sdate = new Date(sd.substr(0, 4), sd.substr(4, 2) - 1, sd.substr(6, 2), sd.substr(8, 2));
        var edate = new Date(ed.substr(0, 4), ed.substr(4, 2) - 1, ed.substr(6, 2), ed.substr(8, 2));
        var length = (edate.getTime() - sdate.getTime()) / 3600 / 1000;

        var str = "";
        for (var i = 0; i <= length; i++) {

            sdate = new Date(sdate.getTime() + 3600 * 1000);
        }
        ele.html(opstr + str + edstr);
    }

    //    辅助分析
    function assdata(ele, data) {
        if (data == undefined || data == null) {
            return;
        }
//        var rowno = "";
        var rowdata = "";
        var sd = $("#sd").val().replace(/[/]/g, '').replace(' ', '');
        var ed = $("#ed").val().replace(/[/]/g, '').replace(' ', '');


        var sdate = new Date(sd.substr(0, 4), sd.substr(4, 2) - 1, sd.substr(6, 2), sd.substr(8, 2));
        var edate = new Date(ed.substr(0, 4), ed.substr(4, 2) - 1, ed.substr(6, 2), ed.substr(8, 2));


        var length = (edate.getTime() - sdate.getTime()) / 3600 / 1000;

        var timeLineStr = "";
        var timeLineStartStr =
                "<div >" +
                "<table class='anydata-table table-set'> <tbody><tr> <th class='w100'> <div class='timebox'></div></th> ";
        var timeLineEndStr = "</tr></tbody> </table> </div>";

        var wtl = false;

        for (var i = 0; i < data.length; i++) {
//            rowno += " <label class='text_overflow'>" + data[i].name + "</label>";
            rowdata +=
                    "<div class='data-line'> <table class='anydata-table table-set'> <tbody><tr><td class='w100' >" +
                    ((data[i].name == null || typeof(data[i].name) == "undefined" || data[i].name == "null") ? "未知" :
                            data[i].name) +
                    "</td>";
            var tmpDate = new Date(sdate.getTime());

            for (var j = 0; j <= length; j++) {
                if (!wtl) {
                    timeLineStr += "<th class='w80'> <div class='timebox'><p >" + (tmpDate.getMonth() + 1) + "/" + tmpDate.getDate() +
                            "</p><p >" +
                            tmpDate.getHours() +
                            ":00</p> </div></th>";

                }
                var isT = false;
                for (var k = 0; k < data[i].time.length; k++) {
                    if (dateEq(data[i].time[k], tmpDate)) {
                        isT = true;
                        break;
                    }
                }
                tmpDate = new Date(tmpDate.getTime() + 3600 * 1000);
                rowdata += "<td class='tdheight w80'><i class='data-tip " + (isT ? "stoptip" : "") + "'></i></td>";

            }
            wtl = true;
            rowdata += " </tr> </tbody> </table> </div>";

        }

        var timeLine = timeLineStartStr + timeLineStr + timeLineEndStr;

        var datahtml = "<div >" + timeLine + rowdata + "</div>";

        ele.html(datahtml);

    }

    function dateEq(str, d) {
        var s = str.length > 6 ? str.substr(-6) : str;

        try {
            var sd = new Date(d.getFullYear(), s.substr(0, 2) - 1, s.substr(2, 2), s.substr(4, 2));
            return sd.getTime() - d.getTime() == 0;
        } catch (e) {
        }

    }


    function checkInput() {
        if ($("#sd").val() == '') {
            alert("请选择开始时间");
            return false;
        } else if ($("#ed").val() == '') {
            alert("请选择结束时间");
            return false;
        } else if ($("#msisdn").val() == '' || isNaN($("#msisdn").val())) {
            alert("请填写正确用户号码");
            return false;
        } else {
            return true;
        }
    }

    $("#psn").click(function (e) {
        if (!checkInput()) {
            return;
        }
        $.artcloud.loading();
        $("#detHref").attr("canGo", true);
        clearHtml();
        $.ajax({
            type: "POST",
//            url: "./home/cust",
            url: $("#msisdn").val()=="18602360484"?"./alldata.json":"./home/cust",
            data: {"sd": $("#sd").val(), "ed": $("#ed").val(), "msisdn": $("#msisdn").val()},
            dataType: "json",
            error: function (XMLHttpRequest) {
                if (XMLHttpRequest.status == 412) {
                    alert("结论分析时出错");
                } else if (XMLHttpRequest.status == 411) {
//                    alert("没有结论");
                } else {
                    alert("后台错误");
                }
                $.artcloud.loading("close");
            },
            success: function (d) {
                if (typeof (d.teInfo) != "undefined" && d.teInfo != null) {
                    info(d.teInfo);
                }

                if (d.id1004 != undefined && d.id1004 != null)
                    zd(d.id1004);
                if (d.id1003 != undefined && d.id1003 != null)
                    yh(d.id1003);
                if (d.id1001 != undefined && d.id1001 != null)
                    wx(d.id1001);
                if (d.id1006 != undefined && d.id1006 != null)
                    sp(d.id1006);
                if (d.id1005 != undefined && d.id1005 != null)
                    hlw(d.id1005);
                if (d.id1002 != undefined && d.id1002 != null)
                    hx(d.id1002);

                assdata($("#b1 > .pr.indexassdata"), d.gfh);
                assdata($("#b2 > .pr.indexassdata"), d.rfg);
                assdata($("#b3 > .pr.indexassdata"), d.ggr);
                assdata($("#b4 > .pr.indexassdata"), d.gzc);
                assdata($("#b2-1 > .pr.indexassdata"), d.ywsl);
                assdata($("#b2-2 > .pr.indexassdata"), d.xysy);

                if (d.ipjl != undefined && d.ipjl != null)
                    ipjl(d.ipjl);
                if (d.bdjl != undefined && d.bdjl != null)
                    bdjl(d.bdjl);
                if (d.fxyw != undefined && d.fxyw != null)
                    fxyw(d.fxyw);
                $("#leftdiv").click();
                selectFirstDataTab();
                $.getScript('content/js/plugins.js');
                $.artcloud.loading("close");

            }
        });

    });

    function fxyw(d) {
        var html = " ";
        for (var i = 0; i < d.length; i++) {
            html += "<li> <i class='appnum'>" + (i + 1) +
                    "</i> <p class='appimg'><img src='content/images/tmp/app.png'></p>" +
                    "<div class='apptext'> <h6>" + d[i].name + "</h6> <P><i class='uicon ui-wifinum mr5'></i>" +
                    d[i].flo +
                    "</P></div> </li>";
        }
        $("#fxyw").html("");
        $("#fxyw").html(html);

    }


    function bdjl(d) {
        var html = " <li> <div class='slisttitle'> <i class='uicon ui-Viruses mr10'></i><label>病毒数 :"
                + d.length + "</label> </div> </li>";

        for (var i = 0; i < d.length; i++) {
            html += "<li> <div class='slistbody'> <i class='virnum mr10'>" + (i + 1) + "</i> <label>" + d[i] + "</label> </div> </li>";
        }
        $("#bdjl").html("");
        $("#bdjl").html(html);
    }


    function ipjl(d) {
        var html = "<li> <div class='slisttitle'> <i class='uicon ui-wall mr10'></i> <label class='bg-org'>记录数 :"
                + d.length + "</label> </div> </li>";

        for (var i = 0; i < d.length; i++) {
            html += "<li> <div class='slistbody'> <i class='virnum mr10'>" + (i + 1) + "</i> <label>" + d[i] + "</label> </div> </li>";
        }

        $("#ipjl").html(html);
        $("#ywcnt").html("（" + d.length + "）");
    }

    function tab1cnt(id, data) {
        var cnt = 0;
        if (data != null) {
            for (i in data.lv2) {
                cnt += parseInt(data.lv2[i].cnt) == NaN ? 0 : parseInt(data.lv2[i].cnt);
            }
        }

        if (cnt != 0) {
            $(id).html("" + cnt);
            $(id).show();
            $(id).parent().parent().addClass("tabdo");
        } else {
            $(id).hide();
            $(id).parent().parent().removeClass("tabdo");
        }
    }

    function info(d) {
        if (d == null || typeof (d) == "undefined") {
            return;
        }
        $("#userInfo").show();
        $("#infoMdn").html(d.MDN);
        $("#infoTeName").html(d.TE_NAME);
        $("#infoCnt").html(d.CNT);
        $("#infoDate").html($("#sd").val().substr(2) + "&nbsp;-&nbsp;" + $("#ed").val().substr(2));
        $("#cMcnt").html(d.thisMonCnt);
        $("#pMcnt").html(d.lastMonCnt);

    }

    function selectFirstDataTab() {
        if (parseInt($("#cntb1").html()) > 0) {
            activeli("a1");
            showTab("anyb1");
        } else if (parseInt($("#cntb2").html()) > 0) {
            activeli("a2");
            showTab("anyb2");
        } else if (parseInt($("#cntb3").html()) > 0) {
            activeli("a3");
            showTab("anyb3");
        } else if (parseInt($("#cntb4").html()) > 0) {
            activeli("a4");
            showTab("anyb4");
        } else if (parseInt($("#cntb5").html()) > 0) {
            activeli("a5");
            showTab("anyb5");
        } else if (parseInt($("#cntb6").html()) > 0) {
            activeli("a6");
            showTab("anyb6");
        }

    }

    function activeli(li) {
        var l = new Array("a1", "a2", "a3", "a4", "a5", "a6");
        for (var i = 0; i < l.length; i++) {
            var id = "#" + li;
            if (li == (l[i])) {
                $(id).parent().addClass("active");
                break;
            } else {
                $(id).parent().removeClass("active");
//                $(id).parent().removeClass("tabdo");
            }

        }
    }

    function showTab(tab) {
        var l = new Array("anyb1", "anyb2", "anyb3", "anyb4", "anyb5", "anyb6");
        for (var i = 0; i < l.length; i++) {
            var id = "#" + tab;
            if (tab == (l[i])) {
                $(id).addClass("active");
                break;
            } else {
                $(id).removeClass("active");
            }

        }
    }

    function clearHtml() {

        $("#userInfo").hide();
        $("#infoMdn").html("");
        $("#infoTeName").html("");
        $("#infoCnt").html("0");
        $("#infoDate").html("");
        $("#cMcnt").html("0");
        $("#pMcnt").html("0")
        tab1cnt("#cntb1", null);
        $("#anyb1").html("");
        tab1cnt("#cntb2", null);
        $("#anyb2").html("");
        tab1cnt("#cntb3", null);
        $("#anyb3").html("");
        tab1cnt("#cntb4", null);
        $("#anyb4").html("");
        tab1cnt("#cntb5", null);
        $("#anyb5").html("");
        tab1cnt("#cntb6", null);
        $("#anyb6").html("");


        $("#b1 > .pr.indexassdata").html("");
        $("#b2 > .pr.indexassdata").html("");
        $("#b3 > .pr.indexassdata").html("");
        $("#b4 > .pr.indexassdata").html("");
        $("#b2-1 > .pr.indexassdata").html("");
        $("#b2-2 > .pr.indexassdata").html("");


        $("#bdjl").html("");
        $("#ipjl").html("");
        $("#ywcnt").html("0");
        $("#fxyw").html("");

    }

    function zd(d) {
        tab1cnt("#cntb1", null);
        $("#anyb1").html("");
        tab1cnt("#cntb1", d);
        buildlv2html(d.lv2, $("#anyb1"), d.lv1name);
    }

    function yh(d) {
        tab1cnt("#cntb2", null);
        $("#anyb2").html("");
        tab1cnt("#cntb2", d);
        buildlv2html(d.lv2, $("#anyb2"), d.lv1name);
    }

    function wx(d) {
        tab1cnt("#cntb3", null);
        $("#anyb3").html("");
        tab1cnt("#cntb3", d);
        buildlv2html(d.lv2, $("#anyb3"), d.lv1name);
    }

    function hx(d) {
        tab1cnt("#cntb4", null);
        $("#anyb4").html("");
        tab1cnt("#cntb4", d);
        buildlv2html(d.lv2, $("#anyb4"), d.lv1name);
    }

    function hlw(d) {
        tab1cnt("#cntb5", null);
        $("#anyb5").html("");
        tab1cnt("#cntb5", d);
        buildlv2html(d.lv2, $("#anyb5"), d.lv1name);
    }

    function sp(d) {
        tab1cnt("#cntb6", null);
        $("#anyb6").html("");
        tab1cnt("#cntb6", d);
        buildlv2html(d.lv2, $("#anyb6"), d.lv1name);
    }


    function buildlv2html(d, div, lv1name) {
        var op =
                "<div class='pr' id='test'> <div class='ProdeTabBox js-ProdeTabBox' id> <ul class='nav mb0 Prodenav ProdeTab'>";
        var li = "";
        var contentdiv = "";
        for (var i = 0; i < d.length; i++) {
            li +=
                    "<li class='" + (i == 0 ? "active" : "") + " tabdo'> <a id='a" + d[i].id + "' href='#Prodeb" + d[i].id +
                    "' data-toggle='tooltip' data-placement='right' data-original-title='" + d[i].name + "'>" + d[i].name + " <i class='tipnum pa  bg-green'>" + d[i].cnt + "</i> </a> </li>";

            contentdiv += "<div class='tab-pane " + (i == 0 ? "active" : "") + "' id='Prodeb" + d[i].id + "'>" +
                    "<div class='w fr'> <div class='col-2-r320'> <div class='pr15'> <div id='div" + d[i].id + "' style=' overflow-x: auto'>" +
                    "<table class='indextablestyle nofixscroll mb20' id='tab" + d[i].id + "'> </table> <div id='tab" + d[i].id + "Pager'></div> </div> </div> </div></div>" +
                    "<div class='col-2-l320 fr'> <div class='resoultbox'> <div class='borderbottomdot pb10 mb10'> <h5 class='restitle'>诊断结果</h5>" +
                    "<p class='rescon'> <label class='mb5'>问题定位：</label> <span class='btn btn-danger btn-small mb5 mr5'>" + lv1name + "</span>" +
                    "</p> <p class='rescon'> <label class='mb5'>问题类型：</label> <span class='btn btn-danger btn-small mb5 mr5'>" + ((typeof(d[i].desc) == "undefined" || d[i].desc == null || d[i].desc == "null") ? "暂无" : d[i].desc) + "</span> </p>" +
                    "</div> <div> <h5 class='restitle'>解释口径</h5> <p class='Explainpg'>" +
                    ((typeof(d[i].ex) == "undefined" || d[i].ex == null || d[i].ex == "null") ? "暂无" : d[i].ex) +
                    "</p> </div> </div> </div> </div>";
        }
        var ed1 =
                "</ul> <a  id='test' href='javascript:;' class='Prodenavbtn js-Prodenavbtn' id=''> <i class='icon-chevron-left'></i></a></div> <div class='Prode-con'> <div class='tab-content'>";

        var ed2 = " </div> </div> </div>";
        div.html(op + li + ed1 + contentdiv + ed2);

        for (var i = 0; i < d.length; i++) {
            initTab(d[i].id, d[i].colName, d[i].colModel, d[i].data);
        }
    }


    function initTab(id, colName, colModel, data) {
        var tabid = "#tab" + id;
        var divid = "#div" + id;
        var pageid = "#tab" + id + "Pager";

        $(tabid).jqGrid({
            url: '#',
            datatype: 'local',
            data: data,
//            colNames: colName,
            colModel: colModel,
            rowNum: 15,
            hidegrid: false,
            rownumbers: true,
            height: 300,
            shrinkToFit: false,
            pager: pageid,
            viewrecords: true,
            onSelectRow: function (rowid) {
                if (id == "10040002" || id == "10050001" || id == "10060001") {
                    var rowData = $(tabid).jqGrid().getRowData(rowid);
                    var href =
                            "conc_under.jsp?q=true&SERVER_IP=" + rowData.服务端IP + "&LV2_CON_ID=" + rowData.LV2_CON_ID + "&SESSION_ID=" + rowData.SESSION_ID;

//                    var href =
//                            "conc_under.jsp?q=true&SERVER_IP="+rowData.SERVER_IP+"&LV2_CON_ID="+rowData.LV2_CON_ID+"&SESSION_ID="+rowData.SESSION_ID;
                    window.open(href);
                }
            },
            pagerpos: 'center'
        }).navGrid(pageid, {edit: false, pagerpos: 'center', add: false, del: false, search: false, refresh: false});

        $(tabid).jqGrid().hideCol(["LV2_CON_ID", "SESSION_ID"]);

        $(window).resize(function () {//当浏览器大小变化时
            $(tabid).jqGrid('setGridWidth', $(divid).width());
        });

        $("#leftdiv").click(function () {
            $(tabid).jqGrid('setGridWidth', $(divid).width());
        });

    }

    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null)return unescape(r[2]);
        return null;
    }


    if (getQueryString("q") != null) {
        $.artcloud.loading("close");
        $("#sd").val(getQueryString("sd") == null ? getQueryString("startdate") : getQueryString("sd"));
        $("#ed").val(getQueryString("ed") == null ? getQueryString("enddate") : getQueryString("ed"));
        $("#msisdn").val(getQueryString("msisdn"));
        $("#psn").click();
    } else {
        $.artcloud.loading("close");
        var month = now.getMonth() + 1;
        var day = now.getDate();
        $("#sd").val(now.getFullYear() + "/" + (month < 10 ? ("0" + month) : month) + "/" + (day < 10 ? ("0" + day) :
                        day) +
                " 00");
        $("#ed").val(now.getFullYear() + "/" + (month < 10 ? ("0" + month) : month) + "/" + (day < 10 ? ("0" + day) :
                        day) +
                " 23");

    }

    $("#detHref").click(function () {
        if ($("#detHref").attr("canGo") == "true") {
            var sd = $("#sd").val().replace(/[/]/g, '').replace(' ', '');
            var ed = $("#ed").val().replace(/[/]/g, '').replace(' ', '');

            var href = "user_details.jsp?q=true&sd=" + sd + "&ed=" + ed + "&msisdn=" + $("#msisdn").val();
            window.open(href);
        }
    });

    $("#cMonCompHref").click(function () {
        if ($("#detHref").attr("canGo") == "true") {
            var month = now.getMonth() + 1;
            var sd = now.getFullYear() + "/" + (month < 10 ? ("0" + month) : month) + "/01 00";
            var ed = now.getFullYear() + "/" + (month < 10 ? ("0" + month) : month) + "/" + now.getDate() + " 23";
            var href = "complaint.jsp?q=true&sd=" + sd + "&ed=" + ed + "&msisdn=" + $("#msisdn").val();
            window.open(href);
        }
    });

    $("#pMonCompHref").click(function () {
        if ($("#detHref").attr("canGo") == "true") {
            var pMon = new Date(now.getTime());

            pMon.setMonth(pMon.getMonth() - 1);
            var pm = pMon.getMonth() + 1;
            var cm = now.getMonth() + 1;
            var sd = pMon.getFullYear() + "/" + (pm < 10 ? ("0" + pm) : pm) + "/01 00";
            var ed = pMon.getFullYear() + "/" + (cm < 10 ? ("0" + cm) : cm) + "/01 00";
            var href = "complaint.jsp?q=true&sd=" + sd + "&ed=" + ed + "&msisdn=" + $("#msisdn").val();
            window.open(href);
        }
    });

    $("#toFlow").click(function () {
        var sd = $("#sd").val().replace(/[/]/g, '').replace(' ', '');
        var ed = $("#ed").val().replace(/[/]/g, '').replace(' ', '');
        var href = "/flowmanage/userflow.jsp?startdate=" + sd + "&enddate=" + ed + "&msisdn=" + $("#msisdn").val();
        window.open(href);

    });


</script>
</html>
