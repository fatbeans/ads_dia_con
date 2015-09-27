$(document).ready(function(){ //页面加载完后执行
    if(getQueryString("usr")!=null){
        document.cookie="usr="+escape(getQueryString("usr"));
    }
    if(getQueryString("dep")!=null){
        document.cookie="dep="+escape(getQueryString("dep"));
    }
    contentH();//计算content高度
    //tab动作
    $('#myTab a').click(function (e) {
      e.preventDefault();
      $(this).tab('show');
    });
    $('#myTab2 a').click(function (e) {
      e.preventDefault();
      $(this).tab('show');
    });
    //$('#myTabhover .tabdo a').mouseover(function (e) {
    //  e.preventDefault();
    //  $(this).tab('show');
    //});
    $('#myTabhover .tabdo a').click(function (e) {
      e.preventDefault();
      $(this).tab('show');
    });
    $('.ProdeTab a').click(function (e) {
      e.preventDefault();
      $(this).tab('show');
    });
    //问题定界二级tab收起
    $('.js-Prodenavbtn').click(function(){
       if($(this).parent('.js-ProdeTabBox').hasClass("mintabbox"))
          {
            $(".mintabbox a[data-toggle='tooltip']").tooltip('destroy');
            $(this).parent('.js-ProdeTabBox').removeClass('mintabbox');
          }
        else
        {
          $(this).parent('.js-ProdeTabBox').addClass('mintabbox');
          $(".mintabbox a[data-toggle='tooltip']").tooltip();
        }
    });
    //GIS左侧菜单动作
    $('#js-villageinfo-list>li>a').click(function(e){
      $('#js-villageinfo-list li').removeClass('active');
      $('#js-villageinfo-list>li').children('.chi-table').slideUp('');
      if($(this).siblings('.chi-table').length>0&&$(this).siblings('.chi-table').is(":hidden"))
      {
        $(this).parent('li').addClass('active');
        $(this).siblings('.chi-table').slideDown('slow');
      }else if($(this).siblings('.chi-table').length>0)
      {
        $(this).parent('li').removeClass('active');
        $(this).siblings('.chi-table').slideUp('');
      }else{
        $(this).parent('li').addClass('active');
      }
    });
    $('.chi-table tr').click(function(event) {
      $('.chi-table tr').removeClass('active');
        $(this).addClass('active');
        $('.infobox').show();
    });
    $('.detailclose').click(function(e){
      $('.infobox').hide();
    });
    $('.S-menulist li').click(function(event) {
      $('.S-menulist li').removeClass('active');
      $(this).addClass('active');
    });
});
$(window).resize(function () {//当浏览器大小变化时
    contentH();//计算content高度
});
/*自定义select*/
$(function(){
  $(".sel_wrap").on("change", function() {
          var o;
          var opt = $(this).find('option');
          opt.each(function(i) {
              if (opt[i].selected == true) {
                  o = opt[i].innerHTML;
              }
          });
          $(this).find('label').html(o);
      }).trigger('change');
});
/* ============================================================
 * 计算content的高度。
 * ============================================================ */
var contentH = function(){
  var h = (window.innerHeight || (window.document.documentElement.clientHeight || window.document.body.clientHeight));
    $("#content").css({"height":h-115});
};

/* ============================================================
 * tab点击激活
 * ============================================================ */
$(function(){
	$('.tab-list').children('li').click(function(event) {
		$(this).siblings('li').removeClass('active');
		$(this).addClass('active');
	});
	$('.nav-menu').children('li').click(function(event) {
		$(this).siblings('li').removeClass('active');
		$(this).addClass('active');
	});
});
