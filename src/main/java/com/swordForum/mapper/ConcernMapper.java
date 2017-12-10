package com.swordForum.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.swordForum.model.Concern;
import com.swordForum.model.Topic;
import com.swordForum.model.VO.ConVo;
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
public interface ConcernMapper extends BaseMapper<Concern> {

    List<ConVo> iConcernSearch(Page page, @Param("meuid") long meuid, @Param("search") String search);

    List<ConVo> iConcern(Page page, long fromuid);

    List<Topic> concernTopic(long fromuid);

    List<ConVo> concernISearch(Page page, @Param("meuid") long meuid, @Param("search") String search);

}