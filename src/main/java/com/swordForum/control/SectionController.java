package com.swordForum.control;


import com.swordForum.listener.Online;
import com.swordForum.mapper.SectionMapper;
import com.swordForum.model.Section;
import com.swordForum.model.VO.SectionVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    @RequestMapping("/Index")
    public String getAllSection(Map map) {
        List<String> parentName = sectionMapper.getParentName();
        List<SectionVo> sectionVoList = new ArrayList<>(parentName.size());
        for (int i = 0; i < parentName.size(); i++) {
            Map<String, Object> mapWhere = new HashMap<>();
            mapWhere.put("sparentname", parentName.get(i));
            List<Section> par_sections = sectionMapper.selectByMap(mapWhere);
            SectionVo sectionVo = new SectionVo();
            sectionVo.setSparentname(parentName.get(i));
            sectionVo.setSections(par_sections);
            sectionVoList.add(sectionVo);
        }
        map.put("sectionvos", sectionVoList);
        Long maxsid = sectionMapper.selectMaxClickSid();
        map.put("maxsid", maxsid);
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

}

