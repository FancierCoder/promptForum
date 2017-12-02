package com.swordForum.model;

import java.io.Serializable;

import com.baomidou.mybatisplus.enums.IdType;
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
public class Concern extends Model<Concern> {

    private static final long serialVersionUID = 1L;

    /**
     * 关注自增id
     */
    @TableId(value = "conid", type = IdType.AUTO)
    private Long conid;
    /**
     * 关注方
     */
    private Long confromuid;
    /**
     * 被关注方
     */
    private Long contouid;


    public Long getConid() {
        return conid;
    }

    public void setConid(Long conid) {
        this.conid = conid;
    }

    public Long getConfromuid() {
        return confromuid;
    }

    public void setConfromuid(Long confromuid) {
        this.confromuid = confromuid;
    }

    public Long getContouid() {
        return contouid;
    }

    public void setContouid(Long contouid) {
        this.contouid = contouid;
    }

    @Override
    protected Serializable pkVal() {
        return this.conid;
    }

    @Override
    public String toString() {
        return "Concern{" +
                ", conid=" + conid +
                ", confromuid=" + confromuid +
                ", contouid=" + contouid +
                "}";
    }
}
