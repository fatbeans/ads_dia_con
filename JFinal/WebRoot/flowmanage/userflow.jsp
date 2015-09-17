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
    		menuli.eq(2).addClass("active");
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
		xmlns:v="http://schemas.microsoft.com/visio/2003/SVGExtensions/" width="11.1688in" height="7.27035in"
		viewBox="0 0 804.154 523.465" xml:space="preserve" color-interpolation-filters="sRGB" class="st16">
	<v:documentProperties v:langID="2052" v:metric="true" v:viewMarkup="false"/>

	<style type="text/css">
	<![CDATA[
		.st1 {visibility:visible}
		.st2 {fill:#000000;fill-opacity:0.4;filter:url(#filter_3.3333334922791);stroke:#000000;stroke-linecap:round;stroke-linejoin:round;stroke-opacity:0.4}
		.st3 {fill:#76c1e7;stroke:#feffff;stroke-linecap:round;stroke-linejoin:round;stroke-opacity:0.6;stroke-width:1}
		.st4 {fill:#000000;font-family:微软雅黑;font-size:0.833336em}
		.st5 {marker-end:url(#mrkr2-27);marker-start:url(#mrkr11-25);stroke:#000000;stroke-linecap:round;stroke-linejoin:round;stroke-width:1.25}
		.st6 {fill:#000000;fill-opacity:1;stroke:#000000;stroke-opacity:1;stroke-width:0.46468401486989}
		.st7 {fill:#000000;fill-opacity:1;stroke:#000000;stroke-opacity:1;stroke-width:0.27839643652561}
		.st8 {fill:#d8d8d8;stroke:#a5a5a5;stroke-linecap:round;stroke-linejoin:round;stroke-opacity:0.6;stroke-width:1}
		.st9 {fill:#7f7f7f;font-family:微软雅黑;font-size:0.833336em}
		.st10 {fill:none;stroke:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:1}
		.st11 {fill:#d19049;font-family:微软雅黑;font-size:0.833336em;font-weight:bold}
		.st12 {font-size:1em}
		.st13 {fill:#ffffff;stroke:none;stroke-linecap:butt;stroke-width:7.2}
		.st14 {fill:#000000;font-family:黑体;font-size:0.666664em}
		.st15 {fill:#ffffff;stroke:none;stroke-linecap:butt}
		.st16 {fill:none;fill-rule:evenodd;font-size:12px;overflow:visible;stroke-linecap:square;stroke-miterlimit:3}
	]]>
	</style>

	<defs id="Markers">
		<g id="lend11">
			<path d="M 0.75 -0.75 L 0.75 0.75 L -0.75 0.75 L -0.75 -0.75 L 0.75 -0.75 " style="stroke:none"/>
		</g>
		<marker id="mrkr11-25" class="st6" v:arrowType="11" v:arrowSize="0" v:setback="1.326" refX="1.326" orient="auto"
				markerUnits="strokeWidth" overflow="visible">
			<use xlink:href="#lend11" transform="scale(2.152) "/>
		</marker>
		<g id="lend2">
			<path d="M 1 1 L 0 0 L 1 -1 L 1 1 " style="stroke:none"/>
		</g>
		<marker id="mrkr2-27" class="st7" v:arrowType="2" v:arrowSize="3" v:setback="3.592" refX="-3.592" orient="auto"
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
		<g id="shape1-1" v:mID="1" v:groupContext="shape" transform="translate(326.726,-495.051)">
			<title>开始</title>
			<desc>开始</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="33.5197" cy="512.127" width="67.04" height="22.6772"/>
			<g id="shadow1-2" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.670394,-10.2425)" class="st1">
				<path d="M0 512.13 A33.5197 11.3386 0 1 1 67.04 512.13 A33.5197 11.3386 0 1 1 0 512.13 Z" class="st2"/>
			</g>
			<path d="M0 512.13 A33.5197 11.3386 0 1 1 67.04 512.13 A33.5197 11.3386 0 1 1 0 512.13 Z" class="st3"/>
			<text x="23.52" y="515.13" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>开始</text>		</g>
		<g id="shape2-7" v:mID="2" v:groupContext="shape" transform="translate(317.726,-419.791)">
			<title>HTTP业务事件</title>
			<desc>HTTP业务事件</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="513.544" width="85.04" height="19.8425"/>
			<g id="shadow2-8" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-10.2709)" class="st1">
				<rect x="0" y="503.623" width="85.0394" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="503.623" width="85.0394" height="19.8425" class="st3"/>
			<text x="9.86" y="516.54" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>HTTP业务事件</text>		</g>
		<g id="shape6-13" v:mID="6" v:groupContext="shape" transform="translate(317.726,-460.327)">
			<title>HTTP分析</title>
			<desc>HTTP分析</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="513.544" width="85.04" height="19.8425"/>
			<g id="shadow6-14" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-10.2709)" class="st1">
				<rect x="0" y="503.623" width="85.0394" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="503.623" width="85.0394" height="19.8425" class="st3"/>
			<text x="19.86" y="516.54" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>HTTP分析</text>		</g>
		<g id="shape7-19" v:mID="7" v:groupContext="shape" v:layerMember="0" transform="translate(353.159,-495.051)">
			<title></title>
			<path d="M7.09 525.12 L7.09 525.48 L7.09 533.86" class="st5"/>
		</g>
		<g id="shape8-28" v:mID="8" v:groupContext="shape" transform="translate(49.1635,-418.374)">
			<title>TCP握手事件</title>
			<desc>TCP握手事件</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="513.544" width="85.04" height="19.8425"/>
			<g id="shadow8-29" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-10.2709)" class="st1">
				<rect x="0" y="503.623" width="85.0394" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="503.623" width="85.0394" height="19.8425" class="st8"/>
			<text x="13.25" y="516.54" class="st9" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>TCP握手事件</text>		</g>
		<g id="shape11-34" v:mID="11" v:groupContext="shape" v:layerMember="0" transform="translate(353.159,-460.327)">
			<title></title>
			<path d="M7.09 525.12 L7.09 525.48 L7.09 539.67" class="st5"/>
		</g>
		<g id="shape27-41" v:mID="27" v:groupContext="shape" transform="translate(431.841,-426.311)">
			<title></title>
			<rect x="0" y="500.788" width="85.0394" height="22.6772" class="st10"/>
		</g>
		<g id="shape28-43" v:mID="28" v:groupContext="shape" transform="translate(403.494,-418.374)">
			<title></title>
			<desc>R:ywxd</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="33.5197" cy="512.127" width="67.04" height="22.6772"/>
			<rect x="0" y="500.788" width="67.0394" height="22.6772" class="st10"/>
			<text x="15.22" y="515.13" class="st11" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>R:ywxd</text>		</g>
		<g id="shape40-46" v:mID="40" v:groupContext="shape" v:layerMember="0" transform="translate(353.159,-460.327)">
			<title></title>
			<path d="M7.09 525.12 L7.09 525.48 L7.09 539.67" class="st5"/>
		</g>
		<g id="shape93-53" v:mID="93" v:groupContext="shape" v:layerMember="0" transform="translate(360.246,-460.327)">
			<title>动态连接线.93</title>
			<path d="M0 525.12 L0 525.48 L0 527.79 A4.32283 4.32283 0 0 1 -4.32 532.11 L-264.06 532.11 A4.5 4.5 -180 0 0 -268.56
						 536.61 L-268.56 541.09" class="st5"/>
		</g>
		<g id="shape94-60" v:mID="94" v:groupContext="shape" transform="translate(141.29,-363.098)">
			<title>上网清单分析</title>
			<desc>上网清单分析</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="513.544" width="85.04" height="19.8425"/>
			<g id="shadow94-61" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-10.2709)" class="st1">
				<rect x="0" y="503.623" width="85.0394" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="503.623" width="85.0394" height="19.8425" class="st3"/>
			<text x="12.52" y="516.54" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>上网清单分析</text>		</g>
		<g id="shape95-66" v:mID="95" v:groupContext="shape" transform="translate(576.408,-363.098)">
			<title>时延分析</title>
			<desc>时延分析</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="513.544" width="85.04" height="19.8425"/>
			<g id="shadow95-67" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-10.2709)" class="st1">
				<rect x="0" y="503.623" width="85.0394" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="503.623" width="85.0394" height="19.8425" class="st3"/>
			<text x="22.52" y="516.54" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>时延分析</text>		</g>
		<g id="shape96-72" v:mID="96" v:groupContext="shape" v:layerMember="0" transform="translate(360.246,-419.791)">
			<title></title>
			<path d="M0 525.12 L0 525.48 L0 529.6 A4.5 4.5 0 0 1 -4.5 534.1 L-171.94 534.1 A4.5 4.5 -180 0 0 -176.44 538.6 L-176.44
						 555.83" class="st5"/>
		</g>
		<g id="shape97-79" v:mID="97" v:groupContext="shape" v:layerMember="0" transform="translate(360.246,-419.791)">
			<title>Dynamic connector.97</title>
			<path d="M0 525.12 L0 525.48 L0 529.6 A4.5 4.5 -180 0 0 4.5 534.1 L254.18 534.1 A4.5 4.5 0 0 1 258.68 538.6 L258.68 555.83"
					class="st5"/>
		</g>
		<g id="shape98-86" v:mID="98" v:groupContext="shape" transform="translate(6.64386,-276.642)">
			<title>是否网外资源异常</title>
			<desc>是否网外资源异常</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:prompt="" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="56.6929" cy="498.697" width="113.39" height="49.5354"/>
			<g id="shadow98-87" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-1.13386,-9.97395)" class="st1">
				<path d="M56.69 523.47 L113.39 498.7 L56.69 473.93 L0 498.7 L56.69 523.47 Z" class="st2"/>
			</g>
			<path d="M56.69 523.47 L113.39 498.7 L56.69 473.93 L0 498.7 L56.69 523.47 Z" class="st3"/>
			<text x="16.69" y="501.7" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是否网外资源异常</text>		</g>
		<g id="shape99-92" v:mID="99" v:groupContext="shape" v:layerMember="0" transform="translate(183.809,-363.098)">
			<title>动态连接线.99</title>
			<path d="M0 525.12 L0 525.48 L0 545.26 A4.5 4.5 0 0 1 -4.5 549.76 L-115.97 549.76 A4.5 4.5 -180 0 0 -120.47 554.26 L-120.47
						 555.9" class="st5"/>
		</g>
		<g id="shape100-99" v:mID="100" v:groupContext="shape" transform="translate(20.8171,-216.122)">
			<title>业务属 网外资源</title>
			<desc>业务属 网外资源</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="507.201" width="85.04" height="32.5276"/>
			<g id="shadow100-100" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-10.144)" class="st1">
				<rect x="0" y="490.938" width="85.0394" height="32.5276" class="st2"/>
			</g>
			<rect x="0" y="490.938" width="85.0394" height="32.5276" class="st3"/>
			<text x="27.52" y="504.2" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>业务属<v:newlineChar/><tspan
						x="22.52" dy="1.2em" class="st12">网外资源</tspan></text>		</g>
		<g id="shape101-106" v:mID="101" v:groupContext="shape" v:layerMember="0" transform="translate(56.2502,-276.642)">
			<title></title>
			<desc>是</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="7.08661" cy="537.461" width="40" height="18.6536"/>
			<path d="M7.09 525.12 L7.09 525.48 L7.09 546.97" class="st5"/>
			<rect v:rectContext="textBkgnd" x="3.08655" y="532.136" width="7.99997" height="10.6501" class="st13"/>
			<text x="3.09" y="540.12" class="st14" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是</text>		</g>
		<g id="shape103-115" v:mID="103" v:groupContext="shape" transform="translate(127.116,-276.642)">
			<title>响应码大于500详单占比是否达到门限</title>
			<desc>响应码大于500详单占比是否达到门限</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:prompt="" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="56.6929" cy="498.697" width="113.39" height="49.5354"/>
			<g id="shadow103-116" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-1.13386,-9.97395)" class="st1">
				<path d="M56.69 523.47 L113.39 498.7 L56.69 473.93 L0 498.7 L56.69 523.47 Z" class="st2"/>
			</g>
			<path d="M56.69 523.47 L113.39 498.7 L56.69 473.93 L0 498.7 L56.69 523.47 Z" class="st3"/>
			<text x="7.9" y="495.7" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>响应码大于500详单占<tspan
						x="21.69" dy="1.2em" class="st12">比是否达到门限</tspan></text>		</g>
		<g id="shape104-122" v:mID="104" v:groupContext="shape" transform="translate(141.29,-216.122)">
			<title>上网日志返回业务侧错误</title>
			<desc>上网日志返回业务侧错误</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="507.201" width="85.04" height="32.5276"/>
			<g id="shadow104-123" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-10.144)" class="st1">
				<rect x="0" y="490.938" width="85.0394" height="32.5276" class="st2"/>
			</g>
			<rect x="0" y="490.938" width="85.0394" height="32.5276" class="st3"/>
			<text x="7.52" y="504.2" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>上网日志返回业<tspan x="22.52"
						dy="1.2em" class="st12">务侧错误</tspan></text>		</g>
		<g id="shape105-129" v:mID="105" v:groupContext="shape" v:layerMember="0" transform="translate(176.723,-363.098)">
			<title></title>
			<path d="M7.09 525.12 L7.09 525.48 L7.09 555.9" class="st5"/>
		</g>
		<g id="shape106-136" v:mID="106" v:groupContext="shape" v:layerMember="0" transform="translate(176.723,-276.642)">
			<title></title>
			<desc>是</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="7.08661" cy="537.461" width="40" height="18.6536"/>
			<path d="M7.09 525.12 L7.09 525.48 L7.09 546.97" class="st5"/>
			<rect v:rectContext="textBkgnd" x="3.08655" y="532.136" width="7.99997" height="10.6501" class="st13"/>
			<text x="3.09" y="540.12" class="st14" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是</text>		</g>
		<g id="shape108-145" v:mID="108" v:groupContext="shape" transform="translate(247.589,-276.642)">
			<title>响应码400-500详单占比是否达到门限</title>
			<desc>响应码400-500详单占比是否达到门限</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:prompt="" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="56.6929" cy="498.697" width="113.39" height="49.5354"/>
			<g id="shadow108-146" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-1.13386,-9.97395)" class="st1">
				<path d="M56.69 523.47 L113.39 498.7 L56.69 473.93 L0 498.7 L56.69 523.47 Z" class="st2"/>
			</g>
			<path d="M56.69 523.47 L113.39 498.7 L56.69 473.93 L0 498.7 L56.69 523.47 Z" class="st3"/>
			<text x="6.94" y="495.7" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>响应码400-500详单占<tspan
						x="21.69" dy="1.2em" class="st12">比是否达到门限</tspan></text>		</g>
		<g id="shape109-152" v:mID="109" v:groupContext="shape" v:layerMember="0" transform="translate(183.809,-363.098)">
			<title></title>
			<path d="M0 525.12 L0 525.48 L0 545.26 A4.5 4.5 -180 0 0 4.5 549.76 L115.97 549.76 A4.5 4.5 0 0 1 120.47 554.26 L120.47
						 555.9" class="st5"/>
		</g>
		<g id="shape110-159" v:mID="110" v:groupContext="shape" transform="translate(261.762,-216.122)">
			<title>上网记录返回用户侧错误</title>
			<desc>上网记录返回用户侧错误</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="507.201" width="85.04" height="32.5276"/>
			<g id="shadow110-160" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-10.144)" class="st1">
				<rect x="0" y="490.938" width="85.0394" height="32.5276" class="st2"/>
			</g>
			<rect x="0" y="490.938" width="85.0394" height="32.5276" class="st3"/>
			<text x="7.52" y="504.2" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>上网记录返回用<tspan x="22.52"
						dy="1.2em" class="st12">户侧错误</tspan></text>		</g>
		<g id="shape111-166" v:mID="111" v:groupContext="shape" v:layerMember="0" transform="translate(297.195,-276.642)">
			<title></title>
			<desc>是</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="7.08661" cy="537.461" width="40" height="18.6536"/>
			<path d="M7.09 525.12 L7.09 525.48 L7.09 546.97" class="st5"/>
			<rect v:rectContext="textBkgnd" x="3.08655" y="532.136" width="7.99997" height="10.6501" class="st13"/>
			<text x="3.09" y="540.12" class="st14" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是</text>		</g>
		<g id="shape113-175" v:mID="113" v:groupContext="shape" transform="translate(411.998,-287.201)">
			<title>用户活动SGW时延分析</title>
			<desc>用户活动SGW时延分析</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="507.201" width="85.04" height="32.5276"/>
			<g id="shadow113-176" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-10.144)" class="st1">
				<rect x="0" y="490.938" width="85.0394" height="32.5276" class="st2"/>
			</g>
			<rect x="0" y="490.938" width="85.0394" height="32.5276" class="st3"/>
			<text x="5.83" y="504.2" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>用户活动SGW时<tspan
						x="27.52" dy="1.2em" class="st12">延分析</tspan></text>		</g>
		<g id="shape115-182" v:mID="115" v:groupContext="shape" transform="translate(576.408,-287.201)">
			<title>用户使用业务时延分析</title>
			<desc>用户使用业务时延分析</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="507.201" width="85.04" height="32.5276"/>
			<g id="shadow115-183" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-10.144)" class="st1">
				<rect x="0" y="490.938" width="85.0394" height="32.5276" class="st2"/>
			</g>
			<rect x="0" y="490.938" width="85.0394" height="32.5276" class="st3"/>
			<text x="7.52" y="504.2" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>用户使用业务时<tspan x="27.52"
						dy="1.2em" class="st12">延分析</tspan></text>		</g>
		<g id="shape117-189" v:mID="117" v:groupContext="shape" transform="translate(698.297,-287.201)">
			<title>用户使用终端时延分析</title>
			<desc>用户使用终端时延分析</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="507.201" width="85.04" height="32.5276"/>
			<g id="shadow117-190" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-10.144)" class="st1">
				<rect x="0" y="490.938" width="85.0394" height="32.5276" class="st2"/>
			</g>
			<rect x="0" y="490.938" width="85.0394" height="32.5276" class="st3"/>
			<text x="7.52" y="504.2" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>用户使用终端时<tspan x="27.52"
						dy="1.2em" class="st12">延分析</tspan></text>		</g>
		<g id="shape119-196" v:mID="119" v:groupContext="shape" transform="translate(397.825,-207.618)">
			<title>SGW时延是否异常</title>
			<desc>SGW时延是否异常</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:prompt="" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="56.6929" cy="498.697" width="113.39" height="49.5354"/>
			<g id="shadow119-197" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-1.13386,-9.97395)" class="st1">
				<path d="M56.69 523.47 L113.39 498.7 L56.69 473.93 L0 498.7 L56.69 523.47 Z" class="st2"/>
			</g>
			<path d="M56.69 523.47 L113.39 498.7 L56.69 473.93 L0 498.7 L56.69 523.47 Z" class="st3"/>
			<text x="15" y="501.7" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>SGW时延是否异常</text>		</g>
		<g id="shape120-202" v:mID="120" v:groupContext="shape" v:layerMember="0" transform="translate(447.431,-287.201)">
			<title></title>
			<path d="M7.09 525.12 L7.09 525.48 L7.09 549.02" class="st5"/>
		</g>
		<g id="shape121-209" v:mID="121" v:groupContext="shape" transform="translate(474.36,-149.508)">
			<title>SGW时延问题</title>
			<desc>SGW时延问题</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="513.544" width="85.04" height="19.8425"/>
			<g id="shadow121-210" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-10.2709)" class="st1">
				<rect x="0" y="503.623" width="85.0394" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="503.623" width="85.0394" height="19.8425" class="st3"/>
			<text x="10.83" y="516.54" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>SGW时延问题</text>		</g>
		<g id="shape123-215" v:mID="123" v:groupContext="shape" v:layerMember="0" transform="translate(506.959,-232.386)">
			<title></title>
			<desc>是</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="9.92126" cy="552.978" width="40" height="18.6536"/>
			<path d="M5.91 523.47 L6.27 523.47 L7.09 523.47 A2.83465 2.83465 0 0 1 9.92 526.3 L9.92 582.01" class="st5"/>
			<rect v:rectContext="textBkgnd" x="5.9212" y="547.654" width="7.99997" height="10.6501" class="st13"/>
			<text x="5.92" y="555.64" class="st14" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是</text>		</g>
		<g id="shape124-224" v:mID="124" v:groupContext="shape" transform="translate(233.416,-72.8386)">
			<title>是否弱覆盖</title>
			<desc>是否弱覆盖</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:prompt="" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="507.201" width="85.04" height="32.5276"/>
			<g id="shadow124-225" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-10.144)" class="st1">
				<path d="M42.52 523.47 L85.04 507.2 L42.52 490.94 L0 507.2 L42.52 523.47 Z" class="st2"/>
			</g>
			<path d="M42.52 523.47 L85.04 507.2 L42.52 490.94 L0 507.2 L42.52 523.47 Z" class="st3"/>
			<text x="17.52" y="510.2" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是否弱覆盖</text>		</g>
		<g id="shape125-230" v:mID="125" v:groupContext="shape" transform="translate(339.715,-72.7677)">
			<title>是否质差</title>
			<desc>是否质差</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:prompt="" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="507.166" width="85.04" height="32.5984"/>
			<g id="shadow125-231" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-10.1433)" class="st1">
				<path d="M42.52 523.47 L85.04 507.17 L42.52 490.87 L0 507.17 L42.52 523.47 Z" class="st2"/>
			</g>
			<path d="M42.52 523.47 L85.04 507.17 L42.52 490.87 L0 507.17 L42.52 523.47 Z" class="st3"/>
			<text x="22.52" y="510.17" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是否质差</text>		</g>
		<g id="shape126-236" v:mID="126" v:groupContext="shape" transform="translate(446.014,-72.7677)">
			<title>是否高负荷</title>
			<desc>是否高负荷</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:prompt="" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="507.166" width="85.04" height="32.5984"/>
			<g id="shadow126-237" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-10.1433)" class="st1">
				<path d="M42.52 523.47 L85.04 507.17 L42.52 490.87 L0 507.17 L42.52 523.47 Z" class="st2"/>
			</g>
			<path d="M42.52 523.47 L85.04 507.17 L42.52 490.87 L0 507.17 L42.52 523.47 Z" class="st3"/>
			<text x="17.52" y="510.17" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是否高负荷</text>		</g>
		<g id="shape127-242" v:mID="127" v:groupContext="shape" transform="translate(233.416,-26.437)">
			<title>无线-弱覆盖</title>
			<desc>无线-弱覆盖</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="513.544" width="85.04" height="19.8425"/>
			<g id="shadow127-243" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-10.2709)" class="st1">
				<rect x="0" y="503.623" width="85.0394" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="503.623" width="85.0394" height="19.8425" class="st3"/>
			<text x="15.36" y="516.54" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>无线-弱覆盖</text>		</g>
		<g id="shape128-248" v:mID="128" v:groupContext="shape" transform="translate(339.715,-26.437)">
			<title>无线-质差小区</title>
			<desc>无线-质差小区</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="513.544" width="85.04" height="19.8425"/>
			<g id="shadow128-249" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-10.2709)" class="st1">
				<rect x="0" y="503.623" width="85.0394" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="503.623" width="85.0394" height="19.8425" class="st3"/>
			<text x="10.36" y="516.54" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>无线-质差小区</text>		</g>
		<g id="shape129-254" v:mID="129" v:groupContext="shape" transform="translate(446.014,-26.437)">
			<title>无线-高负荷</title>
			<desc>无线-高负荷</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="513.544" width="85.04" height="19.8425"/>
			<g id="shadow129-255" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-10.2709)" class="st1">
				<rect x="0" y="503.623" width="85.0394" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="503.623" width="85.0394" height="19.8425" class="st3"/>
			<text x="15.36" y="516.54" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>无线-高负荷</text>		</g>
		<g id="shape131-260" v:mID="131" v:groupContext="shape" transform="translate(339.715,-149.508)">
			<title>无线质量分析</title>
			<desc>无线质量分析</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="513.544" width="85.04" height="19.8425"/>
			<g id="shadow131-261" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-10.2709)" class="st1">
				<rect x="0" y="503.623" width="85.0394" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="503.623" width="85.0394" height="19.8425" class="st3"/>
			<text x="12.52" y="516.54" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>无线质量分析</text>		</g>
		<g id="shape132-266" v:mID="132" v:groupContext="shape" v:layerMember="0" transform="translate(397.825,-232.386)">
			<title>Dynamic connector.132</title>
			<desc>否</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="-15.5906" cy="548.506" width="40" height="18.6536"/>
			<path d="M-1.66 523.47 L-2.02 523.47 L-11.09 523.47 A4.5 4.5 -180 0 0 -15.59 527.97 L-15.59 582.01" class="st5"/>
			<rect v:rectContext="textBkgnd" x="-19.5906" y="543.181" width="7.99997" height="10.6501" class="st15"/>
			<text x="-19.59" y="551.17" class="st14" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>否</text>		</g>
		<g id="shape133-275" v:mID="133" v:groupContext="shape" v:layerMember="0" transform="translate(382.234,-149.508)">
			<title></title>
			<path d="M0 525.12 L0 525.48 L0 542.84 A4.5 4.5 0 0 1 -4.5 547.34 L-101.8 547.34 A4.5 4.5 -180 0 0 -106.3 551.84 L-106.3
						 563.12" class="st5"/>
		</g>
		<g id="shape134-282" v:mID="134" v:groupContext="shape" v:layerMember="0" transform="translate(375.148,-149.508)">
			<title></title>
			<path d="M7.09 525.12 L7.09 525.48 L7.09 563.12" class="st5"/>
		</g>
		<g id="shape136-289" v:mID="136" v:groupContext="shape" v:layerMember="0" transform="translate(268.849,-72.8386)">
			<title></title>
			<desc>是</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="7.08661" cy="536.745" width="40" height="18.6536"/>
			<path d="M7.09 525.12 L7.09 525.48 L7.09 545.53" class="st5"/>
			<rect v:rectContext="textBkgnd" x="3.08655" y="531.42" width="7.99997" height="10.6501" class="st13"/>
			<text x="3.09" y="539.41" class="st14" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是</text>		</g>
		<g id="shape137-298" v:mID="137" v:groupContext="shape" v:layerMember="0" transform="translate(375.148,-72.7677)">
			<title></title>
			<desc>是</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="7.08661" cy="536.709" width="40" height="18.6536"/>
			<path d="M7.09 525.12 L7.09 525.48 L7.09 545.46" class="st5"/>
			<rect v:rectContext="textBkgnd" x="3.08655" y="531.384" width="7.99997" height="10.6501" class="st13"/>
			<text x="3.09" y="539.37" class="st14" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是</text>		</g>
		<g id="shape138-307" v:mID="138" v:groupContext="shape" v:layerMember="0" transform="translate(481.447,-72.7677)">
			<title></title>
			<desc>是</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="7.08661" cy="536.709" width="40" height="18.6536"/>
			<path d="M7.09 525.12 L7.09 525.48 L7.09 545.46" class="st5"/>
			<rect v:rectContext="textBkgnd" x="3.08655" y="531.384" width="7.99997" height="10.6501" class="st13"/>
			<text x="3.09" y="539.37" class="st14" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是</text>		</g>
		<g id="shape139-316" v:mID="139" v:groupContext="shape" transform="translate(562.234,-207.618)">
			<title>业务时延是否异常</title>
			<desc>业务时延是否异常</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:prompt="" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="56.6929" cy="498.697" width="113.39" height="49.5354"/>
			<g id="shadow139-317" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-1.13386,-9.97395)" class="st1">
				<path d="M56.69 523.47 L113.39 498.7 L56.69 473.93 L0 498.7 L56.69 523.47 Z" class="st2"/>
			</g>
			<path d="M56.69 523.47 L113.39 498.7 L56.69 473.93 L0 498.7 L56.69 523.47 Z" class="st3"/>
			<text x="16.69" y="501.7" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>业务时延是否异常</text>		</g>
		<g id="shape140-322" v:mID="140" v:groupContext="shape" v:layerMember="0" transform="translate(611.841,-287.201)">
			<title></title>
			<path d="M7.09 525.12 L7.09 525.48 L7.09 549.02" class="st5"/>
		</g>
		<g id="shape141-329" v:mID="141" v:groupContext="shape" transform="translate(576.408,-149.508)">
			<title>业务时延问题</title>
			<desc>业务时延问题</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="513.544" width="85.04" height="19.8425"/>
			<g id="shadow141-330" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-10.2709)" class="st1">
				<rect x="0" y="503.623" width="85.0394" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="503.623" width="85.0394" height="19.8425" class="st3"/>
			<text x="12.52" y="516.54" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>业务时延问题</text>		</g>
		<g id="shape143-335" v:mID="143" v:groupContext="shape" v:layerMember="0" transform="translate(611.841,-207.618)">
			<title></title>
			<desc>是</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="7.08661" cy="542.599" width="40" height="18.6536"/>
			<path d="M7.09 525.12 L7.09 525.48 L7.09 557.24" class="st5"/>
			<rect v:rectContext="textBkgnd" x="3.08655" y="537.274" width="7.99997" height="10.6501" class="st13"/>
			<text x="3.09" y="545.26" class="st14" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是</text>		</g>
		<g id="shape144-344" v:mID="144" v:groupContext="shape" transform="translate(684.124,-207.618)">
			<title>终端时延是否异常</title>
			<desc>终端时延是否异常</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:prompt="" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="56.6929" cy="498.697" width="113.39" height="49.5354"/>
			<g id="shadow144-345" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-1.13386,-9.97395)" class="st1">
				<path d="M56.69 523.47 L113.39 498.7 L56.69 473.93 L0 498.7 L56.69 523.47 Z" class="st2"/>
			</g>
			<path d="M56.69 523.47 L113.39 498.7 L56.69 473.93 L0 498.7 L56.69 523.47 Z" class="st3"/>
			<text x="16.69" y="501.7" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>终端时延是否异常</text>		</g>
		<g id="shape145-350" v:mID="145" v:groupContext="shape" transform="translate(698.297,-149.508)">
			<title>终端质量问题</title>
			<desc>终端质量问题</desc>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="513.544" width="85.04" height="19.8425"/>
			<g id="shadow145-351" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.850394,-10.2709)" class="st1">
				<rect x="0" y="503.623" width="85.0394" height="19.8425" class="st2"/>
			</g>
			<rect x="0" y="503.623" width="85.0394" height="19.8425" class="st3"/>
			<text x="12.52" y="516.54" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>终端质量问题</text>		</g>
		<g id="shape147-356" v:mID="147" v:groupContext="shape" v:layerMember="0" transform="translate(733.73,-287.201)">
			<title></title>
			<path d="M7.09 525.12 L7.09 525.48 L7.09 549.02" class="st5"/>
		</g>
		<g id="shape148-363" v:mID="148" v:groupContext="shape" v:layerMember="0" transform="translate(733.73,-207.618)">
			<title></title>
			<desc>是</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="7.08661" cy="542.599" width="40" height="18.6536"/>
			<path d="M7.09 525.12 L7.09 525.48 L7.09 557.24" class="st5"/>
			<rect v:rectContext="textBkgnd" x="3.08655" y="537.274" width="7.99997" height="10.6501" class="st13"/>
			<text x="3.09" y="545.26" class="st14" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>是</text>		</g>
		<g id="shape149-372" v:mID="149" v:groupContext="shape" v:layerMember="0" transform="translate(611.841,-363.098)">
			<title></title>
			<path d="M7.09 525.12 L7.09 525.48 L7.09 562.35" class="st5"/>
		</g>
		<g id="shape150-379" v:mID="150" v:groupContext="shape" v:layerMember="0" transform="translate(618.927,-363.098)">
			<title></title>
			<path d="M0 525.12 L0 525.48 L0 545.69 A4.5 4.5 0 0 1 -4.5 550.19 L-159.91 550.19 A4.5 4.5 -180 0 0 -164.41 554.69 L-164.41
						 562.35" class="st5"/>
		</g>
		<g id="shape151-386" v:mID="151" v:groupContext="shape" v:layerMember="0" transform="translate(618.927,-363.098)">
			<title></title>
			<path d="M0 525.12 L0 525.48 L0 546.7 A4.5 4.5 -180 0 0 4.5 551.2 L117.39 551.2 A4.5 4.5 0 0 1 121.89 555.7 L121.89 562.35"
					class="st5"/>
		</g>
		<g id="shape152-393" v:mID="152" v:groupContext="shape" transform="translate(20.8171,-190.61)">
			<title></title>
			<desc>CON:10050001</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="512.127" width="85.04" height="22.6772"/>
			<rect x="0" y="500.788" width="85.0394" height="22.6772" class="st10"/>
			<text id="10050001" x="4.72" y="515.13" class="st11 conclusionPanel" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/><tspan>CON:10050001</tspan></text>		</g>
		<g id="shape153-396" v:mID="153" v:groupContext="shape" transform="translate(141.29,-190.61)">
			<title></title>
			<desc>CON:10060001</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="512.127" width="85.04" height="22.6772"/>
			<rect x="0" y="500.788" width="85.0394" height="22.6772" class="st10"/>
			<text id="10060001" x="4.72" y="515.13" class="st11 conclusionPanel" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/><tspan>CON:10060001</tspan></text>		</g>
		<g id="shape154-399" v:mID="154" v:groupContext="shape" transform="translate(261.762,-190.61)">
			<title></title>
			<desc>CON:10030010</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="512.127" width="85.04" height="22.6772"/>
			<rect x="0" y="500.788" width="85.0394" height="22.6772" class="st10"/>
			<text id="10030010" x="4.72" y="515.13" class="st11 conclusionPanel" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/><tspan>CON:10030010</tspan></text>		</g>
		<g id="shape155-402" v:mID="155" v:groupContext="shape" transform="translate(233.416,-0.5)">
			<title></title>
			<desc>CON:10010001</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="512.127" width="85.04" height="22.6772"/>
			<rect x="0" y="500.788" width="85.0394" height="22.6772" class="st10"/>
			<text id="10010001" x="4.72" y="515.13" class="st11 conclusionPanel" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/><tspan>CON:10010001</tspan></text>		</g>
		<g id="shape156-405" v:mID="156" v:groupContext="shape" transform="translate(339.715,-0.5)">
			<title></title>
			<desc>CON:10010002</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="512.127" width="85.04" height="22.6772"/>
			<rect x="0" y="500.788" width="85.0394" height="22.6772" class="st10"/>
			<text id="10010002" x="4.72" y="515.13" class="st11 conclusionPanel" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/><tspan>CON:10010002</tspan></text>		</g>
		<g id="shape157-408" v:mID="157" v:groupContext="shape" transform="translate(446.014,-0.5)">
			<title></title>
			<desc>CON:10010003</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="512.127" width="85.04" height="22.6772"/>
			<rect x="0" y="500.788" width="85.0394" height="22.6772" class="st10"/>
			<text id="10010003" x="4.72" y="515.13" class="st11 conclusionPanel" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/><tspan>CON:10010003</tspan></text>		</g>
		<g id="shape158-411" v:mID="158" v:groupContext="shape" transform="translate(474.36,-119.744)">
			<title></title>
			<desc>CON:10020003</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="512.127" width="85.04" height="22.6772"/>
			<rect x="0" y="500.788" width="85.0394" height="22.6772" class="st10"/>
			<text id="10020003" x="4.72" y="515.13" class="st11 conclusionPanel" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/><tspan>CON:10020003</tspan></text>		</g>
		<g id="shape159-414" v:mID="159" v:groupContext="shape" transform="translate(576.408,-119.744)">
			<title></title>
			<desc>CON:10060002</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="512.127" width="85.04" height="22.6772"/>
			<rect x="0" y="500.788" width="85.0394" height="22.6772" class="st10"/>
			<text id="10060002" x="4.72" y="515.13" class="st11 conclusionPanel" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/><tspan>CON:10060002</tspan></text>		</g>
		<g id="shape160-417" v:mID="160" v:groupContext="shape" transform="translate(698.297,-119.744)">
			<title></title>
			<desc>CON:10040001</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="512.127" width="85.04" height="22.6772"/>
			<rect x="0" y="500.788" width="85.0394" height="22.6772" class="st10"/>
			<text id="10040001" x="4.72" y="515.13" class="st11 conclusionPanel" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/><tspan>CON:10040001</tspan></text>		</g>
		<g id="shape161-420" v:mID="161" v:groupContext="shape" transform="translate(690.75,-494.972)">
			<title></title>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<g id="shadow161-421" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.170079,-10.2992)" class="st1">
				<rect x="0" y="506.457" width="17.0079" height="17.0079" class="st2"/>
			</g>
			<rect x="0" y="506.457" width="17.0079" height="17.0079" class="st3"/>
		</g>
		<g id="shape162-425" v:mID="162" v:groupContext="shape" transform="translate(690.75,-464.713)">
			<title></title>
			<v:userDefs>
				<v:ud v:nameU="visVersion" v:val="VT0(15):26"/>
			</v:userDefs>
			<g id="shadow162-426" v:groupContext="shadow" v:shadowOffsetX="7.2E-008" v:shadowOffsetY="0" v:shadowType="1"
					v:shadowScale="1.02" transform="matrix(1.02,0,0,1.02,-0.170079,-10.2992)" class="st1">
				<rect x="0" y="506.457" width="17.0079" height="17.0079" class="st2"/>
			</g>
			<rect x="0" y="506.457" width="17.0079" height="17.0079" class="st8"/>
		</g>
		<g id="shape163-430" v:mID="163" v:groupContext="shape" transform="translate(711.514,-492.138)">
			<title>已激活的流程</title>
			<desc>已激活的流程</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="513.465" width="85.04" height="20"/>
			<rect x="0" y="503.465" width="85.0394" height="20" class="st10"/>
			<text x="12.52" y="516.47" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>已激活的流程</text>		</g>
		<g id="shape164-433" v:mID="164" v:groupContext="shape" transform="translate(711.514,-464.555)">
			<title>待完善的流程</title>
			<desc>待完善的流程</desc>
			<v:textBlock v:margins="rect(4,4,4,4)" v:tabSpace="42.5197"/>
			<v:textRect cx="42.5197" cy="513.465" width="85.04" height="20"/>
			<rect x="0" y="503.465" width="85.0394" height="20" class="st10"/>
			<text x="12.52" y="516.47" class="st4" v:langID="2052"><v:paragraph v:horizAlign="1"/><v:tabList/>待完善的流程</text>		</g>
		<g id="shape165-436" v:mID="165" v:groupContext="shape" v:layerMember="0" transform="translate(382.234,-149.508)">
			<title></title>
			<path d="M0 525.12 L0 525.48 L0 544.67 A4.5 4.5 -180 0 0 4.5 549.17 L101.8 549.17 A4.5 4.5 0 0 1 106.3 553.67 L106.3
						 563.12" class="st5"/>
		</g>
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
<!-- 各页面依托JQ组件 -->
<script type="text/javascript" src="../content/js/plugins.js"></script>
<%@ include file="../footer.html" %>

</html>