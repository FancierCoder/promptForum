package xyz.forum.util;

import sun.misc.BASE64Encoder;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MD5Util {
    /**
     * 利用MD5进行加密
     */
    public static String EncoderByMd5(String str) throws NoSuchAlgorithmException, UnsupportedEncodingException {
        //确定计算方法
        MessageDigest md5 = MessageDigest.getInstance("MD5");
        BASE64Encoder base64en = new BASE64Encoder();
        //加密后的字符串
        String new_str = base64en.encode(md5.digest(str.getBytes("utf-8")));
        String newstr = base64en.encode(md5.digest(new_str.getBytes("utf-8")));
        return newstr;
    }

    /**
     * 判断用户密码是否正确
     * newpasswd 用户输入的密码
     * oldpasswd 正确密码
     */
    public static boolean checkPassword(String newPass, String oldPass) throws NoSuchAlgorithmException, UnsupportedEncodingException {
        if (EncoderByMd5(newPass).equals(oldPass))
            return true;
        else
            return false;
    }

    public static void main(String[] args) {
        try {
            System.out.println(EncoderByMd5("admin"));
            //System.out.println(checkPassword("123456", "DIjVZpTC+zvMQW4SLBBy6w=="));
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
    }
}
