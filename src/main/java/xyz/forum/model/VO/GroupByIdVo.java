package xyz.forum.model.VO;


/**
 * 生成 uid:count(*)
 */
public class GroupByIdVo {
    private long uid;
    private long count;

    public long getUid() {
        return uid;
    }

    public void setUid(long uid) {
        this.uid = uid;
    }

    public long getCount() {
        return count;
    }

    public void setCount(long count) {
        this.count = count;
    }
}
