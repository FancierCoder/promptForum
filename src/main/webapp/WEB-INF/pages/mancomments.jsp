<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/base.jsp" %>
<html>
<head>
    <title>评论管理</title>
    <link rel="shortcut icon" href="${staticPath}/img/favicon.ico">
    <link href="${staticPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${staticPath}/css/font-awesome.css" rel="stylesheet">
    <link href="${staticPath}/css/animate.css" rel="stylesheet">
    <link href="${staticPath}/css/style.css" rel="stylesheet">
    <link href="${staticPath}/css/plugins/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
    <script src="${staticPath}/js/jquery-3.2.1.js"></script>
    <script src="${staticPath}/js/bootstrap.min.js"></script>
    <script src="${staticPath}/js/plugins/bootstrap-table/bootstrap-table.min.js"></script>
    <script src="${staticPath}/js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
    <script src="${staticPath}/js/plugins/layer/layer.min.js"></script>

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
    <h1 class="font-bold text-center">评论管理</h1>
    <div id="toolbar">
        <button id="remove" class="btn btn-danger" disabled>
            <i class="glyphicon glyphicon-remove"></i>删除
        </button>
    </div>
    <table id="table"
           data-toolbar="#toolbar"
           data-search="true"
           data-query-params="queryParams"
           data-show-refresh="true"
           data-show-toggle="true"
           data-show-columns="true"
           data-show-export="true"
           data-minimum-count-columns="2"
           data-show-pagination-switch="true"
           data-pagination="true"
           data-id-field="cid"
           data-page-list="[5, 10, 50, 100, ALL]"
           data-show-footer="false"
           data-side-pagination="client"
           data-query-params-type="undefined"  <%--注意如果用自定义的非limit格式去需要写上去--%>
           data-url="${staticPath}/manage/manlistcomments"
           data-response-handler="responseHandler">
    </table>
</div>
<script type="text/javascript">
    var $table = $('#table'),
        $remove = $('#remove'),
        selections = [];

    function initTable() {
        $table.bootstrapTable({
            height: getHeight(),
            columns: [{
                field: 'state',
                checkbox: true,
                align: 'center',
                valign: 'middle'
            }, {
                title: '评论id',
                field: 'cid',
                align: 'center',
                valign: 'middle'
            }, {
                title: '内容',
                field: 'content'

            }, {
                title: '时间',
                field: 'timeinterval',
                align: 'center',
                valign: 'middle'
            }, {
                title: '发言人id',
                field: 'uid',
                align: 'center',
                valign: 'middle'
            }, {
                title: '发言人账号',
                field: 'fromuemail',
                align: 'center',
                valign: 'middle'
            }, {
                title: '昵称',
                field: 'nickname',
                align: 'center',
                valign: 'middle'
            }, {
                title: '头像',
                field: 'headimg',
                align: 'center',
                valign: 'middle',
                formatter: headimgFormatter
            }, {
                title: '帖子id',
                field: 'tid',
                align: 'center',
                valign: 'middle'

            }, {
                title: '标题',
                field: 'ttopic',
                align: 'center',
                valign: 'middle'
            }, {
                title: '上级评论id',
                field: 'rootid',
                align: 'center',
                valign: 'middle'
            }, {
                title: '状态',
                field: 'isshow',
                align: 'center',
                valign: 'middle',
                formatter: stausFormatter
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
        $table.on('check.bs.table uncheck.bs.table ' +
            'check-all.bs.table uncheck-all.bs.table', function () {
            $remove.prop('disabled', !$table.bootstrapTable('getSelections').length);
            //保存选择的
            selections = getIdSelections();
        });

        $remove.click(function () {
            var ids = getIdSelections();
            //alert(ids);
            $.ajax({
                url: '${staticPath}/manage/mdeletecommentbatch',
                type: 'post',
                data: {cids: ids},
                success: function (data) {
                    if (data === 'success') {
                        $table.bootstrapTable('remove', {
                            field: 'cid',
                            values: ids
                        });
                        $remove.prop('disabled', true);
                        layer.msg("删除成功");
                    } else {
                        layer.msg("删除失败");
                    }
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
            return row.cid;
        });
    }

    function responseHandler(res) {
        $.each(res, function (i, row) {
            row.state = $.inArray(row.cid, selections) !== -1
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

    function stausFormatter(value, row, inde) {
        return value === 0 ? '<font class="text-danger" id="comment-' + row.cid + '">未审核</font>' : '<span id="comment-' + row.cid + '">通过</span>';
    }

    function operateFormatter(value, row, index) {
        return [
            '<a class="look" href="javascript:void(0)" title="查看">',
            '<i class="glyphicon glyphicon-eye-open"></i>',
            '</a>',
            '<a class="remove" href="javascript:void(0)" title="删除">',
            '<i class="glyphicon glyphicon-remove"></i>',
            '</a>',
            '<a class="ok" href="javascript:void(0)" title="通过">',
            '<i class="glyphicon glyphicon-ok"></i>',
            '</a>'
        ].join('');
    }


    window.operateEvents = {
        'click .look': function (e, value, row, index) {
            location.href = "${staticPath}/show/showTopicDetail/" + row.tid + "#" + row.cid;
        },
        'click .remove': function (e, value, row, index) {
            $.ajax({
                type: 'post',
                url: "${staticPath}/manage/mdeletecomment",
                data: {cid: row.cid},
                success: function (data) {
                    if (data === 'success') {
                        layer.msg("删除成功");
                        $table.bootstrapTable('remove', {
                            field: 'cid',
                            values: [row.cid]
                        });
                        $table.bootstrapTable('refresh');
                    } else {
                        layer.msg("删除失败");
                    }
                }
            })
        }, 'click .ok': function (e, value, row, index) {
            var status = row.isshow;
            //alert(status);
            if (status === 0) {
                $.ajax({
                    type: 'post',
                    url: "${staticPath}/manage/commentShow",
                    data: {cid: row.cid},
                    success: function (data) {
                        if (data === 'success') {
                            layer.msg("审核通过");

                            $table.bootstrapTable('refresh');
                        } else {
                            layer.msg("审核失败");
                        }
                    }
                });
            } else {
                layer.msg("已经审核成功了！");
            }
        }

    };

    function getHeight() {
        return $(window).height() - $('h1').outerHeight(true);
    }

    initTable();

</script>


</body>
</html>
