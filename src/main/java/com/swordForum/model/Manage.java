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
public class Manage extends Model<Manage> {

    private static final long serialVersionUID = 1L;

    /**
     * 管理员自增id
     */
    @TableId(value = "mid", type = IdType.AUTO)
    private Integer mid;
    /**
     * 名字
     */
    private String mname;
    /**
     * 密码
     */
    private String mpassword;
    /**
     * 性别
     */
    private Integer msex;
    /**
     * 0超管1普管
     */
    private Integer mrole;
    /**
     * E-mail
     */
    private String memail;


    public Integer getMid() {
        return mid;
    }

    public void setMid(Integer mid) {
        this.mid = mid;
    }

    public String getMname() {
        return mname;
    }

    public void setMname(String mname) {
        this.mname = mname;
    }

    public String getMpassword() {
        return mpassword;
    }

    public void setMpassword(String mpassword) {
        this.mpassword = mpassword;
    }

    public Integer getMsex() {
        return msex;
    }

    public void setMsex(Integer msex) {
        this.msex = msex;
    }

    public Integer getMrole() {
        return mrole;
    }

    public void setMrole(Integer mrole) {
        this.mrole = mrole;
    }

    public String getMemail() {
        return memail;
    }

    public void setMemail(String memail) {
        this.memail = memail;
    }

    @Override
    protected Serializable pkVal() {
        return this.mid;
    }

    @Override
    public String toString() {
        return "Manage{" +
                ", mid=" + mid +
                ", mname=" + mname +
                ", mpassword=" + mpassword +
                ", msex=" + msex +
                ", mrole=" + mrole +
                ", memail=" + memail +
                "}";
    }
}
