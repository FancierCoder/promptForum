CREATE TABLE sword.user
(
  uid        BIGINT(20) PRIMARY KEY              NOT NULL
  COMMENT '自增用户id'       AUTO_INCREMENT,
  uemail     VARCHAR(20)                         NOT NULL
  COMMENT 'email账号',
  upassword  VARCHAR(30)                         NOT NULL
  COMMENT '密码',
  unickname  VARCHAR(20)                         NOT NULL
  COMMENT '昵称',
  usex       INT(11)     DEFAULT '0'
  COMMENT '性别',
  ubirthday  DATE COMMENT '生日',
  ulevel     INT(11)     DEFAULT '1'
  COMMENT '等级',
  headimg    VARCHAR(30) DEFAULT 'defaulthead.jpg'
  COMMENT '头像',
  ustatement VARCHAR(30) DEFAULT '此人很懒，没什么个人说明'
  COMMENT '个人描述',
  uregtime   TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
  COMMENT '注册时间',
  ustate     INT(11)     DEFAULT '0'
  COMMENT '被封状态',
  upoint     INT(11)     DEFAULT '0'
  COMMENT '积分'
);
CREATE UNIQUE INDEX uemail
  ON sword.user (uemail, unickname);
INSERT INTO sword.user (uid, uemail, upassword, unickname, usex, ubirthday, ulevel, headimg, ustatement, uregtime, ustate, upoint)
VALUES
  (1, '1353590529@qq.com', '123456', '铎哥', 0, '1994-10-16', 3, '120170531201216.png', '仗剑论坛创始人！', '2017-03-06 17:04:24',
      0, 340);
INSERT INTO sword.user (uid, uemail, upassword, unickname, usex, ubirthday, ulevel, headimg, ustatement, uregtime, ustate, upoint)
VALUES
  (2, '111111@qq.com', '123456', '测试2', 1, '2008-12-16', 2, 'defaulthead.jpg', '此人很懒，没什么个人说明', '2017-05-16 09:30:05', 0,
   98);
INSERT INTO sword.user (uid, uemail, upassword, unickname, usex, ubirthday, ulevel, headimg, ustatement, uregtime, ustate, upoint)
VALUES
  (3, '222222@qq.com', '123456', '测试3', 0, NULL, 1, 'defaulthead.jpg', '此人很懒，没什么个人说明', '2017-05-16 09:34:38', 0, 10);
INSERT INTO sword.user (uid, uemail, upassword, unickname, usex, ubirthday, ulevel, headimg, ustatement, uregtime, ustate, upoint)
VALUES
  (4, '2512634475@qq.com', '123456', '帅哥不是罪', 0, NULL, 1, 'defaulthead.jpg', '此人很懒，没什么个人说明', '2017-06-06 03:10:54', 0,
   10);