package com.swordForum.control;


import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.swordForum.listener.Online;
import com.swordForum.mapper.ConcernMapper;
import com.swordForum.mapper.LogtableMapper;
import com.swordForum.mapper.TopicMapper;
import com.swordForum.mapper.UserMapper;
import com.swordForum.model.Concern;
import com.swordForum.model.Logtable;
import com.swordForum.model.Topic;
import com.swordForum.model.User;
import com.swordForum.model.VO.TopicCatalogVo;
import com.swordForum.util.IpUtil;
import com.swordForum.util.LevelUtil;
import com.swordForum.util.toVoUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
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
@RequestMapping("/user")
public class UserController {

    @Resource
    private UserMapper userMapper;

    @Resource
    private LogtableMapper logtableMapper;

    @Resource
    private ConcernMapper concernMapper;

    @Resource
    private TopicMapper topicMapper;

    @RequestMapping(value = "/checkLogin", method = RequestMethod.POST)
    public void checkLogin(@RequestParam("username") String username, @RequestParam("password") String password, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> mapwhere = new HashMap<>(2);
        mapwhere.put("uemail", username);
        mapwhere.put("upassword", password);
        List<User> userList = userMapper.selectByMap(mapwhere);
        if (userList != null && userList.size() != 0) {
            User user = userList.get(0);
            if (user.getUstate() == 0) {
                //记录登录表，每天的登录加一次积分
                IpUtil ipUtil = new IpUtil();
                String ip = ipUtil.getIp(request);
                Date date = new Date();
                Logtable logtable = new Logtable(user.getUid(), ip, date, 1);
                logtableMapper.insert(logtable);
                //先插入了登录记录，所以为1才是第一次登录
                int count = logtableMapper.todayLoginCount(user.getUid(), date);
                if (count == 1) {
                    int oldPoint = user.getUpoint();
                    int newPoint = oldPoint + 10;
                    int level = LevelUtil.point2Level(newPoint);
                    user.setUpoint(newPoint);
                    user.setUlevel(level);
                    userMapper.updateById(user);
                    request.getSession(false).setAttribute("loginfirst", "yes");  //第一次登录
                    //System.out.println("==今天第一次登录===");
                } else {
                    request.getSession(false).setAttribute("loginfirst", "no");
                    //System.out.println("==今天不是第一次登录====");
                }
                request.getSession(false).setAttribute("user", user);
                Online.add();
                System.out.println("登录成功：" + user.getUnickname());
                try {
                    response.getWriter().write("success");
                    response.getWriter().flush();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            } else {
                /////用户被封了
                try {
                    response.getWriter().write("" + user.getUstate());
                    response.getWriter().flush();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        } else {
            try {
                response.getWriter().write("err");
                response.getWriter().flush();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    @RequestMapping("/login")
    public String login(HttpServletRequest request) {
        User user = (User) request.getSession(false).getAttribute("user");
        if (user != null && user.getUid() != null) {
            return "redirect:/index.jsp";
        } else {
            return "redirect:/login.html";
        }
    }

    @RequestMapping("/firstLoginSession")
    public void changeLoginSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            String loginFirstFlag = (String) session.getAttribute("loginfirst");
            if (loginFirstFlag.equals("yes")) {
                session.setAttribute("loginfirst", "yesing");
            }
        }
    }

    @RequestMapping("/leave")
    public String leave(HttpServletRequest request) throws Exception {
        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            Logtable logtable = new Logtable(user.getUid(), new IpUtil().getIp(request), 2);
            logtableMapper.insert(logtable);
        }
        session.invalidate();
        return "redirect:/login.html";
    }

    @RequestMapping("/showmyplace")
    public String showmyplace(HttpServletRequest request, HttpServletResponse response) {
        User user = (User) request.getSession().getAttribute("user");
        long[] othernums = userOtherinfo(user.getUid());
        request.setAttribute("mytopicnum", othernums[0]);
        request.setAttribute("myconcernnum", othernums[1]);
        request.setAttribute("beconcernnum", othernums[2]);
        //查询我关注的人的最新动态
        List<Topic> topicList = concernMapper.concernTopic(user.getUid());
        List<TopicCatalogVo> topicCatalogVoList = null;
        if (topicList.size() != 0) {
            topicCatalogVoList = new ArrayList<>(topicList.size());
            for (Topic t : topicList) {
                User concerner = userMapper.selectById(t.getTuid());
                TopicCatalogVo vo = toVoUtil.toTopciVO(t, concerner);
                topicCatalogVoList.add(vo);
            }
        }
        request.setAttribute("tcvos", topicCatalogVoList);
        return "myplace";
    }

    /*我发布的帖子数目 我关注的人数目 关注我的人数目 除了自己别人也可以看到 */
    private long[] userOtherinfo(long uid) {
        long[] nums = new long[3];
        Topic topic = new Topic();
        topic.setTuid(uid);
        EntityWrapper<Topic> topicEntityWrapper = new EntityWrapper<>();
        topicEntityWrapper.setEntity(topic);
        int topicnum = topicMapper.selectCount(topicEntityWrapper);
        nums[0] = topicnum;
        /*我关注多少人*/
        Concern concern1 = new Concern();
        concern1.setConfromuid(uid);
        EntityWrapper<Concern> concernEntityWrapper = new EntityWrapper<>();
        concernEntityWrapper.setEntity(concern1);
        int myconcernnum = concernMapper.selectCount(concernEntityWrapper);
        nums[1] = myconcernnum;
        /*关注我多少人*/
        Concern concern2 = new Concern();
        concern2.setContouid(uid);
        EntityWrapper<Concern> concernEntityWrapper1 = new EntityWrapper<>();
        concernEntityWrapper1.setEntity(concern2);
        int beconcernnum = concernMapper.selectCount(concernEntityWrapper1);
        nums[2] = beconcernnum;
        return nums;
    }
}
