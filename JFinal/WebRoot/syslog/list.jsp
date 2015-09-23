<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>模块使用频次明细（按账号）</title>
    <link type="text/css" rel="stylesheet" href="/css/jquery-ui.min.css">
    <link type="text/css" rel="stylesheet" href="/css/theme.css">
    <link type="text/css" rel="stylesheet" href="/css/ui.jqgrid.css">
    <!--<link type="text/css" rel="stylesheet" href="/css/ui.jqgrid-bootstarp.css">-->
    <script src="/js/WdatePicker.js"></script>
</head>
<body>

<!--条件-->
开始日期<input class="Wdate" id="sd" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'ed\')}'})"/>
结束日期<input class="Wdate" id="ed" onClick="WdatePicker({minDate:'#F{$dp.$D(\'sd\')}'})"/>
账户<input id="user" />
<button id="search">查询</button>
<!--列表-->
<table id="jqg"></table>
<div id="pager"></div>

<button id="psb">测试</button>

<!-- ECharts单文件引入 -->
<!--<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>-->
<script src="/js/require.js"></script>
<script src="/js/jquery.js"></script>
<script type="text/javascript">
    // 路径配置
    require.config({
        baseUrl: '/js'
    });

    $("#search").click(function () {

        $("#jqg").setGridParam({
            url: '/syslog/listByUser',
            datatype: 'json',
            postData: {'user': $("#user").val(), 'sd': $("#sd").val(), 'ed': $("#ed").val()}, //发送数据
            page: 1
        }).trigger("reloadGrid"); //重新载入
    });

    require(
            [
                'jquery.jqGrid',
                'i18n/grid.locale-cn',
                'jquery-ui'
            ], function () {
                $("#jqg").jqGrid({
                    url: '/syslog/listByUser',
                    datatype: "json",

                    colNames: ["账户", "操作时间", "操作模块", "投诉用户号码"],
                    colModel: [
                        {name: "user", width: 80},
                        {name: "time", width: 80},
                        {name: "func_desc", width: 80},
                        {name: "tel", width: 80}
                    ],
                    rowNum: 10,
                    autowidth: true,
                    rowList: [10, 20, 30],
                    pager: "#pager",
                    viewrecords: true,
                    rownumbers:true,
                    caption: "模块使用频次统计"

                }).navGrid("#pager", {edit: false, add: false, del: false, search: false, refresh: false});
                jQuery("#psb").click( function() {
                    $("#jqg").jqGrid('setGridParam',{postData:{q2:435}});
//                    $("#jqg").trigger("reloadGrid");
                    var pd =$("#jqg").jqGrid('getGridParam').postData;
                    var r ="";
                    $.each(pd,function(i){
                        r += i+": "+pd[i]+",";
                    })
                });
            }
    );


</script>


</body>
</html>
