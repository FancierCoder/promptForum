<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/base.jsp" %>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> - 个人资料</title>
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
                    <h5>个人资料</h5>
                </div>
                <div>
                    <div class="ibox-content no-padding border-left-right">
                        <img alt="image" style="height: 300px;width: 300px" class="img-responsive circle-border"
                             src="${staticPath}/img/${sessionScope.user.headimg}">
                    </div>
                    <div class="ibox-content profile-content">
                        <h4>账号：${sessionScope.user.uemail}</h4>
                        <h4>昵称：${sessionScope.user.unickname}</h4>
                        <h4>性别：
                            <c:if test="${sessionScope.user.usex==1}">
                                女
                            </c:if>
                            <c:if test="${sessionScope.user.usex==0}">
                                男
                            </c:if>
                        </h4>
                        <h4>生日：<fmt:formatDate value="${sessionScope.user.ubirthday}" type="date"/></h4>
                        <h4>等级：${sessionScope.user.ulevel}</h4>
                        <h4>积分：${sessionScope.user.upoint}</h4>
                        <h4>状态：
                            <c:if test="${sessionScope.user.ustate==0}">
                                正常
                            </c:if>
                            <c:if test="${sessionScope.user.ustate!=0}">
                                暂封${sessionScope.user.ustate}天
                            </c:if>
                        </h4>
                        <h4>注册时间：<fmt:formatDate value="${sessionScope.user.uregtime}" type="date"
                                                 dateStyle="full"/></h4>
                        <h4>
                            关于我
                        </h4>
                        <p>
                            ${sessionScope.user.ustatement}
                        </p>
                        <div class="row m-t-lg">
                            <a href="${staticPath}/user/mytopic?page=1&&condition=">
                                <div class="col-sm-4">
                                    <span class="bar">5,3,9,6,5,9,7,3,5,2</span>
                                    <h5><strong>${mytopicnum}</strong> 帖子</h5>
                                </div>
                            </a>
                            <a href="${staticPath}/user/toiconcern">
                                <div class="col-sm-4">
                                    <span class="line">5,3,9,6,5,9,7,3,5,2</span>
                                    <h5><strong>${myconcernnum}</strong> 关注</h5>
                                </div>
                            </a>
                            <a href="${staticPath}/user/toconcerni">
                                <div class="col-sm-4">
                                    <span class="bar">5,3,2,-1,-3,-2,2,3,5,2</span>
                                    <h5><strong>${beconcernnum}</strong> 粉丝</h5>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-8">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>最新动态</h5>

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
                                        <a href="${staticPath}/showUser/${item.tuid}" class="pull-left">
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

</body>

</html>

