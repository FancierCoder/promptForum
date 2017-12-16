CREATE TABLE sword.dz
(
  dzid      BIGINT(20) PRIMARY KEY              NOT NULL AUTO_INCREMENT,
  dzfromuid BIGINT(20)                          NOT NULL,
  dztopicid BIGINT(20)                          NOT NULL
  COMMENT '点赞的文章，只能赞一次',
  dztime    TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  CONSTRAINT dz_ibfk_1 FOREIGN KEY (dzfromuid) REFERENCES user (uid)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT dz_ibfk_3 FOREIGN KEY (dztopicid) REFERENCES topic (tid)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
CREATE INDEX dzfromuid
  ON sword.dz (dzfromuid);
CREATE INDEX dz_ibfk_3
  ON sword.dz (dztopicid);