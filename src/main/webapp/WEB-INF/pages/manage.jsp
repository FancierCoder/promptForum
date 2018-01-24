<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="../../common/base.jsp" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">

    <title> 仗剑论坛后台- 主页</title>

    <meta name="keywords" content="">
    <meta name="description" content="">

    <!--[if lt IE 9]>
    <meta http-equiv="refresh" content="0;ie.html"/>
    <![endif]-->

    <link rel="shortcut icon" href="${staticPath}/img/favicon.ico">
    <link href="${staticPath}/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="${staticPath}/css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
    <link href="${staticPath}/css/animate.css" rel="stylesheet">
    <link href="${staticPath}/css/style.css?v=4.1.0" rel="stylesheet">
</head>

<body class="fixed-sidebar full-height-layout gray-bg" style="overflow:hidden">
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
                    <div class="logo-element">仗剑
                    </div>
                </li>
                <li>
                    <a class="J_menuItem" href="${staticPath}/manage/mtoChart" onclick="">
                        <i class="fa fa-home"></i>
                        <span class="nav-label">图表统计</span>
                    </a>
                </li>
                <!--版块类别开始-->
                <!--版块类别结束-->

                <li class="line dk"></li>
                <li class="hidden-folded padder m-t m-b-sm text-muted text-xs">
                </li>
                <li>
                    <a class="J_menuItem" href="${staticPath}/manage/mtomanusers">
                        <i class="fa fa-users"></i> <span class="nav-label">用户管理 </span>
                        <span class="label label-warning pull-right"></span>
                    </a>
                </li>

                <li>
                    <a class="J_menuItem" href="${staticPath}/manage/mtomansections">
                        <i class="fa fa-newspaper-o"></i> <span class="nav-label">板块管理 </span>
                        <span class="label label-warning pull-right"></span>
                    </a>
                </li>
                <li>
                    <a href="${staticPath}/manage/mtomantopics?sid=-1" class="J_menuItem">
                        <i class="fa fa-list-alt"></i><span class="nav-label">帖子管理 </span>
                        <span class="label label-warning pull-right"></span>
                    </a>
                </li>
                <li>
                    <a href="${staticPath}/manage/mtomancomments" class="J_menuItem">
                        <i class="fa fa-comment"></i><span class="nav-label">评论管理 </span>
                        <span class="label label-warning pull-right"></span>
                    </a>
                </li>
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
                    <form role="search" class="navbar-form-custom" method="post" action="${staticPath}/show/search">
                        <div class="form-group">
                            <input type="text" placeholder="请输入您需要查找的内容 …" class="form-control" name="top-search"
                                   id="top-search">
                        </div>
                    </form>
                </div>
                <ul class="nav navbar-top-links navbar-right">
                    <!--头像-->
                    <c:if test="${sessionScope.admin!=null}">
                        <li>
                            <a href="${staticPath}/manage/mleave"><i class="glyphicon glyphicon-log-out"></i>注销 </a>
                        </li>
                        <li class="dropdown">
                            <a class="dropdown-toggle J_menuItem count-info" data-toggle="dropdown">
                                    ${sessionScope.admin.mname}
                            </a>
                        </li>
                        <li class="dropdown">
                            <a class="dropdown-toggle count-info" data-toggle="dropdown" href="#" id="all">
                                <i class="fa fa-bell" id="bell"></i>
                                <span class="label label-primary" id="allunread"></span>
                            </a>
                            <ul class="dropdown-menu dropdown-alerts">
                                <li class="divider"></li>
                                <li>
                                    <a>
                                        <div>
                                            <i class="fa fa-qq fa-fw"></i> 反馈信息 待
                                            <span class="pull-right text-muted small">12分钟前</span>
                                        </div>
                                    </a>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <div class="text-center link-block">
                                        <a class="J_menuItem">
                                            <strong>查看所有 待</strong>
                                            <i class="fa fa-angle-right"></i>
                                        </a>
                                    </div>
                                </li>
                            </ul>
                        </li>

                    </c:if>
                    <c:if test="${sessionScope.admin==null}">
                        <li>
                            <a class="   btn-sm" style="color: #010101" href="${staticPath}/login2.html" target="_top">
                                <i class="fa fa-user "></i> 登录
                            </a>
                        </li>
                    </c:if>


                </ul>
            </nav>
        </div>
        <div class="row J_mainContent" id="content-main">
            <iframe id="J_iframe" width="100%" height="100%" src="${staticPath}/manage/mtoChart" frameborder="0"
                    data-id=""
                    seamless></iframe>
        </div>
    </div>
    <!--右侧部分结束-->
</div>
<!-- 全局js -->
<script src="${staticPath}/js/jquery.min.js?v=2.1.4"></script>
<script src="${staticPath}/js/bootstrap.min.js?v=3.3.6"></script>
<script src="${staticPath}/js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="${staticPath}/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${staticPath}/js/plugins/layer/layer.min.js"></script>

<!-- 自定义js -->
<script src="${staticPath}/js/hAdmin.js?v=4.1.0"></script>
<script type="text/javascript" src="${staticPath}/js/index.js"></script>

<!-- 第三方插件 -->
<script src="${staticPath}/js/plugins/pace/pace.min.js"></script>
<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
</body>

</html>
