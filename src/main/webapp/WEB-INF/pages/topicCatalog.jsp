<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ include file="../../common/base.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="keywords" content="">
    <meta name="description" content="">

    <%@ include file="../../common/commons.jsp" %>

    <title>${sname}</title>
</head>

<body class="gray-bg">
<div class="row">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12 ">
                <div class="wrapper wrapper-content animated fadeInRight">

                    <div class="ibox-content m-b-sm border-bottom">
                        <div class="p-xs">
                            <div class="pull-left m-r-md">
                                <i class="fa text-navy mid-icon"></i>
                            </div>
                            <h2>欢迎来到${sname}版区</h2>
                            <span>${sstatement}</span>
                        </div>
                    </div>


                    <!--版块下的文章列表-->
                    <div class="wrapper wrapper-content  animated fadeInRight blog">
                        <div class="row">
                            <c:if test="${tcvos==null || fn:length(tcvos) ==0}">
                                <div class=" col-lg-6 col-lg-offset-3 ">
                                    <h3>这里还没来人创建帖子，赶紧来<a href="${staticPath}/form_editors.jsp?sid=${sid}">创建</a>一个吧
                                    </h3>
                                </div>
                            </c:if>
                            <c:if test="${tcvos!=null && fn:length(tcvos) !=0}">
                                <c:forEach items="${tcvos}" var="item" varStatus="status">

                                    <div class="col-lg-12 ">
                                        <!-------------------------------------------------------------------------------------------->

                                        <div class="ibox">
                                            <a href="${staticPath}/comment/showTopicDetail/${item.tid}"
                                               class="btn-link">
                                                <div class="ibox-content">

                                                    <h2>
                                                            ${item.tTopic}

                                                    </h2>
                                                        <%--</a>--%>
                                                    <div class="small m-b-xs">
                                                        <a href="${staticPath}/user/showUser/${item.tuid}"
                                                           class="pull-left">
                                                            <img alt="image" class="img-circle"
                                                                 style="width: 38px;height: 38px;"
                                                                 src="${staticPath}/img/${item.headimg}">
                                                        </a>

                                                        <strong style="margin-left: 5px;margin-bottom: 0px">${item.uNickName}</strong> </span>
                                                        <span class="text-muted"><i
                                                                class="fa fa-clock-o"></i> ${item.times}前</span>
                                                    </div>
                                                    <br/>
                                                    <p>
                                                            ${item.shortContent}
                                                    </p>
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <h5>标签：</h5>
                                                            <button class="btn btn-primary btn-xs" type="button">xxx
                                                            </button>
                                                            <button class="btn btn-white btn-xs" type="button">xxx</button>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="small text-right">
                                                                <h5>状态：</h5>
                                                                <div><i class="fa fa-comments-o"> </i> ${item.replyCount} 评论
                                                                </div>
                                                                <i class="fa fa-eye"> </i> ${item.clickCount}浏览
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                            </a>
                                        </div>

                                        <!------------------------------------------>
                                    </div>

                                </c:forEach>
                                <div class="col-sm-6 col-sm-offset-3" id="page"></div>
                            </c:if>
                        </div>


                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
    laypage({
        cont: $('#page'),
        pages: ${pages}, //可以叫服务端把总页数放在某一个隐藏域，再获取。假设我们获取到的是18
        curr: function () { //通过url获取当前页，也可以同上（pages）方式获取
            var page = location.search.match(/page=(\d+)/);
            return page ? page[1] : 1;
        }(),
        jump: function (e, first) { //触发分页后的回调
            if (!first) { //一定要加此判断，否则初始时会无限刷新
                location.href = '${staticPath}/show/topicCatalog?sid=${sid}&&page=' + e.curr;
            }
        }
    });
</script>
</html>

