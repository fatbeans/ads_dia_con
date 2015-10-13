(function($) {
	//单行组件
	$.fn.LineItems = function() {
		var _$me = $(this);
		var _thisObj = this;
		var settings = {
			lineHeight:25,
			lineNumber:1,
			textWidth:80,
			isMulti:true,
			isCancel:true,
			hasAll:false,
			name:"",
			key:"",
			labelField:"name",
			valueField:"key",
			datas:[]
		};
		var methods = {
			_create : function(){
				_$me.empty();
				_$me.addClass("lineitems");
				if(settings.name != null && settings.name != ""){
					_$me.append("<div class='lineitems-text' style='width:"+settings.textWidth+"px'>"
							+settings.name+"</div>");
				}
				_$me.append("<div class='lineitems-area'></div>");
				var lineChoose = $(".lineitems-area",_$me);
				if(settings.hasAll){
					lineChoose.append("<span class='lineitems-all lineitems-active'>全部</span>");
				}
				lineChoose.width(_$me.width() - _$me.find("div.lineitems-text").outerWidth());
				var htmlArr = ["<div class='lineitems-fold'><ul class='lineitems-list'>"];
				htmlArr.push("</ul></div>");
				htmlArr.push("<div class='lineitems-option'>" +
						"<span class='lineitems-more lineitems-more-down'><b></b>更多</span></div>");
				lineChoose.append(htmlArr.join("\n"));
				if(settings.hasAll){
					lineChoose.find("div.lineitems-fold").width(lineChoose.width()- 50);
				}
				if(settings.loadUrl != null && settings.loadUrl != ""){
					_thisObj._loadData(settings.loadUrl,settings.param,function(data){
						settings.datas = data.datas;
						_thisObj._createItems(settings.datas,settings.selectDatas);
						_thisObj._resize();
					});
				}else{
					_thisObj._createItems(settings.datas,settings.selectDatas);
					_thisObj._resize();
				}
				if(!settings.isMulti && settings.selectDatas != null && settings.selectDatas.length > 0){
					var selEls = $("li.lineitems-li>span.lineitems-active",_$me);
					settings.oldChooseEl = selEls.eq(0).parent();
				}else{
					settings.oldChooseEl = null;
				}
				lineChoose.delegate(".lineitems-li","click",function(event){
					var targetEl = $(event.currentTarget);
					//已经被选中，有可能被删除，有可能保留不做任何动作
					if(targetEl.children("span").hasClass("lineitems-active")){
						if(settings.isCancel){//选中再点击的时候 取消选中
							_thisObj._removeItem(event,targetEl);
							return ;
						}
						if(settings.oldChooseEl.attr("attr") == targetEl.attr("attr")){
							return ;
						}
					}
					//判断是否移除之前选择的
					if(!settings.isMulti && settings.oldChooseEl != null){//不是多选
						_thisObj._removeItem(event,settings.oldChooseEl);
						settings.oldChooseEl = null;
					}
					settings.oldChooseEl = targetEl;
					_thisObj._addItem(event,targetEl);
				});
				if(settings.hasAll){
					$(".lineitems-all",lineChoose).bind("click",function(event){
						var spanEl = $(event.currentTarget);
						spanEl.toggleClass('lineitems-active');
						if(spanEl.hasClass('lineitems-active')){
							var brotherEls = $("li",$(".lineitems-fold",_$me));
							for(var b=0;b<brotherEls.length;b++){
								brotherEls.eq(b).children("span").removeClass('lineitems-active');
							}
							if(settings.selectChangeHandle != null && typeof(settings.selectChangeHandle) == "function"){
								settings.selectChangeHandle();
							}
						}
					});
				}else{
					
				}
				$(".lineitems-option",_$me).click(function(event){
					var targetEl = $(event.currentTarget);
					var spanEl = targetEl.find("span");
					if(spanEl.text() == "更多"){
						$("ul.lineitems-list",_$me).css({"height":"auto"});
						spanEl.removeClass("lineitems-more-down").addClass("lineitems-more-up");
						spanEl.html("<b></b>收起");
					}else if(spanEl.text() == "收起"){
						$("ul.lineitems-list",_$me).height(settings.lineHeight*(settings.lineNumber+1));
						spanEl.removeClass("lineitems-more-up").addClass("lineitems-more-down");
						spanEl.html("<b></b>更多");
					}
					if(settings.heightChangeHandle != null && typeof(settings.heightChangeHandle) == "function"){
						settings.heightChangeHandle();
					}
				});
				this.settings = settings;
				_$me.data("JSObject",this);
			},
			_resize : function(){
				if($(".lineitems-list",_$me).height() <= settings.lineHeight*(settings.lineNumber+1)){
					$(".lineitems-option",_$me).hide();
				}else{
					$(".lineitems-list",_$me).height(settings.lineHeight*(settings.lineNumber+1));
				}
				if(!settings.hasAll){
					$(".lineitems-fold",_$me).css({"left":"0"});
				}
			},
			_loadData : function(dataUrl,param,callHandle){
				/*
				$.ajax({
		        	type: 'post',
		        	url: dataUrl,
		        	data: param,
		        	dataType: 'json',
		        	success: function (_data, _textStatus) {
		        		callHandle(_data);
					},
		        	error: function (XMLHttpRequest, textStatus, errorThrown) {
		        		
		            }
			    });*/
			    ajaxJsonpPost(dataUrl,param,callHandle);
			},
			_addItem : function(event,itemEl){
				var el = $("span",itemEl);
				el.addClass("lineitems-active");
				if(settings.hasAll){
					$(".lineitems-all",_$me).removeClass("lineitems-active");
				}
				if(settings.itemSelectHandle != null && typeof(settings.itemSelectHandle) == "function"){
					settings.itemSelectHandle(event,itemEl,_thisObj.getData(itemEl.attr("attr")));
				}
			},
			_removeItem : function(event,itemEl,linkEvent){
				if(linkEvent == null){
					linkEvent = true;
				}
				var el = $("span",itemEl);
				el.removeClass("lineitems-active");
				var brotherEls = itemEl.siblings();
				if(this.hasAll){
					var flag = true;
					for(var b=0;b<brotherEls.length;b++){
						if(brotherEls.eq(b).hasClass('lineitems-active')){
							flag = false;
							break; 
						}
					}
					if(flag){
						$(".lineitems-all",_$me).addClass("lineitems-active");
					}
				}
				if(linkEvent){
					if(settings.itemCancelHandle != null && typeof(settings.itemCancelHandle) == "function"){
						settings.itemCancelHandle(event,itemEl,_thisObj.getData(itemEl.attr("attr")));
					}
				}
			},
			_createItems : function(datas,selectDatas){
				if(selectDatas == null ){
					selectDatas = [];
				}
				var htmlArr = [];
				if(datas.length > 1000){
					return ;
				}
				for(var d=0;d<datas.length;d++){
					var dataObj = datas[d];
					var selected = ""
					for(var s=0;s<selectDatas.length;s++){
						if(dataObj[settings.valueField] == selectDatas[s].key ){
							selected = " class='lineitems-active'";
							break;
						}
					}
					htmlArr.push("<li class='lineitems-li' attr='"+dataObj[settings.valueField]+"'>" +
						"<span "+selected+">"+dataObj[settings.labelField]+"</span></li>");
				}
				$(".lineitems-list",_$me).html(htmlArr.join("\n"));
			},
			setDatas : function(datas,selectDatas){
				$.extend(true,settings,_$me.data("JSObject").settings);
				settings.datas = datas;
				settings.selectDatas = selectDatas;
				_thisObj._createItems(datas,selectDatas);
				if(settings.selectChangeHandle != null && typeof(settings.selectChangeHandle) == "function"){
					settings.selectChangeHandle();
				}
				if(!settings.isMulti && selectDatas != null && selectDatas.length > 0){
					var selEls = $("li.lineitems-li>span.lineitems-active",_$me);
					settings.oldChooseEl = selEls.eq(0).parent();
				}else{
					settings.oldChooseEl = null;
				}
				this.settings = settings;
				_$me.data("JSObject",this);
			},
			deleteData : function(data,linkEvent){
				$.extend(true,settings,_$me.data("JSObject").settings);
				if(linkEvent == null){
					linkEvent = true;
				}
				var liArr = $(".lineitems-li",_$me);
				for(var a=0;a<liArr.length;a++){
					if(liArr.eq(a).attr("attr") == data.key){
						this._removeItem(null,liArr.eq(a),linkEvent);
						return true;
					}
				}
				return false;
			},
			getData : function(key){
				if(_$me.data("JSObject") != null){
					$.extend(true,settings,_$me.data("JSObject").settings);
				}
				for(var d=0;d<settings.datas.length;d++){
					if(settings.datas[d][settings.valueField] == key){
						return settings.datas[d];
					}
				}
				return null;
			},
			getItemEl : function(key){
				if(_$me.data("JSObject") != null){
					$.extend(true,settings,_$me.data("JSObject").settings);
				}
				var liArr = $(".lineitems-li[attr="+key+"]",_$me);
				return liArr;
			},
			getSelectDatas : function(){
				if(_$me.data("JSObject") != null){
					$.extend(true,settings,_$me.data("JSObject").settings);
				}
				var selDatas = [];
				var liArr = $(".lineitems-li",_$me);
				for(var a=0;a<liArr.length;a++){
					var liEl = liArr.eq(a);
					if(liEl.children("span").hasClass("lineitems-active")){
						selDatas.push(_thisObj.getData(liEl.attr("attr")));
					}
				}
				return selDatas;
			},
			setSelectDatas : function(selDatas){
				if(_$me.data("JSObject") != null){
					$.extend(true,settings,_$me.data("JSObject").settings);
				}
				for(var s=0;s<selDatas.length;s++){
					var liArr = $(".lineitems-li[attr="+selDatas.key+"]",_$me);
					if(liArr.length > 0){
						liArr.children("span").addClass("lineitems-active");
					}
				}
			},
			setName : function(nameStr){
				if(_$me.data("JSObject") != null){
					$.extend(true,settings,_$me.data("JSObject").settings);
				}
				settings.name = nameStr;
				$(".lineitems-text",_$me).text(nameStr);
			},
			getLineHeight : function(){
				return Math.max($(".lineitems-list",_$me).height(),_$me.outerHeight());
			},
			show : function(){
				_$me.show();
			},
			hide : function(){
				_$me.hide();
			},
			isSelectAll : function(){
				return _$me.find(".lineitems-all").hasClass("lineitems-active");
			}
		};
		$.extend(this,methods);
		var arguParam = arguments[0];
		if(typeof(arguParam) == 'object'){//第一个参数是对象，是初始化或赋属性值
			$.extend(true,settings,arguParam);
			methods["_create"]();
		}else if(typeof(arguParam) == 'string'){//第一个参数是字符串，调用方法
			if(arguParam.substr(0,1) == "_"){
				return ;
			}
			var otherArgu = Array.prototype.slice.call(arguments, 1);
			return this[arguParam].apply(this,otherArgu);
		}
	}
})(jQuery);
var idIndex = 1;
$.getIndex = function(){return idIndex++;}
$.browser = {};
$.browser.mozilla = /firefox/.test(navigator.userAgent.toLowerCase());
$.browser.webkit = /webkit/.test(navigator.userAgent.toLowerCase());
$.browser.opera = /opera/.test(navigator.userAgent.toLowerCase());
$.browser.msie = /msie/.test(navigator.userAgent.toLowerCase());
Array.prototype.indexOf = function(item){
	for(var a=0;a<this.length;a++){
		if(this[a] == item){
			return a;
		}
	}
	return -1;
}
function getClientWidth(){
	if(document.documentElement){
		return document.documentElement.clientWidth;
	}else if(document.body){
		return document.body.clientWidth;
	}
	return $(body).width();
}
function getClientHeight(){
	if(document.documentElement){
		return document.documentElement.clientHeight;
	}else if(document.body){
		return document.body.clientHeight;
	}
	return $(body).height();
}
function windowWidth() {
	var g, h;
	var browser = $.browser || $.support;
	if (browser.msie) {
		g = Math.max(document.documentElement.scrollWidth, document.body.scrollWidth);
		h = Math.max(document.documentElement.offsetWidth, document.body.offsetWidth);
		if (g < h) {
			return $(window).width();
		} else {
			return g;
		}
	} else {
		return $(document).width();
	}
}
function windowHeight(){
	var h, g;
	var browser = $.browser || $.support;
	if (browser.msie && browser.version < 7) {
		h = Math.max(document.documentElement.scrollHeight, document.body.scrollHeight);
		g = Math.max(document.documentElement.offsetHeight, document.body.offsetHeight);
		if (h < g) {
			return $(window).height();
		} else {
			return h;
		}
	} else {
		return $(document).height();
	}
}
function LineExpandItem(config){
	if(config == null || config.render == null){
		return ;
	}
	var paramters = {
			lineHeight:24,
			lineNumber:1,
			textWidth:80,
			labelField:"name",
			valueField:"key",
			isMulti:true,
			isCancel:true,
			hasAll:false,
			name:"",
			key:"",
			datas:[],
			selectDatas:[],
			filter:[],
			filterValue:"",
			filterCallHandle:null
		};
	$.extend(this,paramters);
	var _$me = this;
	$.extend(this,config);
	this.init = function(){
		this.render.empty();
		this.render.addClass("lineitems");
		if(this.name != null && this.name != ""){
			this.render.append("<div class='lineitems-text' style='width:"+this.textWidth+"px'>"+this.name+"</div>");
		}
		this.render.append("<div class='lineitems-area'></div>");
		var lineChoose = $(".lineitems-area",this.render);
		if(this.hasAll){
			lineChoose.append("<span class='lineitems-all lineitems-active'>全部</span>");
		}
		lineChoose.width(this.render.width() - this.render.find("div.lineitems-text").outerWidth() - 20);
		if(this.filter != null && this.filter.length > 0){
			var filterHtml = ["<div class='lineitem-filter' style='display:block;line-height:24px;height:30px'>"];
			for(var f=0;f<this.filter.length;f++){
				var filterObj = this.filter[f];
				var checked = "";
				if(filterObj[this.valueField] == this.filterValue){
					checked = " checked='checked'"
				}
				filterHtml.push("<div class='lineitems-filter-item'>" +
					"<input type='radio' name='lineFilterRadio' value='" + 
					this.filter[f][this.valueField]+"'"+checked+"/>"+this.filter[f][this.labelField]+"</div>");
			}
			filterHtml.push("</div>");
			lineChoose.append(filterHtml.join("\n"));
			lineChoose.find("input[type=radio][name=lineFilterRadio]").click(function(event){
				var targetEl = $(event.currentTarget);
				var filterVal = targetEl.attr("value");
				if(filterVal == _$me.filterValue){
					return ;
				}else{
					_$me.filterValue = filterVal;
					for(var f=0;f<_$me.filter.length;f++){
						var filterObj = _$me.filter[f];
						var checked = "";
						if(filterObj[_$me.valueField] == _$me.filterValue){
							if(_$me.filterCallHandle != null && typeof(_$me.filterCallHandle) == "function"){
								_$me.filterCallHandle(filterObj);
								break;
							}
						}
					}
				}
			});
		}
		var htmlArr = ["<div class='lineitems-fold'><ul class='lineitems-list'>"];
		htmlArr.push("</ul></div>");
		htmlArr.push("<div class='lineitems-option'>" +
				"<span class='lineitems-more lineitems-more-down'><b></b>更多</span></div>");
		lineChoose.append(htmlArr.join("\n"));
		this._createItems(this.datas,this.selectDatas);
		if(!this.isMulti && this.selectDatas != null && this.selectDatas.length > 0){
			var selEls = $("li.lineitems-li>span.lineitems-active",this.render);
			this.oldChooseEl = selEls.eq(0).parent();
		}else{
			this.oldChooseEl = null;
		}
		lineChoose.delegate(".lineitems-li","click",function(event){
			var targetEl = $(event.currentTarget);
			if(targetEl.children("span").hasClass("lineitems-active")){//已经被选中，有可能被删除，有可能保留不做任何动作
				if(_$me.isCancel){//选中再点击的时候 取消选中
					_$me._removeItem(event,targetEl);
					return ;
				}
				if(_$me.oldChooseEl.attr("attr") == targetEl.attr("attr")){
					return ;
				}
			}
			//判断是否移除之前选择的
			if(!_$me.isMulti && _$me.oldChooseEl != null){//不是多选
				_$me._removeItem(event,_$me.oldChooseEl,false);
				_$me.oldChooseEl = null;
			}
			_$me.oldChooseEl = targetEl;
			_$me._addItem(event,targetEl);
		});
		if(this.hasAll){
			$(".lineitems-all",lineChoose).bind("click",function(event){
				var spanEl = $(event.currentTarget);
				spanEl.addClass('lineitems-active');
				var brotherEls = $("li",$(".lineitems-fold",_$me.render));
				for(var b=0;b<brotherEls.length;b++){
					brotherEls.eq(b).children("span").removeClass('lineitems-active');
				}
				if(_$me.selectChangeHandle != null && typeof(_$me.selectChangeHandle) == "function"){
					_$me.selectChangeHandle();
				}
			});
		}else{
			
		}
		this._resize();
		$(".lineitems-option",this.render).click(function(event){
			var targetEl = $(event.currentTarget);
			if(_$me.moreItemHandle != null && typeof(_$me.moreItemHandle) == "function"){
				if(_$me.moreItemHandle() === false){
					return ;
				}
			}
			var spanEl = targetEl.find("span");
			if(spanEl.text() == "更多"){
				$("ul.lineitems-list",_$me.render).css({"height":"auto"});
				spanEl.removeClass("lineitems-more-down").addClass("lineitems-more-up");
				spanEl.html("<b></b>收起");
			}else if(spanEl.text() == "收起"){
				$("ul.lineitems-list",_$me.render).height(_$me.lineHeight*(_$me.lineNumber+1));
				spanEl.removeClass("lineitems-more-up").addClass("lineitems-more-down");
				spanEl.html("<b></b>更多");
			}
			if(_$me.heightChangeHandle != null && typeof(_$me.heightChangeHandle) == "function"){
				_$me.heightChangeHandle();
			}
		});
	}
	this._resize = function(){
		if($(".lineitems-list",this.render).height() <= this.lineHeight*(this.lineNumber+1)){
			$(".lineitems-option",this.render).hide();
		}else{
			$(".lineitems-list",this.render).height(this.lineHeight*(this.lineNumber+1));
			$(".lineitems-option",this.render).show();
		}
		if(!this.hasAll){
			$(".lineitems-fold",this.render).css({"left":"0"});
		}
	}
	this._addItem = function(event,itemEl){
		var el = $("span",itemEl);
		el.addClass("lineitems-active");
		if(this.hasAll){
			$(".lineitems-all",this.render).removeClass("lineitems-active");
		}
		if(this.itemSelectHandle != null && typeof(this.itemSelectHandle) == "function"){
			_$me.itemSelectHandle(event,itemEl,this.getData(itemEl.attr("attr")));
		}
	}
	this._removeItem = function(event,itemEl,linkEvent){
		if(linkEvent == null){
			linkEvent = true;
		}
		var el = $("span",itemEl);
		el.removeClass("lineitems-active");
		var brotherEls = itemEl.siblings();
		if(this.hasAll){
			var flag = true;
			for(var b=0;b<brotherEls.length;b++){
				if(brotherEls.eq(b).hasClass('lineitems-active')){
					flag = false;
					break; 
				}
			}
			if(flag){
				$(".lineitems-all",this.render).addClass("lineitems-active");
			}
		}
		if(linkEvent){
			if(this.itemCancelHandle != null && typeof(this.itemCancelHandle) == "function"){
				this.itemCancelHandle(event,itemEl,this.getData(itemEl.attr("attr")));
			}
		}
	}
	this._createItems = function(datas,selectDatas){
		if(selectDatas == null ){
			selectDatas = [];
		}
		var htmlArr = [];
		for(var d=0;d<datas.length;d++){
			var dataObj = datas[d];
			var selected = ""
			for(var s=0;s<selectDatas.length;s++){
				if(dataObj[this.valueField] == selectDatas[s][this.valueField] ){
					selected = " class='lineitems-active'";
					break;
				}
			}
			htmlArr.push("<li class='lineitems-li' attr='"+dataObj[this.valueField]+"'>" +
				"<span "+selected+">"+dataObj[this.labelField]+"</span></li>");
		}
		$(".lineitems-list",this.render).html(htmlArr.join("\n"));
	}
	this.setDatas = function(datas,selectDatas){
		this.datas = datas;
		this.selectDatas = selectDatas;
		this._createItems(datas,selectDatas);
		if(this.selectChangeHandle != null && typeof(this.selectChangeHandle) == "function"){
			this.selectChangeHandle();
		}
		if(!this.isMulti && selectDatas != null && selectDatas.length > 0){
			var selEls = $("li.lineitems-li>span.lineitems-active",this.render);
			this.oldChooseEl = selEls.eq(0).parent();
		}else{
			this.oldChooseEl = null;
		}
		$("ul.lineitems-list",_$me.render).css({"height":"auto"});
		$(".lineitems-option",_$me.render).hide();
		this._resize();
	}
	this.deleteData = function(data,linkEvent){
		if(linkEvent == null){
			linkEvent = true;
		}
		var liArr = $(".lineitems-li",this.render);
		for(var a=0;a<liArr.length;a++){
			if(liArr.eq(a).attr("attr") == data[this.valueField]){
				this._removeItem(null,liArr.eq(a),linkEvent);
				return true;
			}
		}
		return false;
	}
	this.getData = function(key){
		for(var d=0;d<this.datas.length;d++){
			if(this.datas[d][this.valueField] == key){
				return this.datas[d];
			}
		}
		return null;
	}
	this.getItemEl = function(key){
		var liArr = $(".lineitems-li[attr="+key+"]",this.render);
		return liArr;
	}
	this.getSelectDatas = function(){
		var selDatas = [];
		var liArr = $(".lineitems-li",this.render);
		for(var a=0;a<liArr.length;a++){
			var liEl = liArr.eq(a);
			if(liEl.children("span").hasClass("lineitems-active")){
				selDatas.push(this.getData(liEl.attr("attr")));
			}
		}
		return selDatas;
	}
	this.setSelectDatas = function(selDatas){
		this.render.find(".lineitems-li>span.lineitems-active").removeClass("lineitems-active");
		
		for(var s=0;s<selDatas.length;s++){
			var liArr = $(".lineitems-li[attr="+selDatas[s][this.valueField]+"]",this.render);
			if(liArr.length > 0){
				liArr.children("span").addClass("lineitems-active");
			}
			if(this.isMulti === false && s == selDatas.length -1){
				this.oldChooseEl = liArr;
			}
		}
	}
	this.setName = function(nameStr){
		this.name = nameStr;
		$(".lineitems-text",this.render).text(nameStr);
	}
	this.insertData = function(itemData,index){
		var liArr = $(".lineitems-li[attr="+itemData[this.valueField]+"]",this.render);
		if(liArr.length > 0){
			liArr.insertBefore(this.render.find("ul.lineitems-list").children("li:eq("+index+")"));
		}else{
			$("<li class='lineitems-li' attr='"+itemData[this.valueField]+"'><span>"+
				itemData[this.labelField]+"</span></li>")
				.insertBefore(this.render.find("ul.lineitems-list").children("li:eq("+index+")"));
		}
	}
	this.getLineHeight = function(){
		return Math.max($(".lineitems-list",this.render).height(),this.render.outerHeight());
	}
	this.getRealValue = function(){
		var selDatas = [];
		var liArr = $(".lineitems-li",this.render);
		for(var a=0;a<liArr.length;a++){
			var liEl = liArr.eq(a);
			if(liEl.children("span").hasClass("lineitems-active")){
				selDatas.push(this.getData(liEl.attr("attr"))[this.valueField]);
			}
		}
		return selDatas.join(",");
	}
	this.show = function(){
		this.render.show();
	}
	this.hide = function(){
		this.render.hide();
	}
	this.init();
}

function FilterItem(config){
	if(config == null || config.render == null){
		return ;
	}
	var paramters = {
			textWidth:80,
			name:"",
			key:"",
			filterName:"",
			filterValue:"",
			filterHandle:null
		};
	$.extend(this,paramters);
	var _$me = this;
	var filterOld = "";
	$.extend(this,config);
	this.init = function(){
		this.render.empty();
		this.render.addClass("lineitems");
		if(this.name != null && this.name != ""){
			this.render.append("<div class='lineitems-text' style='width:"+this.textWidth+"px'>"+this.name+"</div>");
		}
		this.render.append("<div class='lineitems-area'></div>");
		var lineChoose = $(".lineitems-area",this.render);
		lineChoose.html("<div class='choose-filter' style='position:relative;top:1px;display:inline-block;'>" +
			"<input key='filterInput' type='text' class='select-input'" + 
			" value='请输入"+this.filterName+"...' style='margin-left: 0px;width:200px;'/>" +
			"<span key='filterSearch' class='search-image-btn'/>" +
			"</div>").width(300);
		this.render.find("input[key=filterInput]").focus(function(event){
			if(_$me.render.find("input[key=filterInput]").val() == "请输入"+_$me.filterName+"..."){
				_$me.render.find("input[key=filterInput]").val("");
			}
		}).blur(function(event){
			if($.trim(_$me.render.find("input[key=filterInput]").val()) == ""){
				_$me.render.find("input[key=filterInput]").val("请输入"+_$me.filterName+"...");
			}
		});
		this.render.find("span[key=filterSearch]").click(function(event){
			var filterValue = $.trim(_$me.render.find("input[key=filterInput]").val());
			if(filterOld == filterValue){
				return ;
			}
			if("请输入"+_$me.filterName+"..." == filterValue){
				filterOld = "";
			}else{
				filterOld = filterValue;
			}
			if(_$me.filterHandle != null && typeof(_$me.filterHandle) == 'function'){
				_$me.filterHandle(filterValue);
			}
		});
	}
	this.getRealValue = function(){
		var filterValue = this.render.find("input[key=filterInput]").val();
		if(filterValue == "请输入"+this.filterName+"..."){
			return "";
		}
		return filterValue;
	}
	this.init();
}