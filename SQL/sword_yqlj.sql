CREATE TABLE sword.yqlj
(
  id       INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  ljname   VARCHAR(255),
  ljurl    VARCHAR(255),
  filename VARCHAR(255)
);
INSERT INTO sword.yqlj (id, ljname, ljurl, filename) VALUES (1, '百度', 'http://www.baidu.com', '201207021739570007.bmp');
INSERT INTO sword.yqlj (id, ljname, ljurl, filename)
VALUES (2, 'google', 'http://www.google.com', '201207021424190002.gif');
INSERT INTO sword.yqlj (id, ljname, ljurl, filename) VALUES (3, '优酷', 'http://www.youku.com', '201207021726330001.png');
INSERT INTO sword.yqlj (id, ljname, ljurl, filename)
VALUES (4, '淘宝', 'http://www.taobao.com', '201207021729150002.png');
INSERT INTO sword.yqlj (id, ljname, ljurl, filename)
VALUES (5, '支付宝', 'https://www.alipay.com/', '201207021731270003.png');
INSERT INTO sword.yqlj (id, ljname, ljurl, filename)
VALUES (6, '淘宝联盟', 'http://www.alimama.com/', '201207021733380005.bmp');
INSERT INTO sword.yqlj (id, ljname, ljurl, filename)
VALUES (7, '一淘网', 'http://www.etao.com/?tbpm=t', '201207021735520006.png');