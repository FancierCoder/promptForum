CREATE TABLE sword.friend
(
  fid     BIGINT(20) PRIMARY KEY              NOT NULL
  COMMENT '自增id' AUTO_INCREMENT,
  fromuid BIGINT(20)                          NOT NULL
  COMMENT '用户a，发出申请方',
  touid   BIGINT(20)                          NOT NULL
  COMMENT '用户b，接受申请方',
  time    TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
  COMMENT '时间',
  CONSTRAINT friend_ibfk_1 FOREIGN KEY (touid) REFERENCES user (uid)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
CREATE INDEX touid
  ON sword.friend (touid);
INSERT INTO sword.friend (fid, fromuid, touid, time) VALUES (9, -1, 1, '2017-05-15 21:54:13');
INSERT INTO sword.friend (fid, fromuid, touid, time) VALUES (10, -1, 2, '2017-05-16 09:30:06');
INSERT INTO sword.friend (fid, fromuid, touid, time) VALUES (11, -1, 3, '2017-05-16 09:34:38');
INSERT INTO sword.friend (fid, fromuid, touid, time) VALUES (12, 2, 1, '2017-05-16 14:16:35');
INSERT INTO sword.friend (fid, fromuid, touid, time) VALUES (13, -1, 4, '2017-06-06 03:10:55');
INSERT INTO sword.friend (fid, fromuid, touid, time) VALUES (14, 4, 1, '2017-06-06 03:31:26');