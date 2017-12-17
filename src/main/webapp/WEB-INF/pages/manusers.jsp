<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/base.jsp" %>
<html>
<head>
    <title>用户管理</title>
    <%@ include file="../../common/commons.jsp" %>

    <style type="text/css">
        td {
            font-family: Arial;
            font-size: 14px;
            font-weight: normal;
        }
    </style>
</head>
<body>
<div class="wrapper ">
    <h1 class="font-bold text-center">用户管理</h1>
    <div id="toolbar">
        <button id="add" class="btn btn-primary">
            <i class="glyphicon glyphicon-plus"></i>添加用户
        </button>
    </div>
    <table id="table"
           data-toolbar="#toolbar"
           data-search="true"
           data-query-params="queryParams"
           data-show-refresh="true"
           data-show-toggle="true"
           data-show-columns="true"
           dat-show-export="true"
           data-minimum-count-columns="2"
           data-show-pagination-switch="true"
           data-pagination="true"
           data-id-field="uid"
           data-page-list="[3, 10, 50, 100, ALL]"
           data-show-footer="false"
           data-side-pagination="client"
           data-query-params-type="undefined"  <%--注意如果用自定义的非limit格式去需要写上去--%>
           data-url="${staticPath}/manage//manlistusers"
           data-response-handler="responseHandler">
    </table>
</div>
<script type="text/javascript">
    var $table = $('#table'),
        $add = $('#add'),
        selections = [];

    function initTable() {
        $table.bootstrapTable({
            height: getHeight(),
            columns: [{
                title: '用户id',
                field: 'uid',
                align: 'center',
                valign: 'middle'
            }, {
                title: 'email账号',
                field: 'uemail',
                align: 'center',
                valign: 'middle'
            }, {
                title: '用户昵称',
                field: 'unickname',
                align: 'center',
                valign: 'middle'
            }, {
                title: '性别',
                field: 'usex',
                align: 'center',
                valign: 'middle'
            }, {
                title: '生日',
                field: 'ubirthday',
                align: 'center',
                valign: 'middle',
                formatter: dateFormatter
            }, {
                title: '头像',
                field: 'headimg',
                align: 'center',
                valign: 'middle',
                formatter: headimgFormatter
            }, {
                title: '等级',
                field: 'ulevel',
                align: 'center',
                valign: 'middle'
            }, {
                title: '注册时间',
                field: 'uregtime',
                align: 'center',
                valign: 'middle',
                formatter: dateFormatter
            }, {
                title: '状态',
                field: 'ustate',
                align: 'center',
                valign: 'middle',
                formatter: stausFormatter
            }, {
                title: '积分',
                field: 'upoint',
                align: 'center',
                valign: 'middle'
            }, {
                title: '操作',
                field: 'operate',
                align: 'center',
                events: operateEvents,
                formatter: operateFormatter
            }]
        });
        setTimeout(function () {
            $table.bootstrapTable('resetView');
        }, 200);


        $add.on('click', function () {
            var size = sizeSet();
            layer.open({
                type: 2,
                shade: 0.8,
                title: '增加用户',
                area: size,
                content: '${staticPath}/manage/mtoadduser',
                success: function (layero, index) {
                    layer.iframeAuto(index);
                }
            })
        });

        $(window).resize(function () {
            $table.bootstrapTable('resetView', {
                height: getHeight()
            });
        });
    }

    function getIdSelections() {
        return $.map($table.bootstrapTable('getSelections'), function (row) {
            return row.tid;
        });
    }

    function responseHandler(res) {
        $.each(res, function (i, row) {
            row.state = $.inArray(row.tid, selections) != -1;
        });
        return res;
    }

    function queryParams(params) {
        var temp = {
            pagenumber: params.pageNumber,
            pagesize: params.pageSize,
            search: params.searchText
        };
        return temp;
    }

    function headimgFormatter(value, row, index) {
        return '<img  class="img-circle" style="width: 32px;height: 32px;" src="${staticPath}/img/' + value + '"/>';
    }

    function dateFormatter(value) {
        var date = new Date(value);
        var y = date.getFullYear(),
            m = date.getMonth() + 1,
            d = date.getDate(),
            h = date.getHours(),
            min = date.getMinutes(),
            s = date.getSeconds();
        return y + "-" + (m < 10 ? "0" + m : m)
            + "-" + (d < 10 ? "0" + d : d) + " "
            + (h < 10 ? "0" + h : h) + ":" + (min < 10 ? "0" + min : min) + ":"
            + (s < 10 ? "0" + s : s);
    }

    function stausFormatter(value, row, inde) {
        return value == 0 ? '正常' : '<font class="text-danger">被封</font>'
    }

    function operateFormatter(value, row, index) {
        return [
            '<a class="edit" href="javascript:void(0)" title="edit">',
            '<i class="glyphicon glyphicon-edit">修改</i>',
            '</a>'
        ].join('');
    }

    window.operateEvents = {
        'click .edit': function (e, value, row, index) {
            var size = sizeSet();
            layer.open({
                type: 2,
                title: '修改用户信息',
                shade: 0.8,
                area: size,
                content: '${staticPath}/manage/mtoedituser?uid=' + row.uid,
                success: function (layero, index) {
                    layer.iframeAuto(index);
                }
            });
        }
    }

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
            size = ['800px', '600px'];
        } else if (flag == 2) {
            size = ['240px', '420px'];
        } else {
            size = ['420px', '600px'];
        }
        return size;
    }

    function getHeight() {
        return $(window).height() - $('h1').outerHeight(true);
    }

    initTable();

</script>


</body>
</html>
