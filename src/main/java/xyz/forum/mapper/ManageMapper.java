package xyz.forum.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import xyz.forum.model.Manage;
import xyz.forum.model.VO.ChartVo;
import xyz.forum.model.VO.ManTopic;
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
public interface ManageMapper extends BaseMapper<Manage> {
    //获取帖子数量
    List<ChartVo> getTopicChartByWeek(String year);

    List<ChartVo> getTopicChartByMonth(String year);

    //获取评论数量
    List<ChartVo> getCommentChartByWeek(String year);

    List<ChartVo> getCommentChartByMonth(String year);

    //用户注册量
    List<ChartVo> getRegisterChartByWeek(String year);

    List<ChartVo> getRegisterChartByMonth(String year);

    //查询帖子详细信息
    List<ManTopic> selectDetailTopic(@Param("sid") int sid);
}