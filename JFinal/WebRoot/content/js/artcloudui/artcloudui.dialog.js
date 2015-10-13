/// <reference path="../../jquery-1.11.0.min.js" />

//;(function (factory) {
//    if (typeof define === "function" && define.amd) {
//        // AMD模式
//        define(["jquery"], factory);
//    } else {
//        // 全局模式
//        factory(jQuery);
//    }
//}
//);
(function ($) {

    $.fn.extend({
        dialog: function (options) {
            var defaults = {
                obj: $(this),
                operate: ""
            };
            if (typeof options == "string") {
                defaults.operate = options;
            } else {
                $.extend(defaults, options);
            }
            $.artcloud.dialog(defaults);
        },

        loading: function (options) {
            var defaults = {
                obj: $(this),
                text: "loading...",
                operate: ""
            };
            if (typeof options == "string") {
                if (options.toLowerCase() == "close") {
                    defaults.operate = "close";
                } else {
                    defaults.text = options;
                }
            } else {
                $.extend(defaults, options);
            }
            $.artcloud.loading(defaults);
        }
    });

    var artCloud = function () {

        var baseObj = {};
        baseObj.zindex = 3000;
        baseObj.moduleList = []; //{ ident: "", module: null, drag: null, content: null, close: null, shead: null };
        baseObj.boxDefinition = {
            //头
            header: null,
            //描述
            summary: null,
            //底部
            bottom: null,
            //边框
            border: null
        };
        this.baseObj = baseObj;

        //GUID
        var newGuid = function () {
            var guid = "";
            for (var i = 1; i <= 32; i++) {
                var n = Math.floor(Math.random() * 16.0).toString(16);
                guid += n;
                if ((i == 8) || (i == 12) || (i == 16) || (i == 20))
                    guid += "-";
            }
            return guid;
        };

        //遮照
        var shade = function (id) {
            if (!id) {
                alert("shade ident not value.");
                return;
            }
            var shadeid = "shade" + id;
            var shadeObj = $("div[acui-shade=" + shadeid + "]");

            this.create = function (zindex, targetObj) {
                var width = document.documentElement.scrollWidth;   //文档高度
                var height = document.documentElement.scrollHeight;  //文档宽度
                width = width < $(window).width() ? $(window).width() : width;
                height = height < $(window).height() ? $(window).height() : height;
                var shade;
                if (shadeObj.length > 0) {
                    shade = shadeObj;
                } else {
                    if (targetObj) {
                        shade = $("<div class='acui-shade'/>").attr("acui-shade", "shade" + id).css({ "z-index": zindex, "position": "absolute" }).appendTo($(targetObj));
                    } else {
                        shade = $("<div class='acui-shade'/>").attr("acui-shade", "shade" + id).css({ "z-index": zindex }).appendTo("body");
                    }
                }
                shade.fadeIn(300);
                return shade;
            };

            this.show = function () {
                if (shadeObj.length > 0) {
                    shadeObj.fadeIn(300);
                }
            };

            this.hide = function () {
                if (shadeObj.length > 0) {
                    shadeObj.fadeOut(300);
                }
            };

            this.clear = function () {
                if (shadeObj.length > 0) {
                    shadeObj.remove();
                }
            };
        };

        //拖动
        var dragAction = function (dragObj, targetObj) {
            if (!dragObj || !targetObj) {
                return;
            }
            var dragObjmousedown = function (e) {
                $(this).addClass("acui-dialog-move");
                var p = { o_left: 0, o_top: 0, width: 0, height: 0, ismove: false };
                p.ismove = true;
                e = e || window.event;
                if (e.preventDefault) {
                    e.preventDefault();
                }
                p.o_left = e.clientX - targetObj.offsetLeft;
                p.o_top = e.clientY - targetObj.offsetTop;
                p.width = $(targetObj).width();
                p.height = $(targetObj).height();

                var docmouseup = function (ue) {
                    p.ismove = false;
                    $(dragObj).removeClass("acui-dialog-move");
                };
                var docmousemove = function (oe) {
                    if (p.ismove) {
                        oe = window.event ? window.event : oe;

                        var left = p.o_left >= oe.clientX ? 0 : oe.clientX - p.o_left;
                        var top = p.o_top >= oe.clientY ? 0 : oe.clientY - p.o_top;

                        var screenWidth = $(window).width();// document.documentElement.scrollWidth;   //文档高度
                        var screenHeight = $(window).height();// document.documentElement.scrollHeight;  //文档宽度
                        if (screenWidth - oe.clientX <= p.width - p.o_left) {
                            left = screenWidth - p.width;
                        }
                        if (screenHeight - oe.clientY <= p.height - p.o_top) {
                            top = screenHeight - p.height;
                        }
                        $(targetObj).css({ "left": left + "px", "top": top + "px", "margin": "0" });
                    }
                };

                removeEventHandler(document, "mouseup", docmouseup);
                addEventHandler(document, "mouseup", docmouseup);

                removeEventHandler(document, "mousemove", docmousemove);
                addEventHandler(document, "mousemove", docmousemove);
            };

            removeEventHandler(dragObj, "mousedown", dragObjmousedown);
            addEventHandler(dragObj, "mousedown", dragObjmousedown);
        };

        /** 获取BOX定义(适用于带边框透明图片)
         */
        var setBoxdefinition = function () {
            if (!baseObj.boxDefinition || !baseObj.boxDefinition.header || !baseObj.boxDefinition.border) {
                var tempboxPanel = $('<div class="acui-dialog-box">'
                                + '<div class="acui-dialog-header">'
                                    + '<span class="acui-header-icon">&nbsp;</span>'
                                    + '<span class="acui-header-title">标题</span>'
                                    + '<button class="acui-header-close" type="button"></button>'
                                + '</div>'
                                + '<div class="acui-dialog-conten">'
                                    + '<div class="acui-content-summary">'
                                        + '<div class="acui-content-summary-content">'
                                            + '<p class="acui-content-summary-title"></p>'
                                            + '<p class="acui-content-summary-text"></p>'
                                        + '</div>'
                                    + '</div>'
                                    + '<div class="acui-content-widget">'
                                        + '<div id="dialogPanel"></div>'
                                    + '</div>'
                                    + '<div class="acui-content-butombar"></div>'
                                + '</div>'
                                + '<div class="acui-resizable-handle acui-resizable-t"></div>'
                                + '<div class="acui-resizable-handle acui-resizable-r"></div>'
                                + '<div class="acui-resizable-handle acui-resizable-b"></div>'
                                + '<div class="acui-resizable-handle acui-resizable-l"></div>'
                                + '<div class="acui-resizable-handle acui-resizable-tl"></div>'
                                + '<div class="acui-resizable-handle acui-resizable-tr"></div>'
                                + '<div class="acui-resizable-handle acui-resizable-br"></div>'
                                + '<div class="acui-resizable-handle acui-resizable-bl"></div>'
                            + '</div>').appendTo("body");
                baseObj.boxDefinition = {
                    header: {
                        height: tempboxPanel.find(".acui-dialog-header").height()
                    },
                    summary: {
                        height: tempboxPanel.find(".acui-content-summary").height()
                    },
                    bottom: {
                        height: tempboxPanel.find(".acui-content-butombar").height()
                    },
                    border: {
                        top: tempboxPanel.find(".acui-resizable-t").height(),
                        right: tempboxPanel.find(".acui-resizable-r").width(),
                        bottom: tempboxPanel.find(".acui-resizable-b").height(),
                        left: tempboxPanel.find(".acui-resizable-l").width()
                    }
                };
                tempboxPanel.remove();
            }
            return baseObj.boxDefinition;
        };

        this.newGuid = newGuid;
        this.shade = shade;
        this.dragAction = dragAction;

        /** 添加事件
        *  @oTarget 需要添加事件的DOM元素
        *  @sEventType 事件名称
        *  @fnHandler 事件函数
        */
        var addEventHandler = function (oTarget, sEventType, fnHandler) {
            if (oTarget.addEventListener) {
                oTarget.addEventListener(sEventType, fnHandler, false);
            } else if (oTarget.attachEvent) {
                oTarget.attachEvent("on" + sEventType, fnHandler);
            } else {
                oTarget["on" + sEventType] = fnHandler;
            }
        };

        /** 删除事件
        *  @target 需要删除事件的DOM元素
        *  @eventName 事件名称
        *  @func 事件函数
        */
        var removeEventHandler = function (target, eventName, func) {
            if (target.detachEvent) {
                target.detachEvent('on' + eventName, func);
            } else if (target.removeEventListener) {
                target.removeEventListener(eventName, func, false);
            } else {
                target['on' + eventName] = null;
            };
        };

        this.dialog = function (options) {

            //获取
            var getboxObj = function () {
                var result = {};
                for (var i = 0; i < baseObj.moduleList.length; i++) {
                    if (baseObj.moduleList[i] && baseObj.moduleList[i].ident && baseObj.moduleList[i].ident == mObj.ident) {
                        result = baseObj.moduleList[i];
                        break;
                    }
                }
                return result;
            };

            /* 组装弹出层
            * @param 参数
            * @zindex
            */
            var boxpack = function (param, zindex) {

                var ts = this;
                ts.module = { ident: "", module: null, drag: null, header: null, content: null, close: null, shead: null };
                ts.param = param;
                ts.zindex = zindex;

                this.createModule = function (ident, cobj) {
                    ts.module.ident = ident;

                    ts.module.module = $('<div class="acui-dialog-box"/>').attr("acui-dialog", "box" + ts.module.ident).css({
                        "width": ts.param.width,
                        "height": ts.param.height,
                        "z-index": ts.zindex,
                        "margin-left": -(ts.param.width / 2) + "px",
                        "margin-top": -(ts.param.height / 2) + "px"
                    });
                    ts.module.header = createHeader();
                    ts.module.drag = ts.module.header;
                    ts.module.content = createContent(cobj);

                    ts.module.module.append(ts.module.drag);
                    ts.module.module.append(ts.module.content);
                    var twidth = ts.param.width - baseObj.boxDefinition.border.left - baseObj.boxDefinition.border.right;
                    var rheight = ts.param.height - baseObj.boxDefinition.border.top - baseObj.boxDefinition.header.height - baseObj.boxDefinition.border.bottom;
                    ts.module.module.append($('<div class="acui-resizable-handle acui-resizable-t">').css("width", twidth));
                    ts.module.module.append($('<div class="acui-resizable-handle acui-resizable-r">').css("height", rheight));
                    ts.module.module.append($('<div class="acui-resizable-handle acui-resizable-b">').css("width", twidth));
                    ts.module.module.append($('<div class="acui-resizable-handle acui-resizable-l">').css("height", rheight));
                    ts.module.module.append($('<div class="acui-resizable-handle acui-resizable-tl">'));
                    ts.module.module.append($('<div class="acui-resizable-handle acui-resizable-tr">'));
                    ts.module.module.append($('<div class="acui-resizable-handle acui-resizable-br">'));
                    ts.module.module.append($('<div class="acui-resizable-handle acui-resizable-bl">'));

                    return ts.module;
                };

                var createHeader = function () {
                    ts.module.close = $('<button class="acui-header-close" type="button">');
                    var header = $("<div class='acui-dialog-header'/>");
                    header.append($('<span class="acui-header-icon">&nbsp;</span>'));
                    header.append($('<span class="acui-header-title">' + param.title + '</span>'));
                    if (ts.param.drag) {
                        $.artcloud.dragAction(header[0], ts.module.module[0]);
                    }
                    ts.module.close.click(function () {
                        new $.artcloud.shade(ts.module.ident).hide();

                        ts.module.module.fadeOut(150);
                        if (param.onclose) {
                            param.onclose();
                        }
                    });
                    header.append(ts.module.close);
                    return header;
                };

                var createContent = function (cobj) {
                    var cheight = param.height - baseObj.boxDefinition.border.top - baseObj.boxDefinition.header.height - baseObj.boxDefinition.border.bottom;
                    var content = $('<div class="acui-dialog-conten"/>');
                    if (param.summary && param.summary.title && param.summary.text) {
                        var summary = $('<div class="acui-content-summary">'
                        + '                <div class="acui-content-summary-content">'
                        + '                   <p class="acui-content-summary-title">' + param.summary.title + '</p>'
                        + '                   <p class="acui-content-summary-text">' + param.summary.text + '</p>'
                        + '                </div>'
                        + '            </div>');
                        content.append(summary);
                        cheight = cheight - baseObj.boxDefinition.summary.height;
                    }

                    var widget = $('<div class="acui-content-widget" />');
                    widget.append(cobj.show());
                    content.append(widget);

                    if (param.buttom && param.buttom.length > 0) {
                        var buttomPanel = $('<div class="acui-content-butombar"/>');
                        for (var i = 0; i < param.buttom.length; i++) {
                            var bobj = param.buttom[i];
                            if (bobj) {
                                var text = bobj.text || "";
                                var btnfClass = "acui-content-butombar-btnsub";
                                var btnclass = "acui-submit";
                                if (bobj.type && bobj.type == "canel") {
                                    btnclass = "acui-button";
                                    btnfClass = "acui-content-butombar-btnbut";
                                }
                                var buttom = $('<a class="acui-content-butombar-btnf" href="javascript:void(0)"/>').css("margin-left", 10 + "px");
                                buttom.addClass(btnfClass);
                                $('<input type="button" />').addClass(btnclass).val(text).appendTo(buttom);

                                if (bobj.click || bobj.type == "canel") {
                                    buttom.click(function () {
                                        var cindex = $(this).parent(".acui-content-butombar").children(".acui-content-butombar-btnf").index($(this));
                                        var currentBtn = param.buttom[cindex];
                                        if (currentBtn.type && currentBtn.type == "canel") {
                                            ts.module.close.click();
                                        }
                                        if (currentBtn.click) {
                                            currentBtn.click($(this));
                                        }
                                    });
                                }
                                buttomPanel.append(buttom);
                            }
                        }
                        content.append(buttomPanel);
                        cheight = cheight - 35;
                    }
                    widget.css("height", cheight);
                    return content;
                };

            };

            /* 重新绑定值
            * @param 参数
            * @mObj
            */
            var binding = function (param, mObj) {
                if (mObj && mObj.content) {
                    //重新绑定标题名称
                    mObj.header.children(".acui-header-title").text(param.title);

                    //重新绑定描述
                    if (param.summary) {
                        var sumPanel = mObj.content.children(".acui-content-summary").children(".acui-content-summary-content");
                        sumPanel.children(".acui-content-summary-title").text(param.summary.title || "");
                        sumPanel.children(".acui-content-summary-text").text(param.summary.text || "");
                    }

                    //重新绑定按钮事件
                    var buttomPanel = mObj.content.children(".acui-content-butombar");
                    buttomPanel.empty();
                    for (var i = 0; i < param.buttom.length; i++) {
                        var bobj = param.buttom[i];
                        if (bobj) {
                            var text = bobj.text || "";
                            var btnfClass = "acui-content-butombar-btnsub";
                            var btnclass = "acui-submit";
                            if (bobj.type && bobj.type == "canel") {
                                btnclass = "acui-button";
                                btnfClass = "acui-content-butombar-btnbut";
                            }
                            var buttom = $('<a class="acui-content-butombar-btnf" href="javascript:void(0)"/>').css("margin-left", 10 + "px");
                            buttom.addClass(btnfClass);
                            $('<input type="button" />').addClass(btnclass).val(text).appendTo(buttom);

                            if (bobj.click || bobj.type == "canel") {
                                buttom.click(function () {
                                    var cindex = $(this).parent(".acui-content-butombar").children(".acui-content-butombar-btnf").index($(this));
                                    var currentBtn = param.buttom[cindex];
                                    if (currentBtn.type && currentBtn.type == "canel" && mObj.close) {
                                        mObj.close.click();
                                    }
                                    if (currentBtn.click) {
                                        currentBtn.click($(this));
                                    }
                                });
                            }
                            buttomPanel.append(buttom);
                        }
                    }
                }
            };

            var defaults = {
                obj: null,//弹出层的jquery对象
                operate: "", //操作方式 :
                width: 450,
                height: 280,
                title: "",
                drag: true,
                shade: true,
                iocn: "<span></span>",
                summary: null,//{ title: "", text: "" }
                buttom: [],
                onclose: function () { }
            };
            $.extend(defaults, options);

            if (!defaults.obj) {
                return;
            }
            defaults.obj.focus();

            var mObj = { ident: "", module: null, drag: null, header: null, content: null, close: null, shead: null };
            mObj.ident = $(defaults.obj).attr("acui-dialog-content");
            if (mObj.ident) {
                mObj = getboxObj();
            }

            if (defaults.operate.toLowerCase() == "close" || defaults.operate.toLowerCase() == "clear") {
                if (mObj.module && mObj.content) {
                    if (defaults.operate.toLowerCase() == "close") {
                        mObj.module.fadeOut(150);
                        if (mObj.shead) {
                            mObj.shead.fadeOut(150);
                        }
                    } else if (defaults.operate.toLowerCase() == "clear") {
                        $(defaults.obj).removeAttr("acui-dialog-content").css("display", "none").appendTo("body");
                        mObj.module.remove();
                        if (mObj.shead) {
                            mObj.shead.remove();
                        }
                    }
                } else {
                    //没找到弹出对象
                }
            } else {
                var zindex = baseObj.zindex + 2;
                baseObj.zindex = zindex;

                if (mObj.module) {
                    if (defaults.shade && mObj.shead) {
                        mObj.shead.css("z-index", zindex - 1).fadeIn(150);
                    }
                    mObj.module.css("z-index", zindex).fadeIn(150);

                    //重新绑定值
                    binding(defaults, mObj);
                } else {
                    //设置box基础定义
                    setBoxdefinition();
                    var guid = $.artcloud.newGuid();
                    $(defaults.obj).attr("acui-dialog-content", guid); //给当前对象定义标识
                    var mpack = new boxpack(defaults, zindex);
                    mObj = mpack.createModule(guid, $(defaults.obj));
                    if (defaults.shade) {
                        mObj.shead = new $.artcloud.shade(guid).create(zindex - 1);
                    }
                    if (mObj.module) {
                        $("body").append(mObj.module);
                        mObj.module.fadeIn(150);
                        baseObj.moduleList.push(mObj);
                    }
                }
            }
        };

        this.alert = function (options) {
            var defaults = {
                title: "消息提示",
                isHtml: false,
                text: "",
                type: "default",
                iocn: "<span></span>",
                width: 400,
                height: 171,
                drag: true,
                onclick: null,
                onclose: null
            };
            $.extend(defaults, options);
            var zindex = baseObj.zindex + 2;

            var boxpack = function (param) {
                var ts = this;
                ts.module = { ident: "", module: null, drag: null, content: null, close: null, shead: null };
                ts.param = param;


                this.createModule = function (ident, zindex) {
                    ts.module.ident = ident;
                    ts.zindex = zindex;

                    ts.module.module = $('<div class="acui-dialog-box"/>').attr("acui-alert", "alert" + ts.module.ident).css({
                        "width": ts.param.width,
                        "height": ts.param.height,
                        "z-index": ts.zindex,
                        "margin-left": -(ts.param.width / 2) + "px",
                        "margin-top": -(ts.param.height / 2) + "px"
                    });
                    ts.module.drag = createHeader();
                    ts.module.content = createContent();

                    ts.module.module.append(ts.module.drag);
                    ts.module.module.append(ts.module.content);
                    var twidth = ts.param.width - baseObj.boxDefinition.border.left - baseObj.boxDefinition.border.right;
                    var rheight = ts.param.height - baseObj.boxDefinition.border.top - baseObj.boxDefinition.header.height - baseObj.boxDefinition.border.bottom;
                    ts.module.module.append($('<div class="acui-resizable-handle acui-resizable-t">').css("width", twidth));
                    ts.module.module.append($('<div class="acui-resizable-handle acui-resizable-r">').css("height", rheight));
                    ts.module.module.append($('<div class="acui-resizable-handle acui-resizable-b">').css("width", twidth));
                    ts.module.module.append($('<div class="acui-resizable-handle acui-resizable-l">').css("height", rheight));
                    ts.module.module.append($('<div class="acui-resizable-handle acui-resizable-tl">'));
                    ts.module.module.append($('<div class="acui-resizable-handle acui-resizable-tr">'));
                    ts.module.module.append($('<div class="acui-resizable-handle acui-resizable-br">'));
                    ts.module.module.append($('<div class="acui-resizable-handle acui-resizable-bl">'));

                    return ts.module;
                };

                var createHeader = function () {
                    ts.module.close = $('<button class="acui-header-close" type="button">');
                    var header = $("<div class='acui-dialog-header'/>");
                    header.append($('<span class="acui-header-icon">&nbsp;</span>'));
                    header.append($('<span class="acui-header-title">' + param.title + '</span>'));
                    if (ts.param.drag) {
                        $.artcloud.dragAction(header[0], ts.module.module[0]);
                    }
                    ts.module.close.click(function () {
                        new $.artcloud.shade(ts.module.ident).clear();
                        ts.module.module.remove();
                        if (param.onclose) {
                            param.onclose();
                        }
                    });
                    header.append(ts.module.close);
                    return header;
                };

                var createContent = function () {
                    var cheight = param.height - baseObj.boxDefinition.border.top - baseObj.boxDefinition.header.height - baseObj.boxDefinition.bottom.height - baseObj.boxDefinition.border.bottom;
                    var content = $('<div class="acui-dialog-conten"/>');

                    var widget = $('<div class="acui-content-widget" />').css("height", cheight + "px");
                    var iconobj = $('<div class="acui-widget-icon"/>');
                    switch (param.type.toLowerCase()) {
                        case "error": iconobj.addClass("acui-icon-error"); break;
                        case "correct": iconobj.addClass("acui-icon-correct"); break;
                        default: iconobj.addClass("acui-icon-default"); break;
                    }
                    widget.append(iconobj);
                    var textPanelWidth = param.width - baseObj.boxDefinition.border.left - baseObj.boxDefinition.border.right - 90 - 20;
                    var vidgetC = $('<div class="acui-widget-text"/>').css("width", textPanelWidth);
                    if (defaults.isHtml) {
                        vidgetC.html(param.text);
                    } else {
                        vidgetC.text(param.text);
                    }
                    widget.append(vidgetC);
                    content.append(widget);

                    var buttomPanel = $('<div class="acui-content-butombar" style="text-align:center;padding-right:0"/>');
                    var buttom = $('<input type="button" class="acui-submit"/>').val("确定");
                    buttom.click(function () {
                        ts.module.close.click();
                        if (ts.param.onclick) {
                            ts.param.onclick();
                        }
                    });
                    buttomPanel.append(buttom);

                    content.append(buttomPanel);

                    return content;
                };

                this.getContentHeight = function (width, text) {
                    var height = 0;
                    var textWidth = width - baseObj.boxDefinition.border.left - baseObj.boxDefinition.border.right - 90;
                    var tempObj = $('<div style="margin:20px 0; table-layout:fixed; word-break: break-all; overflow:hidden;line-height:25px; font-size:12px;display:none"/>').css("width", textWidth).appendTo("body");
                    tempObj.text(text);
                    height = tempObj.height() + 40 + baseObj.boxDefinition.border.top + baseObj.boxDefinition.header.height + baseObj.boxDefinition.bottom.height + baseObj.boxDefinition.border.bottom;
                    tempObj.remove();
                    return height;
                };
            };

            //设置box基础定义
            setBoxdefinition();

            var guid = $.artcloud.newGuid();
            defaults.height = new boxpack(defaults).getContentHeight(defaults.width, defaults.text);
            var minHeight = baseObj.boxDefinition.border.top + baseObj.boxDefinition.header.height + 90 + baseObj.boxDefinition.bottom.height + baseObj.boxDefinition.border.bottom;
            if (defaults.height < minHeight) {
                defaults.height = minHeight;
            } else if (defaults.height > 500) {
                defaults.height = 500;
            }
            var boxmodule = new boxpack(defaults).createModule(guid, zindex);
            if (boxmodule) {
                new shade(guid).create(zindex - 1);
                $("body").append(boxmodule.module);
                boxmodule.module.fadeIn(300);
            }
            boxmodule.module.focus();
        };

        this.confim = function (options) {
            var defaults = {
                title: "消息确认框",
                text: "",
                iocn: "<span></span>",
                width: 400,
                height: 171,
                drag: true,
                onclose: null,
                yes: null,
                no: null
            };
            $.extend(defaults, options);
            var zindex = baseObj.zindex + 2;

            var boxpack = function (param) {
                var ts = this;
                ts.module = { ident: "", module: null, drag: null, content: null, close: null, shead: null };
                ts.param = param;

                this.createModule = function (ident, zindex) {
                    ts.module.ident = ident;
                    ts.zindex = zindex;

                    ts.module.module = $('<div class="acui-dialog-box"/>').attr("acui-alert", "alert" + ts.module.ident).css({
                        "width": ts.param.width,
                        "height": ts.param.height,
                        "z-index": ts.zindex,
                        "margin-left": -(ts.param.width / 2) + "px",
                        "margin-top": -(ts.param.height / 2) + "px"
                    });
                    ts.module.drag = createHeader();
                    ts.module.content = createContent();

                    ts.module.module.append(ts.module.drag);
                    ts.module.module.append(ts.module.content);
                    var twidth = ts.param.width - baseObj.boxDefinition.border.left - baseObj.boxDefinition.border.right;
                    var rheight = ts.param.height - baseObj.boxDefinition.border.top - baseObj.boxDefinition.header.height - baseObj.boxDefinition.border.bottom;
                    ts.module.module.append($('<div class="acui-resizable-handle acui-resizable-t">').css("width", twidth));
                    ts.module.module.append($('<div class="acui-resizable-handle acui-resizable-r">').css("height", rheight));
                    ts.module.module.append($('<div class="acui-resizable-handle acui-resizable-b">').css("width", twidth));
                    ts.module.module.append($('<div class="acui-resizable-handle acui-resizable-l">').css("height", rheight));
                    ts.module.module.append($('<div class="acui-resizable-handle acui-resizable-tl">'));
                    ts.module.module.append($('<div class="acui-resizable-handle acui-resizable-tr">'));
                    ts.module.module.append($('<div class="acui-resizable-handle acui-resizable-br">'));
                    ts.module.module.append($('<div class="acui-resizable-handle acui-resizable-bl">'));

                    return ts.module;
                };

                var createHeader = function () {
                    ts.module.close = $('<button class="acui-header-close" type="button">');
                    var header = $("<div class='acui-dialog-header'/>");
                    header.append($('<span class="acui-header-icon">&nbsp;</span>'));
                    header.append($('<span class="acui-header-title">' + ts.param.title + '</span>'));
                    if (ts.param.drag) {
                        $.artcloud.dragAction(header[0], ts.module.module[0]);
                    }
                    ts.module.close.click(function () {
                        if (ts.param.onclose) {
                            ts.param.onclose();
                        }
                        new shade(ts.module.ident).clear();
                        ts.module.module.remove();
                    });
                    header.append(ts.module.close);
                    return header;
                };

                var createContent = function () {
                    var cheight = param.height - baseObj.boxDefinition.border.top - baseObj.boxDefinition.header.height - baseObj.boxDefinition.bottom.height - baseObj.boxDefinition.border.bottom;
                    var content = $('<div class="acui-dialog-conten"/>');

                    var widget = $('<div class="acui-content-widget" />').css("height", cheight + "px");
                    widget.append($('<div class="acui-widget-icon acui-icon-confirm"/>'));
                    var textPanelWidth = param.width - baseObj.boxDefinition.border.left - baseObj.boxDefinition.border.right - 90 - 20;
                    widget.append($('<div class="acui-widget-text"/>').css("width", textPanelWidth).text(param.text));
                    content.append(widget);

                    var buttomPanel = $('<div class="acui-content-butombar" style="text-align:center;padding-right:0"/>');
                    var buttom = $('<input type="button" class="acui-submit"/>').val("确定");
                    var btncancel = $('<input type="button" class="acui-button" style="margin-left:15px;"/>').val("取消");
                    buttom.click(function () {
                        if (ts.param.yes) {
                            ts.param.yes(this);
                            if (ts.param.onclose) {
                                ts.param.onclose();
                            }
                        }
                        new $.artcloud.shade(ts.module.ident).clear();
                        ts.module.module.remove();
                    });
                    btncancel.click(function () {
                        if (ts.param.no) {
                            ts.param.no(this);
                            if (ts.param.onclose) {
                                ts.param.onclose();
                            }
                        }
                        new shade(ts.module.ident).clear();
                        ts.module.module.remove();
                    });
                    buttomPanel.append(buttom).append(btncancel);

                    content.append(buttomPanel);

                    return content;
                };

                this.getContentHeight = function (width, text) {
                    var height = 0;
                    var textWidth = width - baseObj.boxDefinition.border.left - baseObj.boxDefinition.border.right - 90;
                    var tempObj = $('<div style="margin:20px 0; table-layout:fixed; word-break: break-all; overflow:hidden;line-height:25px; font-size:12px;display:none"/>').css("width", textWidth).appendTo("body");
                    tempObj.text(text);
                    height = tempObj.height() + 40 + baseObj.boxDefinition.border.top + baseObj.boxDefinition.header.height + baseObj.boxDefinition.bottom.height + baseObj.boxDefinition.border.bottom;
                    tempObj.remove();
                    return height;
                };
            };

            //设置box基础定义
            setBoxdefinition();

            var guid = $.artcloud.newGuid();
            defaults.height = new boxpack(defaults).getContentHeight(defaults.width, defaults.text);
            var minHeight = baseObj.boxDefinition.border.top + baseObj.boxDefinition.header.height + 90 + baseObj.boxDefinition.bottom.height + baseObj.boxDefinition.border.bottom;
            if (defaults.height < minHeight) {
                defaults.height = minHeight;
            } else if (defaults.height > 500) {
                defaults.height = 500;
            }
            var boxmodule = new boxpack(defaults).createModule(guid, zindex);
            if (boxmodule) {
                new shade(guid).create(zindex - 1);
                $("body").append(boxmodule.module);
                boxmodule.module.fadeIn(300);
            }
            boxmodule.module.focus();
        };

        this.loading = function (options) {
            var defaults = {
                obj: null,//需要loading的jquery对象
                text: "loading...",
                operate: "" //操作方式 :
            };
            $.extend(defaults, options);
            $(window).blur();

            if (typeof options == "string") {
                if (options.toLowerCase() == "close") {
                    defaults.operate = "close";
                } else {
                    defaults.text = options;
                }
            }

            var boxpack = function (param) {

                this.createModul = function (id, zindex) {
                    var module = $('<div class="acui-loading-box"/>').attr("acui-loading-box", id).css("z-index", zindex);
                    module.append($('<div class="acui-lb-left"/>'));
                    var lcenter = $('<div class="acui-lb-center"/>').append($('<div class="acui-lbcenter-text"/>').text(param.text));
                    module.append(lcenter);
                    module.append($('<div class="acui-lb-right"/>'));
                    if (param.obj) {
                        module.css("position", "absolute");
                        $(param.obj).css("position", "relative").append(module);
                    } else {
                        $("body").append(module);
                        module.css("position", "fixed");
                    }
                    module.fadeIn(300);
                    module.css("margin-left", -module.width() / 2);
                };

            };

            var fixedId = "0000-0000-0000-00000-00000-00000";

            if (defaults.operate.toLowerCase() == "close") {
                var id;
                if (defaults.obj) {
                    id = $(defaults.obj).attr("acui-loading-panel");
                    $(defaults.obj).removeAttr("acui-loading-panel");
                } else {
                    id = fixedId;
                }
                if (id) {
                    new shade(id).clear();
                    var loadingObj = $("div[acui-loading-box=" + id + "]");
                    if (loadingObj.length > 0) {
                        loadingObj.remove();
                    }
                }
            } else {
                var zindex = baseObj.zindex += 2;
                baseObj.zindex = zindex;
                var id = newGuid();
                if (defaults.obj) {
                    $(defaults.obj).attr("acui-loading-panel", id);
                    new shade(id).create(zindex - 1, defaults.obj);
                } else {
                    id = fixedId;
                    new shade(id).create(zindex - 1);
                }
                new boxpack(defaults).createModul(id, zindex);
            }

        };

    };

    $.extend({ artcloud: new artCloud() });
})(jQuery);