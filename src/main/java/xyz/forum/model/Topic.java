package xyz.forum.model;

import java.io.Serializable;

import com.baomidou.mybatisplus.enums.IdType;

import java.util.Date;

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
public class Topic extends Model<Topic> {

    private static final long serialVersionUID = 1L;

    /**
     * 帖子自增id
     */
    @TableId(value = "tid", type = IdType.AUTO)
    private Long tid;
    /**
     * 所属板块
     */
    private Integer tsid;
    /**
     * 发帖人
     */
    private Long tuid;
    /**
     * 主题
     */
    private String ttopic;
    /**
     * 内容
     */
    private String tcontent;
    /**
     * 发布时间
     */
    private Date ttime;
    /**
     * 回帖量
     */
    private Long treplaycount;
    /**
     * 点击量
     */
    private Long tclickcount;
    /**
     * 上次访问时间
     */
    private Date tlastclicktime;
    /**
     * 0不置顶1置顶
     */
    private Integer tstaus;
    /**
     * 点赞量
     */
    private Long tzan;


    public Long getTid() {
        return tid;
    }

    public void setTid(Long tid) {
        this.tid = tid;
    }

    public Integer getTsid() {
        return tsid;
    }

    public void setTsid(Integer tsid) {
        this.tsid = tsid;
    }

    public Long getTuid() {
        return tuid;
    }

    public void setTuid(Long tuid) {
        this.tuid = tuid;
    }

    public String getTtopic() {
        return ttopic;
    }

    public void setTtopic(String ttopic) {
        this.ttopic = ttopic;
    }

    public String getTcontent() {
        return tcontent;
    }

    public void setTcontent(String tcontent) {
        this.tcontent = tcontent;
    }

    public Date getTtime() {
        return ttime;
    }

    public void setTtime(Date ttime) {
        this.ttime = ttime;
    }

    public Long getTreplaycount() {
        return treplaycount;
    }

    public void setTreplaycount(Long treplaycount) {
        this.treplaycount = treplaycount;
    }

    public Long getTclickcount() {
        return tclickcount;
    }

    public void setTclickcount(Long tclickcount) {
        this.tclickcount = tclickcount;
    }

    public Date getTlastclicktime() {
        return tlastclicktime;
    }

    public void setTlastclicktime(Date tlastclicktime) {
        this.tlastclicktime = tlastclicktime;
    }

    public Integer getTstaus() {
        return tstaus;
    }

    public void setTstaus(Integer tstaus) {
        this.tstaus = tstaus;
    }

    public Long getTzan() {
        return tzan;
    }

    public void setTzan(Long tzan) {
        this.tzan = tzan;
    }

    @Override
    protected Serializable pkVal() {
        return this.tid;
    }

    @Override
    public String toString() {
        return "Topic{" +
                ", tid=" + tid +
                ", tsid=" + tsid +
                ", tuid=" + tuid +
                ", ttopic=" + ttopic +
                ", tcontent=" + tcontent +
                ", ttime=" + ttime +
                ", treplaycount=" + treplaycount +
                ", tclickcount=" + tclickcount +
                ", tlastclicktime=" + tlastclicktime +
                ", tstaus=" + tstaus +
                ", tzan=" + tzan +
                "}";
    }
}
