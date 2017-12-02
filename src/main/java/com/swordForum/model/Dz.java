package com.swordForum.model;

import java.io.Serializable;

import com.baomidou.mybatisplus.enums.IdType;

import java.util.Date;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.activerecord.Model;

import java.io.Serializable;

/**
 * <p>
 * <p>
 * </p>
 *
 * @author 李铎
 * @since 2017-12-01
 */
public class Dz extends Model<Dz> {

    private static final long serialVersionUID = 1L;

    @TableId(value = "dzid", type = IdType.AUTO)
    private Long dzid;
    private Long dzfromuid;
    /**
     * 点赞的文章，只能赞一次
     */
    private Long dztopicid;
    private Date dztime;


    public Long getDzid() {
        return dzid;
    }

    public void setDzid(Long dzid) {
        this.dzid = dzid;
    }

    public Long getDzfromuid() {
        return dzfromuid;
    }

    public void setDzfromuid(Long dzfromuid) {
        this.dzfromuid = dzfromuid;
    }

    public Long getDztopicid() {
        return dztopicid;
    }

    public void setDztopicid(Long dztopicid) {
        this.dztopicid = dztopicid;
    }

    public Date getDztime() {
        return dztime;
    }

    public void setDztime(Date dztime) {
        this.dztime = dztime;
    }

    @Override
    protected Serializable pkVal() {
        return this.dzid;
    }

    @Override
    public String toString() {
        return "Dz{" +
                ", dzid=" + dzid +
                ", dzfromuid=" + dzfromuid +
                ", dztopicid=" + dztopicid +
                ", dztime=" + dztime +
                "}";
    }
}
