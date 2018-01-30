package xyz.forum.mapper;

import xyz.forum.model.Topic;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.springframework.stereotype.Repository;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author 李铎
 * @since 2017-12-01
 */
@Repository
public interface TopicMapper extends BaseMapper<Topic> {

    String selectTopicByTid(Long tid);
}