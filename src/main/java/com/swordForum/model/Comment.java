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
public class Comment extends Model<Comment> {

    private static final long serialVersionUID = 1L;

    /**
     * 评论自增id
     */
    @TableId(value = "cid", type = IdType.AUTO)
    private Long cid;
    /**
     * 所属帖子
     */
    private Long ctid;
    /**
     * 回帖人
     */
    private Long cuid;
    /**
     * 时间
     */
    private Date ctime;
    /**
     * 内容
     */
    private String content;
    /**
     * 对于的根评论cid
     */
    private Long rootcid;
    /**
     * 根评论下对谁说用户id
     */
    private Long parentuid;
    /**
     * 点赞
     */
    private Long czan;
    /**
     * 0未读1已读
     */
    private Integer isread;
    /**
     * 直接评论下的间接评论
     */
    private Long parentcid;


    public Long getCid() {
        return cid;
    }

    public void setCid(Long cid) {
        this.cid = cid;
    }

    public Long getCtid() {
        return ctid;
    }

    public void setCtid(Long ctid) {
        this.ctid = ctid;
    }

    public Long getCuid() {
        return cuid;
    }

    public void setCuid(Long cuid) {
        this.cuid = cuid;
    }

    public Date getCtime() {
        return ctime;
    }

    public void setCtime(Date ctime) {
        this.ctime = ctime;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Long getRootcid() {
        return rootcid;
    }

    public void setRootcid(Long rootcid) {
        this.rootcid = rootcid;
    }

    public Long getParentuid() {
        return parentuid;
    }

    public void setParentuid(Long parentuid) {
        this.parentuid = parentuid;
    }

    public Long getCzan() {
        return czan;
    }

    public void setCzan(Long czan) {
        this.czan = czan;
    }

    public Integer getIsread() {
        return isread;
    }

    public void setIsread(Integer isread) {
        this.isread = isread;
    }

    public Long getParentcid() {
        return parentcid;
    }

    public void setParentcid(Long parentcid) {
        this.parentcid = parentcid;
    }

    @Override
    protected Serializable pkVal() {
        return this.cid;
    }

    @Override
    public String toString() {
        return "Comment{" +
                ", cid=" + cid +
                ", ctid=" + ctid +
                ", cuid=" + cuid +
                ", ctime=" + ctime +
                ", content=" + content +
                ", rootcid=" + rootcid +
                ", parentuid=" + parentuid +
                ", czan=" + czan +
                ", isread=" + isread +
                ", parentcid=" + parentcid +
                "}";
    }
}
