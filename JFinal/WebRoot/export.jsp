<%--
  Created by IntelliJ IDEA.
  User: xinxin
  Date: 2015/7/28
  Time: 9:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>导出文件</title>

</head>
<body style="background:#e9f1f4;">
<div id="main">文件生成中。。。。。</div>
</body>

<script type="text/javascript" src="./content/js/jquery.js"></script>
<script type="text/javascript">

    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null)return decodeURIComponent(r[2]);
        return null;
    }


    $(window).load(function () {
        var exType = getQueryString("export");
        var uri = "./user_det/export";
        var isComp = false;
        if (exType == "comp") {
            uri = "./comp/exportExcel";
            isComp = true;
        }
        $.ajax({
            type: 'POST',
            url: uri,
            data: {
                sd: getQueryString('sd'),
                ed: getQueryString('ed'),
                msisdn: getQueryString('msisdn'),
                business_class: getQueryString('business_class') == null ? "" : getQueryString("business_class")
            },
            success: function (data) {
                $("#main").html("文件已生成: <a href='" + encodeURI(
                                (isComp ? ("./comp/download?fileName=" + data) : data)) +
                        "'>点击下载</a>");
            }

        });
    })

</script>
</html>
