CREATE TABLE sword.comment
(
  cid       BIGINT(20) PRIMARY KEY              NOT NULL
  COMMENT '评论自增id'     AUTO_INCREMENT,
  ctid      BIGINT(20)                          NOT NULL
  COMMENT '所属帖子',
  cuid      BIGINT(20)                          NOT NULL
  COMMENT '回帖人',
  ctime     TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
  COMMENT '时间',
  content   VARCHAR(50)                         NOT NULL
  COMMENT '内容',
  rootcid   BIGINT(20) DEFAULT '0'
  COMMENT '对于的根评论cid',
  parentuid BIGINT(20) DEFAULT '0'
  COMMENT '根评论下对谁说用户id',
  czan      BIGINT(20) DEFAULT '0'
  COMMENT '点赞',
  isread    INT(11)    DEFAULT '0'
  COMMENT '0未读1已读',
  parentcid BIGINT(20) DEFAULT '0'
  COMMENT '直接评论下的间接评论',
  CONSTRAINT comment_ibfk_1 FOREIGN KEY (ctid) REFERENCES topic (tid)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT comment_ibfk_2 FOREIGN KEY (cuid) REFERENCES user (uid)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
CREATE INDEX ctid
  ON sword.comment (ctid);
CREATE INDEX cuid
  ON sword.comment (cuid);
INSERT INTO sword.comment (cid, ctid, cuid, ctime, content, rootcid, parentuid, czan, isread, parentcid)
VALUES (26, 32, 1, '2017-06-04 15:09:01', '112213412423', 0, 0, 0, 1, 0);
INSERT INTO sword.comment (cid, ctid, cuid, ctime, content, rootcid, parentuid, czan, isread, parentcid)
VALUES (31, 32, 1, '2017-06-04 16:08:24', '阿斯达所', 0, 0, 0, 1, 0);
INSERT INTO sword.comment (cid, ctid, cuid, ctime, content, rootcid, parentuid, czan, isread, parentcid)
VALUES (32, 32, 1, '2017-06-04 16:08:28', '多少分公司的根深蒂固', 26, 0, 0, 1, 0);
INSERT INTO sword.comment (cid, ctid, cuid, ctime, content, rootcid, parentuid, czan, isread, parentcid)
VALUES (33, 32, 1, '2017-06-04 16:08:34', '成本持续宣传v', 26, 0, 0, 1, 0);
INSERT INTO sword.comment (cid, ctid, cuid, ctime, content, rootcid, parentuid, czan, isread, parentcid)
VALUES (34, 32, 1, '2017-06-04 16:08:38', '2额外企鹅全文', 26, 1, 0, 1, 32);
INSERT INTO sword.comment (cid, ctid, cuid, ctime, content, rootcid, parentuid, czan, isread, parentcid)
VALUES (35, 25, 1, '2017-06-04 16:38:09', '根评论1', 0, 0, 0, 1, 0);
INSERT INTO sword.comment (cid, ctid, cuid, ctime, content, rootcid, parentuid, czan, isread, parentcid)
VALUES (36, 25, 1, '2017-06-04 16:38:14', '根评论2', 0, 0, 0, 1, 0);
INSERT INTO sword.comment (cid, ctid, cuid, ctime, content, rootcid, parentuid, czan, isread, parentcid)
VALUES (37, 25, 1, '2017-06-04 16:38:21', '直接评论1', 35, 0, 0, 1, 0);
INSERT INTO sword.comment (cid, ctid, cuid, ctime, content, rootcid, parentuid, czan, isread, parentcid)
VALUES (39, 32, 2, '2017-12-13 21:54:55', '大家爱看连接法兰', 0, 0, 0, 1, 0);
INSERT INTO sword.comment (cid, ctid, cuid, ctime, content, rootcid, parentuid, czan, isread, parentcid)
VALUES (40, 16728, 1, '2017-12-14 23:28:24', '赞一个', 0, 0, 0, 1, 0);