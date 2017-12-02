package com.swordForum.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.swordForum.model.Comment;
import com.swordForum.model.VO.UnreadComm;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author 李铎
 * @since 2017-12-01
 */
@Repository
public interface CommentMapper extends BaseMapper<Comment> {

    /*****查询根评论下的非直接评论*******/
    List<Comment> selectNdirect(Map<String, Object> map);

    /**
     * 未读评论数量
     **/
    int unreadCount(long uid);

    /**
     * 未读评论
     **/
    List<UnreadComm> unreadComment(Page page, long uid);

    /**
     * 更新未读为已读
     **/
    int updateRead(long tid);
}