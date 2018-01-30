package xyz.forum.mapper;

import xyz.forum.model.Friend;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.springframework.stereotype.Repository;

/**
 * <p>
 * 好友列表 Mapper 接口
 * </p>
 *
 * @author 李铎
 * @since 2017-12-01
 */
@Repository
public interface FriendMapper extends BaseMapper<Friend> {

}