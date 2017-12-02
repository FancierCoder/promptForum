package com.swordForum.model.VO;

import com.swordForum.model.Addfriend;
import com.swordForum.model.User;

public class AddFriendVo {
    private User user;
    private Addfriend addfriend;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Addfriend getAddfriend() {
        return addfriend;
    }

    public void setAddfriend(Addfriend addfriend) {
        this.addfriend = addfriend;
    }
}
