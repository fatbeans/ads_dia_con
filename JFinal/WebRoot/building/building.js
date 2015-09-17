$(document).ready(function () {
    var h = $(window).height() - $(document.body).height();
    if (h > 400) {
        $("#divbuilding").css("height", h - 20 + "px");
    }
    $("#divbuilding").show();
});