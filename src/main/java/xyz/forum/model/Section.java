package xyz.forum.model;

import java.io.Serializable;

import com.baomidou.mybatisplus.enums.IdType;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.activerecord.Model;

/**
 * <p>
 * <p>
 * </p>
 *
 * @author 李铎
 * @since 2017-12-01
 */
public class Section extends Model<Section> {

    private static final long serialVersionUID = 1L;

    /**
     * 板块自增Id
     */
    @TableId(value = "sid", type = IdType.AUTO)
    private Integer sid;
    /**
     * 板块名字
     */
    private String sname;
    /**
     * 对于user表的用户id
     */
    private Long smasterid;
    /**
     * 详细描述
     */
    private String sstatement;
    /**
     * 简要描述
     */
    private String sshortsm;
    /**
     * 访问量
     */
    private Long sclickcount;
    /**
     * 帖子量
     */
    private Long stopiccount;
    /**
     * 父级菜单名称
     */
    private String sparentname;


    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public String getSname() {
        return sname;
    }

    public void setSname(String sname) {
        this.sname = sname;
    }

    public Long getSmasterid() {
        return smasterid;
    }

    public void setSmasterid(Long smasterid) {
        this.smasterid = smasterid;
    }

    public String getSstatement() {
        return sstatement;
    }

    public void setSstatement(String sstatement) {
        this.sstatement = sstatement;
    }

    public String getSshortsm() {
        return sshortsm;
    }

    public void setSshortsm(String sshortsm) {
        this.sshortsm = sshortsm;
    }

    public Long getSclickcount() {
        return sclickcount;
    }

    public void setSclickcount(Long sclickcount) {
        this.sclickcount = sclickcount;
    }

    public Long getStopiccount() {
        return stopiccount;
    }

    public void setStopiccount(Long stopiccount) {
        this.stopiccount = stopiccount;
    }

    public String getSparentname() {
        return sparentname;
    }

    public void setSparentname(String sparentname) {
        this.sparentname = sparentname;
    }

    @Override
    protected Serializable pkVal() {
        return this.sid;
    }

    @Override
    public String toString() {
        return "Section{" +
                ", sid=" + sid +
                ", sname=" + sname +
                ", smasterid=" + smasterid +
                ", sstatement=" + sstatement +
                ", sshortsm=" + sshortsm +
                ", sclickcount=" + sclickcount +
                ", stopiccount=" + stopiccount +
                ", sparentname=" + sparentname +
                "}";
    }
}
