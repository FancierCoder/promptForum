package xyz.forum.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import xyz.forum.model.Logtable;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author 李铎
 * @since 2017-12-01
 */
@Repository
public interface LogtableMapper extends BaseMapper<Logtable> {

    /**
     * 查询当前用户今日已经登陆过几次
     **/
    int todayLoginCount(@Param("uid") long uid, @Param("date") Date date);

    /**
     * 查询今日发布了多少条文章
     **/
    int todayTopicCount(@Param("uid") long uid, @Param("date") Date date);
}