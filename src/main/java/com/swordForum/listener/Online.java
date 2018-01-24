package com.swordForum.listener;

import com.swordForum.model.User;

import javax.servlet.http.HttpServletRequest;

/**
 */
public class Online {
    private Online() {
    }

    private static volatile long count = 0;

    public static long getCount() {
        return count;
    }

    public static void add() {
        count++;
    }

    public static void add(HttpServletRequest request, User user) {
        try {
            User loginUser = (User) request.getSession(false).getAttribute("user");
            if (user.getUemail().equals(loginUser.getUemail()))
                count++;
        } catch (Exception e) {
            System.out.println("用户已登录");
        }
    }

    public static void delete() {
        if (count > 0)
            count--;
    }
}
