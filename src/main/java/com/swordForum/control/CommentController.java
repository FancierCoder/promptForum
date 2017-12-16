package com.swordForum.control;


import com.swordForum.mapper.*;
import com.swordForum.model.*;
import com.swordForum.model.VO.CommentVo;
import com.swordForum.model.VO.CommentVoS;
import com.swordForum.model.VO.TopicCatalogVo;
import com.swordForum.util.DateUtil;
import com.swordForum.util.HtmlUtil;
import com.swordForum.util.IpUtil;
import com.swordForum.util.toVoUtil;
import com.swordForum.websocket.SystemWebSocketHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.socket.TextMessage;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author 李铎
 * @since 2017-12-01
 */
@Controller
@RequestMapping("/comment")
public class CommentController {
    @Resource
    private CommentMapper commentMapper;
    @Resource
    private UserMapper userMapper;
    @Resource
    private TopicMapper topicMapper;
    @Resource
    private SectionMapper sectionMapper;
    @Resource
    private LogtableMapper logtableMapper;
    @Resource
    private SystemWebSocketHandler systemWebSocketHandler;

    @RequestMapping(value = "/showTopicDetail/{tid}")
    public String showComment(@PathVariable("tid") long tid, Map<String, Object> map, HttpServletRequest request) {
        //获取楼主的信息 直接使用TopicCataLogVo,只需把html过滤去掉,时间采用中国日期格式
        Topic maintopic = topicMapper.selectById(tid);
        User topicuser = userMapper.selectById(maintopic.getTuid());
        Section section = sectionMapper.selectById(maintopic.getTsid());
        User me = null;
        me = (User) request.getSession().getAttribute("user");
        if (me != null && me.getUid().equals(topicuser.getUid())) {
            commentMapper.updateRead(tid);
        }
        TopicCatalogVo topicCatalogVo = toVoUtil.toTopciVO(maintopic, topicuser, HtmlUtil.NOTFILTER, 1);
        List<CommentVoS> commentvoslist = new ArrayList<>();   //所有的评论集合
        Map<String, Object> rootmap = new HashMap<>();
        rootmap.put("ctid", tid);
        rootmap.put("rootcid", 0L);
        List<Comment> rootComments = commentMapper.selectByMap(rootmap);  //查出所以得根评论
        for (Comment c : rootComments) {
            //直接根评论
            CommentVo rootcomment = comment2Vo(c, userMapper);
            //根据根评论的cid来查出里面的子评论
            Long cid = c.getCid();
            Map<String, Object> rootdirectmap = new HashMap<>();
            rootdirectmap.put("rootcid", cid);
            rootdirectmap.put("parentuid", 0L);
            List<Comment> rootdirects = commentMapper.selectByMap(rootdirectmap);//根评论下的直接评论
            List<CommentVo> root_directcomment = new ArrayList<>();
            for (Comment c2 : rootdirects) {
                CommentVo onedirect = comment2Vo(c2, userMapper);
                root_directcomment.add(onedirect);
            }
            //非直接评论
            Map<String, Object> root_Ndirectmap = new HashMap<>();
            root_Ndirectmap.put("ctid", tid);
            root_Ndirectmap.put("rootcid", cid);
            List<Comment> root_Ndirect = commentMapper.selectNdirect(root_Ndirectmap);
            List<CommentVo> root_Ndirectcomment = new ArrayList<>();
            for (Comment c3 : root_Ndirect) {
                CommentVo oneNdirect = comment2Vo(c3, userMapper);
                System.err.println(oneNdirect.getCid() + " " + oneNdirect.getContent() + " " + oneNdirect.getParentcid());
                root_Ndirectcomment.add(oneNdirect);
            }
            //完整的一个CommentVoS
            CommentVoS oneCommentvs = new CommentVoS();
            oneCommentvs.setRootcomment(rootcomment);
            oneCommentvs.setRoot_directcomment(root_directcomment);
            oneCommentvs.setRoot_Ndirectcomment(root_Ndirectcomment);
            commentvoslist.add(oneCommentvs);
        }
        map.put("sectionid", section.getSid());
        map.put("sectionname", section.getSname());
        map.put("comment", commentvoslist);
        map.put("topic", topicCatalogVo);
        /*增加帖子的点击数*/
        maintopic.setTclickcount(maintopic.getTclickcount() + 1);
        /*更新查看帖子时间*/
        maintopic.setTlastclicktime(new Date());
        topicMapper.updateById(maintopic);
        return "topicdetail";
    }

    private static CommentVo comment2Vo(Comment comment, UserMapper userMapper) {
        CommentVo cvo = new CommentVo();
        cvo.setCid(comment.getCid());
        cvo.setContent(comment.getContent());
        cvo.setTimeinterval(DateUtil.date(comment.getCtime(), 0));
        cvo.setRootid(comment.getRootcid());
        cvo.setParentcid(comment.getParentcid());
        cvo.setParentuid(comment.getParentuid());
        cvo.setCzan(comment.getCzan());
        cvo.setUid(comment.getCuid());   //自己的uid
        //自己的昵称,头像，账号
        User me = userMapper.selectById(comment.getCuid());
        cvo.setHeadimg(me.getHeadimg());
        cvo.setNickname(me.getUnickname());
        cvo.setFromuemail(me.getUemail());
        //parent的昵称
        Long parentuid = comment.getParentuid();
        if (parentuid != 0) {
            User parent = userMapper.selectById(parentuid);
            cvo.setParentunickname(parent.getUnickname());
        }
        return cvo;
    }

    public static CommentVo comment2Vo(Comment comment, UserMapper userMapper, TopicMapper topicMapper) {

        CommentVo cvo = new CommentVo();
        cvo.setCid(comment.getCid());
        cvo.setContent(comment.getContent());
        cvo.setTimeinterval(DateUtil.date(comment.getCtime(), 1));
        cvo.setRootid(comment.getRootcid());
        cvo.setParentuid(comment.getParentuid());
        cvo.setCzan(comment.getCzan());
        cvo.setUid(comment.getCuid());   //自己的uid
        cvo.setParentcid(comment.getParentcid());
        //自己的昵称,头像,账号
        User me = userMapper.selectById(comment.getCuid());
        cvo.setHeadimg(me.getHeadimg());
        cvo.setNickname(me.getUnickname());
        cvo.setFromuemail(me.getUemail());
        //parent的昵称
        Long parentuid = comment.getParentuid();
        if (parentuid != 0) {
            User parent = userMapper.selectById(parentuid);
            cvo.setParentunickname(parent.getUnickname());
        }
        //帖子信息，id和标题
        cvo.setTid(comment.getCtid());
        Topic t = topicMapper.selectById(comment.getCtid());
        cvo.setTtopic(t.getTtopic());
        return cvo;
    }


    /*发表评论*/
    @RequestMapping("/addComment")
    public void addComment(@RequestParam("content") String content, @RequestParam("tid") long tid,
                           @RequestParam(value = "rootcid", required = false, defaultValue = "0") long rootcid,
                           @RequestParam(value = "parentuid", required = false, defaultValue = "0") long parentuid,
                           @RequestParam(value = "parentcid", required = false, defaultValue = "0") long parentcid,
                           HttpServletRequest request, HttpServletResponse response) throws Exception {
        User user = (User) request.getSession().getAttribute("user");
        Long uid = user.getUid();
        Comment comment = new Comment();
        comment.setContent(HtmlUtil.filter(content));
        comment.setCtid(tid);
        comment.setCuid(uid);
        comment.setRootcid(rootcid);
        comment.setParentuid(parentuid);
        comment.setParentcid(parentcid);
        int i = commentMapper.insert(comment);
        //操作记录
        Logtable logtable = new Logtable(user.getUid(), new IpUtil().getIp(request), 7);
        logtableMapper.insert(logtable);
        PrintWriter pw = null;
        if (i == 1) {
            System.out.println("增加评论成功");
            Topic topic = topicMapper.selectById(tid);
            int unreadCount = commentMapper.unreadCount(topic.getTuid());
            systemWebSocketHandler.sendMessageToUser(topic.getTuid(), new TextMessage(unreadCount + ""));
            try {
                pw = response.getWriter();
                pw.write("success");
                pw.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            try {
                pw = response.getWriter();
                pw.write("err");
                pw.close();
            } catch (IOException e) {
                e.printStackTrace();
            }

        }
    }
}
