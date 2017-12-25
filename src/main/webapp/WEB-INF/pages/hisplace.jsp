<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/base.jsp" %>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title> - 他人资料</title>
    <meta name="keywords" content="">
    <meta name="description" content="">

    <%@ include file="../../common/commons.jsp" %>

</head>

<body class="gray-bg">
<div class="wrapper wrapper-content">
    <div class="row animated fadeInRight">
        <div class="col-sm-4">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>${his.uemail}的资料</h5>
                </div>
                <div>
                    <div class="ibox-content no-padding border-left-right">
                        <img alt="image" style="height: 300px;width: 300px" class="img-responsive circle-border"
                             src="${staticPath}/img/${his.headimg}">
                    </div>
                    <div class="ibox-content profile-content">
                        <h4>账号：${his.uemail}</h4>
                        <h4>昵称：${his.unickname}</h4>
                        <h4>性别：
                            <c:if test="${his.usex==1}">
                                女
                            </c:if>
                            <c:if test="${his.usex==0}">
                                男
                            </c:if>
                        </h4>
                        <h4>生日：<fmt:formatDate value="${his.ubirthday}" type="date"/></h4>
                        <h4>等级：${his.ulevel}</h4>
                        <h4>积分：${his.upoint}</h4>
                        <h4>状态：
                            <c:if test="${his.ustate==0}">
                                正常
                            </c:if>
                            <c:if test="${his.ustate!=0}">
                                暂封${his.ustate}天
                            </c:if>
                        </h4>
                        <h4>注册时间：<fmt:formatDate value="${his.uregtime}" type="date" dateStyle="full"/></h4>
                        <h4>
                            关于我
                        </h4>
                        <p>
                            ${his.ustatement}
                        </p>
                        <div class="row m-t-lg">

                            <div class="col-sm-4">
                                <span class="bar">5,3,9,6,5,9,7,3,5,2</span>
                                <h5><strong>${histopicnum}</strong> 帖子</h5>
                            </div>

                            <div class="col-sm-4">
                                <span class="line">5,3,9,6,5,9,7,3,5,2</span>
                                <h5><strong>${hisconcernnum}</strong> 关注</h5>
                            </div>

                            <div class="col-sm-4">
                                <span class="bar">5,3,2,-1,-3,-2,2,3,5,2</span>
                                <h5><strong>${beconcernnum}</strong> 粉丝</h5>
                            </div>
                        </div>
                        <div class="user-button">
                            <div class="row">
                                <div class="col-sm-6">
                                    <c:if test="${isfriend=='yes'}">
                                        <button type="button" onclick="sendAt(${his.uid});"
                                                class="btn btn-primary btn-sm btn-block" id="send"><i
                                                class="fa fa-envelope"></i> 发送消息
                                        </button>
                                    </c:if>
                                    <c:if test="${isfriend=='no'}">
                                        <button type="button" class="btn btn-primary btn-sm btn-block" id="addfriend"><i
                                                class="fa fa-plus"></i> 添加好友
                                        </button>

                                    </c:if>
                                </div>
                                <input type="hidden" value="${his.uid}" id="hisuid"/>
                                <div class="col-sm-6">
                                    <c:if test="${flag==0}">
                                        <button type="button" id="addConBtn" class="btn btn-default btn-sm btn-block"><i
                                                class="fa fa-coffee"></i>关 注
                                        </button>
                                    </c:if>
                                    <c:if test="${flag==1}">
                                        <button type="button" id="cancelConBtn"
                                                class="btn btn-default btn-sm btn-block"><i class="fa fa-coffee"></i>
                                            取消关注
                                        </button>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-8">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>他发布的帖子</h5>

                </div>
                <div class="ibox-content">
                    <div>
                        <div class="feed-activity-list">
                            <c:if test="${tcvos==null && fn:length(tcvos) ==0}">
                                暂无最新动态
                            </c:if>
                            <c:if test="${tcvos!=null && fn:length(tcvos) !=0}">
                                <c:forEach items="${tcvos}" var="item" varStatus="status">
                                    <div class="feed-element">
                                        <a href="javascript:void(0) " class="pull-left">
                                            <img alt="${item.uNickName}" class="img-circle"
                                                 src="${staticPath}/img/${item.headimg}">
                                        </a>
                                        <div class="media-body ">
                                            <small class="pull-right">${item.times}前</small>
                                            <strong>${item.uNickName}</strong> 发布
                                            <a href="${staticPath}/show/showTopicDetail/${item.tid}"
                                               class="btn-link">
                                                    ${item.tTopic}
                                            </a>
                                            <br>
                                            <div class="well">
                                                    ${item.shortContent}
                                            </div>
                                            <div class="pull-right">
                                                <i class="fa fa-thumbs-up"></i> ${item.tzan}赞&nbsp;
                                                <i class="fa fa-pencil"></i>${item.replyCount} 评论
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:if>
                        </div>

                        <%--
                                                <button class="btn btn-primary btn-block m"><i class="fa fa-arrow-down"></i> 显示更多</button>
                        --%>

                    </div>

                </div>
            </div>

        </div>
    </div>
</div>

<script type="text/javascript">

    /*这里做了两组id对应两组事件方法，但仅仅修改id是不行的,
    因为修改后根据id选择器获取的元素并没有改变，所以它对应的事件方法并没有改变，因此需要在每个绑定事件种写判断，
    既然要达到根据Id选择不同的方法，那就直接判断id*/
    function addCon() {
        $.ajax({
            type: 'post',
            data: {hisuid: $('#hisuid').val()},
            url: "${staticPath}/concern/addConcern",
            success: function (data) {
                if (data == 'ok') {
                    $('#addConBtn').html('<i class="fa fa-coffee"></i> 取消关注');
                    $('#addConBtn').attr("id", "cancelConBtn");

                }
            }
        });
    };

    function cancelCon() {
        $.ajax({
            type: 'post',
            data: {hisuid: $('#hisuid').val()},
            url: "${staticPath}/concern/cancelConcern",
            success: function (data) {
                if (data == 'ok') {
                    $('#cancelConBtn').html('<i class="fa fa-coffee"></i> 关注');
                    $('#cancelConBtn').attr("id", "addConBtn");

                }
            }
        });
    }

    $('#addConBtn').on("click", function () {
        if ($(this).attr("id") == "addConBtn") {
            addCon();
        } else {
            cancelCon();
        }
    });
    $("#cancelConBtn").on("click", function () {
        if ($(this).attr("id") == "addConBtn") {
            addCon();
        } else {
            cancelCon();
        }
    });

    function sizeSet() {
        var size = ['240px', '420px'];
        var userAgentInfo = navigator.userAgent;
        var Agents = ["Android", "iPhone",
            "SymbianOS", "Windows Phone",
            "iPad", "iPod"];
        var flag = 1;   //1为pc 2为安卓 3为ipad
        for (var v = 0; v < Agents.length; v++) {
            if (userAgentInfo.indexOf(Agents[v]) > 0) {
                if (Agents[v] == 'iPad' || Agents[v] == 'iPod') {
                    flag = 3;
                } else {
                    flag = 2;
                }
                alert(Agents[v]);
                break;
            }
        }

        if (flag == 1) {
            size = ['900px', '500px'];
        } else if (flag == 2) {
            size = ['240px', '420px'];
        } else {
            size = ['420px', '600px'];
        }
        return size;
    }

    function sendAt(hisuid) {
        location.href = '${staticPath}/tosixin#' + hisuid;
    }

    $('#send').on('click', function () {
        var size = sizeSet();
        layer.open({
            type: 2,
            shade: 0.8,
            title: '私信',
            area: size,
            content: '${staticPath}/tosixin',
            success: function (layero, index) {
                layer.iframeAuto(index);
            }
        })

    });

    $('#addfriend').on('click', function () {
        $.ajax({
            url: '${staticPath}/askforaddfriend?hisuid=${his.uid}',
            type: 'get',
            success: function (data) {
                if (data == 'success') {
                    layer.msg("已发送添加好友请求");
                } else {
                    layer.msg("出现未知错误");
                }
            }
        })
    })
</script>


</body>

</html>
