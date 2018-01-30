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
public class Sixin extends Model<Sixin> {

    private static final long serialVersionUID = 1L;

    /**
     * 自增私信id
     */
    @TableId(value = "siid", type = IdType.AUTO)
    private Long siid;
    /**
     * 为了让系统发消息，-1代表系统，不用外键
     */
    private Long sifromuid;
    /**
     * 接受方
     */
    private Long sitouid;
    /**
     * 为了丰富以后内容是由text
     */
    private String content;
    /**
     * 发送时间
     */
    private Date time;
    /**
     * 0默认未读，1已读
     */
    private Integer isread;


    public Long getSiid() {
        return siid;
    }

    public void setSiid(Long siid) {
        this.siid = siid;
    }

    public Long getSifromuid() {
        return sifromuid;
    }

    public void setSifromuid(Long sifromuid) {
        this.sifromuid = sifromuid;
    }

    public Long getSitouid() {
        return sitouid;
    }

    public void setSitouid(Long sitouid) {
        this.sitouid = sitouid;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public Integer getIsread() {
        return isread;
    }

    public void setIsread(Integer isread) {
        this.isread = isread;
    }

    @Override
    protected Serializable pkVal() {
        return this.siid;
    }

    @Override
    public String toString() {
        return "Sixin{" +
                ", siid=" + siid +
                ", sifromuid=" + sifromuid +
                ", sitouid=" + sitouid +
                ", content=" + content +
                ", time=" + time +
                ", isread=" + isread +
                "}";
    }
}
