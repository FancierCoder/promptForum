package com.swordForum.model.VO;

import com.swordForum.model.Section;

import java.util.List;

public class SectionVo {
    //父级菜单名字
    private String sparentname;
    //父级下面的板块
    private List<Section> sections;

    public String getSparentname() {
        return sparentname;
    }

    public void setSparentname(String sparentname) {
        this.sparentname = sparentname;
    }

    public List<Section> getSections() {
        return sections;
    }

    public void setSections(List<Section> sections) {
        this.sections = sections;
    }
}
