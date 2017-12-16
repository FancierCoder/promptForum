CREATE TABLE sword.manage
(
  mid       INT(11) PRIMARY KEY NOT NULL
  COMMENT '管理员自增id' AUTO_INCREMENT,
  mname     VARCHAR(20)         NOT NULL
  COMMENT '名字',
  mpassword VARCHAR(30)         NOT NULL
  COMMENT '密码',
  msex      INT(11) DEFAULT '0'
  COMMENT '性别',
  mrole     INT(11) DEFAULT '1'
  COMMENT '0超管1普管',
  memail    VARCHAR(30)         NOT NULL
  COMMENT 'E-mail'
);
INSERT INTO sword.manage (mid, mname, mpassword, msex, mrole, memail)
VALUES (1, 'admin', 'admin', 0, 0, '1353590529@qq.com');