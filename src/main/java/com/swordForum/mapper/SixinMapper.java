package com.swordForum.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.swordForum.model.Sixin;
import com.swordForum.model.VO.GroupByIdVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author 李铎
 * @since 2017-12-01
 */
@Repository
public interface SixinMapper extends BaseMapper<Sixin> {
    List<GroupByIdVo> unReadSixinCount(long uid);

    //查询与某人聊天记录前n条
    List<Sixin> selectLimitSixin(@Param("hisuid") long hisuid, @Param("meuid") long meuid, @Param("n") int n);

    int updateHaveRead(@Param("hisuid") long hisuid, @Param("meuid") long meuid);
}