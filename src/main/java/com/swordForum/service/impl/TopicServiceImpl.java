package com.swordForum.service.impl;

import com.swordForum.model.Topic;
import com.swordForum.mapper.TopicMapper;
import com.swordForum.service.TopicService;
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
@Service("topicService")
public class TopicServiceImpl extends ServiceImpl<TopicMapper, Topic> implements TopicService {

    @Resource
    private TopicMapper topicMapper;

    @Override
    public String selectTopicByTid(Long tid) {
        return topicMapper.selectTopicByTid(tid);
    }
}
