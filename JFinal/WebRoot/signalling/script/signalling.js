/// <reference path="Plugins/jquery-1.11.1.min.js" />

// 对Date的扩展，将 Date 转化为指定格式的String
// 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
// 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
// 例子： 
// (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
// (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
Date.prototype.Format = function (fmt) { //author: meizz 
    var o = {
        "M+": this.getMonth() + 1, //月份 
        "d+": this.getDate(), //日 
        "h+": this.getHours(), //小时 
        "m+": this.getMinutes(), //分 
        "s+": this.getSeconds(), //秒 
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
        "S": this.getMilliseconds() //毫秒 
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
};

$(function () {
    //$('.container4 .div_scroll').scroll_absolute({ arrows: false });
    //$(window).resize(function () {//当浏览器大小变化时
    //    $('.container4 .div_scroll').scroll_absolute({ arrows: false });
    //});
    $('.uipinput').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square',
        increaseArea: '20%' // optional
    });
    new signallingQuery().init();
});

var baseUrl = "";

var signallingQuery = function () {

    var tsobj = this;
    tsobj.gishost = "";
    tsobj.pageDate = null;
    tsobj.search = {
        pageSize: 10,
        pageIndex: 0,
        startDate: null,
        endDate: null,
        phone: null,
        imsi: null,
        interfaceType:null,
        procedure_type:null,
        failStatus:-1
    };

    tsobj.interfaceType = [
        { id: 11, name: 'S1-U' },
        { id: 5, name: 'S1-MME' },
        { id: 7, name: 'S11' },
        { id: 9, name: 'SGS' }
    ];

    tsobj.procedureType = [
        { interfase: 5, id: 1, name: 'Attach' },
        { interfase: 5, id: 2, name: 'Sevice Request' },
        { interfase: 5, id: 3, name: 'Extended Service Request' },
        { interfase: 5, id: 4, name: 'Paging' },
        { interfase: 5, id: 5, name: 'TAU' },
        { interfase: 5, id: 6, name: 'Detach' },
        { interfase: 5, id: 7, name: 'PDN connectivity' },
        { interfase: 5, id: 8, name: 'PDN disconnection' },
        { interfase: 5, id: 9, name: ' EPS bearer resource allocation' },
        { interfase: 5, id: 10, name: 'EPS bearer resource modify' },
        { interfase: 5, id: 11, name: 'EPS bearer context deactivation' },
        { interfase: 5, id: 12, name: 'EPS bearer context modification' },
        { interfase: 5, id: 13, name: 'Dedicated EPS bearer context activation' },
        { interfase: 5, id: 14, name: 'X2 handover' },
        { interfase: 5, id: 15, name: 'S1 handover in' },
        { interfase: 5, id: 16, name: 'S1 handover out' },
        { interfase: 5, id: 17, name: 'S1 handover cancel' },
        { interfase: 5, id: 18, name: 'Initial context setup' },
        { interfase: 5, id: 19, name: 'UE context modification' },
        { interfase: 5, id: 20, name: 'UE context release' },
        { interfase: 5, id: 21, name: 'E-RAB release' },
        { interfase: 5, id: 22, name: 'Reset' },
        { interfase: 5, id: 23, name: 'Error indication' },
        { interfase: 5, id: 24, name: 'S1 setup' },
        { interfase: 5, id: 25, name: 'ENB configuration update' },
        { interfase: 5, id: 26, name: 'MME configuration update' },
        { interfase: 5, id: 27, name: 'Overload start' },
        { interfase: 5, id: 28, name: 'Overload stop' },
        { interfase: 5, id: 29, name: 'Identity Acquisition' },
        { interfase: 5, id: 30, name: 'Authentication' },
        { interfase: 5, id: 31, name: 'Security Activation' },
        { interfase: 5, id: 32, name: 'SMS' },

        { interfase: 11, id: -1, name: 'GENERAL' },
        { interfase: 11, id: -2, name: 'HTTP' },
        { interfase: 11, id: -3, name: 'DNS' },
        { interfase: 11, id: -4, name: 'IM' }
    ];

    var getRat = function (code) {
        var result = "";
        switch (code) {
            case "1": result = "UTRAN"; break;
            case "2": result = "GERAN"; break;
            case "3": result = "WLAN"; break;
            case "4": result = "GAN"; break;
            case "5": result = "HSPA Evolution"; break;
            case "6": result = "EUTRAN"; break;
            default: result = code; break;
        }
        return result;
    };

    var getInterface = function (code) {
        var result = "";
        code = code + "";
        switch (code) {
            case "1": result = "Uu"; break;
            case "2": result = "X2"; break;
            case "3": result = "UE_MR"; break;
            case "4": result = "Cell_MR"; break;
            case "5": result = "S1-MME"; break;
            case "6": result = "S6a"; break;
            case "7": result = "S11"; break;
            case "8": result = "S10"; break;
            case "9": result = "SGs"; break;
            case "10": result = "S5/S8"; break;
            case "11": result = "S1-U"; break;
            case "12": result = "Gn"; break;
            case "21": result = "IDC出口"; break;
            case "22": result = "省网出口"; break;
            case "23": result = "省网网间出口"; break;
            case "24": result = "骨干网网间出口"; break;
            default: result = code; break;
        }
        return result;
    };

    var getProcedureType = function (code) {
        var result = "";
        for (var i = 0; i < tsobj.procedureType.length; i++) {
            if (tsobj.procedureType[i].id + "" == code) {
                result = tsobj.procedureType[i].name;
            }
        }
        if (result == "") {
            result = code;
        }
        return result;
    };

    var getProtoType = function (type, code) {
        var result = code;
        if (type == "http") {
            if (code == "0") {
                result = "TCP";
            } else if (code == "1") {
                result = "UDP";
            }
        }
        result = result || "";
        return result;
    };

    var convertDate = function (unixtime) {
        var result = "";
        if (unixtime) {
            
            var unixTimestamp = new Date(parseFloat(unixtime.substr(0, 10)) * 1000);
            result = unixTimestamp.Format("yyyy-MM-dd hh:mm:ss");
        }
        return result;
    };

    var initPage = function () {
        $("#pagepanel").empty();
        var firstPage = $('<li class="active pageitems"><a href="javascript:void(0)">' + (tsobj.search.pageIndex + 1) + '</a></li>');
        firstPage.data("data", tsobj.search.pageIndex);
        firstPage.click(function () {
            tsobj.search.pageIndex = firstPage.data("data");
            $(this).parent().children("li").removeClass("active");
            $(this).addClass("active");
            tsobj.pageDate = null;
            loadTable();
        });

        var nextPage = $('<li id="btnnextpage"><a href="javascript:void(0)">...</a></li>');
        nextPage.click(function () {
            tsobj.search.pageIndex = tsobj.search.pageIndex + 1;
            $(this).parent().children("li").removeClass("active");
            var pageItems = $(this).parent().children(".pageitems");
            var nextPageObj = pageItems.eq(tsobj.search.pageIndex);
            if (nextPageObj.length > 0) {
                nextPageObj.click();
            } else {
                var pageObj = $('<li class="active pageitems"><a href="javascript:void(0)">' + (tsobj.search.pageIndex + 1) + '</a></li>');
                pageObj.data("data", tsobj.search.pageIndex);
                pageObj.click(function () {
                    tsobj.search.pageIndex = $(this).data("data");
                    $(this).parent().children("li").removeClass("active");
                    $(this).addClass("active");
                    if (tsobj.search.pageIndex > 0) {
                        var lastData = $(this).parent().children(".pageitems").eq(tsobj.search.pageIndex - 1).data("lastdata");
                        tsobj.pageDate = lastData.oldStartDate;
                    } else {
                        tsobj.pageDate = null;
                    }                    
                    loadTable();
                });
                var pageItemObjs = $(this).parent().children(".pageitems");
                if (pageItemObjs.length == 1) {
                    var itemdata= $("#signallingBody").children("tr").last().data("data");
                    pageItemObjs.eq(0).data("lastdata", itemdata);
                }
                var lastData = pageItemObjs.last().data("lastdata");
                if (lastData) {
                    tsobj.pageDate = lastData.oldStartDate;
                }
                
                $(this).before(pageObj);
                loadTable(function (rdata) {
                    if (rdata.signallingList && rdata.signallingList.length > 0) {
                        var lastIndex = rdata.signallingList.length > 10 ? 10 : rdata.signallingList.length - 1;
                        var lastData = rdata.signallingList[lastIndex];
                        pageObj.data("lastdata", lastData);
                    }
                    
                });
            }
        });
        $("#pagepanel").append(firstPage).append(nextPage);
    };

    var init = function () {

        $(".S-label").click(function () {
            $(this).parent().children("input").focus();
        });
        $(".add-on").click(function () {
            $(this).parent().children("input").focus();
        });

        $("#btnQuery").click(function () {

            tsobj.search.startDate = $.trim($("#txtStartDate").val()).replace("-", "").replace("-", "").replace(" ", "").replace(":", "");
            tsobj.search.endDate = $.trim($("#txtEndDate").val()).replace("-", "").replace("-", "").replace(" ", "").replace(":", "");
            tsobj.pageDate = null;
            tsobj.search.phone = $.trim($("#txtPhone").val());
            tsobj.search.failStatus = $("#cbLoadData").prop("checked") ? 1 : -1;
            tsobj.search.procedure_type = null;
            tsobj.search.interfaceType = null;
            tsobj.search.pageIndex = 0;
            if (tsobj.search.startDate == "") {
                $.artcloud.alert({
                    text: "开始时间不能为空.", onclose: function () {
                        $("#txtStartDate").focus();
                    }
                });
                return;
            }
            if (tsobj.search.endDate == "") {
                $.artcloud.alert({
                    text: "结束时间不能为空.", onclose: function () {
                        $("#txtEndDate").focus();
                    }
                });
                return;
            }
            if (!tsobj.search.phone || tsobj.search.phone.length<11) {
                $.artcloud.alert({
                    text: "用户标识必须在11-15位之间.", onclose: function () {
                        $("#txtPhone").focus();
                    }
                });
                return;
            }

            var flowTypeData = $("#flowtypepanel").data("data");
            if (flowTypeData) {
                var ids = [];
                for (var i = 0; i < flowTypeData.length; i++) {
                    ids.push(flowTypeData[i].id);
                }
                tsobj.search.procedure_type = ids.join(",");
            }

            var interfaceData = $("#interfacepanel").data("data");
            if (interfaceData) {
                var ids = [];
                for (var i = 0; i < interfaceData.length; i++) {
                    ids.push(interfaceData[i].id);
                }
                tsobj.search.interfaceType = ids.join(",");
            }
            initPage();

            loadTable();

            if (tsobj.search.phone && tsobj.search.startDate && tsobj.search.endDate) {
                $("#btnIssue").addClass("btn-danger");
                $("#btngogis").addClass("btn-success");
            } else {
                $("#btnIssue").removeClass("btn-danger");
                $("#btngogis").removeClass("btn-success");
            }
            
        });

        $("#cbStatusPanel").click(function () {
            tsobj.search.failStatus = $("#cbLoadData").prop("checked") ? 1 : -1;
            if (tsobj.search.startDate != null && tsobj.search.endDate != null && tsobj.search.phone != null) {
                loadTable();
            }
        });

        $("#cbloadPanel").click(function () {
            $("#btnQuery").click();
        });

        $("#btnIssue").click(function () {
            if (!$(this).hasClass("btn-danger")) {
                return;
            }
            if (tsobj.search.phone && tsobj.search.startDate && tsobj.search.endDate) {
                var param = "msisdn=" + tsobj.search.phone + "&startdate=" + tsobj.search.startDate + "&enddate=" + tsobj.search.endDate;
                window.open("/index_cust.jsp?q=true&" + param);
            }
        });

        $("#btngogis").click(function () {
            if (!$(this).hasClass("btn-success")) {
                return;
            }
            if (tsobj.search.phone && tsobj.search.startDate && tsobj.search.endDate) {
                var param = "msisdn=" + tsobj.search.phone + "&startdate=" + tsobj.search.startDate + "&enddate=" + tsobj.search.endDate;
                window.open(tsobj.gishost + "/Pages/GisDefault.aspx?m=mobilenetdiagnosis&" + param);
            }
        });

        $.ajax({
            type: "Get",
            url: "/signalling/getProp",
            async:false,
            success: function (rdata) {
                if (rdata && rdata.obj && rdata.obj.gishost) {
                    tsobj.gishost = rdata.obj.gishost;
                }
            }, complete: function (xhr) {
                $.artcloud.loading("close");
            }, error: function (xhr) {
                alert("加载配置文件出错:" + xhr.status);
            }
        });


        $("#interfacepanel").children("ul").empty();
        for (var i = 0; i < tsobj.interfaceType.length; i++) {
            var liitem = $('<li style="height:30px;line-height:30px;"><label style="color:#000;"><input style="margin-top: -2px;" type="checkbox" value="' + tsobj.interfaceType[i].id + '" />' + tsobj.interfaceType[i].name + '</label></li>');
            liitem.find('input[type=checkbox]').data("data", tsobj.interfaceType[i]);
            $("#interfacepanel").children("ul").append(liitem);
        }
        registerDragDownList($("#interfacepanel"), function (ids) {
            var seldata = $("#flowtypepanel").data("data");
            $("#flowtypepanel").children("ul").empty();
            for (var i = 0; i < ids.length; i++) {
                for (var j = 0; j < tsobj.procedureType.length; j++) {
                    if (ids[i].id == tsobj.procedureType[j].interfase+"") {
                        var liitem = $('<li style="height:30px;line-height:30px;"><label style="color:#000;"><input style="margin-top: -2px;" type="checkbox" interface="' + tsobj.procedureType[j].interfase + '" value="' + tsobj.procedureType[j].id + '" />' + tsobj.procedureType[j].name + '</label></li>');
                        liitem.find('input[type=checkbox]').data("data", tsobj.procedureType[j]);

                        if (seldata && seldata.length > 0) {
                            for (var n = 0; n < seldata.length; n++) {
                                if (seldata[n].id == tsobj.procedureType[j].id + "" && tsobj.procedureType[j].interfase + "" == seldata[n].interfase) {
                                    liitem.find('input[type=checkbox]').prop("checked", true);
                                    break;
                                }
                            }
                        }
                        $("#flowtypepanel").children("ul").append(liitem);
                    }
                }
            }
            registerDragDownList($("#flowtypepanel"));

            //update
            var checkedObjs = $("#flowtypepanel").children("ul").find("input[type=checkbox]:checked");
            var text = [];
            var ids = [];
            for (var i = 0; i < checkedObjs.length; i++) {
                var cbitem = checkedObjs.eq(i);
                text.push(cbitem.parent().text());
                ids.push(cbitem.data("data"));
            }
            $("#flowtypepanel").children("label").text(text.join()).attr("title", text.join());
            $("#flowtypepanel").data("data", ids);
        });


        $(".dragdownlist").children("label").click(function (event) {
            var e = window.event || event;
            if (e.preventDefault) {
                e.preventDefault();
            }
            if (e.stopPropagation) {
                e.stopPropagation();
            }
            if (window.event) {
                e.cancelBubble = true;
            }

            var ulObj = $(this).parent().children("ul");
            if (ulObj.css("display") != "none") {
                ulObj.slideUp(200);
            } else {
                ulObj.slideDown(200);
            }
            var searpanel = $(".dragdownlist");
            for (var i = 0; i < searpanel.length; i++) {
                var searchItem = searpanel.eq(i);
                if (!searchItem.is(e.target) && searchItem.has(e.target).length == 0) {
                    searchItem.children("ul").slideUp(200);
                }
            }
        });
        $(".dragdownlist").children("a").click(function (event) {
            var e = window.event || event;
            if (e.preventDefault) {
                e.preventDefault();
            }
            if (e.stopPropagation) {
                e.stopPropagation();
            }
            if (window.event) {
                e.cancelBubble = true;// ie下阻止冒泡
            }
            
            var ulObj = $(this).parent().children("ul");
            if (ulObj.css("display") != "none") {
                ulObj.slideUp(200);
            } else {
                ulObj.slideDown(200);
            }
            var searpanel = $(".dragdownlist");
            for (var i = 0; i < searpanel.length; i++) {
                var searchItem = searpanel.eq(i);
                if (!searchItem.is(e.target) && searchItem.has(e.target).length == 0) {
                    searchItem.children("ul").slideUp(200);
                }
            }
        });

        $(document).click(function (event) {
            var e = window.event || event;
            var searpanel = $(".dragdownlist");
            for (var i = 0; i < searpanel.length; i++) {
                var searchItem = searpanel.eq(i);
                if (!searchItem.is(e.target) && searchItem.has(e.target).length == 0) {
                    searchItem.children("ul").slideUp(200);
                } 
            }
        });
    };

    var registerDragDownList = function (dragJqObj,callback) {
        var dragDwonListObj = dragJqObj;
        var dragContentObj = dragDwonListObj.children("ul");
        dragContentObj.find('input[type=checkbox]').click(function () {
            var checkedObjs = dragContentObj.find("input[type=checkbox]:checked");
            var text = [];
            var ids = [];
            for (var i = 0; i < checkedObjs.length; i++) {
                var cbitem = checkedObjs.eq(i);
                //ids.push(cbitem.val());
                text.push(cbitem.parent().text());
                ids.push(cbitem.data("data"));
            }
            dragDwonListObj.children("label").text(text.join()).attr("title", text.join());
            dragDwonListObj.data("data", ids);
            if (callback) {
                callback(ids);
            }
        });
    };

    var loadTable = function (callback) {
        $.artcloud.loading();
        var postDate = $.extend(true, {}, tsobj.search);
        postDate.pageDate = tsobj.pageDate;
        $.ajax({
            type: "POST",
            url: "/signalling/getSignallingList",
            data: postDate,
            success: function (rdata) {
                if (rdata.status == 1) {
                    packTable(rdata.obj);
                    if (callback) {
                        callback(rdata.obj)
                    }
                    //分页控制
                    var pageitems = $("#pagepanel").children(".pageitems");
                    pageitems.show();
                    var totalSize = pageitems.length;
                    var index = pageitems.index($("#pagepanel").children(".active"));
                    if (totalSize == (index+1)) {
                        if (rdata.obj.signallingList.length > 10) {
                            $("#btnnextpage").show();
                        } else {
                            $("#btnnextpage").hide();
                        }
                    }
                    if (index-4 > 1) {
                        for (var i = 1; i < index - 5; i++) {
                            pageitems.eq(i).hide();
                        }
                    }
                    if (totalSize - index - 5 > 1) {
                        for (var i = index + 5; i < totalSize; i++) {
                            pageitems.eq(i).hide();
                        }
                    }
                } else {
                    alert(rdata.message || "出错.");
                }
            }, complete: function (xhr) {
                $.artcloud.loading("close");
            }, error: function (xhr) {
                alert("出错:" + xhr.status);
            }
        });
    };

    var packTable = function (dataObj) {
        var tabBody = $("#signallingBody");
        tabBody.empty();
        $("#tabdetail").empty();
        var rdata = dataObj.signallingList;
        if (rdata && rdata.length > 0) {
            var size = rdata.length > 10 ? 10 : rdata.length;
            for (var i = 0; i < size; i++) {
                var dataItem = rdata[i];
                var trObj = $('<tr style="cursor:pointer"/>').data("data", dataItem);
                $('<td scope="row"/>').text(i + 1).appendTo(trObj);
                $('<td/>').text(convertDate(dataItem.procedure_starttime_ms)).appendTo(trObj);
                $('<td/>').text(convertDate(dataItem.procedure_endtime_ms)).appendTo(trObj);
                //$('<td/>').text(dataItem.msisdn || "").appendTo(trObj);
                //$('<td/>').text(dataItem.imsi || "").appendTo(trObj);
                $('<td/>').text(dataItem.xdrId || "").appendTo(trObj);
                $('<td/>').text(dataItem.city || "").appendTo(trObj);
                $('<td/>').text(dataItem.tac || "").appendTo(trObj);
                $('<td/>').text(dataItem.cellId || "").appendTo(trObj);
                $('<td/>').text(getRat(dataItem.rat)).appendTo(trObj);
                $('<td/>').text(getInterface(dataItem.interfaceType)).appendTo(trObj);
                $('<td/>').text(getProcedureType(dataItem.procedureType)).appendTo(trObj);
                $('<td/>').text(dataItem.busLantency || "").appendTo(trObj);
                $('<td/>').text(dataItem.userIp4 || "").appendTo(trObj);
                $('<td/>').text(dataItem.serverIp || "").appendTo(trObj);
                var statusObj = $('<td/>').text(dataItem.procedureStatusText).appendTo(trObj);
                $('<td/>').text(dataItem.failureCause || "").appendTo(trObj);
                $('<td/>').text(getProtoType(dataItem.tabname, dataItem.protocolType)).appendTo(trObj);
                if (dataItem.procedureStatus == "1") {
                    statusObj.css("background-color", "red").addClass("bgred");
                }
                tabBody.append(trObj);
                trObj.click(function () {
                    $(this).parent().children("tr").removeClass("active");
                    $(this).addClass("active");
                    loadInfo($(this).data("data"));
                });
            }
        }
    };

    var packPager = function (totalNum,pageSize,pageIndex) {
        var totalPage = parseInt((totalNum - 1) / pageSize) + 1;
        var currentPage = pageIndex + 1;
        var showPageNum = 10;
        var lastShowPageNum = showPageNum > totalPage ? totalPage : showPageNum;

        var pagePanel = $("#").children("ul");
        pagePanel.empty();
        if (totalPage > showPageNum && currentPage > parseInt(showPageNum / 2)) {
            pagePanel.append($('<li><a href="javascript:void(0)">' + i + '</a></li>').data("val", 0));
        }
        for (var i = 0; i < lastShowPageNum; i++) {
            var pitem = $('<li><a href="javascript:void(0)"></a></li>');
            var pindex = 0;
            if (showPageNum > totalPage || currentPage <= parseInt(showPageNum / 2)) {
                pindex = i;
            } else if ((currentPage + parseInt(showPageNum / 2)) > totalPage) {
                pindex = totalPage - lastShowPageNum + i;
            } else {
                pindex = (currentPage - parseInt(showPageNum / 2)) + i;
            }

            pitem.data("val", pindex).children("a").text((pindex + 1));
            if (currentPage == pindex + 1) {
                pitem.addClass("active");
            }
            pagePanel.append(pitem);
        }
        pagePanel.children("li").click(function () {
            var page = $(this).data("val");
            load(page);
        });
    };

    var loadInfo = function (trdata) {
        $("#tabdetail").empty();
        if (trdata) {
            var postData = {
                tabName: trdata.tabname,
                procedure_starttime_ms: trdata.oldStartDate,
                procedure_endtime_ms: trdata.oldEndDate,
                xdr_id: trdata.xdrId,
                msisdn: trdata.msisdn,
                rowKey: trdata.rowKey
            };
            $.artcloud.loading();
            $.ajax({
                type: "POST",
                url: "/signalling/getSignallingDetail",
                data: postData,
                success: function (rdata) {
                    $.artcloud.loading("close");
                    if (rdata.status == 1) {
                        var cols = rdata.cols;
                        cols = cols.split(",");
                        for (var i = 0; i < cols.length; i++) {
                            var item = $.trim(cols[i]);
                            if (item != "") {
                                var liObj = $('<li/>');
                                var labelObj = $('<label class="pull-left text-darkgray mb0"/>').text(item);
                                var valueObj = $('<label class="pull-right text-blue f14 fb"/>');
                                var val = rdata.obj[0][item] || "";
                                valueObj.attr("title", val);
                                if (val.length > 20) {
                                    valueObj.text(val.substring(0, 12));
                                } else {
                                    valueObj.text(val);
                                }
                                liObj.append(labelObj).append(valueObj);
                                $("#tabdetail").append(liObj);
                            }
                        }
                        //var height = $("#content").outerHeight();
                        $("#content").animate({ scrollTop: 153 }, 200);
                    } else {
                        alert(rdata.message || "出错.");
                    }
                }, complete: function (xhr) {
                    $.artcloud.loading("close");
                }, error: function (xhr) {
                    alert("出错:" + xhr.status);
                }
            });
        }
    };

    this.init = init;
};