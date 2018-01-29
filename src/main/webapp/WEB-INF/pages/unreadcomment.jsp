<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/base.jsp" %>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title> - 未读评论</title>
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
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>未读评论</h5>
                </div>
                <div class="ibox-content">

                    <div class="feed-activity-list">
                        <c:if test="${unreadcomms==null || fn:length(unreadcomms) ==0}">
                            暂无未读评论
                        </c:if>
                        <c:if test="${unreadcomms!=null && fn:length(unreadcomms) !=0}">
                            <c:forEach items="${unreadcomms}" var="item" varStatus="status">
                                <div class="feed-element">
                                    <a href="javascript:void(0) " class="pull-left">
                                        <img alt="${item.unickname}" class="img-circle"
                                             src="${staticPath}/img/${item.headimg}">
                                    </a>
                                    <div class="media-body ">
                                        <small class="pull-right">${item.ctime}</small>
                                        <strong>${item.unickname}</strong> 在您发布的&nbsp;
                                        <a href="${staticPath}/show/showTopicDetail/${item.ctid}#${item.cid}"
                                           class="btn-link">
                                                ${item.ttopic}
                                        </a>&nbsp;发表了评论 :
                                        <br>
                                        <div class="well">
                                            <span class="comment_content">${item.content}</span>
                                            <br>
                                            <span>
                                                <a href="${staticPath}/show/showTopicDetail/${item.ctid}#${item.cid}">查看</a>
                                            </span>
                                        </div>
                                    </div>
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
<!-- 全局js -->
<script src="${staticPath}/js/jquery-3.2.1.js"></script>
<script src="${staticPath}/js/bootstrap.min.js"></script>
<!-- 自定义js -->
<script src="${staticPath}/js/content.js"></script>
<script src="${staticPath}/js/plugins/layer/layer.js"></script>
<script src="${staticPath}/js/plugins/layer/laypage/laypage.js"></script>
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
                location.href = '${staticPath}/unReadComment?page=' + e.curr;
            }
        }
    });

    //查看结果
    function replace_em(str) {
        str = str.replace(/\</g, '&lt;');
        str = str.replace(/\>/g, '&gt;');
        str = str.replace(/\n/g, '<br/>');
        str = str.replace(/\[em_([0-9]*)\]/g, '<img src="${staticPath}/js/plugins/qqface/face/$1.gif" border="0" />');
        return str;
    }

    function getComment() {
        $(".comment_content").each(function () {
            //alert($(this).html());
            $(this).html(replace_em($(this).html()));
        });
    }

    getComment();
</script>
</body>

</html>
