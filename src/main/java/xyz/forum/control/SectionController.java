package xyz.forum.control;


import xyz.forum.listener.Online;
import xyz.forum.mapper.SectionMapper;
import xyz.forum.model.Section;
import xyz.forum.model.VO.SectionVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.*;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author 李铎
 * @since 2017-11-29
 */
@Controller
public class SectionController {

    @Resource
    private SectionMapper sectionMapper;

    private String forumName = "";

    @RequestMapping("/Index")
    public String getAllSection(Map map) {
        List<String> parentName = sectionMapper.getParentName();
        List<SectionVo> sectionVoList = new ArrayList<>(parentName.size());
        for (String aParentName : parentName) {
            Map<String, Object> mapWhere = new HashMap<>();
            mapWhere.put("sparentname", aParentName);
            List<Section> par_sections = sectionMapper.selectByMap(mapWhere);
            SectionVo sectionVo = new SectionVo();
            sectionVo.setSparentname(aParentName);
            sectionVo.setSections(par_sections);
            sectionVoList.add(sectionVo);
        }
        map.put("sectionvos", sectionVoList);
        Long maxSid = sectionMapper.selectMaxClickSid();
        map.put("maxsid", maxSid);

        readPro();
        map.put("forumName", forumName);
        return "index";
    }

    @RequestMapping("/section/toCatalog")
    public String toCatalog(Map map) {
        System.out.println("进入论坛");
        List<Section> sectionList = sectionMapper.selectList(null);
        Long sumOfTopic = sectionMapper.selectAllTopicSum();
        map.put("sectionlist", sectionList);
        map.put("sumoftopic", sumOfTopic);
        map.put("onlineCount", Online.getCount());
        return "forum_main";
    }

    @RequestMapping("/section/getSection")
    @ResponseBody
    public List<Section> getSection() {
        List<Section> sectionList = sectionMapper.selectList(null);
        return sectionList;
    }

    private void readPro() {
        ResourceBundle resource = ResourceBundle.getBundle("otherConfig");
        forumName = resource.getString("forumName");
    }
}

