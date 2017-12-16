CREATE TABLE sword.addfriend
(
  aid     BIGINT(20) PRIMARY KEY              NOT NULL
  COMMENT '自增id'  AUTO_INCREMENT,
  fromuid BIGINT(20)                          NOT NULL
  COMMENT '发出请求方',
  touid   BIGINT(20)                          NOT NULL
  COMMENT '接受请求方',
  addtime TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
  COMMENT '时间',
  staus   VARCHAR(20)                         NOT NULL
  COMMENT '‘接受’，‘拒绝’，等待',
  flag    INT(11) DEFAULT '0'
  COMMENT '0未改变1改变状态',
  CONSTRAINT addfriend_ibfk_1 FOREIGN KEY (fromuid) REFERENCES user (uid)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT addfriend_ibfk_2 FOREIGN KEY (touid) REFERENCES user (uid)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
CREATE INDEX fromuid
  ON sword.addfriend (fromuid);
CREATE INDEX touid
  ON sword.addfriend (touid);
INSERT INTO sword.addfriend (aid, fromuid, touid, addtime, staus, flag)
VALUES (1, 4, 1, '2017-06-06 03:31:26', '接受', 1);