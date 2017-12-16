CREATE TABLE sword.section
(
  sid         INT(11) PRIMARY KEY     NOT NULL
  COMMENT '板块自增Id'       AUTO_INCREMENT,
  sname       VARCHAR(20)             NOT NULL
  COMMENT '板块名字',
  smasterid   BIGINT(20)              NOT NULL
  COMMENT '对于user表的用户id',
  sstatement  VARCHAR(300)            NOT NULL
  COMMENT '详细描述',
  sshortsm    VARCHAR(30) COMMENT '简要描述',
  sclickcount BIGINT(20) DEFAULT '0'
  COMMENT '访问量',
  stopiccount BIGINT(20) DEFAULT '0'
  COMMENT '帖子量',
  sparentname VARCHAR(20) DEFAULT '0' NOT NULL
  COMMENT '父级菜单名称',
  CONSTRAINT section_ibfk_1 FOREIGN KEY (smasterid) REFERENCES user (uid)
    ON DELETE CASCADE
);
CREATE INDEX smasterid
  ON sword.section (smasterid);
INSERT INTO sword.section (sid, sname, smasterid, sstatement, sshortsm, sclickcount, stopiccount, sparentname)
VALUES (1, '技术问答', 1, '把你的问题提出来，给大神解答吧！', '有什么问题来这里提吧', 59, 2, '0');
INSERT INTO sword.section (sid, sname, smasterid, sstatement, sshortsm, sclickcount, stopiccount, sparentname) VALUES
  (2, 'Java', 1,
   'Java是一门面向对象编程语言，不仅吸收了C++语言的各种优点，还摒弃了C++里难以理解的多继承、指针等概念，因此Java语言具有功能强大和简单易用两个特征。Java语言作为静态面向对象编程语言的代表，极好地实现了面向对象理论，允许程序员以优雅的思维方式进行复杂的编程',
   'java编程', 75, 5, '技术分享');
INSERT INTO sword.section (sid, sname, smasterid, sstatement, sshortsm, sclickcount, stopiccount, sparentname) VALUES
  (3, 'C/C++ ', 1,
   'C语言是在70年代初问世的。一九七八年由美国电话电报公司(AT&T)贝尔实验室正式发表了C语言。同时由B.W.Kernighan和D.M.Ritchit合著了著名的“THE C PROGRAMMING LANGUAGE”一书。通常简称为《K&R》，也有人称之为《K&R》标准。但是，在《K&R》中并没有定义一个完整的标准C语言，后来由美国国家标准学会在此基础上制定了一个C 语言标准，于一九八三年发表。通常称之为ANSI C',
   'c/c++编程', 76, 0, '技术分享');
INSERT INTO sword.section (sid, sname, smasterid, sstatement, sshortsm, sclickcount, stopiccount, sparentname) VALUES
  (4, 'Python', 1,
   'Python具有丰富和强大的库。它常被昵称为胶水语言，能够把用其他语言制作的各种模块（尤其是C/C++）很轻松地联结在一起。常见的一种应用情形是，使用Python快速生成程序的原型（有时甚至是程序的最终界面），然后对其中[3]  有特别要求的部分，用更合适的语言改写，比如3D游戏中的图形渲染模块，性能要求特别高，就可以用C/C++重写，而后封装为Python可以调用的扩展类库。需要注意的是在您使用扩展类库时可能需要考虑平台问题，某些可能不提供跨平台的实现。',
   'python编程', 42, 0, '技术分享');
INSERT INTO sword.section (sid, sname, smasterid, sstatement, sshortsm, sclickcount, stopiccount, sparentname)
VALUES (5, '情感部落', 1, '在这里你可以宣泄一切情感遭遇，可以深情表白，还可以晒情侣幸福合照。情感', '感情的碰撞', 28, 1, '情感');
INSERT INTO sword.section (sid, sname, smasterid, sstatement, sshortsm, sclickcount, stopiccount, sparentname)
VALUES (6, '真情天下', 1, '深夜，安静的角落，听听心里的声音', '天下有真情', 23, 0, '情感');
INSERT INTO sword.section (sid, sname, smasterid, sstatement, sshortsm, sclickcount, stopiccount, sparentname)
VALUES (7, '婆媳关系', 1, '复杂的婆媳关系', '婆媳关系', 12, 0, '情感');
INSERT INTO sword.section (sid, sname, smasterid, sstatement, sshortsm, sclickcount, stopiccount, sparentname)
VALUES (8, '仗剑杂谈', 1, '本论坛的杂谈', '本论坛的杂谈', 17, 1, '杂谈');
INSERT INTO sword.section (sid, sname, smasterid, sstatement, sshortsm, sclickcount, stopiccount, sparentname)
VALUES (9, '医疗曝光', 1, '医疗曝光', '医疗的曝光', 16, 0, '杂谈');
INSERT INTO sword.section (sid, sname, smasterid, sstatement, sshortsm, sclickcount, stopiccount, sparentname)
VALUES (10, '大话教育', 1, '教育对于一个人的成长很重要', '说说学校与家庭的教育', 16, 1, '杂谈');
INSERT INTO sword.section (sid, sname, smasterid, sstatement, sshortsm, sclickcount, stopiccount, sparentname)
VALUES (11, '娱乐八卦', 1, '看看身边乃至娱乐圈的八卦', '我们一起来八卦', 11, 0, '娱乐');
INSERT INTO sword.section (sid, sname, smasterid, sstatement, sshortsm, sclickcount, stopiccount, sparentname)
VALUES (12, '体育沙龙', 1, '体育最近状况咱们来聊聊', '体育体育', 8, 0, '娱乐');
INSERT INTO sword.section (sid, sname, smasterid, sstatement, sshortsm, sclickcount, stopiccount, sparentname)
VALUES (13, '星座论坛', 1, '你是什么座，我们般配吗', '你是什么座，我们般配吗', 8, 0, '娱乐');
INSERT INTO sword.section (sid, sname, smasterid, sstatement, sshortsm, sclickcount, stopiccount, sparentname)
VALUES (14, '保健养生', 1, '保健养生', '保健养生', 37, 0, '生活');
INSERT INTO sword.section (sid, sname, smasterid, sstatement, sshortsm, sclickcount, stopiccount, sparentname)
VALUES (15, '文化漫谈', 1, '各路各国文化杂谈', '探究文化', 14, 0, '生活');
INSERT INTO sword.section (sid, sname, smasterid, sstatement, sshortsm, sclickcount, stopiccount, sparentname)
VALUES (16, '手机综艺', 1, '手机的各种资料', '手机综艺', 7, 0, '生活');
INSERT INTO sword.section (sid, sname, smasterid, sstatement, sshortsm, sclickcount, stopiccount, sparentname)
VALUES (19, '英雄联盟', 1, '《英雄联盟》(简称LOL)是由美国拳头游戏(Riot Games)开发、中国大陆地区腾讯游戏代理运营的英雄对战MOBA竞技网游。
游戏里拥有数百个个性英雄，并拥有排位系统、天赋系统、符文系统等特色养成系统。
《英雄联盟》还致力于推动全球电子竞技的发展，除了联动各赛区发展职业联赛、打造电竞体系之外，每年还会举办“季中冠军赛”“全球总决赛”“All Star全明星赛”三大世界级赛事，获得了亿万玩家的喜爱，形成了自己独有的电子竞技文化。',
        '一起战斗吧', 34, 0, '网络游戏');