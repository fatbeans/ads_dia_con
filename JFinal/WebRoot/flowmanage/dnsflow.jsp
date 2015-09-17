<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html >
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>信令查询</title>
    <!-- 基础css样式 -->
    <link rel="stylesheet" type="text/css" href="../content/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../content/css/bootstrap-responsive.css">
    <!-- 页面样式 -->
    <link href="../content/css/content.css" rel="stylesheet">
    <link href="../content/css/animate.css" rel="stylesheet">

    <!--jqgrid样式-->
    <link type="text/css" rel="stylesheet" href="../content/jqGrid/css/jquery-ui-1.7.1.custom.css">
    <link type="text/css" rel="stylesheet" href="../content/jqGrid/css/ui.jqgrid.css">
    <link rel="stylesheet" type="text/css" href="../content/css/Frame.css">
    <script type="text/javascript" src="../content/js/jquery.js"></script>
    <script type="text/javascript" src="../My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="/content/js/icheck.min.js"></script>
    <script type="text/javascript" src="../content/js/bootstrap.js"></script>

	<%--<!-- 滚动条模拟组件 -->--%>
	<script type="text/javascript" src="../content/js/mousewheel.js"></script>
	<script type="text/javascript" src="../content/js/easyscroll.js"></script>
	
	<!-- 自定义checkbox样式 -->
	<link href="/content/js/skins/square/blue.css" rel="stylesheet">

	<script type="text/javascript" src="/content/js/artcloudui/artcloudui.dialog.js"></script>
	<link rel="stylesheet" href="/content/js/artcloudui/skins/gray/css/artcloudui.css" >
    <script type="text/javascript" src="/flowmanage/script/flow.js"></script>
    <script type="text/javascript" >
    	$(function(){
    		var menuli=$("#js-villageinfo-list").children("li");
    		menuli.removeClass("active");
    		menuli.eq(3).addClass("active");
    	});
    </script>
</head>
<body>
	<%@ include file="../menu.html" %>
	<div class="content" id="content" style="overflow:auto">
		<div class="ml15 mr15 div-open">
			<!-- 页面功能标题-s -->
        <h1 class="page-title borderbottom animated fadeInDown mb15"><i class="t-icon mr10"></i><span class="text-blue vm">流程</span></h1>
        <!-- 页面功能标题-e -->
        <!-- 右边数据-s -->
        <div class="w fr">
            <div class="col-2-r320">
                <div class="panel panel-default animated fadeInRight" style="text-align: center;padding-top: 40px;padding-bottom: 40px;overflow-x: auto;">
					<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:ev="http://www.w3.org/2001/xml-events"
		xmlns:v="http://schemas.microsoft.com/visio/2003/SVGExtensions/" width="10.1711in" height="5.10778in"
		viewBox="0 0 732.321 367.76" xml:space="preserve" color-interpolation-filters="sRGB" class="st13">
	<v:documentProperties v:langID="2052" v:metric="true" v:viewMarkup="false"/>

	<style type="text/css">
	<![CDATA[
		.st1 {visibility:visible}
		.st2 {fill:#000000;fill-opacity:0.4;filter:url(#filter_3.3333334922791);stroke:#000000;stroke-linecap:round;stroke-linejoin:round;stroke-opacity:0.4}
		.st3 {fill:#76c1e7;stroke:#feffff;stroke-linecap:round;stroke-linejoin:round;stroke-opacity:0.6;stroke-width:1}
		.st4 {fill:#000000;font-family:微软雅黑;font-size:0.833336em}
		.st5 {marker-end:url(#mrkr2-21);marker-start:url(#mrkr11-19);stroke:#000000;stroke-linecap:round;stroke-linejoin:round;stroke-width:1.25}
		.st6 {fill:#000000;fill-opacity:1;stroke:#000000;stroke-opacity:1;stroke-width:0.46468401486989}
		.st7 {fill:#000000;fill-opacity:1;stroke:#000000;stroke-opacity:1;stroke-width:0.27839643652561}
		.st8 {fill:none;stroke:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:1}
		.st9 {fill:#d19049;font-family:微软雅黑;font-size:0.833336em;font-weight:bold}
		.st10 {font-size:1em}
		.st11 {fill:#ffffff;stroke:none;stroke-linecap:butt;stroke-width:7.2}
		.st12 {fill:#000000;font-family:黑体;font-size:0.666664em}
		.st13 {fill:none;fill-rule:evenodd;font-size:12px;overflow:visible;stroke-linecap:square;stroke-miterlimit:3}
	]]>
	</style>

	<defs id="Markers">
		<g id="lend11">
			<path d="M 0.75 -0.75 L 0.75 0.75 L -0.75 0.75 L -0.75 -0.75 L 0.75 -0.75 " style="stroke:none"/>
		</g>
		<marker id="mrkr11-19" class="st6" v:arrowType="11" v:arrowSize="0" v:setback="1.326" refX="1.326" orient="auto"
				markerUnits="strokeWidth" overflow="visible">
			<use xlink:href="#lend11" transform="scale(2.152) "/>
		</marker>
		<g id="lend2">
			<path d="M 1 1 L 0 0 L 1 -1 L 1 1 " style="stroke:none"/>
		</g>
		<marker id="mrkr2-21" class="st7" v:arrowType="2" v:arrowSize="3" v:setback="3.592" refX="-3.592" orient="auto"
				markerUnits="strokeWidth" overflow="visible">
			<use xlink:href="#lend2" transform="scale(-3.592,-3.592) "/>
		</marker>
	</defs>
	<defs id="Filters">
		<filter id="filter_3.3333334922791">
			<feGaussianBlur stdDeviation="3.3333334922791"/>
		</filter>
	</defs>
	<g v:mID="0" v:index="1" v:groupContext="foregroundPage">
		<title>页-1</title>
		<v:pageProperties v:drawingScale="0.0393701" v:pageScale="0.0393701" v:drawingUnits="24" v:shadowOffsetX="8.50394"
				v:shadowOffsetY="-8.50394"/>
		<v:layer v:name="连接线" v:index="0"/>
		<g id="shape1-1" v:mID="1" v:groupContext="shape" transform="translate(346.913,-339.346)">
			<title>开始</title>
			<desc>开始</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="33.5197" cy="356.422" width="67.04" height="22.6772"/>
			<g id="shadow1-2" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.670394,-7.12844)" class="st1">
				<path d="M0 356.42 A33.5197 11.3386 0 1 1 67.04 356.42 A33.5197 11.3386 0 1 1 0 356.42 Z" class="st2"/>
			</g>
			<path d="M0 356.42 A33.5197 11.3386 0 1 1 67.04 356.42 A33.5197 11.3386 0 1 1 0 356.42 Z" class="st3"/>
			<text x="23.52" y="359.42" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>开始</text>		</g>
		<g id="shape3-7" v:mID="3" v:groupContext="shape" transform="translate(330.826,-303.205)">
			<title>DNS详单</title>
			<desc>DNS详单</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="49.6063" cy="356.422" width="99.22" height="22.6772"/>
			<g id="shadow3-8" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.992126,-7.12844)" class="st1">
				<rect x="0" y="345.083" width="99.2126" height="22.6772" class="st2"/>
			</g>
			<rect x="0" y="345.083" width="99.2126" height="22.6772" class="st3"/>
			<text x="28.85" y="359.42" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>DNS详单</text>		</g>
		<g id="shape4-13" v:mID="4" v:groupContext="shape" v:layerMember="0" transform="translate(373.346,-339.701)">
			<title></title>
			<path d="M7.09 369.77 L7.09 370.13 L7.09 377.09" class="st5"/>
		</g>
		<g id="shape6-22" v:mID="6" v:groupContext="shape" v:layerMember="0" transform="translate(373.528,-303.205)">
			<title></title>
			<path d="M6.94 369.42 L6.95 369.78 L7.18 381.13" class="st5"/>
		</g>
		<g id="shape7-29" v:mID="7" v:groupContext="shape" transform="translate(425.888,-270.606)">
			<title></title>
			<rect x="0" y="345.083" width="85.0394" height="22.6772" class="st8"/>
		</g>
		<g id="shape8-31" v:mID="8" v:groupContext="shape" transform="translate(428.854,-303.205)">
			<title></title>
			<desc>R:dnsxd</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="33.5197" cy="356.422" width="67.04" height="22.6772"/>
			<rect x="0" y="345.083" width="67.0394" height="22.6772" class="st8"/>
			<text x="13.32" y="359.42" class="st9" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>R:dnsxd</text>		</g>
		<g id="shape9-34" v:mID="9" v:groupContext="shape" v:layerMember="0" transform="translate(373.528,-303.205)">
			<title></title>
			<path d="M6.94 369.42 L6.95 369.78 L7.18 381.13" class="st5"/>
		</g>
		<g id="shape11-41" v:mID="11" v:groupContext="shape" transform="translate(128.25,-220.15)">
			<title>DNS解析失败分析</title>
			<desc>DNS解析失败分析</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="49.6063" cy="356.422" width="99.22" height="22.6772"/>
			<g id="shadow11-42" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.992126,-7.12844)" class="st1">
				<rect x="0" y="345.083" width="99.2126" height="22.6772" class="st2"/>
			</g>
			<rect x="0" y="345.083" width="99.2126" height="22.6772" class="st3"/>
			<text x="8.85" y="359.42" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>DNS解析失败分析</text>		</g>
		<g id="shape12-47" v:mID="12" v:groupContext="shape" transform="translate(563.368,-220.15)">
			<title>DNS时延分析</title>
			<desc>DNS时延分析</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="49.6063" cy="356.422" width="99.22" height="22.6772"/>
			<g id="shadow12-48" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.992126,-7.12844)" class="st1">
				<rect x="0" y="345.083" width="99.2126" height="22.6772" class="st2"/>
			</g>
			<rect x="0" y="345.083" width="99.2126" height="22.6772" class="st3"/>
			<text x="18.85" y="359.42" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>DNS时延分析</text>		</g>
		<g id="shape17-53" v:mID="17" v:groupContext="shape" transform="translate(6.36039,-28.811)">
			<title>DNS格式错误</title>
			<desc>DNS格式错误</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="351.461" width="85.04" height="32.5984"/>
			<g id="shadow17-54" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-7.02922)" class="st1">
				<rect x="0" y="335.162" width="85.0394" height="32.5984" class="st2"/>
			</g>
			<rect x="0" y="335.162" width="85.0394" height="32.5984" class="st3"/>
			<text x="11.76" y="354.46" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>DNS格式错误</text>		</g>
		<g id="shape20-59" v:mID="20" v:groupContext="shape" transform="translate(97.0691,-28.811)">
			<title>DNS服务器 出错</title>
			<desc>DNS服务器 出错</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="351.461" width="85.04" height="32.5984"/>
			<g id="shadow20-60" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-7.02922)" class="st1">
				<rect x="0" y="335.162" width="85.0394" height="32.5984" class="st2"/>
			</g>
			<rect x="0" y="335.162" width="85.0394" height="32.5984" class="st3"/>
			<text x="16.76" y="348.46" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>DNS服务器<v:newlineChar/><tspan
						x="32.52" dy="1.2em" class="st10">出错</tspan></text>		</g>
		<g id="shape25-66" v:mID="25" v:groupContext="shape" transform="translate(187.778,-28.811)">
			<title>DNS请求的 域名错误</title>
			<desc>DNS请求的 域名错误</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="351.461" width="85.04" height="32.5984"/>
			<g id="shadow25-67" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-7.02922)" class="st1">
				<rect x="0" y="335.162" width="85.0394" height="32.5984" class="st2"/>
			</g>
			<rect x="0" y="335.162" width="85.0394" height="32.5984" class="st3"/>
			<text x="16.76" y="348.46" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>DNS请求的<v:newlineChar/><tspan
						x="22.52" dy="1.2em" class="st10">域名错误</tspan></text>		</g>
		<g id="shape59-73" v:mID="59" v:groupContext="shape" transform="translate(6.36039,-0.5)">
			<title></title>
			<desc>CON:10030006</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="356.422" width="85.04" height="22.6772"/>
			<rect x="0" y="345.083" width="85.0394" height="22.6772" class="st8"/>
			<text id="10030006" x="4.72" y="359.42" class="st9 conclusionPanel" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/><tspan>CON:10030006</tspan></text>		</g>
		<g id="shape60-76" v:mID="60" v:groupContext="shape" transform="translate(97.0691,-0.5)">
			<title></title>
			<desc>CON:10020005</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="356.422" width="85.04" height="22.6772"/>
			<rect x="0" y="345.083" width="85.0394" height="22.6772" class="st8"/>
			<text id="10020005" x="4.72" y="359.42" class="st9 conclusionPanel" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/><tspan>CON:10020005</tspan></text>		</g>
		<g id="shape61-79" v:mID="61" v:groupContext="shape" transform="translate(187.778,-0.5)">
			<title></title>
			<desc>CON:10030007</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="356.422" width="85.04" height="22.6772"/>
			<rect x="0" y="345.083" width="85.0394" height="22.6772" class="st8"/>
			<text id="10030007" x="4.72" y="359.42" class="st9 conclusionPanel" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/><tspan>CON:10030007</tspan></text>		</g>
		<g id="shape68-82" v:mID="68" v:groupContext="shape" transform="translate(303.209,-235.811)">
			<title>任意一类失败响应码次数&#62;=3次</title>
			<desc>任意一类失败响应码次数&#62;=3次</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:prompt="" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="77.5883" cy="342.993" width="155.18" height="49.5354"/>
			<g id="shadow68-83" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-1.55177,-6.85985)" class="st1">
				<path d="M77.59 367.76 L155.18 342.99 L77.59 318.22 L0 342.99 L77.59 367.76 Z" class="st2"/>
			</g>
			<path d="M77.59 367.76 L155.18 342.99 L77.59 318.22 L0 342.99 L77.59 367.76 Z" class="st3"/>
			<text x="7.24" y="345.99" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>任意一类失败响应码次数&#62;=3次</text>		</g>
		<g id="shape70-88" v:mID="70" v:groupContext="shape" v:layerMember="0" transform="translate(303.209,-260.579)">
			<title></title>
			<desc>是</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="-70.234" cy="367.76" width="40" height="18.6536"/>
			<path d="M-1.66 367.76 L-2.02 367.76 L-120.85 367.76 A4.5 4.5 -180 0 0 -125.35 372.26 L-125.35 381.02" class="st5"/>
			<rect v:rectContext="textBkgnd" x="-74.2341" y="362.436" width="7.99997" height="10.6501" class="st11"/>
			<text x="-74.23" y="370.42" class="st12" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是</text>		</g>
		<g id="shape71-97" v:mID="71" v:groupContext="shape" v:layerMember="0" transform="translate(458.385,-260.579)">
			<title></title>
			<desc>否</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="84.8527" cy="367.76" width="40" height="18.6536"/>
			<path d="M1.66 367.76 L2.02 367.76 L150.09 367.76 A4.5 4.5 0 0 1 154.59 372.26 L154.59 381.02" class="st5"/>
			<rect v:rectContext="textBkgnd" x="80.8526" y="362.436" width="7.99997" height="10.6501" class="st11"/>
			<text x="80.85" y="370.42" class="st12" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>否</text>		</g>
		<g id="shape73-106" v:mID="73" v:groupContext="shape" transform="translate(6.36039,-113.921)">
			<title>错误码#1&#62;=3次</title>
			<desc>错误码#1&#62;=3次</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:prompt="" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="342.993" width="85.04" height="49.5354"/>
			<g id="shadow73-107" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-6.85985)" class="st1">
				<path d="M42.52 367.76 L85.04 342.99 L42.52 318.22 L0 342.99 L42.52 367.76 Z" class="st2"/>
			</g>
			<path d="M42.52 367.76 L85.04 342.99 L42.52 318.22 L0 342.99 L42.52 367.76 Z" class="st3"/>
			<text x="6.05" y="345.99" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>错误码#1&#62;=3次</text>		</g>
		<g id="shape74-112" v:mID="74" v:groupContext="shape" v:layerMember="0" transform="translate(177.856,-220.15)">
			<title>动态连接线.74</title>
			<path d="M0 369.42 L0 369.78 L0 387.64 A4.5 4.5 0 0 1 -4.5 392.14 L-124.48 392.14 A4.5 4.5 -180 0 0 -128.98 396.64 L-128.98
						 419.96" class="st5"/>
		</g>
		<g id="shape75-119" v:mID="75" v:groupContext="shape" v:layerMember="0" transform="translate(41.7935,-113.921)">
			<title></title>
			<desc>是</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="7.08661" cy="394.016" width="40" height="18.6536"/>
			<path d="M7.09 369.42 L7.09 369.78 L7.09 415.78" class="st5"/>
			<rect v:rectContext="textBkgnd" x="3.08655" y="388.692" width="7.99997" height="10.6501" class="st11"/>
			<text x="3.09" y="396.68" class="st12" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是</text>		</g>
		<g id="shape77-128" v:mID="77" v:groupContext="shape" transform="translate(97.0691,-113.921)">
			<title>错误码#2&#62;=3次</title>
			<desc>错误码#2&#62;=3次</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:prompt="" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="342.993" width="85.04" height="49.5354"/>
			<g id="shadow77-129" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-6.85985)" class="st1">
				<path d="M42.52 367.76 L85.04 342.99 L42.52 318.22 L0 342.99 L42.52 367.76 Z" class="st2"/>
			</g>
			<path d="M42.52 367.76 L85.04 342.99 L42.52 318.22 L0 342.99 L42.52 367.76 Z" class="st3"/>
			<text x="6.05" y="345.99" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>错误码#2&#62;=3次</text>		</g>
		<g id="shape78-134" v:mID="78" v:groupContext="shape" transform="translate(187.778,-113.921)">
			<title>错误码#3&#62;=3次</title>
			<desc>错误码#3&#62;=3次</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:prompt="" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="342.993" width="85.04" height="49.5354"/>
			<g id="shadow78-135" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-6.85985)" class="st1">
				<path d="M42.52 367.76 L85.04 342.99 L42.52 318.22 L0 342.99 L42.52 367.76 Z" class="st2"/>
			</g>
			<path d="M42.52 367.76 L85.04 342.99 L42.52 318.22 L0 342.99 L42.52 367.76 Z" class="st3"/>
			<text x="6.05" y="345.99" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>错误码#3&#62;=3次</text>		</g>
		<g id="shape79-140" v:mID="79" v:groupContext="shape" transform="translate(278.486,-113.921)">
			<title>错误码#4&#62;=3次</title>
			<desc>错误码#4&#62;=3次</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:prompt="" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="342.993" width="85.04" height="49.5354"/>
			<g id="shadow79-141" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-6.85985)" class="st1">
				<path d="M42.52 367.76 L85.04 342.99 L42.52 318.22 L0 342.99 L42.52 367.76 Z" class="st2"/>
			</g>
			<path d="M42.52 367.76 L85.04 342.99 L42.52 318.22 L0 342.99 L42.52 367.76 Z" class="st3"/>
			<text x="6.05" y="345.99" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>错误码#4&#62;=3次</text>		</g>
		<g id="shape80-146" v:mID="80" v:groupContext="shape" transform="translate(369.195,-113.921)">
			<title>错误码#5&#62;=3次</title>
			<desc>错误码#5&#62;=3次</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:prompt="" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="342.993" width="85.04" height="49.5354"/>
			<g id="shadow80-147" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-6.85985)" class="st1">
				<path d="M42.52 367.76 L85.04 342.99 L42.52 318.22 L0 342.99 L42.52 367.76 Z" class="st2"/>
			</g>
			<path d="M42.52 367.76 L85.04 342.99 L42.52 318.22 L0 342.99 L42.52 367.76 Z" class="st3"/>
			<text x="6.05" y="345.99" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>错误码#5&#62;=3次</text>		</g>
		<g id="shape81-152" v:mID="81" v:groupContext="shape" transform="translate(278.486,-28.811)">
			<title>DNS域名服务器不支持请求的类型</title>
			<desc>DNS域名服务器不支持请求的类型</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="351.461" width="85.04" height="32.5984"/>
			<g id="shadow81-153" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-7.02922)" class="st1">
				<rect x="0" y="335.162" width="85.0394" height="32.5984" class="st2"/>
			</g>
			<rect x="0" y="335.162" width="85.0394" height="32.5984" class="st3"/>
			<text x="6.76" y="342.46" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>DNS域名服务器<tspan
						x="7.52" dy="1.2em" class="st10">不支持请求的类</tspan><tspan x="37.52" dy="1.2em" class="st10">型</tspan></text>		</g>
		<g id="shape82-160" v:mID="82" v:groupContext="shape" transform="translate(369.195,-28.811)">
			<title>DNS拒绝服务</title>
			<desc>DNS拒绝服务</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="351.461" width="85.04" height="32.5984"/>
			<g id="shadow82-161" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-7.02922)" class="st1">
				<rect x="0" y="335.162" width="85.0394" height="32.5984" class="st2"/>
			</g>
			<rect x="0" y="335.162" width="85.0394" height="32.5984" class="st3"/>
			<text x="11.76" y="354.46" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>DNS拒绝服务</text>		</g>
		<g id="shape83-166" v:mID="83" v:groupContext="shape" v:layerMember="0" transform="translate(177.856,-220.15)">
			<title></title>
			<path d="M0 369.42 L0 369.78 L0 387.64 A4.5 4.5 0 0 1 -4.5 392.14 L-33.77 392.14 A4.5 4.5 -180 0 0 -38.27 396.64 L-38.27
						 419.96" class="st5"/>
		</g>
		<g id="shape84-173" v:mID="84" v:groupContext="shape" v:layerMember="0" transform="translate(177.856,-220.15)">
			<title></title>
			<path d="M0 369.42 L0 369.78 L0 388.06 A4.5 4.5 -180 0 0 4.5 392.56 L47.94 392.56 A4.5 4.5 0 0 1 52.44 397.06 L52.44
						 419.96" class="st5"/>
		</g>
		<g id="shape85-180" v:mID="85" v:groupContext="shape" v:layerMember="0" transform="translate(177.856,-220.15)">
			<title></title>
			<path d="M0 369.42 L0 369.78 L0 386.72 A4.5 4.5 -180 0 0 4.5 391.22 L138.65 391.22 A4.5 4.5 0 0 1 143.15 395.72 L143.15
						 419.96" class="st5"/>
		</g>
		<g id="shape86-187" v:mID="86" v:groupContext="shape" v:layerMember="0" transform="translate(177.856,-220.15)">
			<title></title>
			<path d="M0 369.42 L0 369.78 L0 386.72 A4.5 4.5 -180 0 0 4.5 391.22 L229.36 391.22 A4.5 4.5 0 0 1 233.86 395.72 L233.86
						 419.96" class="st5"/>
		</g>
		<g id="shape91-194" v:mID="91" v:groupContext="shape" v:layerMember="0" transform="translate(132.502,-113.921)">
			<title></title>
			<desc>是</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="7.08661" cy="394.016" width="40" height="18.6536"/>
			<path d="M7.09 369.42 L7.09 369.78 L7.09 415.78" class="st5"/>
			<rect v:rectContext="textBkgnd" x="3.08655" y="388.692" width="7.99997" height="10.6501" class="st11"/>
			<text x="3.09" y="396.68" class="st12" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是</text>		</g>
		<g id="shape92-203" v:mID="92" v:groupContext="shape" v:layerMember="0" transform="translate(223.211,-113.921)">
			<title></title>
			<desc>是</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="7.08661" cy="394.016" width="40" height="18.6536"/>
			<path d="M7.09 369.42 L7.09 369.78 L7.09 415.78" class="st5"/>
			<rect v:rectContext="textBkgnd" x="3.08655" y="388.692" width="7.99997" height="10.6501" class="st11"/>
			<text x="3.09" y="396.68" class="st12" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是</text>		</g>
		<g id="shape93-212" v:mID="93" v:groupContext="shape" v:layerMember="0" transform="translate(313.919,-113.921)">
			<title></title>
			<desc>是</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="7.08661" cy="394.016" width="40" height="18.6536"/>
			<path d="M7.09 369.42 L7.09 369.78 L7.09 415.78" class="st5"/>
			<rect v:rectContext="textBkgnd" x="3.08655" y="388.692" width="7.99997" height="10.6501" class="st11"/>
			<text x="3.09" y="396.68" class="st12" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是</text>		</g>
		<g id="shape94-221" v:mID="94" v:groupContext="shape" v:layerMember="0" transform="translate(404.628,-113.921)">
			<title></title>
			<desc>是</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="7.08661" cy="394.016" width="40" height="18.6536"/>
			<path d="M7.09 369.42 L7.09 369.78 L7.09 415.78" class="st5"/>
			<rect v:rectContext="textBkgnd" x="3.08655" y="388.692" width="7.99997" height="10.6501" class="st11"/>
			<text x="3.09" y="396.68" class="st12" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是</text>		</g>
		<g id="shape95-230" v:mID="95" v:groupContext="shape" transform="translate(278.486,-0.5)">
			<title></title>
			<desc>CON:10020006</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="356.422" width="85.04" height="22.6772"/>
			<rect x="0" y="345.083" width="85.0394" height="22.6772" class="st8"/>
			<text id="10020006" x="4.72" y="359.42" class="st9 conclusionPanel" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/><tspan>CON:10020006</tspan></text>		</g>
		<g id="shape96-233" v:mID="96" v:groupContext="shape" transform="translate(369.195,-0.5)">
			<title></title>
			<desc>CON:10020007</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="356.422" width="85.04" height="22.6772"/>
			<rect x="0" y="345.083" width="85.0394" height="22.6772" class="st8"/>
			<text id="10020007"  x="4.72" y="359.42" class="st9 conclusionPanel" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/><tspan>CON:10020007</tspan></text>		</g>
		<g id="shape97-236" v:mID="97" v:groupContext="shape" transform="translate(501.371,-114.488)">
			<title>用户请求的DNS服务器解析平均时延&#62;=4S的时段占比&#62;2%</title>
			<desc>用户请求的DNS服务器解析平均时延&#62;=4S的时段占比&#62;2%</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:prompt="" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="111.604" cy="342.993" width="223.21" height="49.5354"/>
			<g id="shadow97-237" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-2.23208,-6.85985)" class="st1">
				<path d="M111.6 367.76 L223.21 342.99 L111.6 318.22 L0 342.99 L111.6 367.76 Z" class="st2"/>
			</g>
			<path d="M111.6 367.76 L223.21 342.99 L111.6 318.22 L0 342.99 L111.6 367.76 Z" class="st3"/>
			<text x="7.61" y="339.99" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>用户请求的<tspan
						class="st10" v:langID="1033">DNS</tspan>服务器解析平均时延&#62;=4<tspan class="st10" v:langID="1033">S</tspan>的时<tspan
						x="85.52" dy="1.2em" class="st10">段占比</tspan>&#62;2%</text>		</g>
		<g id="shape98-245" v:mID="98" v:groupContext="shape" v:layerMember="0" transform="translate(605.888,-220.15)">
			<title></title>
			<path d="M7.09 369.42 L7.09 369.78 L7.09 419.4" class="st5"/>
		</g>
		<g id="shape100-252" v:mID="100" v:groupContext="shape" transform="translate(563.368,-28.811)">
			<title>DNS解析时延问题</title>
			<desc>DNS解析时延问题</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="49.6063" cy="351.461" width="99.22" height="32.5984"/>
			<g id="shadow100-253" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.992126,-7.02922)" class="st1">
				<rect x="0" y="335.162" width="99.2126" height="32.5984" class="st2"/>
			</g>
			<rect x="0" y="335.162" width="99.2126" height="32.5984" class="st3"/>
			<text x="8.85" y="354.46" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>DNS解析时延问题</text>		</g>
		<g id="shape103-258" v:mID="103" v:groupContext="shape" v:layerMember="0" transform="translate(605.888,-114.488)">
			<title></title>
			<desc>否</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="7.08661" cy="394.3" width="40" height="18.6536"/>
			<path d="M7.09 369.42 L7.09 369.78 L7.09 416.35" class="st5"/>
			<rect v:rectContext="textBkgnd" x="3.08655" y="388.975" width="7.99997" height="10.6501" class="st11"/>
			<text x="3.09" y="396.96" class="st12" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>否</text>		</g>
		<g id="shape105-267" v:mID="105" v:groupContext="shape" transform="translate(570.455,-3.33465)">
			<title></title>
			<desc>CON:10020008</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="356.422" width="85.04" height="22.6772"/>
			<rect x="0" y="345.083" width="85.0394" height="22.6772" class="st8"/>
			<text id="10020008" x="4.72" y="359.42" class="st9 conclusionPanel" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/><tspan>CON:10020008</tspan></text>		</g>
	</g>
</svg>
                </div>
            </div>
        </div>
        <!-- 右边数据-e -->
        <!-- 左边列表-s -->
        <div class="col-2-l320 fr">
            <div class="panel panel-default animated fadeInLeft">
                <%@ include file="menu.html" %>
            </div>
        </div>
        <!-- 左边列表-e -->
		</div>
	</div>
</body>
<%@ include file="../footer.html" %>

</html>