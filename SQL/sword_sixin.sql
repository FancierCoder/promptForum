CREATE TABLE sword.sixin
(
  siid      BIGINT(20) PRIMARY KEY              NOT NULL
  COMMENT '自增私信id'  AUTO_INCREMENT,
  sifromuid BIGINT(20)                          NOT NULL
  COMMENT '为了让系统发消息，-1代表系统，不用外键',
  sitouid   BIGINT(20)                          NOT NULL
  COMMENT '接受方',
  content   TEXT                                NOT NULL
  COMMENT '为了丰富以后内容是由text',
  time      TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
  COMMENT '发送时间',
  isread    INT(11) DEFAULT '0'
  COMMENT '0默认未读，1已读',
  CONSTRAINT sixin_ibfk_2 FOREIGN KEY (sitouid) REFERENCES user (uid)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
CREATE INDEX sifromuid
  ON sword.sixin (sifromuid);
CREATE INDEX sitouid
  ON sword.sixin (sitouid);
INSERT INTO sword.sixin (siid, sifromuid, sitouid, content, time, isread) VALUES
  (1, -1, 2, '<p style=''color:grern''>欢迎使用仗剑论坛，有你的世界更精彩!<br/>  <small> 站长：李胜助</small></p>', '2017-05-16 09:30:05', 1);
INSERT INTO sword.sixin (siid, sifromuid, sitouid, content, time, isread) VALUES
  (2, -1, 3, '<p style=''color:grern''>欢迎使用仗剑论坛，有你的世界更精彩!<br/>  <small> 站长：李胜助</small></p>', '2017-05-16 09:34:38', 1);
INSERT INTO sword.sixin (siid, sifromuid, sitouid, content, time, isread)
VALUES (3, 1, 2, 'sfsdfsdf', '2017-05-16 14:47:06', 1);
INSERT INTO sword.sixin (siid, sifromuid, sitouid, content, time, isread)
VALUES (4, 1, 2, 'dasdasf', '2017-05-16 14:47:11', 1);
INSERT INTO sword.sixin (siid, sifromuid, sitouid, content, time, isread)
VALUES (5, 1, 2, '855', '2017-05-16 15:19:13', 1);
INSERT INTO sword.sixin (siid, sifromuid, sitouid, content, time, isread) VALUES
  (6, -1, 4, '<p style=''color:grern''>欢迎使用仗剑论坛，有你的世界更精彩!<br/>  <small> 站长：李胜助</small></p>', '2017-06-06 03:10:54', 1);
INSERT INTO sword.sixin (siid, sifromuid, sitouid, content, time, isread)
VALUES (7, 2, 1, '2333', '2017-12-15 13:10:37', 1);
INSERT INTO sword.sixin (siid, sifromuid, sitouid, content, time, isread)
VALUES (8, 1, 2, '666', '2017-12-15 13:25:20', 1);
INSERT INTO sword.sixin (siid, sifromuid, sitouid, content, time, isread)
VALUES (9, 1, 2, '你是谁？', '2017-12-16 07:49:21', 0);