package com.swordForum.control;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.google.code.kaptcha.Constants;
import com.google.code.kaptcha.Producer;
import com.swordForum.mapper.*;
import com.swordForum.model.*;
import com.swordForum.model.VO.AddFriendVo;
import com.swordForum.model.VO.UnreadComm;
import com.swordForum.websocket.SixinHandler;
import com.swordForum.websocket.SystemWebSocketHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.socket.TextMessage;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

/**
 * 消息方面的处理
 */
@Controller
public class MessageControl {
    @Resource
    private UserMapper userMapper;
    @Resource
    private SixinMapper sixinMapper;
    @Resource
    private FriendMapper friendMapper;
    @Resource
    private AddfriendMapper addfriendMapper;
    @Resource
    private SystemWebSocketHandler webSocketHandler;
    @Resource
    private CommentMapper commentMapper;

    @RequestMapping("/tosixin")
    public String toSixin(HttpServletRequest request, Map<String, Object> map) {
        User me = (User) request.getSession(false).getAttribute("user");
        //查出我的所有好友列表
        Map map1 = new HashMap<String, Object>(1);
        map1.put("fromuid", me.getUid());
        List<Friend> friends1 = friendMapper.selectByMap(map1);
        Map map2 = new HashMap<String, Object>(1);
        map2.put("touid", me.getUid());
        List<Friend> friends2 = friendMapper.selectByMap(map2);
        List<User> users1 = null;
        List<User> users2 = null;
        if (friends1 != null && friends1.size() != 0) {
            users1 = new ArrayList<>(friends1.size());
            for (Friend f : friends1) {
                User u = userMapper.selectById(f.getTouid());
                users1.add(u);
            }
        }
        if (friends2 != null && friends2.size() != 0) {
            users2 = new ArrayList<>(friends2.size());
            for (Friend f : friends2) {
                if (f.getFromuid() == -1L) {
                    User sys = new User();
                    sys.setUid(-1L);
                    sys.setUemail("系统");
                    sys.setUnickname("系统");
                    sys.setHeadimg("sys.png");
                    users2.add(sys);
                } else {
                    User u = userMapper.selectById(f.getFromuid());
                    users2.add(u);
                }
            }
        }
        if (users1 != null) {
            users2.addAll(users1);
        }
        map.put("myfriends", users2);

        return "sixin";
    }

    /**
     * 判断是不是朋友
     **/
    public static boolean isFriend(long hisuid, long meid, FriendMapper friendMapper) {
        Friend friendWhere = new Friend();

        friendWhere.setFromuid(meid);
        friendWhere.setTouid(hisuid);
        EntityWrapper<Friend> friendEntityWrapper = new EntityWrapper<>();
        friendEntityWrapper.setEntity(friendWhere);
        int i = friendMapper.selectCount(friendEntityWrapper);

        friendWhere.setFromuid(hisuid);
        friendWhere.setTouid(meid);
        int j = friendMapper.selectCount(friendEntityWrapper);

        if ((i + j) != 0) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * 添加好友,发送请求
     **/
    @RequestMapping("/askforaddfriend")
    @ResponseBody
    public void askForAddFriend(@RequestParam("hisuid") Long hisuid, HttpServletRequest request, HttpServletResponse response) throws IOException {
        User me = (User) request.getSession(false).getAttribute("user");
        Addfriend addfriend = new Addfriend();
        addfriend.setFromuid(me.getUid());
        addfriend.setTouid(hisuid);
        addfriend.setAddtime(new Date());
        addfriend.setStaus("等待");
        addfriend.setFlag(0);
        int i = addfriendMapper.insert(addfriend);
        PrintWriter pw = response.getWriter();
        if (i > 0) {
            Map<String, Integer> countMap = webSocketHandler.unReadMsgCount(me.getUid());
            webSocketHandler.sendMessageToUser(hisuid, new TextMessage(JSON.toJSONString(countMap)));
            pw.write("success");
        } else {
            pw.write("error");
        }
    }

    /**
     * 我添加他人和他人添加我的消息记录
     **/
    @RequestMapping("/unhandleraddfriend")
    public String unHandlerAddFriend(HttpServletRequest request, @RequestParam("page") int current, Map<String, Object> map) {
        User me = (User) request.getSession(false).getAttribute("user");
        EntityWrapper<Addfriend> ew1 = new EntityWrapper<>();
        ew1.where("fromuid=" + me.getUid()).and("staus!={0}", "'等待'").and("flag=1").orderBy("addtime", false);
        List<Addfriend> iadd = addfriendMapper.selectList(ew1);
        List<AddFriendVo> iaddVo = new ArrayList<>(iadd.size());
        for (Addfriend addfriend1 : iadd) {
            AddFriendVo addFriendVo = new AddFriendVo();
            addFriendVo.setUser(userMapper.selectById(addfriend1.getTouid()));
            addFriendVo.setAddfriend(addfriend1);
            System.out.println(addfriend1.getAddtime());
            iaddVo.add(addFriendVo);
        }
        EntityWrapper<Addfriend> ew2 = new EntityWrapper<>();
        ew2.where("touid=" + me.getUid()).and("staus='等待'").orderBy("addtime", false);
        List<Addfriend> addi = addfriendMapper.selectList(ew2);
        List<AddFriendVo> addiVo = new ArrayList<>(addi.size());
        for (Addfriend addFriend2 : addi) {
            AddFriendVo addFriendVo = new AddFriendVo();
            addFriendVo.setUser(userMapper.selectById(addFriend2.getFromuid()));
            addFriendVo.setAddfriend(addFriend2);
            addiVo.add(addFriendVo);
            System.out.println(addFriend2.getAddtime());
        }
        iaddVo.addAll(addiVo);
        map.put("alladdfriend", iaddVo);
        return "unhandleraddfriend";
    }

    /**
     * 查看我的未读评论
     **/
    @RequestMapping("/unReadComment")
    public String unReadComment(HttpServletRequest request, @RequestParam("page") int current, Map<String, Object> map) {
        User me = (User) request.getSession(false).getAttribute("user");
        Page page = new Page(current, 8);
        List<UnreadComm> unreadComms = commentMapper.unreadComment(page, me.getUid());
        map.put("unreadcomms", unreadComms);
        map.put("pages", page.getPages());
        return "unreadcomment";
    }

    /**
     * 接受拒绝和完成添加好友
     * 1.添加他人为好友的对方反馈 我再确认表明已读下次不再查询此条记录
     * 2.自己接受添加他人
     * 3.自己拒绝添加他人
     **/
    @RequestMapping("/finishaddfriend")
    public void finishAddFriend(@RequestParam("touid") long touid, HttpServletRequest request, HttpServletResponse response) throws IOException {
        User me = (User) request.getSession(false).getAttribute("user");
        PrintWriter pw = response.getWriter();
        int i = addfriendMapper.finishAddFriend(me.getUid(), touid);
        if (i != 0) {
            pw.write("success");
        } else {
            pw.write("error");
        }
        pw.close();
    }

    @RequestMapping("/acceptaddfriend")
    public void acceptAddFriend(@RequestParam("fromuid") long fromuid, HttpServletRequest request, HttpServletResponse response) throws IOException {
        PrintWriter pw = response.getWriter();
        User me = (User) request.getSession(false).getAttribute("user");
        addfriendMapper.acceptAddFriend(fromuid, me.getUid());
        Friend friend = new Friend();
        friend.setFromuid(fromuid);
        friend.setTouid(me.getUid());
        EntityWrapper<Friend> friendEntityWrapper = new EntityWrapper<>();
        friendEntityWrapper.setEntity(friend);
        if (friendMapper.selectCount(friendEntityWrapper) == 0) {
            friendMapper.insert(friend);
            Map<String, Integer> countMap = webSocketHandler.unReadMsgCount(fromuid);
            webSocketHandler.sendMessageToUser(fromuid, new TextMessage(JSON.toJSONString(countMap)));
            pw.write("success");
        } else {
            pw.write("error");
        }
        pw.close();
    }

    @RequestMapping("/rejectaddfriend")
    public void rejectAddFriend(@RequestParam("fromuid") long fromuid, HttpServletRequest request, HttpServletResponse response) throws IOException {
        PrintWriter pw = response.getWriter();
        User me = (User) request.getSession(false).getAttribute("user");
        addfriendMapper.rejectAddFriend(fromuid, me.getUid());
        Map<String, Integer> countMap = webSocketHandler.unReadMsgCount(fromuid);
        webSocketHandler.sendMessageToUser(fromuid, new TextMessage(JSON.toJSONString(countMap)));
        pw.write("success");
        pw.close();
    }

    /**
     * 打开与某人的聊天记录
     *
     * @param request
     * @param hisuid
     * @return
     * @throws IOException
     */
    @RequestMapping("/openchatlastinfo")
    @ResponseBody
    public List<Sixin> openChatLastInfo(HttpServletRequest request, @RequestParam("hisuid") long hisuid) throws IOException {
        User me = (User) request.getSession(false).getAttribute("user");
        List<Sixin> sixinList = sixinMapper.selectLimitSixin(hisuid, me.getUid(), 100);
        sixinMapper.updateHaveRead(hisuid, me.getUid()); //更新未读-》已读
        SixinHandler.who_To_who.put(me.getUid(), hisuid); //说明我正在和hisuid聊天
        //更新首页未读信息，为了当你查看未读私信之后不在提示有未读消息
        //好友列表显示的未读数目放在前台搞
        Map map = webSocketHandler.unReadMsgCount(me.getUid());
        webSocketHandler.sendMessageToUser(me.getUid(), new TextMessage(JSON.toJSONString(map)));

        return sixinList;
    }

    @RequestMapping("/forgetPass")
    public String forgetPass() {

        return "forgetPass";
    }

    @Resource
    private Producer producer;

    @RequestMapping("captcha.jpg")
    public void captcha(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setHeader("Cache-Control", "no-store, no-cache");
        response.setContentType("image/jpeg");

        //生成文字验证码
        String text = producer.createText();
        //生成图片验证码
        BufferedImage image = producer.createImage(text);
        //保存到shiro session
        try {
            request.getSession(false).setAttribute(Constants.KAPTCHA_SESSION_KEY, text);
        } catch (Exception e) {
            request.getSession().setAttribute(Constants.KAPTCHA_SESSION_KEY, text);
        }

        ServletOutputStream out = response.getOutputStream();
        ImageIO.write(image, "jpg", out);
    }

    @RequestMapping("/manage")
    public String toManage(HttpServletRequest request) {
        Manage admin;
        try {
            admin = (Manage) request.getSession(false).getAttribute("admin");
            if (admin == null)
                return "redirect:/login2.html";
            else
                return "manage";
        } catch (Exception e) {
            return "redirect:/login2.html";
        }
    }

}
