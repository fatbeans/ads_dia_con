<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
    <title>添加EOMS工单</title>
    <link rel="stylesheet" href="css/style.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script type="text/javascript" src="js/jquery.json-2.4.min.js"></script>
    <script type="text/javascript">

        function getQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if (r != null)return decodeURIComponent(r[2]);
            return null;
        }

        var localUrl = "${pageContext.request.contextPath}";
        var workAddUrl = localUrl + "/work/addWork";
        var downFileUrl = localUrl+"/work/downFile";
        var synchData = null;

        function initSource() {
            var source = {
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
                "rangeId": getQueryString("rangeId")
            };
            return source;
        }

        function cityInput(source) {

            if (source.cityName != null && source.cityName != undefined && source.cityName != '') {

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
                                $("#citySelect").html("<select id='cityName' name='CityName' type='text' style='width: 200px;'>" + h + "</select>");
                                $("#cityKey").val($("#cityName option:selected").attr("citykey"));
                                $("#cityName").change(function () {
                                    $("#cityKey").val($("#cityName option:selected").attr("citykey"));
                                });
                            }
                        },
                        error: function () {
                            alert("获取地市错误");
                        }
                });
            }
        }

        function rangeInput(source) {

            if (source.rangeName != null && source.rangeName != undefined && source.rangeName != '') {

            } else {
                $.ajax({
                    url: getQueryString("test") == "true" ? "./citySelectTest.json" : "./work/getRange",
                    type: "post",
                    data: {workJson: $.toJSON(synchData)},
                    dataType: 'json',
                    success: function (data) {

//                        jsonObject.put("rangeid", resultSet.getString(1));
//                        jsonObject.put("rangename", resultSet.getString(2));
                        var h = "";
                        for (var i = 0; i < data.length; i++) {
                            h += "<option rangekey='" + data[i].rangeid + "' value ='" + data[i].rangename + "'>" +
                                    data[i].rangename + "</option> ";
                            $("#rangeSelect").html("<select id='rangeName' name='RangeName' type='text' style='width: 200px;'>" + h + "</select>");
                            $("#rangeId").val($("#rangeName option:selected").attr("rangekey"));
                            $("#rangeName").change(function () {
                                $("#rangeId").val($("#rangeName option:selected").attr("rangekey"));
                            });
                        }
                    },
                    error: function () {
                        alert("获取问题对象列表数据错误");
                    }
                });
            }
        }


        $(document).ready(function () {
            var source = initSource(source);
            cityInput(source);
            rangeInput(source);
            $("#eomsOrderTitle").val(source.eomsOrderTitle);
            $("#typeName").val(source.typeName);
            $("#typeSubName").val(source.typeSubName);
            $("#cityName").val(source.cityName);
            $("#rangeName").val(source.rangeName);
            $("#neType").val(source.neType);
            $("#sendWay").val(source.sendWay);
            $("#content").val(source.content);
            $("#eomsOrderId").val(source.eomsOrderId);
            $("#cityKey").val(source.cityKey);
            $("#typeId").val(source.typeId);
            $("#typeSubId").val(source.typeSubId);
            $("#rangeId").val(source.rangeId);
            if(!(source.fileName==null || source.fileName==undefined||source.fileName=='')){
                $("#fileName").html(source.fileName);
                $("#fileName").attr("href", downFileUrl+"?fileName="+source.fileName);
            }



            if (source.woType != null) {
                synchData = {
                    "woType": source.woType,
                    "woTime": source.time,
                    "woCityKey": source.cityKey,
                    "woCity": source.cityName,
                    "woRangeId": source.rangeId,
                    "woRange": source.rangeName,
                    "woObjId": source.objIds,
                    "woObjName": source.objNames
                };
                delete source.woType;
                delete source.time;
                delete source.objIds;
                delete source.objNames;
            }

            $("#submitBtn").click(function () {
                source.content = $("#content").val();
                $.ajax({
                    type: 'post',
                    url: workAddUrl,
                    data: {
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
                        eomsOrderId: $("#eomsOrderId").val()
                    },
                    dataType: 'json',
                    success: function (data) {
                        alert("工单添加成功！");
                    },
                    error: function () {

                    }
                });
            });

        });
    </script>
</head>
<body>
<table class="conditionTable">
    <tr>
        <td class="title">任务主题:</td>
        <td colspan="3"><input id="eomsOrderTitle"
                               name="EomsOrderTitle" type="text" style="width: 508px;"/></td>
    </tr>
    <tr>
        <td class="title">任务大类:</td>
        <td><input id="typeName" name="TypeName" type="text"
                   style="width: 200px;"/></td>
        <td class="title">任务子类:</td>
        <td><input id="typeSubName" name="TypeSubName" type="text"
                   style="width: 200px;"/></td>
    <tr>
    <tr>
        <td class="title">地市:</td>
        <td id="citySelect"><input id="cityName" name="CityName" type="text"
                                   style="width: 200px;" readonly="readonly"/></td>
        <td class="title">问题对象:</td>
        <td id="rangeSelect"><input id="rangeName" name="RangeName" type="text"
                   style="width: 200px;" readonly="readonly"/></td>
    <tr>
    <tr>
        <td class="title">任务处理对象:</td>
        <td><input id="neType" name="NetType" type="text"
                   style="width: 200px;"/></td>
        <td class="title">派单方式:</td>
        <td><input id="sendWay" name="SendWay" type="text"
                   style="width: 200px;"/></td>
    <tr>
    <tr>
        <td class="title">派单内容:</td>
        <td colspan="3"><textarea id="content" name="Content"
                                  style="width: 508px; height: 100px;"></textarea></td>
    </tr>
    <tr>
        <td class="title">附件名称:</td>
        <td colspan="3"><a id="fileName" tyle="width: 200px;color:blue;cursor:pointer;">无附件</a></td>
    <tr>
    <tr>
        <td colspan="4" style="text-align: center;"><input
                id="submitBtn" type="button" value="提交" class="myButton"/>
    </tr>
</table>
<input type="hidden" id="eomsOrderId" name="EomsOrderID">
<input type="hidden" id="cityKey" name="CityKey">
<input type="hidden" id="typeId" name="TypeID">
<input type="hidden" id="typeSubId" name="TypeSubID">
<input type="hidden" id="rangeId" name="RangeID">
</body>
</html>