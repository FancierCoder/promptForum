package com.swordForum.task;

import com.swordForum.model.User;
import com.swordForum.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * author: 李铎
 * date: 2018/1/8
 **/
@Service
public class LockTimeTask {

    @Resource
    UserService userService;

    public void lessTime() {
        List<User> users = userService.selectList(null);
        for (User user : users) {
            if (user.getUstate() > 0) {
                user.setUstate(user.getUstate() - 1);
                userService.updateById(user);
            }
        }
        System.out.println("被封账户的时间减少一天！");
    }
}
