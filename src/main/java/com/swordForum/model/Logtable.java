package com.swordForum.model;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.enums.IdType;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * <p>
 * </p>
 *
 * @author 李铎
 * @since 2017-12-01
 */
public class Logtable extends Model<Logtable> {

    private static final long serialVersionUID = 1L;

    /**
     * 自增
     */
    @TableId(value = "lid", type = IdType.AUTO)
    private Long lid;
    /**
     * 用户Id
     */
    private Long uid;
    /**
     * 用户ip
     */
    private String ip;
    /**
     * 操作时间
     */
    private Date time;
    /**
     * 1登录2退出3修改密码4忘记密码再修改5发表文章6删除文章7发表评论8删除评论
     */
    private Integer type;

    public Logtable() {

    }

    public Logtable(Long uid, String ip, Date time, Integer type) {
        this.uid = uid;
        this.ip = ip;
        this.time = time;
        this.type = type;
    }

    public Logtable(Long uid, String ip, Integer type) {
        this.uid = uid;
        this.ip = ip;
        this.type = type;
    }

    public Long getLid() {
        return lid;
    }

    public void setLid(Long lid) {
        this.lid = lid;
    }

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    @Override
    protected Serializable pkVal() {
        return this.lid;
    }

    @Override
    public String toString() {
        return "Logtable{" +
                ", lid=" + lid +
                ", uid=" + uid +
                ", ip=" + ip +
                ", time=" + time +
                ", type=" + type +
                "}";
    }
}
