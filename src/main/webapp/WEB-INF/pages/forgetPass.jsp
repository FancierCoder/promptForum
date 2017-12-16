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

    <%@ include file="../../common/commons.jsp" %>

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
<script type="text/javascript">
    function getyzm(obj) {
        var email = $('#email').val().trim();
        if (email != null && email != '') {
            $('#yzm').removeAttr('readonly');
            $(obj).attr({'disabled': 'disabled'});
            $.ajax({
                type: 'get',
                url: '${staticPath}/user/sendyzm2',
                data: {email: email},
                success: function (data) {
                    if (data == 'erremail')
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
        if (!rpassword.test(newpassword)) {
            layer.tips("格式错误", $('#newpassword'));
            return false;
        }
        $.ajax({
            url: '${staticPath}/user/forgetpassword',
            type: "post",
            data: {email: email, newpassword: newpassword, yzm: yzm},
            success: function (data) {
                if (data == 'erryzm') {
                    layer.tips("验证码错误", $('#yzm'));
                } else if (data == 'unknowerr') {
                    layer.msg("未知错误！");
                } else if (data == 'success') {
                    layer.msg("修改成功，请使用新密码登录");
                    setTimeout(function () {
                        location.href = '${staticPath}/login.html';
                    }, 2000);
                }
            }
        });
    }

</script>
</html>
