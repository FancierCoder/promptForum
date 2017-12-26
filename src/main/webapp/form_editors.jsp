<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="common/base.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title> - 富文本编辑器</title>
    <meta name="keywords" content="">
    <meta name="description" content="">

    <link rel="shortcut icon" href="${staticPath}/img/favicon.ico">
    <link href="${staticPath}/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="${staticPath}/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="${staticPath}/css/animate.css" rel="stylesheet">
    <link href="${staticPath}/css/plugins/summernote/summernote.css" rel="stylesheet">
    <link href="${staticPath}/css/plugins/summernote/summernote-bs3.css" rel="stylesheet">
    <link href="${staticPath}/css/style.css?v=4.1.0" rel="stylesheet">

</head>

<body class="gray-bg">
<div class="wrapper wrapper-content">

    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">

                <div class="ibox-content">

                    <h2>
                        Summernote
                    </h2>
                    <p>
                        Summernote是一个简单的基于Bootstrap的WYSIWYG富文本编辑器
                    </p>

                    <div class="alert alert-warning">
                        官方文档请参考：
                        <a href="http://hackerwins.github.io/summernote/features.html#api">http://hackerwins.github.io/summernote/features.html#api</a>
                    </div>

                    <div class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2  col-md-2 control-label ">标题：</label>
                            <div class="col-sm-10 col-md-7">
                                <input type="text" class="form-control" id="topic">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 col-md-2 control-label">所属版块：</label>

                            <div class="col-sm-10 col-md-7">
                                <select class="form-control m-b" id="section">

                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <label class="col-sm-2 col-md-2  control-label">内容：</label>
                            <div class="col-sm-10 col-md-7 ">
                                <div class="ibox float-e-margins">
                                    <div class="row">
                                        <div class="ibox-title col-sm-12">
                                            <h5>编辑/保存为html代码示例</h5>
                                            <button id="edit" class="btn btn-primary btn-xs m-l-sm" onclick="edit()"
                                                    type="button">编辑
                                            </button>
                                            <button id="save" class="btn btn-primary  btn-xs" onclick="save()"
                                                    type="button">保存
                                            </button>
                                        </div>
                                    </div>
                                    <div class="ibox-content" id="eg">
                                        <div class="click2edit wrapper" id="content">
                                            <h3>你好 </h3>
                                            <p>这里写你的文章</p>
                                        </div>
                                    </div>
                                </div>
                                <div>
                                    <button type="button" onclick="submitMyTopic();" class="btn btn-primary"
                                            style="float: right; margin-right: 0px">提交
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

</div>

<!-- 全局js -->
<script src="${staticPath}/js/jquery.min.js?v=2.1.4"></script>
<script src="${staticPath}/js/bootstrap.min.js?v=3.3.6"></script>
<script src="${staticPath}/js/plugins/layer/layer.min.js"></script>

<!-- 自定义js -->
<script src="${staticPath}/js/content.js?v=1.0.0"></script>

<!-- SUMMERNOTE -->
<script src="${staticPath}/js/plugins/summernote/summernote.min.js"></script>
<script src="${staticPath}/js/plugins/summernote/summernote-zh-CN.js"></script>

<script>
    $.ajaxSetup({
        contentType: "application/x-www-form-urlencoded;charset=utf-8",
        complete: function (XMLHttpRequest, textStatus) {
            var sessionstatus = XMLHttpRequest.getResponseHeader("sessionstatus");
            if (sessionstatus == "timeout") {
                layer.msg("请先登录");
                setTimeout(function () {
                    location.replace("${staticPath}/login.html");
                }, 500);
            }
        }
    });
    $(document).ready(function () {
        $('.summernote').summernote({
            lang: 'zh-CN'
        });
        $.ajax({
            url: '${staticPath}/section/getSection',
            cache: false,
            dataType: "json",
            success: function (data) {

                for (var i = 0; i < data.length; i++) {
                    $('#section').append(' <option value="' + data[i].sid +
                        '">' + data[i].sname +
                        '</option>');
                }
                var sid = getUrlParam("sid");
                if (sid != null) {
                    $("select option[value=" + sid + "]").attr("selected", true);
                } else {
                    $('select option[value="2"]').attr("selected", true);
                }
            }
        })


    });

    function getUrlParam(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]);
        return null;
    };
    var edit = function () {
        $("#eg").addClass("no-padding");
        $('.click2edit').summernote({
            lang: 'zh-CN',
            focus: true
        });
    };
    var save = function () {
        $("#eg").removeClass("no-padding");
        var aHTML = $('.click2edit').code(); //save HTML If you need(aHTML: array).
        $('.click2edit').destroy();
    };
    var submitMyTopic = function () {
        var content = $('#content').code();
        var topic = $('#topic').val().trim();
        if (topic == null || topic == '') {
            layer.tips("不能为空", $('#topic'));
            return false;
        } else if (content == null || content == '') {
            layer.tips("内容不能为空", $('#eg'));
            return false;
        }
        $.ajax({
            type: 'post',
            url: '${staticPath}/topic/addTopic',
            data: {topic: topic, sid: $('#section').val(), content: content},
            success: function (data) {
                if (data == 'success') {
                    layer.msg("发布成功");
                    layer.confirm('继续发布帖子吗', {
                        btn: ['是', '否'] //按钮
                    }, function () {
                        location.reload();
                    }, function () {
                        location.replace("${staticPath}/show/topicCatalog?sid=" + $('#section').val() + '&&page=1');
                    });
                }

            }
        });
    }
</script>


</body>

</html>

