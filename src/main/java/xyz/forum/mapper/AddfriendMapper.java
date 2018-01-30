package xyz.forum.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import xyz.forum.model.Addfriend;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * <p>
 * 申请添加好友持久化记录 Mapper 接口
 * </p>
 *
 * @author 李铎
 * @since 2017-12-01
 */
@Repository
public interface AddfriendMapper extends BaseMapper<Addfriend> {
    /**
     * 对我加别人的信息反馈进行确认 就是更新，表示完成下次不再查询
     **/
    int finishAddFriend(@Param("fromuid") long fromuid, @Param("touid") long touid);

    /**
     * 接受添加好友请求
     **/
    int acceptAddFriend(@Param("fromuid") long fromuid, @Param("touid") long touid);

    /**
     * 拒绝添加好友请求
     **/
    int rejectAddFriend(@Param("fromui") long fromuid, @Param("touid") long touid);

}