package com.swordForum.control;


import com.swordForum.listener.Online;
import com.swordForum.mapper.LogtableMapper;
import com.swordForum.mapper.UserMapper;
import com.swordForum.model.Logtable;
import com.swordForum.model.User;
import com.swordForum.util.IpUtil;
import com.swordForum.util.LevelUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
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
@RequestMapping("/user")
public class UserController {

    @Resource
    private UserMapper userMapper;

    @Resource
    private LogtableMapper logtableMapper;

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
                    request.getSession().setAttribute("loginfirst", "yes");  //第一次登录
                    //System.out.println("==今天第一次登录===");
                } else {
                    request.getSession().setAttribute("loginfirst", "no");
                    //System.out.println("==今天不是第一次登录====");
                }
                request.getSession().setAttribute("user", user);
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
}
