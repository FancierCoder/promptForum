<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="../../common/base.jsp" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">

    <title> 仗剑论坛- 主页</title>

    <meta name="keywords" content="">
    <meta name="description" content="">

    <!--[if lt IE 9]>
    <meta http-equiv="refresh" content="0;ie.html"/>
    <![endif]-->

    <%@ include file="../../common/commons.jsp" %>
</head>

<body class="fixed-sidebar full-height-layout gray-bg " style="overflow:hidden">
<div id="wrapper">
    <!--左侧导航开始-->
    <nav class="navbar-default navbar-static-side" role="navigation">
        <div class="nav-close"><i class="fa fa-times-circle"></i>
        </div>
        <div class="sidebar-collapse">
            <ul class="nav" id="side-menu">
                <li class="nav-header">
                    <div class="dropdown profile-element">
                        <a data-toggle="dropdown" class="dropdown-toggle" href="" style="cursor: default">
                            <span class="clear">
                                <span class="block m-t-xs" style="font-size:20px;">
                                    <i class="fa fa-globe"></i>
                                    <strong class="font-bold">仗剑论坛</strong>
                                </span>
                            </span>
                        </a>
                    </div>
                    <div class="logo-element">仗剑</div>
                </li>
                <li>
                    <a class="" href="${staticPath}/index.jsp" onclick="">
                        <i class="fa fa-home"></i>
                        <span class="nav-label">主页</span>
                    </a>
                </li>
                <!--版块类别开始-->
                <li>
                    <a href="">
                        <i class="fa fa fa-bar-chart-o"></i>
                        <span class="nav-label">版块类别</span>
                        <span class="fa arrow"></span>
                    </a>

                    <ul class="nav nav-second-level">
                        <c:if test="${sectionvos!=null && fn:length(sectionvos)!=0}">
                            <c:forEach items="${sectionvos}" var="sectionvo">
                                <c:if test="${sectionvo.sparentname=='0'}">
                                    <li>
                                        <a class="J_menuItem"
                                           href="${staticPath}/show/topicCatalog?sid=${sectionvo.sections[0].sid}&&page=1">${sectionvo.sections[0].sname}</a>
                                    </li>
                                </c:if>
                                <c:if test="${sectionvo.sparentname!='0'}">
                                    <li>
                                        <a class="J_menuItem">${sectionvo.sparentname}<span class="fa arrow"></span></a>
                                        <ul class="nav nav-third-level">
                                            <c:forEach items="${sectionvo.sections}" var="section">
                                                <li><a href="${staticPath}/show/topicCatalog?sid=${section.sid}&&page=1"
                                                       class="J_menuItem">${section.sname}
                                                    <c:if test="${section.sid==maxsid}">
                                                        <span class="label label-danger pull-right">推荐</span>
                                                    </c:if>
                                                </a></li>
                                            </c:forEach>
                                        </ul>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </c:if>
                    </ul>
                </li>
                <!--版块类别结束-->
                <c:if test="${sessionScope.user!=null}">
                    <li class="line dk"></li>
                    <li class="hidden-folded padder m-t m-b-sm text-muted text-xs">
                        <span class="ng-scope">分类</span>
                    </li>
                    <li>
                        <a><i class="fa fa-envelope"></i> <span class="nav-label">帖子 </span><span
                                class="label label-warning pull-right"></span>
                            <span class="fa arrow"></span>
                        </a>
                        <ul class="nav nav-second-level">
                            <li><a class="J_menuItem" href="${staticPath}/user/mytopic?page=1&&condition=">我的帖子</a>
                            </li>
                            <li><a class="J_menuItem" href="${staticPath}/user/tomycomment">我的评论</a></li>

                            <li><a class="J_menuItem" href="${staticPath}/form_editors.jsp">发&nbsp;&nbsp;帖</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a><i class="fa fa-edit"></i> <span class="nav-label">个人资料</span><span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                            <li><a class="J_menuItem" href="${staticPath}/user/showmyplace">我的空间</a></li>
                            <li><a class="J_menuItem" href="${staticPath}/user/intoalterinfo">修改资料</a></li>
                            <li><a href="#" id="changePass">密码修改</a></li>
                        </ul>
                    </li>
                    <%--私信--%>
                    <li>
                        <a class="J_menuItem " href="${staticPath}/tosixin"><i class="fa fa-edit"></i> <span
                                class="nav-label">私信聊天</span></a>
                    </li>
                </c:if>
            </ul>
        </div>
    </nav>
    <!--左侧导航结束-->
    <!--右侧部分开始-->
    <div id="page-wrapper" class="gray-bg dashbard-1">
        <div class="row border-bottom">
            <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
                <div class="navbar-header"><a class="navbar-minimalize minimalize-styl-2 btn btn-info " href="#"><i
                        class="fa fa-bars"></i> </a>
                    <form role="search" id="searchform" class="navbar-form-custom" action="${staticPath}/show/search">
                        <div class="form-group">
                            <input type="text" placeholder="请输入您需要查找的内容 …" class="form-control" name="searchkey"
                                   id="searchkey">
                        </div>
                    </form>
                </div>
                <ul class="nav navbar-top-links navbar-right">
                    <!--头像-->
                    <c:if test="${not empty sessionScope.user}">
                        <li>
                            <a href="${staticPath}/user/leave"><i class="glyphicon glyphicon-log-out"></i>注销</a>
                        </li>
                        <li class="dropdown">
                            <a class="dropdown-toggle J_menuItem count-info" data-toggle="dropdown"
                               href="${staticPath}/user/showmyplace">
                                <img alt="image" class="img-circle" style="width: 32px;height: 32px;"
                                     src="${staticPath}/img/${sessionScope.user.headimg}"/>
                            </a>
                        </li>
                        <li class="dropdown">
                            <a class="dropdown-toggle count-info" data-toggle="dropdown" href="#" id="all">
                                <i class="fa fa-bell" id="bell"></i>
                                <span class="label label-primary" id="allunread"></span>
                            </a>
                            <ul class="dropdown-menu dropdown-alerts">
                                <li>
                                    <a href="${staticPath}/unReadComment?page=1" class="J_menuItem">
                                        <div>
                                            <i class="fa fa-envelope fa-fw"></i> 您有<font id="unreadComment">0</font>条未读评论
                                        </div>
                                    </a>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <a href="${staticPath}/tosixin" class="J_menuItem">
                                        <div>
                                            <i class="fa fa-qq fa-fw"></i>您有 <font id="unreadsixin">0</font>条私信消息
                                        </div>
                                    </a>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <a href="${staticPath}/unhandleraddfriend?page=1" class="J_menuItem">
                                        <div>
                                            <i class="fa fa-flag "></i>您有 <font id="unreadadvise">0</font>条通知
                                        </div>
                                    </a>
                                </li>

                                <li class="divider"></li>
                                <li>
                                    <div class="text-center link-block">
                                        <a class="J_menuItem">
                                            <strong>查看所有 </strong>
                                            <i class="fa fa-angle-right"></i>
                                        </a>
                                    </div>
                                </li>
                            </ul>
                        </li>
                    </c:if>
                    <c:if test="${sessionScope.user==null}">
                        <li>
                            <a class="btn-sm" style="color: #010101" id="register">
                                <i class="fa fa-registered "></i> 注册
                            </a>
                        </li>
                        <li>
                            <a class="btn-sm" style="color: #010101" id="login">
                                <i class="fa fa-user "></i> 登录
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>
        <div class="row J_mainContent" id="content-main">
            <iframe id="J_iframe" width="100%" height="100%" src="${staticPath}/section/toCatalog" frameborder="0"
                    seamless>
            </iframe>
        </div>
    </div>
    <!--右侧部分结束-->
    <%
        int serverPort = request.getServerPort();
        request.setAttribute("port", serverPort);
    %>
</div>


<script>
    var websocket;
    if ('WebSocket' in window) {
        websocket = new WebSocket("ws://localhost:${requestScope.port}/msgCountSocket");
    } else if ('MozWebSocket' in window) {
        websocket = new MozWebSocket("ws://localhost:${requestScope.port}/msgCountSocket");
    } else {
        websocket = new SockJS("http://localhost:${requestScope.port}/sockjs/msgCountSocket");
    }
    websocket.onopen = function (evnt) {

    };
    websocket.onmessage = function (evnt) {
        var data = JSON.parse(evnt.data);
        var allcount = data.allcount;
        var commentcount = data.commentcount;
        var sixincount = data.sixincount;
        var advisecount = data.advisecount;//目前只有申请添加好友的请求通知
        var timer = null;
        if (data != null) {

            if (allcount != 0) {
                $('#allunread').html(allcount);

                var i = 0;
                clearInterval(timer);
                document.getElementById("all").onclick = function () {
                    clearInterval(timer);
                }
                timer = setInterval(function () {
                    document.getElementById("all").style.visibility = (i++) % 2 ? "hidden" : "visible";
                    i > 100 && (clearInterval(timer))
                }, 500);
            } else {
                clearInterval(timer);
                $('#allunread').html("");
            }

            /**未读评论**/
            if (commentcount != 0) {
                $('#unreadComment').attr("color", "red");
                $('#unreadComment').html(commentcount);
            } else {
                $('#unreadComment').attr("color", "");
                $('#unreadComment').html(commentcount);
            }
            /**未读私信**/
            if (sixincount != 0) {
                $('#unreadsixin').attr("color", "red");
                $('#unreadsixin').html(sixincount);
            } else {
                $('#unreadsixin').attr("color", "");
                $('#unreadsixin').html(sixincount);
            }
            /**通知**/
            if (advisecount != 0) {
                $('#unreadadvise').attr('color', 'red');
                $('#unreadadvise').html(advisecount);
            } else {
                $('#unreadadvise').attr('color', '');
                $('#unreadadvise').html(advisecount);
            }

        }
    };
    websocket.onerror = function (evnt) {
    };
    websocket.onclose = function (evnt) {
    }

    function isLoginFirst() {
        var loginFirstFlag = '${sessionScope.loginfirst}';
        if (loginFirstFlag == 'yes') {
            layer.msg("今日首次登录积分+10 ^_^");
            $.ajax({
                url: '${staticPath}/user/firstLoginSession',
                type: 'get'
            })
        }
    }

    isLoginFirst();

    $("#login").click(function () {
        layer.open({
            type: 2,
            title: '用户登录',
            shadeClose: true,
            shade: false,
            maxmin: true, //开启最大化最小化按钮
            area: ['600px', '600px'],
            content: '${staticPath}/login.html'
        });
    });

    $("#register").click(function () {
        layer.open({
            type: 2,
            title: '用户注册',
            shadeClose: true,
            shade: false,
            maxmin: true, //开启最大化最小化按钮
            area: ['600px', '600px'],
            content: '${staticPath}/register.html'
        });
    });

    $("#changePass").click(function () {
        layer.open({
            type: 2,
            title: '修改密码',
            shadeClose: false,
            shade: 0.3,
            area: ['400px', '500px'],
            content: ['${staticPath}/user/intoalterpassword', 'no']
        });
    });
</script>
</body>

</html>
