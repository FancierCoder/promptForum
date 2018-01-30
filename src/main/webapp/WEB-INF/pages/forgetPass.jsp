<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/base.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> - 忘记密码</title>
    <meta name="keywords" content="">
    <meta name="description" content="">

    <link rel="shortcut icon" href="${staticPath}/img/favicon.ico">
    <link href="${staticPath}/css/bootstrap.css" rel="stylesheet">
    <link href="${staticPath}/css/font-awesome.css" rel="stylesheet">
    <link href="${staticPath}/css/animate.css" rel="stylesheet">
    <link href="${staticPath}/css/style.css" rel="stylesheet">

</head>

<body class="gray-bg">
<div class="wrapper wrapper-content">
    <div class="row animated fadeInRight">
        <div class="col-sm-12 col-md-8 col-lg-offset-2">

            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>忘记密码</h5>
                </div>
                <div class="ibox-content profile-content">
                    <div class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-12 col-md-2 control-label">邮 箱：</label>

                            <div class="col-sm-12 col-md-4">
                                <input type="text" id="email" class="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-12 col-md-2 control-label">新 密 码：</label>

                            <div class="col-sm-12 col-md-4">
                                <input type="password" id="newpassword" class="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 col-md-2 control-label">验 证 码：</label>

                            <div class="col-sm-8 col-md-2">
                                <input id="yzm" type="text" readonly class="form-control"/>
                            </div>
                            <div class="col-sm-2 col-md-2">
                                <button class="btn btn-danger" onclick="getyzm(this);">获取验证码</button>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-8 col-md-3 col-md-offset-2">
                                <button type="button" class="btn btn-primary btn-block" onclick="alterpsd();">提交
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<!-- 全局js -->
<script src="${staticPath}/js/jquery-3.2.1.js"></script>
<script src="${staticPath}/js/bootstrap.js"></script>
<script src="${staticPath}/js/plugins/layer/layer.js"></script>
<!-- 自定义js -->
<script src="${staticPath}/js/content.js"></script>
<script type="text/javascript">
    function getyzm(obj) {
        var email = $('#email').val().trim();
        if (email != null && email !== '') {
            $('#yzm').removeAttr('readonly');
            $(obj).attr({'disabled': 'disabled'});
            $.ajax({
                type: 'get',
                url: '${staticPath}/user/sendyzm2',
                data: {email: email},
                success: function (data) {
                    if (data === 'erremail')
                        layer.msg("账号不存在！请确认！");
                }
            });
            setTimeout(function () {
                $(obj).removeAttr('disabled');
            }, 45000);
        } else {
            layer.tips("请输入邮箱", $('#email'));
        }
    }

    function alterpsd() {
        var email = $('#email').val().trim();
        var newpassword = $('#newpassword').val().trim();
        var yzm = $('#yzm').val().trim();
        var rpassword = /^[\w]{6,12}$/;
        var remail = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;
        if (email == null || email === '') {
            layer.tips("不能为空", $('#email'));
            return false;
        } else if (!rpassword.test(newpassword)) {
            layer.tips("格式错误", $('#newpassword'));
            return false;
        } else if (!remail.test(email)) {
            layer.tips("邮箱格式错误", $('#email'));
            return false;
        } else {
            $.ajax({
                url: '${staticPath}/user/forgetpassword',
                type: "post",
                data: {email: email, newpassword: newpassword, yzm: yzm},
                success: function (data) {
                    if (data === 'erryzm') {
                        layer.tips("验证码错误", $('#yzm'));
                    } else if (data === 'unknowerr') {
                        layer.msg("未知错误！");
                    } else if (data === 'success') {
                        layer.msg("修改成功，请使用新密码登录");
                        setTimeout(function () {
                            location.href = '${staticPath}/login.html';
                        }, 2000);
                    }
                }
            });
        }
    }

</script>
</html>
