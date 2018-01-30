package xyz.forum.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import xyz.forum.model.Section;
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
public interface SectionMapper extends BaseMapper<Section> {
    List<String> getParentName();

    Long selectAllTopicSum();

    Long selectMaxClickSid();
}