package xyz.forum.service.impl;

import xyz.forum.model.Addfriend;
import xyz.forum.mapper.AddfriendMapper;
import xyz.forum.service.AddfriendService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 申请添加好友持久化记录 服务实现类
 * </p>
 *
 * @author 李铎
 * @since 2017-12-01
 */
@Service
public class AddfriendServiceImpl extends ServiceImpl<AddfriendMapper, Addfriend> implements AddfriendService {

}
