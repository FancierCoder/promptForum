package xyz.forum.service.impl;

import xyz.forum.model.Topic;
import xyz.forum.mapper.TopicMapper;
import xyz.forum.service.TopicService;
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
