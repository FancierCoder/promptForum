CREATE TABLE sword.concern
(
  conid      BIGINT(20) PRIMARY KEY NOT NULL
  COMMENT '关注自增id' AUTO_INCREMENT,
  confromuid BIGINT(20)             NOT NULL
  COMMENT '关注方',
  contouid   BIGINT(20)             NOT NULL
  COMMENT '被关注方',
  CONSTRAINT concern_ibfk_1 FOREIGN KEY (confromuid) REFERENCES user (uid)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT concern_ibfk_2 FOREIGN KEY (contouid) REFERENCES user (uid)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
CREATE INDEX confromuid
  ON sword.concern (confromuid);
CREATE INDEX contouid
  ON sword.concern (contouid);
INSERT INTO sword.concern (conid, confromuid, contouid) VALUES (2, 2, 1);
INSERT INTO sword.concern (conid, confromuid, contouid) VALUES (3, 4, 1);