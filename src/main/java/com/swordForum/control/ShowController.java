package com.swordForum.control;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.swordForum.mapper.*;
import com.swordForum.model.Comment;
import com.swordForum.model.Section;
import com.swordForum.model.Topic;
import com.swordForum.model.User;
import com.swordForum.model.VO.CommentVo;
import com.swordForum.model.VO.CommentVoS;
import com.swordForum.model.VO.TopicCatalogVo;
import com.swordForum.util.DateUtil;
import com.swordForum.util.HtmlUtil;
import com.swordForum.util.toVoUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

@Controller
@RequestMapping("/show")
public class ShowController {
    public static final int PAGESIZE = 9;
    @Resource
    private SectionMapper sectionMapper;
    @Resource
    private TopicMapper topicMapper;
    @Resource
    private CommentMapper commentMapper;
    @Resource
    private CateLogMapper catelogMapper;
    @Resource
    private UserMapper userMapper;

    @RequestMapping(value = "/showTopicDetail/{tid}")
    public String showComment(@PathVariable("tid") long tid, Map<String, Object> map, HttpServletRequest request) {
        //获取楼主的信息 直接使用TopicCataLogVo,只需把html过滤去掉,时间采用中国日期格式
        Topic maintopic = topicMapper.selectById(tid);
        User topicuser = userMapper.selectById(maintopic.getTuid());
        Section section = sectionMapper.selectById(maintopic.getTsid());
        User me = null;
        me = (User) request.getSession(false).getAttribute("user");
        if (me != null && me.getUid().equals(topicuser.getUid())) {
            commentMapper.updateRead(tid);
        }
        TopicCatalogVo topicCatalogVo = toVoUtil.toTopciVO(maintopic, topicuser, HtmlUtil.NOTFILTER, 1);
        List<CommentVoS> commentvoslist = new ArrayList<>();   //所有的评论集合
//        Map<String, Object> rootmap = new HashMap<>();
//        rootmap.put("ctid", tid);
//        rootmap.put("rootcid", 0L);
        Comment comment = new Comment();
        comment.setCtid(tid);
        comment.setRootcid(0L);
        EntityWrapper<Comment> commentEntityWrapper = new EntityWrapper<>();
        commentEntityWrapper.setEntity(comment);
        commentEntityWrapper.and("isshow = 1");
        //List<Comment> rootComments = commentMapper.selectByMap(rootmap);  //查出所以得根评论
        List<Comment> rootComments = commentMapper.selectList(commentEntityWrapper);  //查出所以得根评论
        for (Comment c : rootComments) {
            //直接根评论
            CommentVo rootcomment = comment2Vo(c, userMapper);
            //根据根评论的cid来查出里面的子评论
            Long cid = c.getCid();
//            Map<String, Object> rootdirectmap = new HashMap<>();
//            rootdirectmap.put("rootcid", cid);
//            rootdirectmap.put("parentuid", 0L);
            Comment subComment = new Comment();
            subComment.setRootcid(cid);
            subComment.setParentuid(0L);
            EntityWrapper<Comment> wrapper = new EntityWrapper<>(subComment);
            wrapper.and("isshow = 1");
            //List<Comment> rootdirects = commentMapper.selectByMap(rootdirectmap);//根评论下的直接评论
            List<Comment> rootdirects = commentMapper.selectList(wrapper);//根评论下的直接评论
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

    @RequestMapping(value = "/catalog", method = RequestMethod.POST)
    @ResponseBody
    public Map getCatalog(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<>();
        List<Section> sectionList = sectionMapper.selectList(null);
        List<Integer> replycountList = new ArrayList<Integer>();
        for (int i = 0; i < sectionList.size(); i++) {
            int sid = sectionList.get(i).getSid();
            int count = catelogMapper.sectionReply(sid);
            replycountList.add(count);
        }

        map.put("b", replycountList);

        return map;
    }

    @RequestMapping("/topicCatalog")
    public String getTopicCatalog(@RequestParam("sid") int sid, @RequestParam(value = "page", required = false) Integer current, Map<String, Object> map) {
        ArrayList<TopicCatalogVo> topicCatalogVos = new ArrayList<>(20);
        Map<String, Object> mapwhere1 = new HashMap<>(2);
        mapwhere1.put("tsid", sid);
        mapwhere1.put("tstaus", 1);
        List<Topic> topics1 = topicMapper.selectByMap(mapwhere1); //查询出在sid版块下的被置顶的帖子
        int size = PAGESIZE;
        //如果是第一页则把置顶的放入集合，然后分页查询未置顶的size-1
        if (current == 0 || current == 1 || current == null) {
            current = 1;
            if (topics1.size() != 0) {
                Topic t1 = topics1.get(0);
                User user = userMapper.selectById(t1.getTuid());
                TopicCatalogVo tcvo1 = toVoUtil.toTopciVO(t1, user);
                topicCatalogVos.add(tcvo1);
                size = size - 1;
            }
        }
        List<Topic> topics2 = catelogMapper.sectionTopic(new Page<>(current, size), sid);//查询出sid板块下的未被置顶的帖子 时间降序
        Topic countTopic = new Topic();
        countTopic.setTsid(sid);
        EntityWrapper<Topic> topicEntityWrapper = new EntityWrapper<>();
        topicEntityWrapper.setEntity(countTopic);
        int count = topicMapper.selectCount(topicEntityWrapper);     //总数
        for (Topic t : topics2) {
            User user = userMapper.selectById(t.getTuid());
            TopicCatalogVo tcvo = toVoUtil.toTopciVO(t, user);  //默认为过滤，时间为间隔
            topicCatalogVos.add(tcvo);
        }
        Section section = sectionMapper.selectById(sid);
        String sname = section.getSname();
        String sstatement = section.getSstatement();
        int pages = 0;
        if (count <= PAGESIZE) {
            pages = 1;
        } else {
            if (count % PAGESIZE == 0) {
                pages = count / PAGESIZE;
            } else {
                pages = count / PAGESIZE + 1;
            }
        }
        map.put("tcvos", topicCatalogVos);
        map.put("sname", sname);
        map.put("sstatement", sstatement);
        map.put("sid", sid);
        map.put("pages", pages);
        /************最后再点击数+1*************/
        updateSessionClick(sid);
        return "topicCatalog";
    }

    public synchronized void updateSessionClick(int sid) {
        Section section = sectionMapper.selectById(sid);
        section.setSclickcount(section.getSclickcount() + 1);
        sectionMapper.updateById(section);
    }

    @RequestMapping("/search")
    public String search(@RequestParam("searchkey") String key, Map map) {
        System.out.println(key);
        EntityWrapper<User> userEw = new EntityWrapper<>();
        userEw.where("unickname like '%" + key + "%'").or("uemail like '%" + key + "%'");
        List<User> userList = userMapper.selectList(userEw);
        EntityWrapper<Topic> topicEw = new EntityWrapper<>();
        topicEw.where("ttopic like '%" + key + "%'");
        List<Topic> topicList = topicMapper.selectList(topicEw);
        List<TopicCatalogVo> topicCatalogVos = null;
        if (topicList.size() != 0) {
            topicCatalogVos = new ArrayList<>(topicList.size());
        }
        for (Topic t : topicList) {
            User user = userMapper.selectById(t.getTuid());
            TopicCatalogVo topicCatalogVo = toVoUtil.toTopciVO(t, user);
            topicCatalogVos.add(topicCatalogVo);
        }
        map.put("userlist", userList);
        map.put("topiclist", topicCatalogVos);
        return "search";
    }

}
