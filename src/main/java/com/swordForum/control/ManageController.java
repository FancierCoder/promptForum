package com.swordForum.control;


import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.sun.istack.internal.Nullable;
import com.swordForum.mapper.*;
import com.swordForum.model.Manage;
import com.swordForum.model.Section;
import com.swordForum.model.Topic;
import com.swordForum.model.User;
import com.swordForum.model.VO.ChartVo;
import com.swordForum.model.VO.ManTopic;
import com.swordForum.util.MD5Util;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    @Resource
    private ManageMapper manageMapper;

    @Resource
    private SectionMapper sectionMapper;

    @Resource
    private UserMapper userMapper;

    /**
     * 登录到后台
     **/
    @RequestMapping("/mloginback")
    public String loginback(String username, String password, HttpServletRequest request) throws UnsupportedEncodingException, NoSuchAlgorithmException {
        Manage manage = new Manage();
        manage.setMname(username);
        manage.setMpassword(MD5Util.EncoderByMd5(password));
        @Nullable
        Manage me = manageMapper.selectOne(manage);
        if (me == null) {
            return "redirect:/login2.html?logininfo=err";
        } else {
            request.getSession().setAttribute("admin", me);
            return "manage";
        }
    }

    @RequestMapping("/mleave")
    public String mleave(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        try {
            session.invalidate();
        } catch (Exception e) {
            e.printStackTrace();
            return "login2.html";
        }
        return "login2.html";
    }

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

    /**
     * 图表显示
     **/
    @RequestMapping("/mtoChart")
    public String tochart() {
        return "chart";
    }

    @RequestMapping("/mtopictcount")
    @ResponseBody
    public Map topicCount(@RequestParam("type") String type, @RequestParam("year") String year) {
        List<ChartVo> chartVos = null;
        if ("week".equals(type)) {
            chartVos = manageMapper.getTopicChartByWeek(year);
        } else if ("month".equals(type)) {
            chartVos = manageMapper.getTopicChartByMonth(year);
        }

        Map<String, Object> map = new HashMap<>();
        map.put("topicchart", chartVos);
        return map;
    }

    @RequestMapping("/mcommentcount")
    @ResponseBody
    public Map commentCount(@RequestParam("type") String type, @RequestParam("year") String year) {
        List<ChartVo> chartVos = null;
        if ("week".equals(type)) {
            chartVos = manageMapper.getCommentChartByWeek(year);
        } else if ("month".equals(type)) {
            chartVos = manageMapper.getCommentChartByMonth(year);
        }
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("commentchart", chartVos);
        return map;
    }

    @RequestMapping("/mregistercount")
    @ResponseBody
    public Map registerCount(@RequestParam("type") String type, @RequestParam("year") String year) {
        List<ChartVo> chartVos = null;
        if ("week".equals(type)) {
            chartVos = manageMapper.getRegisterChartByWeek(year);
        } else if ("month".equals(type)) {
            chartVos = manageMapper.getRegisterChartByMonth(year);
        }
        Map<String, Object> map = new HashMap<>();
        map.put("registerchart", chartVos);
        return map;
    }

    /**
     * 用户管理
     **/
    @RequestMapping("/mtomanusers")
    public String toManUsersJsp() {
        return "manusers";
    }

    /**
     * 板块管理
     **/
    @RequestMapping("/mtomansections")
    public String toManSections() {
        return "mansections";
    }

    @RequestMapping("/manlistsections")
    @ResponseBody
    public List manListSections() {
        List<Section> sectionList = sectionMapper.selectList(new EntityWrapper<>(new Section()));
        return sectionList;
    }

    @RequestMapping("/mtoeditsection")
    public String mToEditSection(@RequestParam("sid") int sid, Map<String, Object> map) {
        Section section = sectionMapper.selectById(sid);
        map.put("selectSection", section);
        return "editsection";
    }

    @RequestMapping("meditupdatesection")
    public void mEditUpdateSection(@RequestParam("sid") int sid, @RequestParam("sname") String sname,
                                   @RequestParam("sstatement") String sstatement, @RequestParam("sshortsm") String sshortsm,
                                   @RequestParam("sparentname") String sparentname,
                                   @RequestParam("smasterid") long smasterid, HttpServletResponse response) throws IOException {
        Section section = sectionMapper.selectById(sid);
        PrintWriter pw = response.getWriter();
        if (section == null) {
            pw.write("nosection");
        } else {
            if (sname.trim() == "" || sstatement.trim() == "" || sshortsm.trim() == "") {
                pw.write("hasnull");
            } else {
                User user = userMapper.selectById(smasterid);
                if (user == null) {
                    pw.write("smsternotexist");
                } else {
                    section.setSname(sname);
                    section.setSstatement(sstatement);
                    section.setSshortsm(sshortsm);
                    section.setSmasterid(smasterid);
                    section.setSparentname(sparentname);
                    //EntityWrapper<Section> sectionEntityWrapper = new EntityWrapper<>();
                    //sectionEntityWrapper.setEntity(section);
                    sectionMapper.updateById(section);
                    pw.write("success");
                }
            }
        }
    }

    @RequestMapping("/mtoaddsection")
    public String mToAddSection() {
        return "addsection";
    }

    @RequestMapping("/maddsection")
    public void addSection(@RequestParam("sname") String sname,
                           @RequestParam("sstatement") String sstatement,
                           @RequestParam("sshortsm") String sshortsm,
                           @RequestParam("sparentname") String sparentname,
                           @RequestParam("smasterid") long smasterid, HttpServletResponse response) throws IOException {
        PrintWriter pw = response.getWriter();
        if (sname.trim() == "" || sstatement.trim() == "" || sshortsm.trim() == "") {
            pw.write("hasnull");
        } else {
            User user = userMapper.selectById(smasterid);
            if (user == null) {
                pw.write("smsternotexist");
            } else {
                Section section = new Section();
                section.setSname(sname);
                section.setSstatement(sstatement);
                section.setSshortsm(sshortsm);
                section.setSmasterid(smasterid);
                section.setSparentname(sparentname);
                //EntityWrapper<Section> sectionEntityWrapper = new EntityWrapper<>();
                //sectionEntityWrapper.setEntity(section);
                sectionMapper.insert(section);
                pw.write("success");
            }
        }
    }

    /**
     * 帖子管理
     **/
    @RequestMapping("/mtomantopics")
    public String toManTopics(@RequestParam(value = "sid", required = false) Integer sid, Map<String, Object> map) {
        if (null != sid && sid != -1) {
            Section section = sectionMapper.selectById(sid);
            if (null != section) {
                System.out.println("section不等于空");
                map.put("sid", sid);
            } else {
                map.put("sid", -1);
            }
        } else {
            map.put("sid", -1);
        }
        return "mantopics";
    }

    @RequestMapping("/manlisttopics")
    @ResponseBody
    public List<ManTopic> manListTopics(@RequestParam("sid") int sid, HttpServletResponse response) {
        System.out.println("sid" + sid);
        List<ManTopic> manTopics = manageMapper.selectDetailTopic(sid);  //sid=0全部查询
        return manTopics;
    }

    @RequestMapping("/mdeletetopic")
    public void deleteTopic(@RequestParam("tid") long tid, HttpServletResponse response) throws IOException {
        int i = topicMapper.deleteById(tid);
        PrintWriter pw = response.getWriter();
        if (i == 1) {
            pw.write("success");
        } else {
            pw.write("err");
        }
        pw.close();
    }

    @RequestMapping("/mdeletetopicbatch")
    public void deleteTopicBatch(@RequestParam("tids[]") long[] tids, HttpServletResponse response) throws IOException {
        List tidList = Arrays.asList(tids);
        int i = topicMapper.deleteBatchIds(tidList);
        PrintWriter pw = response.getWriter();
        if (i == tidList.size()) {
            pw.write("success");
        } else {
            pw.write("err");
        }
        pw.close();
    }
}
