$(function () {
    $(".J_menuItem").on('click', function () {
        var url = $(this).attr('href');
        $("#J_iframe").attr('src', url);
        if ('undefined' !== typeof (url))
            $("body").toggleClass("mini-navbar");
        return false;
    });

    $('#searchform').submit(function (e) {
        $('#J_iframe').attr('src', '/show/search?searchkey=' + $('#searchkey').val());
        return false;
    });
});