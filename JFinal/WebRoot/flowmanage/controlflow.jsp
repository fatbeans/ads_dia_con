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
    		menuli.eq(1).addClass("active");
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
					<div style="width:1103">
						<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:ev="http://www.w3.org/2001/xml-events"
		xmlns:v="http://schemas.microsoft.com/visio/2003/SVGExtensions/" width="11.4851in" height="7.04872in"
		viewBox="0 0 826.93 507.508" xml:space="preserve" color-interpolation-filters="sRGB" class="st21">
	<v:documentProperties v:langID="2052" v:metric="true" v:viewMarkup="false"/>

	<style type="text/css">
	<![CDATA[
		.st1 {visibility:visible}
		.st2 {fill:#000000;fill-opacity:0.4;filter:url(#filter_3.3333334922791);stroke:#000000;stroke-linecap:round;stroke-linejoin:round;stroke-opacity:0.4}
		.st3 {fill:#76c1e7;stroke:#feffff;stroke-linecap:round;stroke-linejoin:round;stroke-opacity:0.6;stroke-width:1}
		.st4 {fill:#000000;font-family:微软雅黑;font-size:0.833336em}
		.st5 {fill:none;filter:url(#filter_3.3333334922791);marker-end:url(#mrkr2-47);marker-start:url(#mrkr11-45);stroke:#000000;stroke-linecap:round;stroke-linejoin:round;stroke-opacity:0.4}
		.st6 {fill:#000000;fill-opacity:0.4;stroke:#000000;stroke-opacity:0.4;stroke-width:0.46468401486989}
		.st7 {fill:#000000;fill-opacity:0.4;stroke:#000000;stroke-opacity:0.4;stroke-width:0.27839643652561}
		.st8 {marker-end:url(#mrkr2-56);marker-start:url(#mrkr11-54);stroke:#135f87;stroke-linecap:round;stroke-linejoin:round;stroke-width:1.25}
		.st9 {fill:#135f87;fill-opacity:1;stroke:#135f87;stroke-opacity:1;stroke-width:0.46468401486989}
		.st10 {fill:#135f87;fill-opacity:1;stroke:#135f87;stroke-opacity:1;stroke-width:0.27839643652561}
		.st11 {fill:#d8d8d8;stroke:#a5a5a5;stroke-linecap:round;stroke-linejoin:round;stroke-opacity:0.6;stroke-width:1}
		.st12 {fill:#7f7f7f;font-family:微软雅黑;font-size:0.833336em}
		.st13 {fill:none;stroke:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:1}
		.st14 {fill:#5a74d1;font-family:微软雅黑;font-size:0.833336em;font-weight:bold}
		.st15 {fill:#ffffff;stroke:none;stroke-linecap:butt;stroke-width:7.2}
		.st16 {fill:#ffffff;stroke:none;stroke-linecap:butt}
		.st17 {font-size:1em}
		.st18 {marker-end:url(#mrkr2-914);marker-start:url(#mrkr11-912);stroke:#6699c2;stroke-linecap:round;stroke-linejoin:round;stroke-width:1.25}
		.st19 {fill:#6699c2;fill-opacity:1;stroke:#6699c2;stroke-opacity:1;stroke-width:0.46468401486989}
		.st20 {fill:#6699c2;fill-opacity:1;stroke:#6699c2;stroke-opacity:1;stroke-width:0.27839643652561}
		.st21 {fill:none;fill-rule:evenodd;font-size:12px;overflow:visible;stroke-linecap:square;stroke-miterlimit:3}
	]]>
	</style>

	<defs id="Markers">
		<g id="lend11">
			<path d="M 0.75 -0.75 L 0.75 0.75 L -0.75 0.75 L -0.75 -0.75 L 0.75 -0.75 " style="stroke:none"/>
		</g>
		<marker id="mrkr11-45" class="st6" v:arrowType="11" v:arrowSize="0" v:setback="1.326" refX="1.326" orient="auto"
				markerUnits="strokeWidth" overflow="visible">
			<use xlink:href="#lend11" transform="scale(2.152) "/>
		</marker>
		<g id="lend2">
			<path d="M 1 1 L 0 0 L 1 -1 L 1 1 " style="stroke:none"/>
		</g>
		<marker id="mrkr2-47" class="st7" v:arrowType="2" v:arrowSize="3" v:setback="3.592" refX="-3.592" orient="auto"
				markerUnits="strokeWidth" overflow="visible">
			<use xlink:href="#lend2" transform="scale(-3.592,-3.592) "/>
		</marker>
		<marker id="mrkr11-54" class="st9" v:arrowType="11" v:arrowSize="0" v:setback="1.326" refX="1.326" orient="auto"
				markerUnits="strokeWidth" overflow="visible">
			<use xlink:href="#lend11" transform="scale(2.152) "/>
		</marker>
		<marker id="mrkr2-56" class="st10" v:arrowType="2" v:arrowSize="3" v:setback="3.592" refX="-3.592" orient="auto"
				markerUnits="strokeWidth" overflow="visible">
			<use xlink:href="#lend2" transform="scale(-3.592,-3.592) "/>
		</marker>
		<marker id="mrkr11-912" class="st19" v:arrowType="11" v:arrowSize="0" v:setback="1.326" refX="1.326" orient="auto"
				markerUnits="strokeWidth" overflow="visible">
			<use xlink:href="#lend11" transform="scale(2.152) "/>
		</marker>
		<marker id="mrkr2-914" class="st20" v:arrowType="2" v:arrowSize="3" v:setback="3.592" refX="-3.592" orient="auto"
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
		<title></title>
		<v:pageProperties v:drawingScale="0.0393701" v:pageScale="0.0393701" v:drawingUnits="24" v:shadowOffsetX="8.50394"
				v:shadowOffsetY="-8.50394"/>
		<v:layer v:name="连接线" v:index="0"/>
		<g id="shape79-1" v:mID="79" v:groupContext="shape" transform="translate(332.353,-479.094)">
			<title>开始</title>
			<desc>开始</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="33.5197" cy="496.17" width="67.04" height="22.6772"/>
			<g id="shadow79-2" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.670394,-9.92339)" class="st1">
				<path d="M0 496.17 A33.5197 11.3386 0 1 1 67.04 496.17 A33.5197 11.3386 0 1 1 0 496.17 Z" class="st2"/>
			</g>
			<path d="M0 496.17 A33.5197 11.3386 0 1 1 67.04 496.17 A33.5197 11.3386 0 1 1 0 496.17 Z" class="st3"/>
			<text x="23.52" y="499.17" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>开始</text>		</g>
		<g id="shape80-7" v:mID="80" v:groupContext="shape" transform="translate(168.176,-402.559)">
			<title>ATTACH附着</title>
			<desc>ATTACH附着</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="497.587" width="85.04" height="19.8425"/>
			<g id="shadow80-8" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-9.95174)" class="st1">
				<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st3"/>
			<text x="12.54" y="500.59" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>ATTACH附着</text>		</g>
		<g id="shape81-13" v:mID="81" v:groupContext="shape" transform="translate(274.475,-402.559)">
			<title>缺省承载</title>
			<desc>缺省承载</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="497.587" width="85.04" height="19.8425"/>
			<g id="shadow81-14" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-9.95174)" class="st1">
				<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st3"/>
			<text x="22.52" y="500.59" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>缺省承载</text>		</g>
		<g id="shape84-19" v:mID="84" v:groupContext="shape" transform="translate(380.775,-402.559)">
			<title>跟踪区更新</title>
			<desc>跟踪区更新</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="497.587" width="85.04" height="19.8425"/>
			<g id="shadow84-20" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-9.95174)" class="st1">
				<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st3"/>
			<text x="17.52" y="500.59" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>跟踪区更新</text>		</g>
		<g id="shape85-25" v:mID="85" v:groupContext="shape" transform="translate(487.074,-402.559)">
			<title>切换</title>
			<desc>切换</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="497.587" width="85.04" height="19.8425"/>
			<g id="shadow85-26" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-9.95174)" class="st1">
				<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st3"/>
			<text x="32.52" y="500.59" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>切换</text>		</g>
		<g id="shape86-31" v:mID="86" v:groupContext="shape" transform="translate(295.006,-445.079)">
			<title>错误码及横向对比分析</title>
			<desc>错误码及横向对比分析</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="70.8661" cy="497.587" width="141.74" height="19.8425"/>
			<g id="shadow86-32" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-1.41732,-9.95174)" class="st1">
				<rect x="0" y="487.666" width="141.732" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="487.666" width="141.732" height="19.8425" class="st3"/>
			<text x="20.87" y="500.59" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>错误码及横向对比分析</text>		</g>
		<g id="shape88-37" v:mID="88" v:groupContext="shape" v:layerMember="0" transform="translate(358.786,-479.094)">
			<title></title>
			<g id="shadow88-38" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.141732,-10.2919)" class="st1">
				<path d="M7.09 509.17 L7.09 509.53 L7.09 517.19" class="st5"/>
			</g>
			<path d="M7.09 509.17 L7.09 509.53 L7.09 517.19" class="st8"/>
		</g>
		<g id="shape93-57" v:mID="93" v:groupContext="shape" transform="translate(625.263,-436.575)">
			<title>前后信令消息关联定界分析</title>
			<desc>前后信令消息关联定界分析</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="70.8661" cy="496.17" width="141.74" height="22.6772"/>
			<g id="shadow93-58" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-1.41732,-9.92339)" class="st1">
				<rect x="0" y="484.831" width="141.732" height="22.6772" class="st2"/>
			</g>
			<rect x="0" y="484.831" width="141.732" height="22.6772" class="st11"/>
			<text x="10.87" y="499.17" class="st12" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>前后信令消息关联定界分析</text>		</g>
		<g id="shape95-63" v:mID="95" v:groupContext="shape" transform="translate(653.609,-388.386)">
			<title>频繁TAU</title>
			<desc>频繁TAU</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="496.17" width="85.04" height="22.6772"/>
			<g id="shadow95-64" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-9.92339)" class="st1">
				<rect x="0" y="484.831" width="85.0394" height="22.6772" class="st2"/>
			</g>
			<rect x="0" y="484.831" width="85.0394" height="22.6772" class="st11"/>
			<text x="22.4" y="499.17" class="st12" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>频繁TAU</text>		</g>
		<g id="shape96-69" v:mID="96" v:groupContext="shape" v:layerMember="0" transform="translate(689.042,-436.575)">
			<title></title>
			<g id="shadow96-70" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.141732,-10.4053)" class="st1">
				<path d="M7.09 509.17 L7.09 509.53 L7.09 528.53" class="st5"/>
			</g>
			<path d="M7.09 509.17 L7.09 509.53 L7.09 528.53" class="st8"/>
		</g>
		<g id="shape97-85" v:mID="97" v:groupContext="shape" v:layerMember="0" transform="translate(399.392,-490.433)">
			<title></title>
			<g id="shadow97-86" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-2.96737,-10.462)" class="st1">
				<path d="M1.66 507.51 L2.02 507.51 L292.24 507.51 A4.5 4.5 0 0 1 296.74 512.01 L296.74 534.2" class="st5"/>
			</g>
			<path d="M1.66 507.51 L2.02 507.51 L292.24 507.51 A4.5 4.5 0 0 1 296.74 512.01 L296.74 534.2" class="st8"/>
		</g>
		<g id="shape98-101" v:mID="98" v:groupContext="shape" transform="translate(304.948,-359.401)">
			<title>根据错误码结果初定界</title>
			<desc>根据错误码结果初定界</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="65.1969" cy="497.587" width="130.4" height="19.8425"/>
			<g id="shadow98-102" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-1.30394,-9.95174)" class="st1">
				<rect x="0" y="487.666" width="130.394" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="487.666" width="130.394" height="19.8425" class="st3"/>
			<text x="15.2" y="500.59" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>根据错误码结果初定界</text>		</g>
		<g id="shape100-107" v:mID="100" v:groupContext="shape" v:layerMember="0" transform="translate(210.696,-402.559)">
			<title></title>
			<g id="shadow100-108" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-1.59449,-10.3833)" class="st1">
				<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 -180 0 0 4.5 518.14 L154.95 518.14 A4.5 4.5 0 0 1 159.45 522.64 L159.45
							 526.33" class="st5"/>
			</g>
			<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 -180 0 0 4.5 518.14 L154.95 518.14 A4.5 4.5 0 0 1 159.45 522.64 L159.45
						 526.33" class="st8"/>
		</g>
		<g id="shape101-123" v:mID="101" v:groupContext="shape" v:layerMember="0" transform="translate(316.995,-402.559)">
			<title></title>
			<g id="shadow101-124" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.531496,-10.3833)" class="st1">
				<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 -180 0 0 4.5 518.14 L48.65 518.14 A4.5 4.5 0 0 1 53.15 522.64 L53.15
							 526.33" class="st5"/>
			</g>
			<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 -180 0 0 4.5 518.14 L48.65 518.14 A4.5 4.5 0 0 1 53.15 522.64 L53.15
						 526.33" class="st8"/>
		</g>
		<g id="shape102-139" v:mID="102" v:groupContext="shape" v:layerMember="0" transform="translate(423.294,-402.559)">
			<title></title>
			<g id="shadow102-140" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,0.531496,-10.3833)" class="st1">
				<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 0 0 1 -4.5 518.14 L-48.65 518.14 A4.5 4.5 -180 0 0 -53.15 522.64
							 L-53.15 526.33" class="st5"/>
			</g>
			<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 0 0 1 -4.5 518.14 L-48.65 518.14 A4.5 4.5 -180 0 0 -53.15 522.64 L-53.15
						 526.33" class="st8"/>
		</g>
		<g id="shape103-155" v:mID="103" v:groupContext="shape" v:layerMember="0" transform="translate(529.593,-402.559)">
			<title></title>
			<g id="shadow103-156" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,1.59449,-10.3833)" class="st1">
				<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 0 0 1 -4.5 518.14 L-154.95 518.14 A4.5 4.5 -180 0 0 -159.45 522.64
							 L-159.45 526.33" class="st5"/>
			</g>
			<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 0 0 1 -4.5 518.14 L-154.95 518.14 A4.5 4.5 -180 0 0 -159.45 522.64 L-159.45
						 526.33" class="st8"/>
		</g>
		<g id="shape104-171" v:mID="104" v:groupContext="shape" transform="translate(12.2706,-267.913)">
			<title>无线质量分析</title>
			<desc>无线质量分析</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="497.587" width="85.04" height="19.8425"/>
			<g id="shadow104-172" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-9.95174)" class="st1">
				<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st3"/>
			<text x="12.52" y="500.59" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>无线质量分析</text>		</g>
		<g id="shape105-177" v:mID="105" v:groupContext="shape" transform="translate(182.349,-267.913)">
			<title>无线参数分析</title>
			<desc>无线参数分析</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="497.587" width="85.04" height="19.8425"/>
			<g id="shadow105-178" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-9.95174)" class="st1">
				<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st3"/>
			<text x="12.52" y="500.59" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>无线参数分析</text>		</g>
		<g id="shape106-183" v:mID="106" v:groupContext="shape" transform="translate(309.908,-267.913)">
			<title>核心质量分析</title>
			<desc>核心质量分析</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="497.587" width="85.04" height="19.8425"/>
			<g id="shadow106-184" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-9.95174)" class="st1">
				<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st3"/>
			<text x="12.52" y="500.59" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>核心质量分析</text>		</g>
		<g id="shape107-189" v:mID="107" v:groupContext="shape" transform="translate(458.727,-266.638)">
			<title>核心参数分析</title>
			<desc>核心参数分析</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="497.587" width="85.04" height="19.8425"/>
			<g id="shadow107-190" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-9.95174)" class="st1">
				<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st3"/>
			<text x="12.52" y="500.59" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>核心参数分析</text>		</g>
		<g id="shape108-195" v:mID="108" v:groupContext="shape" transform="translate(554.397,-309.795)">
			<title>用户及终端精准分析</title>
			<desc>用户及终端精准分析</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="63.7795" cy="497.587" width="127.56" height="19.8425"/>
			<g id="shadow108-196" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-1.27559,-9.95174)" class="st1">
				<rect x="0" y="487.666" width="127.559" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="487.666" width="127.559" height="19.8425" class="st3"/>
			<text x="18.78" y="500.59" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>用户及终端精准分析</text>		</g>
		<g id="shape109-201" v:mID="109" v:groupContext="shape" transform="translate(692.586,-309.795)">
			<title>二级错误码分析</title>
			<desc>二级错误码分析</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="63.7795" cy="497.587" width="127.56" height="19.8425"/>
			<g id="shadow109-202" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-1.27559,-9.95174)" class="st1">
				<rect x="0" y="487.666" width="127.559" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="487.666" width="127.559" height="19.8425" class="st3"/>
			<text x="28.78" y="500.59" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>二级错误码分析</text>		</g>
		<g id="shape112-207" v:mID="112" v:groupContext="shape" v:layerMember="0" transform="translate(423.294,-311.212)">
			<title></title>
			<g id="shadow112-208" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,0.708661,-10.3847)" class="st1">
				<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 0 0 1 -4.5 518.14 L-66.37 518.14 A4.5 4.5 -180 0 0 -70.87 522.64
							 L-70.87 526.47" class="st5"/>
			</g>
			<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 0 0 1 -4.5 518.14 L-66.37 518.14 A4.5 4.5 -180 0 0 -70.87 522.64 L-70.87
						 526.47" class="st8"/>
		</g>
		<g id="shape113-223" v:mID="113" v:groupContext="shape" v:layerMember="0" transform="translate(423.294,-311.212)">
			<title></title>
			<g id="shadow113-224" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.779527,-10.3975)" class="st1">
				<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 -180 0 0 4.5 518.14 L73.45 518.14 A4.5 4.5 0 0 1 77.95 522.64 L77.95
							 527.75" class="st5"/>
			</g>
			<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 -180 0 0 4.5 518.14 L73.45 518.14 A4.5 4.5 0 0 1 77.95 522.64 L77.95
						 527.75" class="st8"/>
		</g>
		<g id="shape114-239" v:mID="114" v:groupContext="shape" v:layerMember="0" transform="translate(370.145,-359.401)">
			<title></title>
			<g id="shadow114-240" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.531496,-10.4336)" class="st1">
				<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 -180 0 0 4.5 518.14 L48.65 518.14 A4.5 4.5 0 0 1 53.15 522.64 L53.15
							 531.36" class="st5"/>
			</g>
			<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 -180 0 0 4.5 518.14 L48.65 518.14 A4.5 4.5 0 0 1 53.15 522.64 L53.15
						 531.36" class="st8"/>
		</g>
		<g id="shape117-255" v:mID="117" v:groupContext="shape" transform="translate(437.467,-356.567)">
			<title></title>
			<desc>R:kzmxd</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="33.5197" cy="496.17" width="67.04" height="22.6772"/>
			<rect x="0" y="484.831" width="67.0394" height="22.6772" class="st13"/>
			<text x="11.89" y="499.17" class="st14" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>R:kzmxd</text>		</g>
		<g id="shape118-258" v:mID="118" v:groupContext="shape" transform="translate(76.0502,-311.212)">
			<title>无线分析</title>
			<desc>无线分析</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="63.7795" cy="497.587" width="127.56" height="19.8425"/>
			<g id="shadow118-259" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-1.27559,-9.95174)" class="st1">
				<rect x="0" y="487.666" width="127.559" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="487.666" width="127.559" height="19.8425" class="st3"/>
			<text x="43.78" y="500.59" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>无线分析</text>		</g>
		<g id="shape119-264" v:mID="119" v:groupContext="shape" v:layerMember="0" transform="translate(370.145,-359.401)">
			<title></title>
			<g id="shadow119-265" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,2.30315,-10.4336)" class="st1">
				<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 0 0 1 -4.5 518.14 L-225.81 518.14 A4.5 4.5 -180 0 0 -230.31 522.64
							 L-230.31 531.36" class="st5"/>
			</g>
			<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 0 0 1 -4.5 518.14 L-225.81 518.14 A4.5 4.5 -180 0 0 -230.31 522.64 L-230.31
						 531.36" class="st8"/>
		</g>
		<g id="shape120-280" v:mID="120" v:groupContext="shape" transform="translate(359.515,-311.212)">
			<title>核心网分析</title>
			<desc>核心网分析</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="63.7795" cy="497.587" width="127.56" height="19.8425"/>
			<g id="shadow120-281" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-1.27559,-9.95174)" class="st1">
				<rect x="0" y="487.666" width="127.559" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="487.666" width="127.559" height="19.8425" class="st3"/>
			<text x="38.78" y="500.59" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>核心网分析</text>		</g>
		<g id="shape121-286" v:mID="121" v:groupContext="shape" v:layerMember="0" transform="translate(370.145,-359.401)">
			<title></title>
			<g id="shadow121-287" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-2.48031,-10.4478)" class="st1">
				<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 -180 0 0 4.5 518.14 L243.53 518.14 A4.5 4.5 0 0 1 248.03 522.64 L248.03
							 532.78" class="st5"/>
			</g>
			<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 -180 0 0 4.5 518.14 L243.53 518.14 A4.5 4.5 0 0 1 248.03 522.64 L248.03
						 532.78" class="st8"/>
		</g>
		<g id="shape122-302" v:mID="122" v:groupContext="shape" v:layerMember="0" transform="translate(370.145,-359.401)">
			<title></title>
			<g id="shadow122-303" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-2.48031,-10.4478)" class="st1">
				<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 -180 0 0 4.5 518.14 L243.53 518.14 A4.5 4.5 0 0 1 248.03 522.64 L248.03
							 532.78" class="st5"/>
			</g>
			<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 -180 0 0 4.5 518.14 L243.53 518.14 A4.5 4.5 0 0 1 248.03 522.64 L248.03
						 532.78" class="st8"/>
		</g>
		<g id="shape123-318" v:mID="123" v:groupContext="shape" transform="translate(40.6171,-219.866)">
			<title>是否弱覆盖</title>
			<desc>是否弱覆盖</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:prompt="" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="491.244" width="85.04" height="32.5276"/>
			<g id="shadow123-319" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-9.82489)" class="st1">
				<path d="M42.52 507.51 L85.04 491.24 L42.52 474.98 L0 491.24 L42.52 507.51 Z" class="st2"/>
			</g>
			<path d="M42.52 507.51 L85.04 491.24 L42.52 474.98 L0 491.24 L42.52 507.51 Z" class="st3"/>
			<text x="17.52" y="494.24" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是否弱覆盖</text>		</g>
		<g id="shape124-324" v:mID="124" v:groupContext="shape" transform="translate(40.6171,-125.614)">
			<title>是否质差</title>
			<desc>是否质差</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:prompt="" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="491.209" width="85.04" height="32.5984"/>
			<g id="shadow124-325" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-9.82418)" class="st1">
				<path d="M42.52 507.51 L85.04 491.21 L42.52 474.91 L0 491.21 L42.52 507.51 Z" class="st2"/>
			</g>
			<path d="M42.52 507.51 L85.04 491.21 L42.52 474.91 L0 491.21 L42.52 507.51 Z" class="st3"/>
			<text x="22.52" y="494.21" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是否质差</text>		</g>
		<g id="shape125-330" v:mID="125" v:groupContext="shape" transform="translate(40.6171,-43.9761)">
			<title>是否高负荷</title>
			<desc>是否高负荷</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:prompt="" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="491.209" width="85.04" height="32.5984"/>
			<g id="shadow125-331" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-9.82418)" class="st1">
				<path d="M42.52 507.51 L85.04 491.21 L42.52 474.91 L0 491.21 L42.52 507.51 Z" class="st2"/>
			</g>
			<path d="M42.52 507.51 L85.04 491.21 L42.52 474.91 L0 491.21 L42.52 507.51 Z" class="st3"/>
			<text x="17.52" y="494.21" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是否高负荷</text>		</g>
		<g id="shape129-336" v:mID="129" v:groupContext="shape" v:layerMember="0" transform="translate(365.872,-445.079)">
			<title></title>
			<g id="shadow129-337" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.574218,-10.3769)" class="st1">
				<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 -180 0 0 4.5 518.14 L52.92 518.14 A4.5 4.5 0 0 1 57.42 522.64 L57.42
							 525.7" class="st5"/>
			</g>
			<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 -180 0 0 4.5 518.14 L52.92 518.14 A4.5 4.5 0 0 1 57.42 522.64 L57.42
						 525.7" class="st8"/>
		</g>
		<g id="shape131-352" v:mID="131" v:groupContext="shape" v:layerMember="0" transform="translate(365.872,-445.079)">
			<title></title>
			<g id="shadow131-353" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,0.488774,-10.3769)" class="st1">
				<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 0 0 1 -4.5 518.14 L-44.38 518.14 A4.5 4.5 -180 0 0 -48.88 522.64
							 L-48.88 525.7" class="st5"/>
			</g>
			<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 0 0 1 -4.5 518.14 L-44.38 518.14 A4.5 4.5 -180 0 0 -48.88 522.64 L-48.88
						 525.7" class="st8"/>
		</g>
		<g id="shape132-368" v:mID="132" v:groupContext="shape" v:layerMember="0" transform="translate(365.872,-445.079)">
			<title></title>
			<g id="shadow132-369" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,1.55177,-10.3769)" class="st1">
				<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 0 0 1 -4.5 518.14 L-150.68 518.14 A4.5 4.5 -180 0 0 -155.18 522.64
							 L-155.18 525.7" class="st5"/>
			</g>
			<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 0 0 1 -4.5 518.14 L-150.68 518.14 A4.5 4.5 -180 0 0 -155.18 522.64 L-155.18
						 525.7" class="st8"/>
		</g>
		<g id="shape134-384" v:mID="134" v:groupContext="shape" v:layerMember="0" transform="translate(370.145,-359.401)">
			<title></title>
			<g id="shadow134-385" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-2.48031,-10.4478)" class="st1">
				<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 -180 0 0 4.5 518.14 L243.53 518.14 A4.5 4.5 0 0 1 248.03 522.64 L248.03
							 532.78" class="st5"/>
			</g>
			<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 -180 0 0 4.5 518.14 L243.53 518.14 A4.5 4.5 0 0 1 248.03 522.64 L248.03
						 532.78" class="st8"/>
		</g>
		<g id="shape135-400" v:mID="135" v:groupContext="shape" v:layerMember="0" transform="translate(370.145,-359.401)">
			<title></title>
			<g id="shadow135-401" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-3.8622,-10.4478)" class="st1">
				<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 -180 0 0 4.5 518.14 L381.72 518.14 A4.5 4.5 0 0 1 386.22 522.64 L386.22
							 532.78" class="st5"/>
			</g>
			<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 -180 0 0 4.5 518.14 L381.72 518.14 A4.5 4.5 0 0 1 386.22 522.64 L386.22
						 532.78" class="st8"/>
		</g>
		<g id="shape136-416" v:mID="136" v:groupContext="shape" transform="translate(40.6171,-167.425)">
			<title>无线-弱覆盖</title>
			<desc>无线-弱覆盖</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="497.587" width="85.04" height="19.8425"/>
			<g id="shadow136-417" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-9.95174)" class="st1">
				<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st3"/>
			<text x="15.36" y="500.59" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>无线-弱覆盖</text>		</g>
		<g id="shape137-422" v:mID="137" v:groupContext="shape" transform="translate(40.6171,-85.0785)">
			<title>无线-质差小区</title>
			<desc>无线-质差小区</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="497.587" width="85.04" height="19.8425"/>
			<g id="shadow137-423" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-9.95174)" class="st1">
				<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st3"/>
			<text x="10.36" y="500.59" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>无线-质差小区</text>		</g>
		<g id="shape138-428" v:mID="138" v:groupContext="shape" transform="translate(40.6171,-5.70842)">
			<title>无线-高负荷</title>
			<desc>无线-高负荷</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="497.587" width="85.04" height="19.8425"/>
			<g id="shadow138-429" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-9.95174)" class="st1">
				<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st3"/>
			<text x="15.36" y="500.59" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>无线-高负荷</text>		</g>
		<g id="shape140-434" v:mID="140" v:groupContext="shape" v:layerMember="0" transform="translate(54.7903,-267.913)">
			<title></title>
			<g id="shadow140-435" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,0.141732,-10.468)" class="st1">
				<path d="M0 509.17 L0 509.53 L0 520.72 A4.5 4.5 0 0 1 -4.5 525.22 L-30.65 525.22 A4.5 4.5 -180 0 0 -35.15 529.72
							 L-35.15 534.79 A4.5 4.5 -180 0 0 -30.65 539.29 L-18.66 539.29" class="st5"/>
			</g>
			<path d="M0 509.17 L0 509.53 L0 520.72 A4.5 4.5 0 0 1 -4.5 525.22 L-30.65 525.22 A4.5 4.5 -180 0 0 -35.15 529.72 L-35.15
						 534.79 A4.5 4.5 -180 0 0 -30.65 539.29 L-18.66 539.29" class="st8"/>
		</g>
		<g id="shape141-450" v:mID="141" v:groupContext="shape" v:layerMember="0" transform="translate(54.7903,-267.913)">
			<title></title>
			<g id="shadow141-451" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,0.141732,-11.4102)" class="st1">
				<path d="M0 509.17 L0 509.53 L0 520.72 A4.5 4.5 0 0 1 -4.5 525.22 L-30.65 525.22 A4.5 4.5 -180 0 0 -35.15 529.72
							 L-35.15 629.01 A4.5 4.5 -180 0 0 -30.65 633.51 L-18.66 633.51" class="st5"/>
			</g>
			<path d="M0 509.17 L0 509.53 L0 520.72 A4.5 4.5 0 0 1 -4.5 525.22 L-30.65 525.22 A4.5 4.5 -180 0 0 -35.15 529.72 L-35.15
						 629.01 A4.5 4.5 -180 0 0 -30.65 633.51 L-18.66 633.51" class="st8"/>
		</g>
		<g id="shape142-466" v:mID="142" v:groupContext="shape" v:layerMember="0" transform="translate(54.7903,-267.913)">
			<title></title>
			<g id="shadow142-467" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,0.141732,-12.2265)" class="st1">
				<path d="M0 509.17 L0 509.53 L0 520.72 A4.5 4.5 0 0 1 -4.5 525.22 L-30.65 525.22 A4.5 4.5 -180 0 0 -35.15 529.72
							 L-35.15 710.65 A4.5 4.5 -180 0 0 -30.65 715.15 L-18.66 715.15" class="st5"/>
			</g>
			<path d="M0 509.17 L0 509.53 L0 520.72 A4.5 4.5 0 0 1 -4.5 525.22 L-30.65 525.22 A4.5 4.5 -180 0 0 -35.15 529.72 L-35.15
						 710.65 A4.5 4.5 -180 0 0 -30.65 715.15 L-18.66 715.15" class="st8"/>
		</g>
		<g id="shape144-482" v:mID="144" v:groupContext="shape" v:layerMember="0" transform="translate(76.0502,-219.866)">
			<title></title>
			<desc>是</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="7.08661" cy="523.807" width="50" height="20.0036"/>
			<g id="shadow144-483" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.141732,-10.4761)" class="st1">
				<path d="M7.09 509.17 L7.09 509.53 L7.09 535.62" class="st5"/>
			</g>
			<path d="M7.09 509.17 L7.09 509.53 L7.09 535.62" class="st8"/>
			<rect v:rectContext="textBkgnd" x="2.08668" y="517.808" width="10" height="12.0001" class="st15"/>
			<text x="2.09" y="526.81" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是</text>		</g>
		<g id="shape145-500" v:mID="145" v:groupContext="shape" v:layerMember="0" transform="translate(76.0502,-125.614)">
			<title></title>
			<desc>是</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="7.08661" cy="517.855" width="50" height="20.0036"/>
			<g id="shadow145-501" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.141732,-10.3571)" class="st1">
				<path d="M7.09 509.17 L7.09 509.53 L7.09 523.71" class="st5"/>
			</g>
			<path d="M7.09 509.17 L7.09 509.53 L7.09 523.71" class="st8"/>
			<rect v:rectContext="textBkgnd" x="2.08668" y="511.855" width="10" height="12.0001" class="st16"/>
			<text x="2.09" y="520.85" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是</text>		</g>
		<g id="shape146-518" v:mID="146" v:groupContext="shape" v:layerMember="0" transform="translate(76.0502,-43.9761)">
			<title></title>
			<desc>是</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="7.08661" cy="516.721" width="50" height="20.0036"/>
			<g id="shadow146-519" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.141732,-10.3344)" class="st1">
				<path d="M7.09 509.17 L7.09 509.53 L7.09 521.44" class="st5"/>
			</g>
			<path d="M7.09 509.17 L7.09 509.53 L7.09 521.44" class="st8"/>
			<rect v:rectContext="textBkgnd" x="2.08668" y="510.721" width="10" height="12.0001" class="st15"/>
			<text x="2.09" y="519.72" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是</text>		</g>
		<g id="shape148-536" v:mID="148" v:groupContext="shape" transform="translate(182.349,-219.866)">
			<title>是否需要核查参数</title>
			<desc>是否需要核查参数</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:prompt="" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="491.209" width="85.04" height="32.5984"/>
			<g id="shadow148-537" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-9.82418)" class="st1">
				<path d="M42.52 507.51 L85.04 491.21 L42.52 474.91 L0 491.21 L42.52 507.51 Z" class="st2"/>
			</g>
			<path d="M42.52 507.51 L85.04 491.21 L42.52 474.91 L0 491.21 L42.52 507.51 Z" class="st3"/>
			<text x="7.52" y="488.21" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是否需要核查参<tspan
						x="37.52" dy="1.2em" class="st17">数</tspan></text>		</g>
		<g id="shape149-543" v:mID="149" v:groupContext="shape" transform="translate(182.349,-167.425)">
			<title>无线-核查参数</title>
			<desc>无线-核查参数</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="497.587" width="85.04" height="19.8425"/>
			<g id="shadow149-544" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-9.95174)" class="st1">
				<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st3"/>
			<text x="10.36" y="500.59" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>无线-核查参数</text>		</g>
		<g id="shape150-549" v:mID="150" v:groupContext="shape" v:layerMember="0" transform="translate(217.782,-219.866)">
			<title></title>
			<desc>是</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="7.08661" cy="523.807" width="50" height="20.0036"/>
			<g id="shadow150-550" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.141732,-10.4761)" class="st1">
				<path d="M7.09 509.17 L7.09 509.53 L7.09 535.62" class="st5"/>
			</g>
			<path d="M7.09 509.17 L7.09 509.53 L7.09 535.62" class="st8"/>
			<rect v:rectContext="textBkgnd" x="2.08668" y="517.808" width="10" height="12.0001" class="st15"/>
			<text x="2.09" y="526.81" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是</text>		</g>
		<g id="shape151-567" v:mID="151" v:groupContext="shape" v:layerMember="0" transform="translate(217.782,-267.913)">
			<title></title>
			<g id="shadow151-568" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.141732,-10.3047)" class="st1">
				<path d="M7.09 509.17 L7.09 509.53 L7.09 518.47" class="st5"/>
			</g>
			<path d="M7.09 509.17 L7.09 509.53 L7.09 518.47" class="st8"/>
		</g>
		<g id="shape152-583" v:mID="152" v:groupContext="shape" transform="translate(338.255,-219.866)">
			<title>是否质差</title>
			<desc>是否质差</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:prompt="" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="491.209" width="85.04" height="32.5984"/>
			<g id="shadow152-584" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-9.82418)" class="st1">
				<path d="M42.52 507.51 L85.04 491.21 L42.52 474.91 L0 491.21 L42.52 507.51 Z" class="st2"/>
			</g>
			<path d="M42.52 507.51 L85.04 491.21 L42.52 474.91 L0 491.21 L42.52 507.51 Z" class="st3"/>
			<text x="22.52" y="494.21" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是否质差</text>		</g>
		<g id="shape153-589" v:mID="153" v:groupContext="shape" transform="translate(338.255,-125.614)">
			<title>是否高负荷</title>
			<desc>是否高负荷</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:prompt="" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="491.209" width="85.04" height="32.5984"/>
			<g id="shadow153-590" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-9.82418)" class="st1">
				<path d="M42.52 507.51 L85.04 491.21 L42.52 474.91 L0 491.21 L42.52 507.51 Z" class="st2"/>
			</g>
			<path d="M42.52 507.51 L85.04 491.21 L42.52 474.91 L0 491.21 L42.52 507.51 Z" class="st3"/>
			<text x="17.52" y="494.21" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是否高负荷</text>		</g>
		<g id="shape154-595" v:mID="154" v:groupContext="shape" transform="translate(338.255,-167.425)">
			<title>核心-质量问题</title>
			<desc>核心-质量问题</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="497.587" width="85.04" height="19.8425"/>
			<g id="shadow154-596" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-9.95174)" class="st1">
				<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st3"/>
			<text x="10.36" y="500.59" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>核心-质量问题</text>		</g>
		<g id="shape155-601" v:mID="155" v:groupContext="shape" transform="translate(338.255,-78.8423)">
			<title>核心-高负荷</title>
			<desc>核心-高负荷</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="497.587" width="85.04" height="19.8425"/>
			<g id="shadow155-602" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-9.95174)" class="st1">
				<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st3"/>
			<text x="15.36" y="500.59" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>核心-高负荷</text>		</g>
		<g id="shape156-607" v:mID="156" v:groupContext="shape" v:layerMember="0" transform="translate(352.428,-267.913)">
			<title></title>
			<g id="shadow156-608" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,0.141732,-10.4676)" class="st1">
				<path d="M0 509.17 L0 509.53 L0 517.74 A4.5 4.5 0 0 1 -4.5 522.24 L-25.22 522.24 A4.5 4.5 -180 0 0 -29.72 526.74
							 L-29.72 534.76 A4.5 4.5 -180 0 0 -25.22 539.26 L-18.66 539.26" class="st5"/>
			</g>
			<path d="M0 509.17 L0 509.53 L0 517.74 A4.5 4.5 0 0 1 -4.5 522.24 L-25.22 522.24 A4.5 4.5 -180 0 0 -29.72 526.74 L-29.72
						 534.76 A4.5 4.5 -180 0 0 -25.22 539.26 L-18.66 539.26" class="st8"/>
		</g>
		<g id="shape158-623" v:mID="158" v:groupContext="shape" v:layerMember="0" transform="translate(373.688,-219.866)">
			<title></title>
			<desc>是</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="7.08661" cy="523.807" width="50" height="20.0036"/>
			<g id="shadow158-624" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.141732,-10.4761)" class="st1">
				<path d="M7.09 509.17 L7.09 509.53 L7.09 535.62" class="st5"/>
			</g>
			<path d="M7.09 509.17 L7.09 509.53 L7.09 535.62" class="st8"/>
			<rect v:rectContext="textBkgnd" x="2.08668" y="517.808" width="10" height="12.0001" class="st15"/>
			<text x="2.09" y="526.81" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是</text>		</g>
		<g id="shape159-641" v:mID="159" v:groupContext="shape" v:layerMember="0" transform="translate(352.428,-267.913)">
			<title></title>
			<g id="shadow159-642" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,0.141732,-11.4102)" class="st1">
				<path d="M0 509.17 L0 509.53 L0 517.74 A4.5 4.5 0 0 1 -4.5 522.24 L-24.76 522.24 A4.5 4.5 -180 0 0 -29.26 526.74
							 L-29.26 629.01 A4.5 4.5 -180 0 0 -24.76 633.51 L-18.66 633.51" class="st5"/>
			</g>
			<path d="M0 509.17 L0 509.53 L0 517.74 A4.5 4.5 0 0 1 -4.5 522.24 L-24.76 522.24 A4.5 4.5 -180 0 0 -29.26 526.74 L-29.26
						 629.01 A4.5 4.5 -180 0 0 -24.76 633.51 L-18.66 633.51" class="st8"/>
		</g>
		<g id="shape160-657" v:mID="160" v:groupContext="shape" v:layerMember="0" transform="translate(373.688,-125.614)">
			<title></title>
			<desc>是</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="7.08661" cy="520.973" width="50" height="20.0036"/>
			<g id="shadow160-658" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.141732,-10.4195)" class="st1">
				<path d="M7.09 509.17 L7.09 509.53 L7.09 529.95" class="st5"/>
			</g>
			<path d="M7.09 509.17 L7.09 509.53 L7.09 529.95" class="st8"/>
			<rect v:rectContext="textBkgnd" x="2.08668" y="514.973" width="10" height="12.0001" class="st16"/>
			<text x="2.09" y="523.97" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是</text>		</g>
		<g id="shape161-675" v:mID="161" v:groupContext="shape" transform="translate(458.727,-219.866)">
			<title>是否需要核查参数</title>
			<desc>是否需要核查参数</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:prompt="" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="491.209" width="85.04" height="32.5984"/>
			<g id="shadow161-676" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-9.82418)" class="st1">
				<path d="M42.52 507.51 L85.04 491.21 L42.52 474.91 L0 491.21 L42.52 507.51 Z" class="st2"/>
			</g>
			<path d="M42.52 507.51 L85.04 491.21 L42.52 474.91 L0 491.21 L42.52 507.51 Z" class="st3"/>
			<text x="7.52" y="488.21" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是否需要核查参<tspan
						x="37.52" dy="1.2em" class="st17">数</tspan></text>		</g>
		<g id="shape162-682" v:mID="162" v:groupContext="shape" transform="translate(458.727,-167.425)">
			<title>核心-核查参数</title>
			<desc>核心-核查参数</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="497.587" width="85.04" height="19.8425"/>
			<g id="shadow162-683" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-9.95174)" class="st1">
				<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st3"/>
			<text x="10.36" y="500.59" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>核心-核查参数</text>		</g>
		<g id="shape163-688" v:mID="163" v:groupContext="shape" v:layerMember="0" transform="translate(494.16,-219.866)">
			<title></title>
			<desc>是</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="7.08661" cy="523.807" width="50" height="20.0036"/>
			<g id="shadow163-689" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.141732,-10.4761)" class="st1">
				<path d="M7.09 509.17 L7.09 509.53 L7.09 535.62" class="st5"/>
			</g>
			<path d="M7.09 509.17 L7.09 509.53 L7.09 535.62" class="st8"/>
			<rect v:rectContext="textBkgnd" x="2.08668" y="517.808" width="10" height="12.0001" class="st15"/>
			<text x="2.09" y="526.81" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是</text>		</g>
		<g id="shape164-706" v:mID="164" v:groupContext="shape" v:layerMember="0" transform="translate(494.16,-266.638)">
			<title></title>
			<g id="shadow164-707" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.141732,-10.2919)" class="st1">
				<path d="M7.09 509.17 L7.09 509.53 L7.09 517.19" class="st5"/>
			</g>
			<path d="M7.09 509.17 L7.09 509.53 L7.09 517.19" class="st8"/>
		</g>
		<g id="shape166-722" v:mID="166" v:groupContext="shape" transform="translate(593.373,-219.866)">
			<title>是否质差终端</title>
			<desc>是否质差终端</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:prompt="" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="491.244" width="85.04" height="32.5276"/>
			<g id="shadow166-723" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-9.82489)" class="st1">
				<path d="M42.52 507.51 L85.04 491.24 L42.52 474.98 L0 491.24 L42.52 507.51 Z" class="st2"/>
			</g>
			<path d="M42.52 507.51 L85.04 491.24 L42.52 474.98 L0 491.24 L42.52 507.51 Z" class="st3"/>
			<text x="12.52" y="494.24" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是否质差终端</text>		</g>
		<g id="shape167-728" v:mID="167" v:groupContext="shape" v:layerMember="0" transform="translate(618.176,-309.795)">
			<title></title>
			<g id="shadow167-729" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,0.248032,-10.8868)" class="st1">
				<path d="M0 509.17 L0 509.53 L0 523.79 A4.5 4.5 0 0 1 -4.5 528.29 L-35.22 528.29 A4.5 4.5 -180 0 0 -39.72 532.79
							 L-39.72 576.67 A4.5 4.5 -180 0 0 -35.22 581.17 L-29.29 581.17" class="st5"/>
			</g>
			<path d="M0 509.17 L0 509.53 L0 523.79 A4.5 4.5 0 0 1 -4.5 528.29 L-35.22 528.29 A4.5 4.5 -180 0 0 -39.72 532.79 L-39.72
						 576.67 A4.5 4.5 -180 0 0 -35.22 581.17 L-29.29 581.17" class="st8"/>
		</g>
		<g id="shape168-744" v:mID="168" v:groupContext="shape" transform="translate(593.373,-79.9053)">
			<title>EMM#15错误码是否超门限</title>
			<desc>EMM#15错误码是否超门限</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:prompt="" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="486.603" width="85.04" height="41.811"/>
			<g id="shadow168-745" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-9.73205)" class="st1">
				<path d="M42.52 507.51 L85.04 486.6 L42.52 465.7 L0 486.6 L42.52 507.51 Z" class="st2"/>
			</g>
			<path d="M42.52 507.51 L85.04 486.6 L42.52 465.7 L0 486.6 L42.52 507.51 Z" class="st3"/>
			<text x="5.94" y="483.6" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>EMM#15错误码<tspan
						x="17.52" dy="1.2em" class="st17">是否超门限</tspan></text>		</g>
		<g id="shape169-751" v:mID="169" v:groupContext="shape" v:layerMember="0" transform="translate(618.176,-309.795)">
			<title></title>
			<g id="shadow169-752" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,0.248032,-12.24)" class="st1">
				<path d="M0 509.17 L0 509.53 L0 523.79 A4.5 4.5 0 0 1 -4.5 528.29 L-35.22 528.29 A4.5 4.5 -180 0 0 -39.72 532.79
							 L-39.72 711.99 A4.5 4.5 -180 0 0 -35.22 716.49 L-29.29 716.49" class="st5"/>
			</g>
			<path d="M0 509.17 L0 509.53 L0 523.79 A4.5 4.5 0 0 1 -4.5 528.29 L-35.22 528.29 A4.5 4.5 -180 0 0 -39.72 532.79 L-39.72
						 711.99 A4.5 4.5 -180 0 0 -35.22 716.49 L-29.29 716.49" class="st8"/>
		</g>
		<g id="shape170-767" v:mID="170" v:groupContext="shape" transform="translate(593.373,-161.756)">
			<title>终端-质量问题</title>
			<desc>终端-质量问题</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="497.587" width="85.04" height="19.8425"/>
			<g id="shadow170-768" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-9.95174)" class="st1">
				<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st3"/>
			<text x="10.36" y="500.59" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>终端-质量问题</text>		</g>
		<g id="shape171-773" v:mID="171" v:groupContext="shape" transform="translate(579.2,-22.1494)">
			<title>用户-用户更换4G终端未更换4G卡</title>
			<desc>用户-用户更换4G终端未更换4G卡</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="56.6929" cy="497.587" width="113.39" height="19.8425"/>
			<g id="shadow171-774" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-1.13386,-9.95174)" class="st1">
				<rect x="0" y="487.666" width="113.386" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="487.666" width="113.386" height="19.8425" class="st3"/>
			<text x="7.88" y="494.59" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>用户-用户更换4G终端<tspan
						x="30.04" dy="1.2em" class="st17">未更换</tspan>4G卡</text>		</g>
		<g id="shape172-780" v:mID="172" v:groupContext="shape" v:layerMember="0" transform="translate(628.806,-219.866)">
			<title></title>
			<desc>是</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="7.08661" cy="526.642" width="50" height="20.0036"/>
			<g id="shadow172-781" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.141732,-10.5328)" class="st1">
				<path d="M7.09 509.17 L7.09 509.53 L7.09 541.29" class="st5"/>
			</g>
			<path d="M7.09 509.17 L7.09 509.53 L7.09 541.29" class="st8"/>
			<rect v:rectContext="textBkgnd" x="2.08668" y="520.642" width="10" height="12.0001" class="st15"/>
			<text x="2.09" y="529.64" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是</text>		</g>
		<g id="shape174-798" v:mID="174" v:groupContext="shape" v:layerMember="0" transform="translate(628.806,-79.9053)">
			<title></title>
			<desc>是</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="7.08661" cy="526.465" width="50" height="20.0036"/>
			<g id="shadow174-799" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.141732,-10.5293)" class="st1">
				<path d="M7.09 509.17 L7.09 509.53 L7.09 540.93" class="st5"/>
			</g>
			<path d="M7.09 509.17 L7.09 509.53 L7.09 540.93" class="st8"/>
			<rect v:rectContext="textBkgnd" x="2.08668" y="520.465" width="10" height="12.0001" class="st15"/>
			<text x="2.09" y="529.47" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是</text>		</g>
		<g id="shape175-816" v:mID="175" v:groupContext="shape" transform="translate(706.759,-217.368)">
			<title>APN设置是否有问题</title>
			<desc>APN设置是否有问题</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:prompt="" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="49.6063" cy="488.746" width="99.22" height="37.5236"/>
			<g id="shadow175-817" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.992126,-9.77493)" class="st1">
				<path d="M49.61 507.51 L99.21 488.75 L49.61 469.98 L0 488.75 L49.61 507.51 Z" class="st2"/>
			</g>
			<path d="M49.61 507.51 L99.21 488.75 L49.61 469.98 L0 488.75 L49.61 507.51 Z" class="st3"/>
			<text x="8.96" y="485.75" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>APN设置是否有问<tspan
						x="44.61" dy="1.2em" class="st17">题</tspan></text>		</g>
		<g id="shape176-823" v:mID="176" v:groupContext="shape" v:layerMember="0" transform="translate(749.279,-309.795)">
			<title></title>
			<g id="shadow176-824" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.141732,-10.6992)" class="st1">
				<path d="M7.09 509.17 L7.09 509.53 L7.09 557.92" class="st5"/>
			</g>
			<path d="M7.09 509.17 L7.09 509.53 L7.09 557.92" class="st8"/>
		</g>
		<g id="shape177-839" v:mID="177" v:groupContext="shape" transform="translate(713.845,-161.756)">
			<title>终端-APN设置问题</title>
			<desc>终端-APN设置问题</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="497.587" width="85.04" height="19.8425"/>
			<g id="shadow177-840" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-9.95174)" class="st1">
				<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="487.666" width="85.0394" height="19.8425" class="st3"/>
			<text x="4.71" y="494.59" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>终端-APN设置问<tspan
						x="37.52" dy="1.2em" class="st17">题</tspan></text>		</g>
		<g id="shape179-846" v:mID="179" v:groupContext="shape" v:layerMember="0" transform="translate(749.279,-217.368)">
			<title></title>
			<desc>是</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="7.08661" cy="525.393" width="50" height="20.0036"/>
			<g id="shadow179-847" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.141732,-10.5079)" class="st1">
				<path d="M7.09 509.17 L7.09 509.53 L7.09 538.79" class="st5"/>
			</g>
			<path d="M7.09 509.17 L7.09 509.53 L7.09 538.79" class="st8"/>
			<rect v:rectContext="textBkgnd" x="2.08668" y="519.393" width="10" height="12.0001" class="st15"/>
			<text x="2.09" y="528.39" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是</text>		</g>
		<g id="shape180-864" v:mID="180" v:groupContext="shape" transform="translate(94.1096,-189.96)">
			<title></title>
			<desc>CON:10010001</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="49.6063" cy="496.17" width="99.22" height="22.6772"/>
			<rect x="0" y="484.831" width="99.2126" height="22.6772" class="st13"/>
			<text id="10010001" x="11.81" y="499.17" class="st14 conclusionPanel" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/><tspan>CON:10010001</tspan></text>		</g>
		<g id="shape181-867" v:mID="181" v:groupContext="shape" transform="translate(90.2234,-104.921)">
			<title></title>
			<desc>CON:10010002</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="49.6063" cy="496.17" width="99.22" height="22.6772"/>
			<rect x="0" y="484.831" width="99.2126" height="22.6772" class="st13"/>
			<text id="10010002" x="11.81" y="499.17" class="st14 conclusionPanel" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/><tspan>CON:10010002</tspan></text>		</g>
		<g id="shape182-870" v:mID="182" v:groupContext="shape" transform="translate(90.2234,-25.5509)">
			<title></title>
			<desc>CON:10010003</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="49.6063" cy="496.17" width="99.22" height="22.6772"/>
			<rect x="0" y="484.831" width="99.2126" height="22.6772" class="st13"/>
			<text id="10010003" x="11.81" y="499.17" class="st14 conclusionPanel" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/><tspan>CON:10010003</tspan></text>		</g>
		<g id="shape183-873" v:mID="183" v:groupContext="shape" transform="translate(169.776,-143.968)">
			<title></title>
			<desc>CON:10010006</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="55.0927" cy="496.17" width="110.19" height="22.6772"/>
			<rect x="0" y="484.831" width="110.185" height="22.6772" class="st13"/>
			<text id="10010006" x="17.3" y="499.17" class="st14 conclusionPanel" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/><tspan>CON:10010006</tspan></text>		</g>
		<g id="shape184-876" v:mID="184" v:groupContext="shape" transform="translate(380.775,-188.685)">
			<title></title>
			<desc>CON:10020002</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="49.6063" cy="496.17" width="99.22" height="22.6772"/>
			<rect x="0" y="484.831" width="99.2126" height="22.6772" class="st13"/>
			<text id="10020002" x="11.81" y="499.17" class="st14 conclusionPanel" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/><tspan>CON:10020002</tspan></text>		</g>
		<g id="shape185-879" v:mID="185" v:groupContext="shape" transform="translate(324.082,-53.2596)">
			<title></title>
			<desc>CON:10020001</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="56.6929" cy="496.17" width="113.39" height="22.6772"/>
			<rect x="0" y="484.831" width="113.386" height="22.6772" class="st13"/>
			<text id="10020001" x="18.9" y="499.17" class="st14 conclusionPanel" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/><tspan>CON:10020001</tspan></text>		</g>
		<g id="shape186-882" v:mID="186" v:groupContext="shape" transform="translate(451.641,-143.968)">
			<title></title>
			<desc>CON:10020009</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="49.6063" cy="496.17" width="99.22" height="22.6772"/>
			<rect x="0" y="484.831" width="99.2126" height="22.6772" class="st13"/>
			<text id="10020009" x="11.81" y="499.17" class="st14 conclusionPanel" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/><tspan>CON:10020009</tspan></text>		</g>
		<g id="shape187-885" v:mID="187" v:groupContext="shape" transform="translate(586.286,-138.299)">
			<title></title>
			<desc>CON:10040001</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="49.6063" cy="496.17" width="99.22" height="22.6772"/>
			<rect x="0" y="484.831" width="99.2126" height="22.6772" class="st13"/>
			<text id="10040001" x="11.81" y="499.17" class="st14 conclusionPanel" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/><tspan>CON:10040001</tspan></text>		</g>
		<g id="shape188-888" v:mID="188" v:groupContext="shape" transform="translate(653.822,-48.2281)">
			<title></title>
			<desc>CON:10030001</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="49.6063" cy="496.17" width="99.22" height="22.6772"/>
			<rect x="0" y="484.831" width="99.2126" height="22.6772" class="st13"/>
			<text id="10030001" x="11.81" y="499.17" class="st14 conclusionPanel" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/><tspan>CON:10030001</tspan></text>		</g>
		<g id="shape190-891" v:mID="190" v:groupContext="shape" transform="translate(205.735,-309.795)">
			<title></title>
			<desc>R:wxfx</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="33.3071" cy="496.17" width="66.62" height="22.6772"/>
			<rect x="0" y="484.831" width="66.6142" height="22.6772" class="st13"/>
			<text x="16.25" y="499.17" class="st14" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>R:wxfx</text>		</g>
		<g id="shape191-894" v:mID="191" v:groupContext="shape" transform="translate(484.239,-308.378)">
			<title></title>
			<desc>R:hxwfx</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="33.3071" cy="496.17" width="66.62" height="22.6772"/>
			<rect x="0" y="484.831" width="66.6142" height="22.6772" class="st13"/>
			<text x="13.03" y="499.17" class="st14" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>R:hxwfx</text>		</g>
		<g id="shape192-897" v:mID="192" v:groupContext="shape" v:layerMember="0" transform="translate(365.872,-445.079)">
			<title></title>
			<g id="shadow192-898" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-1.63721,-10.3769)" class="st1">
				<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 -180 0 0 4.5 518.14 L159.22 518.14 A4.5 4.5 0 0 1 163.72 522.64 L163.72
							 525.7" class="st5"/>
			</g>
			<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 -180 0 0 4.5 518.14 L159.22 518.14 A4.5 4.5 0 0 1 163.72 522.64 L163.72
						 525.7" class="st18"/>
		</g>
		<g id="shape193-915" v:mID="193" v:groupContext="shape" transform="translate(5.68008,-480.051)">
			<title></title>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<g id="shadow193-916" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.170079,-9.98009)" class="st1">
				<rect x="0" y="490.5" width="17.0079" height="17.0079" class="st2"/>
			</g>
			<rect x="0" y="490.5" width="17.0079" height="17.0079" class="st3"/>
		</g>
		<g id="shape194-920" v:mID="194" v:groupContext="shape" transform="translate(5.68008,-449.791)">
			<title></title>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<g id="shadow194-921" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.170079,-9.98009)" class="st1">
				<rect x="0" y="490.5" width="17.0079" height="17.0079" class="st2"/>
			</g>
			<rect x="0" y="490.5" width="17.0079" height="17.0079" class="st11"/>
		</g>
		<g id="shape195-925" v:mID="195" v:groupContext="shape" transform="translate(26.4439,-477.216)">
			<title>已激活的流程</title>
			<desc>已激活的流程</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="497.508" width="85.04" height="20"/>
			<rect x="0" y="487.508" width="85.0394" height="20" class="st13"/>
			<text x="12.52" y="500.51" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>已激活的流程</text>		</g>
		<g id="shape196-928" v:mID="196" v:groupContext="shape" transform="translate(26.4439,-449.634)">
			<title>待完善的流程</title>
			<desc>待完善的流程</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="497.508" width="85.04" height="20"/>
			<rect x="0" y="487.508" width="85.0394" height="20" class="st13"/>
			<text x="12.52" y="500.51" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>待完善的流程</text>		</g>
		<g id="shape197-931" v:mID="197" v:groupContext="shape" v:layerMember="0" transform="translate(139.83,-311.212)">
			<title></title>
			<g id="shadow197-932" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-10.3847)" class="st1">
				<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 -180 0 0 4.5 518.14 L80.54 518.14 A4.5 4.5 0 0 1 85.04 522.64 L85.04
							 526.47" class="st5"/>
			</g>
			<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 -180 0 0 4.5 518.14 L80.54 518.14 A4.5 4.5 0 0 1 85.04 522.64 L85.04
						 526.47" class="st8"/>
		</g>
		<g id="shape198-947" v:mID="198" v:groupContext="shape" v:layerMember="0" transform="translate(139.83,-311.212)">
			<title></title>
			<g id="shadow198-948" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,0.850394,-10.3847)" class="st1">
				<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 0 0 1 -4.5 518.14 L-80.54 518.14 A4.5 4.5 -180 0 0 -85.04 522.64
							 L-85.04 526.47" class="st5"/>
			</g>
			<path d="M0 509.17 L0 509.53 L0 513.64 A4.5 4.5 0 0 1 -4.5 518.14 L-80.54 518.14 A4.5 4.5 -180 0 0 -85.04 522.64 L-85.04
						 526.47" class="st8"/>
		</g>
	</g>
</svg>
					</div>
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
<!-- 各页面依托JQ组件 -->
<script type="text/javascript" src="../content/js/plugins.js"></script>
<%@ include file="../footer.html" %>

</html>