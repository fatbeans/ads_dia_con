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

var now = new Date();
now.setDate(now.getDate() - 1);
var month = now.getMonth() + 1
$("#txtStartDate").val(now.getFullYear() + "/" + (month < 10 ? ("0" + month) : month) + "/" + now.getDate() + " 00");
$("#txtEndDate").val(now.getFullYear() + "/" + (month < 10 ? ("0" + month) : month) + "/" + now.getDate() + " 23");


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

var signallingQuery = function () {

    var tsobj = this;
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
        switch (code) {
            case 1: result = "Uu"; break;
            case 2: result = "X2"; break;
            case 3: result = "UE_MR"; break;
            case 4: result = "Cell_MR"; break;
            case 5: result = "S1-MME"; break;
            case 6: result = "S6a"; break;
            case 7: result = "S11"; break;
            case 8: result = "S10"; break;
            case 9: result = "SGs"; break;
            case 10: result = "S5/S8"; break;
            case 11: result = "S1-U"; break;
            case 12: result = "Gn"; break;
            case 21: result = "IDC出口"; break;
            case 22: result = "省网出口"; break;
            case 23: result = "省网网间出口"; break;
            case 24: result = "骨干网网间出口"; break;
            default: result = code; break;
        }
        return result;
    };

    var getProtoType = function (code) {
        var result = code;
        if (code == "0") {
            result = "TCP";
        } else if (code == "1") {
            result = "UDP";
        }
        return result;
    };

    var convertDate = function (unixtime) {
        var result = "";
        if (unixtime) {
            var unixTimestamp = new Date(unixtime);
            result = unixTimestamp.Format("yyyy-MM-dd hh:mm:ss");
        }
        return result;
    };

    var getStatus = function (code) {
        var result = "";
        switch (code) {
            case "1": result = "失败"; break;
            case "2": result = "成功"; break;
            default: result = code; break;
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
            loadTable();
        });

        var nextPage = $('<li id="btnnextpage"><a href="javascript:void(0)">></a></li>');
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
                    loadTable();
                });
                $(this).before(pageObj);
                loadTable();
            }
        });
        $("#pagepanel").append(firstPage).append(nextPage);
    };

    var init = function () {

        $("#btnQuery").click(function () {
            tsobj.search.startDate = $.trim($("#txtStartDate").val()).replace("-", "").replace("-", "").replace(" ", "").replace(":", "");
            tsobj.search.endDate = $.trim($("#txtEndDate").val()).replace("-", "").replace("-", "").replace(" ", "").replace(":", "");
            tsobj.search.phone = $.trim($("#txtPhone").val());
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
            if (tsobj.search.phone == "") {
                $.artcloud.alert({
                    text: "手机号码不能为空.", onclose: function () {
                        $("#txtPhone").focus();
                    }
                });
                return;
            }
            if ($("#flowtypepanel").data("data")) {
                tsobj.search.procedure_type = $("#flowtypepanel").data("data");
            }
            if ($("#interfacepanel").data("data")) {
                tsobj.search.interfaceType = $("#interfacepanel").data("data");
            }
            initPage();

            loadTable();
        });

        $("#cbloadPanel").click(function () {
            tsobj.search.failStatus = $("#cbLoadData").prop("checked") ? 1 : -1;
            if (tsobj.search.startDate != null && tsobj.search.endDate != null && tsobj.search.phone != null) {
                loadTable();
            }
        });

        $.artcloud.loading();
        $.post("/signalling/getFlowType", tsobj.search, function (rdata) {
            $.artcloud.loading("close");
            if (rdata.status == 1) {
                $("#flowtypepanel").children("ul").empty();
                for (var i = 0; i < rdata.obj.length; i++) {
                    var item = rdata.obj[i];
                    var liitem = $('<li style="height:30px;line-height:30px;"><label style="color:#000;"><input style="margin-top: -2px;" type="checkbox" value="' + item.procedure_type_code + '" />' + item.procedure_type + '</label></li>');
                    $("#flowtypepanel").children("ul").append(liitem);
                }
                registerDragDownList($("#flowtypepanel"));
            } else {
                alert(rdata.message || "出错.");
            }
        });


        $("#interfacepanel").children("ul").empty();
        var liitem1 = $('<li style="height:30px;line-height:30px;"><label style="color:#000;"><input style="margin-top: -2px;" type="checkbox" value="1" />S1-U</label></li>');
        var liitem2 = $('<li style="height:30px;line-height:30px;"><label style="color:#000;"><input style="margin-top: -2px;" type="checkbox" value="2" />S1-MME</label></li>');
        var liitem3 = $('<li style="height:30px;line-height:30px;"><label style="color:#000;"><input style="margin-top: -2px;" type="checkbox" value="3" />SGS</label></li>');
        var liitem4 = $('<li style="height:30px;line-height:30px;"><label style="color:#000;"><input style="margin-top: -2px;" type="checkbox" value="4" />S11</label></li>');
        $("#interfacepanel").children("ul").append(liitem1).append(liitem2).append(liitem3).append(liitem4);
        registerDragDownList($("#interfacepanel"));


        $(".dragdownlist").children("label").click(function () {
            $(this).parent().children("a").click();
        });
        $(".dragdownlist").children("a").click(function () {
            var ulObj = $(this).parent().children("ul");
            if (ulObj.css("display") != "none") {
                ulObj.slideUp(200);
            } else {
                ulObj.slideDown(200);
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

    var registerDragDownList = function (dragJqObj) {
        var dragDwonListObj = dragJqObj;
        var dragContentObj = dragDwonListObj.children("ul");
        dragContentObj.find('input[type=checkbox]').click(function () {
            var checkedObjs = dragContentObj.find("input[type=checkbox]:checked");
            var text = [];
            var ids = [];
            for (var i = 0; i < checkedObjs.length; i++) {
                var cbitem = checkedObjs.eq(i);
                ids.push(cbitem.val());
                text.push(cbitem.parent().text());
            }
            dragDwonListObj.children("label").text(text.join()).attr("title", text.join());
            dragDwonListObj.data("data", ids.join());
        });
    };

    var loadTable = function () {
        $.artcloud.loading();
        $.post("/signalling/getSignallingList", tsobj.search, function (rdata) {
            $.artcloud.loading("close");
            if (rdata.status == 1) {
                packTable(rdata.obj);
            } else {
                alert(rdata.message || "出错.");
            }
        });
    };

    var packTable = function (rdata) {
        if (rdata && rdata.length > 0) {
            var tabBody = $("#signallingBody");
            tabBody.empty();
            for (var i = 0; i < rdata.length; i++) {
                var dataItem = rdata[i];
                var trObj = $('<tr style="cursor:pointer"/>').data("data", dataItem);
                $('<td scope="row"/>').text(i + 1).appendTo(trObj);
                $('<td/>').text(convertDate(dataItem.procedure_starttime_ms)).appendTo(trObj);
                $('<td/>').text(convertDate(dataItem.procedure_endtime_ms)).appendTo(trObj);
                //$('<td/>').text(dataItem.msisdn || "").appendTo(trObj);
                //$('<td/>').text(dataItem.imsi || "").appendTo(trObj);
                $('<td/>').text(dataItem.xdr_id || "").appendTo(trObj);
                $('<td/>').text(dataItem.city || "").appendTo(trObj);
                $('<td/>').text(dataItem.tac || "").appendTo(trObj);
                $('<td/>').text(dataItem.cell_id || "").appendTo(trObj);
                $('<td/>').text(getRat(dataItem.rat)).appendTo(trObj);
                $('<td/>').text(getInterface(dataItem.interface)).appendTo(trObj);
                $('<td/>').text(dataItem.procedure_type || "").appendTo(trObj);
                $('<td/>').text(dataItem.bus_lantency || "").appendTo(trObj);
                $('<td/>').text(dataItem.user_ipv4 || "").appendTo(trObj);
                $('<td/>').text(dataItem.mme_ip_add || "").appendTo(trObj);
                var statusObj= $('<td/>').text(getStatus(dataItem.procedure_status)).appendTo(trObj);
                $('<td/>').text(dataItem.failure_cause || "").appendTo(trObj);
                $('<td/>').text(getProtoType(dataItem.proto_type)).appendTo(trObj);
                if (dataItem.procedure_status == "1") {
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
        if (trdata) {
            var postData = {
                tabName: trdata.tabname,
                procedure_starttime_ms: trdata.procedure_starttime_ms,
                procedure_endtime_ms: trdata.procedure_endtime_ms,
                xdr_id: trdata.xdr_id,
                msisdn: trdata.msisdn
            };
            $.artcloud.loading();
            $.post("/signalling/getSignallingDetail", postData, function (rdata) {
                $.artcloud.loading("close");
                $("#tabdetail").empty();
                if (rdata.status == 1) {
                    var cols = "length, city, interface, xdr_id, rat, imsi, imei, msisdn, procedure_type, procedure_starttime, procedure_endtime, procedure_status, request_cause, failure_cause, keyword_1, keyword_2, keyword_3, keyword_4, mme_ue_s1ap_id, old_mme_group_id, old_mme_code, old_m_tmsi, mme_group_id, mme_code, m_tmsi, tmsi, user_ipv4, user_ipv6, mme_ip_add, enb_ip_add, mme_port, enb_port, tac, cell_id, other_tac, other_eci, apn,eps_bearer_number";
                    if (trdata == "http") {
                        cols = "length, city, interface, xdr_id, rat, imsi, imei, msisdn, machine_ip_addtype, sgw_ggsn_ip_add, enb_sgsn_ip_add, sgw_ggsn_port, enb_sgsn_port, enb_sgsn_gtp_teid, sgw_ggsn_gtp_teid, tac, cell_id, apn, app_type_code, procedure_starttime, procedure_endtime, protocol_type, app_type, app_sub_type, app_content, app_status, user_ipv4, user_ipv6, user_port, l4_protocal, app_server_ip_ipv4, app_server_ip_ipv6, app_server_port, ul_data, dl_data, ul_ip_packet, dl_ip_packet, up_tcp_disorder_packet, down_tcp_disorder_packet, up_tcp_retran_packet, down_tcp_retran_packet, tcp_build_re_lantency, tcp_build_ack_lantency, ul_ip_frag_packets, dl_ip_frag_packets, tcp_build_first_lantency, tcp_fst_to_first_lantency, tcp_window_size, mss_size, tcp_rebuild, tcp_status, is_status, http_version, http_type, http_wap_status, req, http_first_re_time, http_last_packet_time, host, uri, x_online_host, user_agent, http_content_type, refer_uri, cookie, content_length, target_behav, wtp_interrupt_type, wtp_interrupt_cause, title, key_word, bus_behav, bus_ok, bus_lantency, tool, app_sum, procedure_starttime_ms, procedure_endtime_ms";
                    }
                    cols = cols.split(",");
                    for (var i = 0; i < cols.length; i++) {
                        var item = cols[i].trim();
                        var liObj = $('<li/>');
                        var labelObj = $('<label class="pull-left text-darkgray mb0"/>').text(item);
                        var valueObj = $('<label class="pull-right text-blue f14 fb"/>');
                        var val = rdata.obj[item] || "";
                        valueObj.attr("title", val);
                        if (val.length > 20) {
                            valueObj.text(val.substring(0, 12));
                        } else {
                            valueObj.text(val);
                        }
                        liObj.append(labelObj).append(valueObj);
                        $("#tabdetail").append(liObj);
                    }
                } else {
                    alert(rdata.message || "出错.");
                }
            });
        }
    };

    this.init = init;
};