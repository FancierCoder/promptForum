package com.swordForum.service.impl;

import com.swordForum.model.User;
import com.swordForum.mapper.UserMapper;
import com.swordForum.service.UserService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author 李铎
 * @since 2017-12-01
 */
@Service("userService")
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    @Resource
    private UserMapper userMapper;

    @Override
    public String selectNicknameByUid(Long uid) {
        return userMapper.selectNicknameByUid(uid);
    }

    @Override
    public User selectEmailAndNickAndHeadByUid(Long uid) {
        return userMapper.selectEmailAndNickAndHeadByUid(uid);
    }
}
