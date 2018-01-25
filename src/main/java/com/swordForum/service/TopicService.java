package com.swordForum.service;

import com.swordForum.model.Topic;
import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author 李铎
 * @since 2017-12-01
 */
public interface TopicService extends IService<Topic> {

    String selectTopicByTid(Long tid);
}
