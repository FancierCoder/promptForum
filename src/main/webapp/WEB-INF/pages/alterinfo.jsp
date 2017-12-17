<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/base.jsp" %>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title> - 修改资料</title>
    <meta name="keywords" content="">
    <meta name="description" content="">

    <%@ include file="../../common/commons.jsp" %>

</head>

<body class="gray-bg">
<div class="wrapper wrapper-content">
    <div class="row animated fadeInRight">
        <div class="col-sm-12 col-md-8 col-lg-offset-1">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>修改资料</h5>
                </div>
                <div>
                    <div class="ibox-content profile-content">

                        <div class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-3 col-md-2 control-label">头像：</label>
                                <div class="col-md-4">
                                    <div class="image-crop" id="imgitem">
                                        <img id="myheadimg" style="cursor: hand;width: 200px;height: 200px"
                                             class="circle-border" onclick="imgitem();"
                                             src="${staticPath}/img/${sessionScope.user.headimg}"/>
                                    </div>
                                </div>
                            </div>


                            <div class="form-group">
                                <label class="col-sm-3 col-md-2 control-label">昵称：</label>

                                <div class="col-sm-8 col-md-4">
                                    <input type="text" id="nickname" value="${sessionScope.user.unickname}"
                                           class="form-control"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 col-md-2 control-label">性别：</label>
                                <div class="col-sm-8 col-md-4">
                                    <div class="radio i-checks">
                                        <label>
                                            <input type="radio" ${sessionScope.user.usex==0?'checked':''} value="0"
                                                   name="sex"> <i></i> 男
                                        </label>
                                        <label>
                                            <input type="radio" ${sessionScope.user.usex==1?'checked':''} value="1"
                                                   name="sex"> <i></i> 女
                                        </label>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 col-md-2 control-label">生日：</label>
                                <div class="col-sm-8 col-md-4">
                                    <input readonly class="form-control layer-date" id="birthday"
                                           value='<fmt:formatDate value="${sessionScope.user.ubirthday}" type="date"/>'/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 col-md-2 control-label">关于我：</label>
                                <div class="col-sm-8 col-md-6">
                                    <textarea id="statement" class="form-control"
                                              rows="2">${sessionScope.user.ustatement}</textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-3 col-sm-8 col-md-4 col-md-offset-2">
                                    <button class="btn btn-sm btn-info" onclick="save();" type="button">保 存</button>
                                </div>
                            </div>


                        </div>
                    </div>
                </div>
            </div>
        </div>


    </div>
</div>


<script type="text/javascript">
    //日期范围限制
    var start = {
        elem: '#birthday',
        format: 'YYYY-MM-DD',
        max: laydate.now(), //最大日期
        istime: true,
        istoday: false,
        start: '<fmt:formatDate value="${sessionScope.user.ubirthday}" type="date" />',
        choose: function (datas) {

        }
    };
    laydate(start);

    function imgitem() {
        layer.open({
            type: 2,
            title: '更换头像',
            shadeClose: true,
            shade: 0.8,
            area: ['1000px', '500px'],
            content: '${staticPath}/changeheadimg.jsp' //iframe的url
        });
    }

    function save() {
        var sex = $(':radio:checked').val();
        var nickname = $('#nickname').val().trim();
        var birthday = $('#birthday').val();
        var statement = $('#statement').val().trim();
        //alert(nickname + "-" + birthday + "-" + sex + "-" + statement);
        if (nickname == null || nickname == '') {
            layer.tips("不允许为空", $('#nickname'));
            return false;
        } else {
            var flag = 0;
            var headimg = $('#myheadimg').attr('src');
            if (headimg != "${staticPath}/img/${sessionScope.user.headimg}") {
                flag = 1;
            } else {
                flag = 0;
            }
            $.ajax({
                url: '${staticPath}/user/alterinfo',
                type: 'POST',
                data: {
                    nickname: nickname,
                    sex: sex,
                    birthday: birthday,
                    headimg: headimg,
                    statement: statement,
                    flag: flag
                },
                success: function (data) {
                    layer.msg(data);
                }
            });
        }

    }
</script>


</body>

</html>


