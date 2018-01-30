<%@ include file="../../common/base.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link href="${staticPath}/css/bootstrap.css" rel="stylesheet">
    <link href="${staticPath}/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="${staticPath}/css/animate.css" rel="stylesheet">
    <link href="${staticPath}/css/style.css?v=4.1.0" rel="stylesheet">
</head>
<body class="gray-bg animated bounceInLeft">
<div class="wrapper wrapper-content container">
    <div class="form-horizontal">
        <div class="row ">
            <div class="form-group col-sm-12 ">
                <label class="col-sm-2 control-label ">板块ID：</label>
                <div class="col-sm-10 ">
                    <input type="text" value="${selectSection.sid}" id="sid" readonly class="form-control views-number">
                </div>
            </div>
            <div class="form-group col-sm-12">
                <label class="col-sm-2  control-label">名 称：</label>
                <div class="col-sm-10 ">
                    <input type="text" placeholder="名 称" value="${selectSection.sname}" id="sname" class="form-control">
                </div>
            </div>
            <div class="form-group col-sm-12">
                <label class="col-sm-2  control-label">父级菜单：</label>
                <div class="col-sm-10 ">
                    <input type="text" placeholder="父级菜单" value="${selectSection.sparentname}" id="sparentname"
                           class="form-control">
                </div>
            </div>
            <div class="form-group col-sm-12">
                <label class="col-sm-2 control-label ">详细描述：</label>
                <div class="col-sm-10 ">
                    <textarea class="form-control" rows="6" id="sstatement">${selectSection.sstatement}</textarea>
                </div>
            </div>
            <div class="form-group col-sm-12">
                <label class="col-sm-2 control-label ">简要描述：</label>
                <div class="col-sm-10 ">
                    <textarea id="sshortsm" class="form-control">${selectSection.sshortsm}</textarea>
                </div>
            </div>

            <div class="form-group col-sm-12">
                <label class="col-sm-2 control-label ">版主id：</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="smasterid" value="${selectSection.smasterid}"/>
                </div>
            </div>

        </div>
    </div>
    <div style="height: 50px"></div>
    <div class="row " style="margin-top: 30px;padding:5px 2px 5px 2px">
        <div class=" col-sm-6">
            <button class="btn btn-sm btn-default  btn-block " onclick="cancle();" type="button">取 消</button>
        </div>
        <div class=" col-sm-6">
            <button class="btn btn-sm btn-primary btn-block " id="submit" type="button">确 定</button>
        </div>
    </div>

</div>
</body>
<script src="${staticPath}/js/jquery.min.js?v=2.1.4"></script>
<script src="${staticPath}/js/bootstrap.min.js?v=3.3.6"></script>
<!--layer插件-->
<script src="${staticPath}/js/plugins/layer/layer.js"></script>
<!-- layerDate plugin javascript -->
<script src="${staticPath}/js/plugins/layer/laydate/laydate.js"></script>


<script type="text/javascript">
    $('#submit').on('click', function () {
        var sid = '${selectSection.sid}';
        var sname = $('#sname').val().trim();
        var sstatement = $('#sstatement').val().trim();
        var sshortsm = $('#sshortsm').val().trim();
        var smasterid = $('#smasterid').val().trim();
        var sparentname = $('#sparentname').val().trim();
        if (sname == '' || sstatement == '' || sshortsm == '' || smasterid == '' || sparentname == '') {
            layer.msg("错误，输入有为空的值", {icon: 5});
            return false;
        } else {
            $.ajax({
                url: '${staticPath}/manage/meditupdatesection',
                type: 'post',
                data: {
                    sid: sid,
                    sname: sname,
                    sstatement: sstatement,
                    sshortsm: sshortsm,
                    smasterid: smasterid,
                    sparentname: sparentname
                },
                success: function (data) {
                    switch (data) {
                        case "nosection":
                            layer.msg("错误,没有这个板块");
                            break;
                        case "hasnull":
                            layer.msg("错误,存在为空的值");
                            break;
                        case "smsternotexist":
                            layer.msg("错误，没有这个版主id");
                            break;
                        case "success":
                            layer.msg("修改成功",
                                {
                                    time: '800',
                                    end: function () {
                                        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                                        parent.layer.close(index);
                                    }
                                });
                            break;
                    }
                }

            });


        }
    });

    function cancle() {
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index);
    }
</script>
</html>
