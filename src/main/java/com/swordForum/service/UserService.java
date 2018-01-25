package com.swordForum.service;

import com.swordForum.model.User;
import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author 李铎
 * @since 2017-12-01
 */
public interface UserService extends IService<User> {

    String selectNicknameByUid(Long uid);

    User selectEmailAndNickAndHeadByUid(Long uid);
}
