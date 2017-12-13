package com.swordForum.control;


import com.swordForum.mapper.CommentMapper;
import com.swordForum.mapper.TopicMapper;
import com.swordForum.model.Topic;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author 李铎
 * @since 2017-12-01
 */
@Controller
@RequestMapping("/manage")
public class ManageController {

    @Resource
    private CommentMapper commentMapper;

    @Resource
    private TopicMapper topicMapper;

    @RequestMapping("/mdeletecomment")
    public void deleteComment(@RequestParam("cid") long cid, HttpServletResponse response) throws IOException {
        int i = commentMapper.deleteById(cid);
        PrintWriter pw = response.getWriter();
        if (i == 1) {
            pw.write("success");
        } else {
            pw.write("err");
        }
        pw.close();
    }

    @RequestMapping("/mdeletecommentbatch")
    public void deleteCommentBatch(@RequestParam("cids") long[] cids, HttpServletResponse response) throws IOException {
        List cidlist = Arrays.asList(cids);
        int i = commentMapper.deleteBatchIds(cidlist);
        PrintWriter pw = response.getWriter();
        if (!(cidlist.size() == i)) {
            pw.write("err");
        } else {
            pw.write("success");
        }
        pw.close();
    }

    @RequestMapping("/mtotop")
    public void toTop(@RequestParam("tid") long tid, @RequestParam("sid") int sid, HttpServletResponse response) throws IOException {
        Topic topicWhere = new Topic();
        topicWhere.setTsid(sid);
        topicWhere.setTstaus(1);
        Topic oldTopTopic = topicMapper.selectOne(topicWhere);
        if (oldTopTopic != null && oldTopTopic.getTid() != tid) {
            oldTopTopic.setTstaus(0);
            topicMapper.updateById(oldTopTopic);
        }
        Topic newTopic = new Topic();
        newTopic.setTid(tid);
        newTopic.setTstaus(1);
        int i = topicMapper.updateById(newTopic);
        PrintWriter pw = response.getWriter();
        if (i == 1) {
            pw.write("success");
        } else {
            pw.write("err");
        }
        pw.close();
    }

    @RequestMapping("/mcancletotop")
    public void cancleToTop(@RequestParam("tid") long tid, HttpServletResponse response) throws IOException {
        Topic t = new Topic();
        t.setTid(tid);
        t.setTstaus(0);
        int i = topicMapper.updateById(t);
        PrintWriter pw = response.getWriter();
        if (i == 1) {
            pw.write("success");
        } else {
            pw.write("err");
        }
        pw.close();
    }
}
