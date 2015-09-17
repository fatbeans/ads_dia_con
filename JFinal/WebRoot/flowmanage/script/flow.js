/// <reference path="Plugins/jquery-1.11.1.min.js" />

$(function () {
    autoAdapter();
    new flowManage().init();
});

$(window).resize(function () {
    autoAdapter();
});

var autoAdapter = function () {
    $(".fadeInLeft").css("height", "auto");
    $(".fadeInRight").css("height", "auto");
    var topHeight = $(".navbar-fixed-top").outerHeight();
    var titleHeight = $(".page-title").outerHeight() + 15;
    var bottomHeight = $(".navbar-fixed-bottom").outerHeight();
    var totalHeight = $(window).height();
    var centerHeight = totalHeight - topHeight - titleHeight - bottomHeight;

    if ($(".fadeInRight").outerHeight() < centerHeight) {
        $(".fadeInRight").css("height", (centerHeight-92));
    }
    $(".fadeInLeft").children(".div-open").css("height", ($(".fadeInRight").outerHeight() - 40));
};

var getQueryString = function (name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]); return null;
};

var flowManage = function () {

    var tsObj = this;
    tsObj.conclusionInfo = {
        lv1id: null,
        id: null,
        title:null
    };
    tsObj.page={
        pageIndex:0,
        pageSize:10
    };
    tsObj.param = {
        startDate: getQueryString("startdate"),
        endDate: getQueryString("enddate"),
        phone: getQueryString("msisdn"),
    };

    var init = function () {

        var liitems = $("#js-villageinfo-list").children("li");
        for (var i = 0; i < liitems.length; i++) {
            var aitem = liitems.eq(i).children("a");
            var url = aitem.attr("href");
            url=url+"?msisdn="+tsObj.param.phone+"&startdate="+tsObj.param.startDate+"&enddate="+tsObj.param.endDate;
            aitem.attr("href",url);
        }

        var ids = [];
        var conclusion = $(".conclusionPanel");
        for (var i = 0; i < conclusion.length; i++) {
            var itemid = conclusion.eq(i).attr("id");
            if (itemid) {
                ids.push(parseFloat(itemid));
            }
        }
        conclusion.click(function () {
            tsObj.conclusionInfo.lv1id = $(this).attr("lv1");
            tsObj.conclusionInfo.id = $(this).attr("id");
            tsObj.conclusionInfo.title = $(this).attr("title");
            showDetail(0);
        });
        loadConclusion(ids);
    };

    var loadConclusion = function (ids) {
        if (ids && ids.length > 0) {
            for (var i = 0; i < ids.length; i++) {
                var textObj = $("#" + ids[i]);
                textObj.css("cursor", "pointer");
                var tspan = textObj.children("tspan");
                tspan.css("font-size", 10);
                tspan.text("");
            }
            $.artcloud.loading();
            $.ajax({
                type: "POST",
                url: "/delimitflow/getConclusion",
                data: tsObj.param,
                success: function (rdata) {
                    if (rdata.status && rdata.obj) {
                        for (var i = 0; i < ids.length; i++) {
                            var lv1ConId = "";
                            var conNum = "CON:0";
                            for (var j = 0; j < rdata.obj.length; j++) {
                                if (ids[i] == rdata.obj[j].lv2ConId) {
                                    lv1ConId = rdata.obj[j].lv1ConId;
                                    conNum = "CON:" + rdata.obj[j].conNum;
                                    conNum = rdata.obj[j].conNum == "-1" ? "" : conNum;
                                    break;
                                }
                            }
                            var textObj = $("#" + ids[i]);
                            textObj.attr("lv1", lv1ConId);
                            textObj.css("cursor", "pointer");
                            var tspan = textObj.children("tspan");
                            tspan.css("font-size", 10).text(conNum);
                        }
                    } else {
                        alert("加载数据出错:" + rdata.message);
                    }
                }, complete: function (xhr) {
                    $.artcloud.loading("close");
                }, error: function (xhr) {
                    alert("加载结论出错:" + xhr.status);
                }
            });
        }
    };

    var showDetail = function (pindex) {
        if (pindex!=undefined) {
            tsObj.page.pageIndex = pindex;
        }

        var contentPanel=$("#contentPanel");
        if (contentPanel.length == 0) {
            contentPanel = $('<div id="contentPanel" style="display:none;position: relative"/>').appendTo("body");
            $('<div id="tablePanel" style="min-height:415px;"/>').appendTo(contentPanel);
            $('<div id="totalInfo" class="pull-left text-lightgray" />').appendTo(contentPanel);
            var pagerPanel = $('<div class="pagination ui-pager" style="text-align: right">').appendTo(contentPanel);
            $('<ul id="pagePanel"/>').appendTo(pagerPanel);
        }
        var tableObj = $("#tablePanel");
        var pageObj = $("#pagePanel");
        tableObj.empty();
        pageObj.empty();

        var postData = {
            lv1: tsObj.conclusionInfo.lv1id,
            cid: tsObj.conclusionInfo.id,
            startDate: tsObj.param.startDate,
            endDate: tsObj.param.endDate,
            phone: tsObj.param.phone,
            pageIndex: tsObj.page.pageIndex,
            pageSize: tsObj.page.pageSize
        };
        $.artcloud.loading();
        $.ajax({
            type: "POST",
            url: "/delimitflow/getConclusionDetail",
            data: postData,
            success: function (rdata) {
                if (rdata.status && rdata.obj && rdata.obj.cols && rdata.obj.jsonArray) {
                    $("#contentPanel").dialog({
                        width: 900,
                        height: 530,
                        title: tsObj.conclusionInfo.title,
                        buttom: [{ text: "确定", type: "canel" }]
                    });

                    var cols = rdata.obj.cols.split(",");
                    var colsCN = rdata.obj.colsCN.split(",");
                    var tableObj = $('<table class="table table-striped table-bordered panel-tabborder table-hover"/>');
                    var headerTRObj = $('<tr/>').appendTo(tableObj);
                    for (var i = 0; i < colsCN.length; i++) {
                        var tdObj = $('<td style="white-space: nowrap"/>').appendTo(headerTRObj);
                        tdObj.text($.trim(colsCN[i]));
                    }
                    for (var i = 0; i < rdata.obj.jsonArray.length; i++) {
                        var itemData = rdata.obj.jsonArray[i];
                        var trObj = $('<tr/>').appendTo(tableObj);
                        trObj.data("data", itemData);
                        for (var j = 0; j < cols.length; j++) {
                            var field = $.trim(cols[j]);
                            var tdObj = $('<td style="white-space: nowrap"/>').appendTo(trObj);
                            tdObj.text(itemData[field]);
                        }
                    }
                    $("#tablePanel").append(tableObj);
                    detailPage(tsObj.page.pageIndex, rdata.obj.totalNum);

                } else {
                    alert("加载数据出错:" + rdata.message);
                }
            }, complete: function (xhr) {
                $.artcloud.loading("close");
            }, error: function (xhr) {
                alert("加载结论出错:" + xhr.status);
            }
        });
    };

    var detailPage = function (pageIndex, totalNum) {

        var totalPage = parseInt((totalNum - 1) / tsObj.page.pageSize) + 1;
        var currentPage = pageIndex + 1;
        var showPageNum = 10;
        var lastShowPageNum = showPageNum > totalPage ? totalPage : showPageNum;
        $("#totalInfo").text("总共 " + totalPage + " 页,每页 " + tsObj.page.pageSize + " 条");
        var pagePanel = $("#pagePanel");
        pagePanel.empty();
        if (totalPage > showPageNum && currentPage > parseInt(showPageNum / 2)) {
            var pitem = $('<li class="pageitems"><a href="javascript:void(0)"></a></li>').data("val", 0);
            pitem.children("a").text("1");
            pagePanel.append(pitem);
        }
        for (var i = 0; i < lastShowPageNum; i++) {
            var pitem = $('<li class="pageitems"><a href="javascript:void(0)"></a></li>');
            var pindex = 0;
            if (showPageNum > totalPage || currentPage <= parseInt(showPageNum / 2)) {
                pindex = i;
            } else if ((currentPage + parseInt(showPageNum / 2)) > totalPage) {
                pindex = totalPage - lastShowPageNum + i;
            } else {
                pindex = (currentPage - parseInt(showPageNum / 2)) + i;
            }

            pitem.children("a").text((pindex + 1));
            pitem.data("val", pindex);
            if (currentPage == pindex + 1) {
                pitem.addClass("active");
            }
            pagePanel.append(pitem);
        }
        pagePanel.children("li").click(function () {
            var page = $(this).data("val");
            $(this).parent().children("li").removeClass("active");
            $(this).addClass("active");
            showDetail(page);
        });
    };

    this.init = init;
};