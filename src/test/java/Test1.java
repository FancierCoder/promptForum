import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.swordForum.mapper.CommentMapper;
import com.swordForum.model.Comment;
import com.swordForum.model.User;
import com.swordForum.service.UserService;
import org.apache.ibatis.session.RowBounds;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:config/spring-base.xml")
public class Test1 {
    @Resource
    UserService userService;

    @Resource
    CommentMapper commentMapper;

    @Test
    public void test1() {
        User user1 = new User();
        user1.setUsex(0);
        EntityWrapper<User> wrapper = new EntityWrapper<>();
        wrapper.setEntity(user1);
        EntityWrapper<Comment> wrapper1 = new EntityWrapper<>();
        wrapper1.setEntity(new Comment());
        List<Comment> comments = commentMapper.selectPage(new RowBounds(2, 5), null);
        System.out.println(comments.size());
        User user = userService.selectOne(wrapper);
        System.out.println(user);
    }

    @Test
    public void test2() {
        int[][] a = {{1, 5, 8, 56, 78, 3}, {2, 4, 7, 6, 32, 596, 45, 2313}};
        System.out.println(Arrays.toString(a));
    }
}
