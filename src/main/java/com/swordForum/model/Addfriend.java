package com.swordForum.model;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.enums.IdType;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 申请添加好友持久化记录
 * </p>
 *
 * @author 李铎
 * @since 2017-12-01
 */
public class Addfriend extends Model<Addfriend> {

    private static final long serialVersionUID = 1L;

    /**
     * 自增id
     */
    @TableId(value = "aid", type = IdType.AUTO)
    private Long aid;
    /**
     * 发出请求方
     */
    private Long fromuid;
    /**
     * 接受请求方
     */
    private Long touid;
    /**
     * 时间
     */
    private Date addtime;
    /**
     * ‘接受’，‘拒绝’，等待
     */
    private String staus;
    /**
     * 0未改变1改变状态
     */
    private Integer flag;


    public Long getAid() {
        return aid;
    }

    public void setAid(Long aid) {
        this.aid = aid;
    }

    public Long getFromuid() {
        return fromuid;
    }

    public void setFromuid(Long fromuid) {
        this.fromuid = fromuid;
    }

    public Long getTouid() {
        return touid;
    }

    public void setTouid(Long touid) {
        this.touid = touid;
    }

    public Date getAddtime() {
        return addtime;
    }

    public void setAddtime(Date addtime) {
        this.addtime = addtime;
    }

    public String getStaus() {
        return staus;
    }

    public void setStaus(String staus) {
        this.staus = staus;
    }

    public Integer getFlag() {
        return flag;
    }

    public void setFlag(Integer flag) {
        this.flag = flag;
    }

    @Override
    protected Serializable pkVal() {
        return this.aid;
    }

    @Override
    public String toString() {
        return "Addfriend{" +
                ", aid=" + aid +
                ", fromuid=" + fromuid +
                ", touid=" + touid +
                ", addtime=" + addtime +
                ", staus=" + staus +
                ", flag=" + flag +
                "}";
    }
}
