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
    		menuli.eq(0).addClass("active");
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
		xmlns:v="http://schemas.microsoft.com/visio/2003/SVGExtensions/" width="8.84597in" height="3.94489in"
		viewBox="0 0 636.91 284.032" xml:space="preserve" color-interpolation-filters="sRGB" class="st13">
	<v:documentProperties v:langID="2052" v:metric="true" v:viewMarkup="false"/>

	<style type="text/css">
	<![CDATA[
		.st1 {visibility:visible}
		.st2 {fill:#000000;fill-opacity:0.4;filter:url(#filter_3.3333334922791);stroke:#000000;stroke-linecap:round;stroke-linejoin:round;stroke-opacity:0.4}
		.st3 {fill:#76c1e7;stroke:#feffff;stroke-linecap:round;stroke-linejoin:round;stroke-opacity:0.6;stroke-width:1}
		.st4 {fill:#000000;font-family:微软雅黑;font-size:0.833336em}
		.st5 {fill:none;stroke:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:1}
		.st6 {fill:#d19049;font-family:微软雅黑;font-size:0.833336em;font-weight:bold}
		.st7 {font-size:1em}
		.st8 {marker-end:url(#mrkr2-49);marker-start:url(#mrkr11-47);stroke:#000000;stroke-linecap:round;stroke-linejoin:round;stroke-width:1.25}
		.st9 {fill:#000000;fill-opacity:1;stroke:#000000;stroke-opacity:1;stroke-width:0.46468401486989}
		.st10 {fill:#000000;fill-opacity:1;stroke:#000000;stroke-opacity:1;stroke-width:0.27839643652561}
		.st11 {fill:#ffffff;stroke:none;stroke-linecap:butt;stroke-width:7.2}
		.st12 {fill:#000000;font-family:黑体;font-size:0.666664em}
		.st13 {fill:none;fill-rule:evenodd;font-size:12px;overflow:visible;stroke-linecap:square;stroke-miterlimit:3}
		.st-dis {fill:#d8d8d8;stroke:#a5a5a5;stroke-linecap:round;stroke-linejoin:round;stroke-opacity:0.6;stroke-width:1}
	]]>
	</style>

	<defs id="Markers">
		<g id="lend11">
			<path d="M 0.75 -0.75 L 0.75 0.75 L -0.75 0.75 L -0.75 -0.75 L 0.75 -0.75 " style="stroke:none"/>
		</g>
		<marker id="mrkr11-47" class="st9" v:arrowType="11" v:arrowSize="0" v:setback="1.326" refX="1.326" orient="auto"
				markerUnits="strokeWidth" overflow="visible">
			<use xlink:href="#lend11" transform="scale(2.152) "/>
		</marker>
		<g id="lend2">
			<path d="M 1 1 L 0 0 L 1 -1 L 1 1 " style="stroke:none"/>
		</g>
		<marker id="mrkr2-49" class="st10" v:arrowType="2" v:arrowSize="3" v:setback="3.592" refX="-3.592" orient="auto"
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
		<g id="shape1-1" v:mID="1" v:groupContext="shape" transform="translate(279.266,-255.618)">
			<title>开始</title>
			<desc>开始</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="33.5197" cy="272.693" width="67.04" height="22.6772"/>
			<g id="shadow1-2" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.670394,-5.45387)" class="st1">
				<path d="M0 272.69 A33.5197 11.3386 0 1 1 67.04 272.69 A33.5197 11.3386 0 1 1 0 272.69 Z" class="st2"/>
			</g>
			<path d="M0 272.69 A33.5197 11.3386 0 1 1 67.04 272.69 A33.5197 11.3386 0 1 1 0 272.69 Z" class="st3"/>
			<text x="23.52" y="275.69" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>开始</text>		</g>
		<g id="shape10-7" v:mID="10" v:groupContext="shape" transform="translate(6.64386,-28.8465)">
			<title>用户感染手机病毒</title>
			<desc>用户感染手机病毒</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="56.6929" cy="267.768" width="113.39" height="32.5276"/>
			<g id="shadow10-8" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-1.13386,-5.35537)" class="st1">
				<rect x="0" y="251.504" width="113.386" height="32.5276" class="st2"/>
			</g>
			<rect x="0" y="251.504" width="113.386" height="32.5276" class="st3"/>
			<text x="16.69" y="270.77" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>用户感染手机病毒</text>		</g>
		<g id="shape11-13" v:mID="11" v:groupContext="shape" transform="translate(125.699,-28.8465)">
			<title>用户访问非法地址</title>
			<desc>用户访问非法地址</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="56.6929" cy="267.768" width="113.39" height="32.5276"/>
			<g id="shadow11-14" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-1.13386,-5.35537)" class="st1">
				<rect x="0" y="251.504" width="113.386" height="32.5276" class="st2"/>
			</g>
			<rect x="0" y="251.504" width="113.386" height="32.5276" class="st3"/>
			<text x="16.69" y="270.77" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>用户访问非法地址</text>		</g>
		<g id="shape12-19" v:mID="12" v:groupContext="shape" transform="translate(256.093,-28.8465)">
			<title>用户没有产生上网记录</title>
			<desc>用户没有产生上网记录</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="56.6929" cy="267.768" width="113.39" height="32.5276"/>
			<g id="shadow12-20" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-1.13386,-5.35537)" class="st1">
				<rect x="0" y="251.504" width="113.386" height="32.5276" class="st2"/>
			</g>
			<rect x="0" y="251.504" width="113.386" height="32.5276" class="st3"/>
			<text x="6.69" y="270.77" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>用户没有产生上网记录</text>		</g>
		<g id="shape13-25" v:mID="13" v:groupContext="shape" transform="translate(20.8171,-0.5)">
			<title></title>
			<desc>CON:10030002</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="272.693" width="85.04" height="22.6772"/>
			<rect x="0" y="261.355" width="85.0394" height="22.6772" class="st5"/>
			<text id="10030002" title="用户感染手机病毒" x="4.72" y="275.69" class="st6 conclusionPanel" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/><tspan>CON:10030002</tspan> </text></g>
		<g id="shape14-28" v:mID="14" v:groupContext="shape" transform="translate(139.872,-0.5)">
			<title></title>
			<desc>CON:10030003</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="272.693" width="85.04" height="22.6772"/>
			<rect x="0" y="261.355" width="85.0394" height="22.6772" class="st5"/>
			<text id="10030003" title="用户访问非法地址" x="4.72" y="275.69" class="st6 conclusionPanel" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/><tspan>CON:10030003</tspan></text>		</g>
		<g id="shape15-31" v:mID="15" v:groupContext="shape" transform="translate(270.266,-0.5)">
			<title></title>
			<desc>CON:10030004</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="272.693" width="85.04" height="22.6772"/>
			<rect x="0" y="261.355" width="85.0394" height="22.6772" class="st5"/>
			<text id="10030004" title="用户没有产生上网记录"  x="4.72" y="275.69" class="st6 conclusionPanel" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/><tspan font-size="10">CON:10030004</tspan></text>		</g>
		<g id="shape19-34" v:mID="19" v:groupContext="shape" transform="translate(6.64386,-113.886)">
			<title>用户是否在病毒库用户列表</title>
			<desc>用户是否在病毒库用户列表</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:prompt="" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="56.6929" cy="259.264" width="113.39" height="49.5354"/>
			<g id="shadow19-35" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-1.13386,-5.18529)" class="st1">
				<path d="M56.69 284.03 L113.39 259.26 L56.69 234.5 L0 259.26 L56.69 284.03 Z" class="st2"/>
			</g>
			<path d="M56.69 284.03 L113.39 259.26 L56.69 234.5 L0 259.26 L56.69 284.03 Z" class="st3"/>
			<text x="6.69" y="256.26" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>用户是否在病毒库用户<tspan
						x="46.69" dy="1.2em" class="st7">列表</tspan></text>		</g>
		<g id="shape21-41" v:mID="21" v:groupContext="shape" v:layerMember="0" transform="translate(56.2502,-113.886)">
			<title></title>
			<desc>是</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="7.08661" cy="310.288" width="40" height="18.6536"/>
			<path d="M7.09 285.69 L7.09 286.05 L7.09 332.05" class="st8"/>
			<rect v:rectContext="textBkgnd" x="3.08655" y="304.963" width="7.99997" height="10.6501" class="st11"/>
			<text x="3.09" y="312.95" class="st12" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是</text>		</g>
		<g id="shape22-52" v:mID="22" v:groupContext="shape" transform="translate(125.699,-113.886)">
			<title>用户访问IP是否在IP封堵库内</title>
			<desc>用户访问IP是否在IP封堵库内</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:prompt="" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="56.6929" cy="259.264" width="113.39" height="49.5354"/>
			<g id="shadow22-53" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-1.13386,-5.18529)" class="st1">
				<path d="M56.69 284.03 L113.39 259.26 L56.69 234.5 L0 259.26 L56.69 284.03 Z" class="st2"/>
			</g>
			<path d="M56.69 284.03 L113.39 259.26 L56.69 234.5 L0 259.26 L56.69 284.03 Z" class="st3"/>
			<text x="7.64" y="256.26" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>用户访问IP是否在IP封<tspan
						x="41.69" dy="1.2em" class="st7">堵库内</tspan></text>		</g>
		<g id="shape23-59" v:mID="23" v:groupContext="shape" transform="translate(256.093,-113.886)">
			<title></title>
			<desc>查询时段是否没有用户上网记录</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:prompt="" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="56.6929" cy="259.264" width="113.39" height="49.5354"/>
			<g id="shadow23-60" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-1.13386,-5.18529)" class="st1">
				<path d="M56.69 284.03 L113.39 259.26 L56.69 234.5 L0 259.26 L56.69 284.03 Z" class="st2"/>
			</g>
			<path d="M56.69 284.03 L113.39 259.26 L56.69 234.5 L0 259.26 L56.69 284.03 Z" class="st3"/>
			<text x="6.69" y="256.26" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>查询时段是否没有用户<tspan
						x="36.69" dy="1.2em" class="st7">上网记录</tspan></text>		</g>
		<g id="shape24-66" v:mID="24" v:groupContext="shape" transform="translate(386.486,-113.886)">
			<title>用户终端是否在终端案例库中</title>
			<desc>用户终端是否在终端案例库中</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:prompt="" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="56.6929" cy="259.264" width="113.39" height="49.5354"/>
			<g id="shadow24-67" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-1.13386,-5.18529)" class="st1">
				<path d="M56.69 284.03 L113.39 259.26 L56.69 234.5 L0 259.26 L56.69 284.03 Z" class="st2"/>
			</g>
			<path d="M56.69 284.03 L113.39 259.26 L56.69 234.5 L0 259.26 L56.69 284.03 Z" class="st-dis"/>
			<text x="6.69" y="256.26" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>用户终端是否在终端案<tspan
						x="41.69" dy="1.2em" class="st7">例库中</tspan></text>		</g>
		<g id="shape25-73" v:mID="25" v:groupContext="shape" transform="translate(516.88,-113.886)">
			<title>查询时段是否访问高流量业务</title>
			<desc>查询时段是否访问高流量业务</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:prompt="" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="56.6929" cy="259.264" width="113.39" height="49.5354"/>
			<g id="shadow25-74" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-1.13386,-5.18529)" class="st1">
				<path d="M56.69 284.03 L113.39 259.26 L56.69 234.5 L0 259.26 L56.69 284.03 Z" class="st2"/>
			</g>
			<path d="M56.69 284.03 L113.39 259.26 L56.69 234.5 L0 259.26 L56.69 284.03 Z" class="st3"/>
			<text x="6.69" y="256.26" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>查询时段是否访问高流<tspan
						x="41.69" dy="1.2em" class="st7">量业务</tspan></text>		</g>
		<g id="shape26-80" v:mID="26" v:groupContext="shape" transform="translate(386.486,-28.8465)">
			<title>用户终端有异常</title>
			<desc>用户终端有异常</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="56.6929" cy="267.768" width="113.39" height="32.5276"/>
			<g id="shadow26-81" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-1.13386,-5.35537)" class="st1">
				<rect x="0" y="251.504" width="113.386" height="32.5276" class="st2"/>
			</g>
			<rect x="0" y="251.504" width="113.386" height="32.5276" class="st-dis"/>
			<text x="21.69" y="270.77" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>用户终端有异常</text>		</g>
		<g id="shape27-86" v:mID="27" v:groupContext="shape" transform="translate(516.88,-28.8465)">
			<title>用户访问较多容易产生高流量的业务</title>
			<desc>用户访问较多容易产生高流量的业务</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="56.6929" cy="267.768" width="113.39" height="32.5276"/>
			<g id="shadow27-87" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-1.13386,-5.35537)" class="st1">
				<rect x="0" y="251.504" width="113.386" height="32.5276" class="st2"/>
			</g>
			<rect x="0" y="251.504" width="113.386" height="32.5276" class="st3"/>
			<text x="6.69" y="264.77" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>用户访问较多容易产生<tspan
						x="26.69" dy="1.2em" class="st7">高流量的业务</tspan></text>		</g>
		<g id="shape32-93" v:mID="32" v:groupContext="shape" v:layerMember="0" transform="translate(175.305,-113.886)">
			<title></title>
			<desc>是</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="7.08661" cy="310.288" width="40" height="18.6536"/>
			<path d="M7.09 285.69 L7.09 286.05 L7.09 332.05" class="st8"/>
			<rect v:rectContext="textBkgnd" x="3.08655" y="304.963" width="7.99997" height="10.6501" class="st11"/>
			<text x="3.09" y="312.95" class="st12" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是</text>		</g>
		<g id="shape33-102" v:mID="33" v:groupContext="shape" v:layerMember="0" transform="translate(305.699,-113.886)">
			<title></title>
			<desc>是</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="7.08661" cy="310.288" width="40" height="18.6536"/>
			<path d="M7.09 285.69 L7.09 286.05 L7.09 332.05" class="st8"/>
			<rect v:rectContext="textBkgnd" x="3.08655" y="304.963" width="7.99997" height="10.6501" class="st11"/>
			<text x="3.09" y="312.95" class="st12" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是</text>		</g>
		<g id="shape34-111" v:mID="34" v:groupContext="shape" v:layerMember="0" transform="translate(436.093,-113.886)">
			<title></title>
			<desc>是</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="7.08661" cy="310.288" width="40" height="18.6536"/>
			<path d="M7.09 285.69 L7.09 286.05 L7.09 332.05" class="st8"/>
			<rect v:rectContext="textBkgnd" x="3.08655" y="304.963" width="7.99997" height="10.6501" class="st11"/>
			<text x="3.09" y="312.95" class="st12" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是</text>		</g>
		<g id="shape35-120" v:mID="35" v:groupContext="shape" v:layerMember="0" transform="translate(566.486,-113.886)">
			<title></title>
			<desc>是</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="7.08661" cy="310.288" width="40" height="18.6536"/>
			<path d="M7.09 285.69 L7.09 286.05 L7.09 332.05" class="st8"/>
			<rect v:rectContext="textBkgnd" x="3.08655" y="304.963" width="7.99997" height="10.6501" class="st11"/>
			<text x="3.09" y="312.95" class="st12" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是</text>		</g>
		<g id="shape36-129" v:mID="36" v:groupContext="shape" transform="translate(400.66,-0.5)">
			<title></title>
			<desc>CON:10040004</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="272.693" width="85.04" height="22.6772"/>
			<rect x="0" y="261.355" width="85.0394" height="22.6772" class="st5"/>
			<text id="10040004"  title="用户终端有异常" x="4.72" y="275.69" class="st6" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/><tspan></tspan></text></g>
		<g id="shape37-132" v:mID="37" v:groupContext="shape" transform="translate(531.053,-0.5)">
			<desc>CON:10030005</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="272.693" width="85.04" height="22.6772"/>
			<rect x="0" y="261.355" width="85.0394" height="22.6772" class="st5"/>
			<text id="10030005" title="用户访问较多容易产生高流量的业务" x="4.72" y="275.69" class="st6 conclusionPanel" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/><tspan>CON:10030005</tspan></text>		</g>
		<g id="shape46-135" v:mID="46" v:groupContext="shape" v:layerMember="0" transform="translate(312.786,-255.618)">
			<path d="M0 285.69 L0 286.05 L0 310.71 A4.5 4.5 0 0 1 -4.5 315.21 L-125.89 315.21 A4.5 4.5 -180 0 0 -130.39 319.71 L-130.39
						 371.74" class="st8"/>
		</g>
		<g id="shape47-142" v:mID="47" v:groupContext="shape" v:layerMember="0" transform="translate(305.699,-255.618)">
			<path d="M7.09 285.69 L7.09 286.05 L7.09 371.74" class="st8"/>
		</g>
		<g id="shape48-149" v:mID="48" v:groupContext="shape" v:layerMember="0" transform="translate(312.786,-255.618)">
			<path d="M0 285.69 L0 286.05 L0 310.71 A4.5 4.5 -180 0 0 4.5 315.21 L125.89 315.21 A4.5 4.5 0 0 1 130.39 319.71 L130.39
						 371.74" class="st8"/>
		</g>
		<g id="shape56-156" v:mID="56" v:groupContext="shape" v:layerMember="0" transform="translate(312.786,-224.437)">
			<path d="M1.66 284.03 L2.02 284.03 L256.29 284.03 A4.5 4.5 0 0 1 260.79 288.53 L260.79 340.56" class="st8"/>
		</g>
		<g id="shape57-163" v:mID="57" v:groupContext="shape" v:layerMember="0" transform="translate(312.786,-255.618)">
			<path d="M0 285.69 L0 286.05 L0 310.71 A4.5 4.5 0 0 1 -4.5 315.21 L-244.95 315.21 A4.5 4.5 -180 0 0 -249.45 319.71 L-249.45
						 371.74" class="st8"/>
		</g>
	</g>
</svg>


						
                </div>
            </div>
        </div>
        <!-- 右边数据-e -->
        <!-- 左边列表-s -->
        <div class="col-2-l320 fr" >
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