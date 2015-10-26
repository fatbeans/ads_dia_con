<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
    <title>添加EOMS工单</title>
    <link rel="stylesheet" href="css/bootstrap.css"/>
    <link rel="stylesheet" href="css/content.css"/>
    <link rel="stylesheet" href="css/style.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script type="text/javascript" src="js/jquery.json-2.4.min.js"></script>
    <script type="text/javascript" src="js/plugins.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>

    <script type="text/javascript">



        function getQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if (r != null)return decodeURIComponent(r[2]);
            return null;
        }

        var localUrl = "${pageContext.request.contextPath}";
        var workAddUrl = localUrl + "/work/addWork";
        var selectWorkUrl = localUrl + "/work/getTaskOne";
        var downFileUrl = localUrl + "/work/downFile";
        var synchData = null;

        function initSource() {
            var source = {
                "neNames": getQueryString("neName"),
                "eomsOrderId": getQueryString("eomsOrderId"),
                "eomsOrderTitle": getQueryString("eomsOrderTitle"),
                "typeId": getQueryString("typeId"),
                "typeName": getQueryString("typeName"),
                "typeSubId": getQueryString("typeSubId"),
                "typeSubName": getQueryString("typeSubName"),
                "cityKey": getQueryString("cityKey"),
                "cityName": getQueryString("cityName"),
                "rangeName": getQueryString("rangeName"),
                "neType": getQueryString("neType"),
                "sendWay": getQueryString("sendWay"),
                "content": getQueryString("content"),
                "fileName": getQueryString("fileName"),
                "rangeId": getQueryString("rangeId"),
                "wo_id": getQueryString("wo_id")
            };
            return source;
        }

        function cityInput(source) {

            if (source.cityName != null && source.cityName != undefined && source.cityName != '') {
                val2Html(source);
            } else {
                $.ajax({
                    url: getQueryString("test") == "true" ? "./citySelectTest.json" : "./work/getCity",
                    type: "post",
                    data: {workJson: $.toJSON(synchData)},
                    dataType: 'json',
                    success: function (data) {
                        var h = "";
                        for (var i = 0; i < data.length; i++) {
                            h += "<option citykey='" + data[i].citykey + "' value ='" + data[i].cityname + "'>" +
                                    data[i].cityname + "</option> ";
                            $("#citySelect").html("<select id='cityName' class='select'  name='CityName' type='text' style='width: 200px;'>" + h + "</select>");
                            $("#cityKey").val($("#cityName option:selected").attr("citykey"));
                            $("#cityName").change(function () {
                                $("#cityKey").val($("#cityName option:selected").attr("citykey"));
                            });
                        }
                        val2Html(source);
                    },
                    error: function () {
                        alert("获取地市错误");
                    }
                });
            }
        }

        function rangeInput(source) {

            $.ajax({
                url: getQueryString("test") == "true" ? "./citySelectTest.json" : "./work/getRange",
                type: "post",
                data: {workJson: $.toJSON(synchData)},
                dataType: 'json',
                success: function (data) {
                    var h = "";
                    for (var i = 0; i < data.length; i++) {
                        h += "<option rangekey='" + data[i].rangeid + "' value ='" + data[i].rangename + "'>" +
                                data[i].rangename + "</option> ";

                    }
                    $("#rangeSelect").html("<select id='rangeName' class='select'  name='RangeName'>" + h + "</select>");
                    $("#rangeId").val($("#rangeName option:selected").attr("rangekey"));
                    $("#rangeName").change(function () {
                        $("#rangeId").val($("#rangeName option:selected").attr("rangekey"));
                    });
                    val2Html(source);
                    if (source.send_status == 1 || source.send_status == 2) {
                        $("#rangeName").attr("disabled", "disabled");
                    }
                },
                error: function () {
                    alert("获取问题对象列表数据错误");
                }
            });

        }

        function val2Html(source) {
            $("#eomsOrderTitle").val(source.eomsOrderTitle);
            $("#typeName").val(source.typeName);
            $("#typeSubName").val(source.typeSubName);
            $("#cityName").val(source.cityName);
            $("#neType").val(source.neType);
            $("#sendWay").val(source.sendWay);
            $("#content").val(source.content);
            $("#eomsOrderId").val(source.eomsOrderId);
            $("#cityKey").val(source.cityKey);
            $("#typeId").val(source.typeId);
            $("#typeSubId").val(source.typeSubId);
            $("#neNames").val(source.neNames);
            if (!(source.fileName == null || source.fileName == undefined || source.fileName == '')) {
                $("#fileName").html(source.fileName);
                $("#fileName").attr("href", downFileUrl + "?fileName=" + encodeURIComponent(source.fileName));
            }
            if (!(source.wo_id == null || source.wo_id == undefined || source.wo_id == '')) {
                $("#wo_id").val(source.wo_id);
            }

            if (!(source.rangeId == null || source.rangeId == undefined || source.rangeId == '')) {
                $("#rangeId").val(source.rangeId);
            }

            if (!(source.rangeName == null || source.rangeName == undefined || source.rangeName == '')) {
                $("#rangeName").val(source.rangeName);
            }
        }


        function initSourceFromAjax(data) {
            var source = {
                "neNames": data.NENAME,
                "eomsOrderId": data.EOMSORDERID,
                "eomsOrderTitle": data.WO_TITLE,
                "typeId": data.WO_TYPE,
                "typeName": data.WO_NAME,
                "typeSubId": data.WO_TYPE_SUB,
                "typeSubName": data.WO_SUB_NAME,
                "cityKey": data.CITY_KEY,
                "cityName": data.CITY,
                "rangeName": data.WO_RANGE,
                "neType": data.WO_NETYPE,
                "sendWay": data.WO_SEND_WAY,
                "content": data.WO_CONTENT,
                "fileName": data.FILE_NAME,
                "rangeId": data.WO_RANGE_ID,
                "send_status": data.SEND_STATUS,
                "wo_id": data.WO_ID
            };
            return source;
        }

        $(document).ready(function () {
            var source;
            var woid = getQueryString("wo_id");
            if (!(woid == null || woid == undefined || woid == '')) {
                $.ajax({
                    type: 'post',
                    url: selectWorkUrl,
                    data: {
                        wo_id: woid
                    },
                    dataType: 'json',
                    success: function (data) {
                        source = initSourceFromAjax(data);
                        rangeInput(source);
                        if (source.send_status == 1 || source.send_status == 2) {
                            $("#saveBtn").hide();
                            $("#submitBtn").hide();
                        }
                    },
                });
            } else {

                var source = initSource();
                rangeInput(source);

            }


            $("#submitBtn").click(function () {
                if(!checkInput()){
                    return;
                }
                source.content = $("#content").val();
                $.ajax({
                    type: 'post',
                    url: workAddUrl,
                    data: {
                        wo_id: $("#wo_id").val(),
                        neNames: $("#neNames").val(),
                        eomsOrderTitle: $("#eomsOrderTitle").val(),
                        typeId: $("#typeId").val(),
                        typeName: $("#typeName").val(),
                        typeSubId: $("#typeSubId").val(),
                        typeSubName: $("#typeSubName").val(),
                        cityKey: $("#cityKey").val(),
                        cityName: $("#cityName").val(),
                        rangeId: $("#rangeId").val(),
                        rangeName: $("#rangeName").val(),
                        neType: $("#neType").val(),
                        sendWay: $("#sendWay").val(),
                        content: $("#content").val(),
                        fileName: $("#fileName").html(),
                        sendStatus: 1,
                        eomsOrderId: $("#eomsOrderId").val()
                    },
                    dataType: 'json',
                    success: function (data) {
                        $("#wo_id").val(data.workId);
                        alert("工单提交成功！");
                        $("#submitBtn").hide();
                        $("#saveBtn").hide();
                    },
                    error: function () {
                        alert("工单提交失败！");
                    }
                });
            });

            $("#saveBtn").click(function () {
                if(!checkInput()){
                    return;
                }
                source.content = $("#content").val();
                $.ajax({
                    type: 'post',
                    url: workAddUrl,
                    data: {
                        wo_id: $("#wo_id").val(),
                        neNames: $("#neNames").val(),
                        eomsOrderTitle: $("#eomsOrderTitle").val(),
                        typeId: $("#typeId").val(),
                        typeName: $("#typeName").val(),
                        typeSubId: $("#typeSubId").val(),
                        typeSubName: $("#typeSubName").val(),
                        cityKey: $("#cityKey").val(),
                        cityName: $("#cityName").val(),
                        rangeId: $("#rangeId").val(),
                        rangeName: $("#rangeName").val(),
                        neType: $("#neType").val(),
                        sendWay: $("#sendWay").val(),
                        content: $("#content").val(),
                        fileName: $("#fileName").html(),
                        sendStatus: 0,
                        eomsOrderId: $("#eomsOrderId").val()
                    },
                    dataType: 'json',
                    success: function (data) {
                        $("#wo_id").val(data.workId);
                        alert("工单保存成功！");
                    },
                    error: function () {
                        alert("工单保存失败！");
                    }
                });
            });

        });
        function checkInput() {
            if ($("#rangeLabel").html() == "问题对象") {
                alert("请选择问题对象");
                return false;
            }else{
                return true;
            }
        }
    </script>
</head>
<body>
<div class="padding-30">
    <div class="animated fadeInDown pr">
        <div class="inlininput mr10">
            <label class="S-label">任务主题</label>
            <input id="eomsOrderTitle" type="text" class="w500" placeholder="" value="" maxlength="11">
        </div>
    </div>
    <div class="animated fadeInDown pr">
        <div class="inlininput mr10">
            <label class="S-label">任务大类</label>
            <input id="typeName" type="text" style="width: 204px;" placeholder="" value="" maxlength="11">
        </div>
        <div class="inlininput mr10">
            <label class="S-label">任务子类</label>
            <input id="typeSubName" type="text" style="width: 204px;" placeholder="" value="" maxlength="11">
        </div>
    </div>
    <div class="animated fadeInDown pr">
        <div class="inlininput mr10">
            <label class="S-label">地市</label>

            <input id="cityName" type="text" style="width: 204px;" placeholder="" value="" maxlength="11">
        </div>
        <div class="sel_wrap mb10 mr10" style="width: 280px;">
            <label id="rangeLabel">问题对象</label>
            <span id="rangeSelect"><input id="rangeName" name="RangeName" type="text" readonly="readonly"/></span>
            <a class="sel-link"><i class="icon-arrow"></i></a>
        </div>
    </div>
    <div class="animated fadeInDown pr">
        <div class="inlininput mr10">
            <label class="S-label">任务处理对象</label>
            <input id="neType" type="text" style="padding-left: 98px;width: 177px;" placeholder="" value=""
                   maxlength="11">
        </div>
        <div class="inlininput mr10">
            <label class="S-label">派单方式</label>
            <input id="sendWay" type="text" style="width: 204px;" placeholder="" value="" maxlength="11">
        </div>
    </div>

    <div class="animated fadeInDown pr">
        <div class="inlininput mr10">
            <label class="S-label">派单内容</label>
            <textarea id="content" name="Content"
                      style="width: 563px; height: 180px; padding: 29px 7px 7px 7px;"></textarea>
        </div>
    </div>

    <div class="animated fadeInDown pr" style="height: 35px;margin: 10px 0;">
        <div class="inlininput mr10 w500">
            <label class="S-label">附件名称:</label>
            <a href="#" id="fileName" style="margin-left: 75px;line-height: 35px;">无附件</a>
        </div>
    </div>

    <div class="animated fadeInDown pr">
        <input id="saveBtn" type="button" value="保存" class="myButton btn btn-primary"/>&nbsp;&nbsp;
        <input id="submitBtn" type="button" value="提交" class="myButton btn btn-danger"/>
    </div>

    <input type="hidden" id="eomsOrderId" name="EomsOrderID">
    <input type="hidden" id="cityKey" name="CityKey">
    <input type="hidden" id="typeId" name="TypeID">
    <input type="hidden" id="typeSubId" name="TypeSubID">
    <input type="hidden" id="rangeId" name="RangeID">
    <input type="hidden" id="wo_id" name="wo_id">
    <input type="hidden" id="neNames" name="neNames">
</div>
</body>
</html>
