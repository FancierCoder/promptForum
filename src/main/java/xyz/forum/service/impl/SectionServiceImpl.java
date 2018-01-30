package xyz.forum.service.impl;

import xyz.forum.model.Section;
import xyz.forum.mapper.SectionMapper;
import xyz.forum.service.SectionService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author 李铎
 * @since 2017-12-01
 */
@Service
public class SectionServiceImpl extends ServiceImpl<SectionMapper, Section> implements SectionService {

}
