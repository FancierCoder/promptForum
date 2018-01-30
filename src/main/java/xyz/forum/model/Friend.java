package xyz.forum.model;

import java.io.Serializable;

import com.baomidou.mybatisplus.enums.IdType;

import java.util.Date;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.activerecord.Model;

/**
 * <p>
 * 好友列表
 * </p>
 *
 * @author 李铎
 * @since 2017-12-01
 */
public class Friend extends Model<Friend> {

    private static final long serialVersionUID = 1L;

    /**
     * 自增id
     */
    @TableId(value = "fid", type = IdType.AUTO)
    private Long fid;
    /**
     * 用户a，发出申请方
     */
    private Long fromuid;
    /**
     * 用户b，接受申请方
     */
    private Long touid;
    /**
     * 时间
     */
    private Date time;


    public Long getFid() {
        return fid;
    }

    public void setFid(Long fid) {
        this.fid = fid;
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

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    @Override
    protected Serializable pkVal() {
        return this.fid;
    }

    @Override
    public String toString() {
        return "Friend{" +
                ", fid=" + fid +
                ", fromuid=" + fromuid +
                ", touid=" + touid +
                ", time=" + time +
                "}";
    }
}
