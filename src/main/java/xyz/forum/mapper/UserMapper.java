package xyz.forum.mapper;

import xyz.forum.model.User;
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
public interface UserMapper extends BaseMapper<User> {

    String selectNicknameByUid(Long uid);

    User selectEmailAndNickAndHeadByUid(Long uid);
}