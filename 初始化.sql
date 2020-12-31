--==================创建用户表
create table user_table
(
    u_id  number primary key,
    u_email varchar2(50) not null,
    u_passw varchar2(50) not null
)

-- 创建自增序列
create sequence user_table_seq
minvalue 1
maxvalue 999999
start with 1
increment by 1
cache 20;

--创建触发器：
create or replace trigger user_table_tig
before insert on user_table for each row 
begin
    select to_char(user_table_seq.nextval) into:new.u_id from dual;
end user_table_tig;
/
--查看表结构
desc userTable;
--查看表
select * from user_table;
--插入用户表数据
insert into user_table(u_email,u_passw) values('11@qq.com', '123');
insert into user_table(u_email,u_passw) values('12@qq.com', '123');
--=============================

--====================创建类别表
create table movie_class
(
    c_id  number primary key,
    c_name varchar2(50) not null
)
-- 创建自增序列
create sequence movie_class_seq
minvalue 1
maxvalue 999999
start with 1
increment by 1
cache 20;

--创建触发器：
create or replace trigger movie_class_tig
before insert on movie_class for each row 
begin
    select to_char(movie_class_seq.nextval) into:new.c_id from dual;
end movie_class_tig;
/
--查看数据
select * from movie_class;
--插入数据
insert into movie_class(c_name) values('剧情');
insert into movie_class(c_name) values('喜剧');
insert into movie_class(c_name) values('动作');
insert into movie_class(c_name) values('爱情');
insert into movie_class(c_name) values('动画');
insert into movie_class(c_name) values('悬疑');
insert into movie_class(c_name) values('惊悚');
insert into movie_class(c_name) values('恐怖');
insert into movie_class(c_name) values('犯罪');
insert into movie_class(c_name) values('同行');
insert into movie_class(c_name) values('音乐');
insert into movie_class(c_name) values('歌舞');
insert into movie_class(c_name) values('传记');
insert into movie_class(c_name) values('历史');
insert into movie_class(c_name) values('战争');
insert into movie_class(c_name) values('西部');
--============================

--==================创建电影表
--v_id	Int	主	电影ID
--v_title	Varchar		电影名字
--v_Class	Varchar	外	类别
--v_img	Varchar		图片
--v_director	Varchar		导演
--v_writer	Varchar		编剧
--v_starring	Varchar		主演
--v_detail	Varchar		剧情
--v_time	Date		上映时间
--删除表
drop table movie purge;
--创建表
create table movie
(
    v_id  number primary key,
    v_title varchar2(50) not null,
    v_class number not null,
    v_img VARCHAR2(250) not null,
    v_director VARCHAR2(250) default '暂无',
    v_writer VARCHAR2(250) default '暂无',
    v_starring VARCHAR2(500) default '暂无',
    v_detail VARCHAR2(2500) not null,
    v_time varchar2(50) not null
)
--建立外键
alter table movie add constraint movie_class foreign key(v_class) references movie_class(c_id) on delete cascade;

-- 创建自增序列
create sequence movie_seq
minvalue 1
maxvalue 999999
start with 1
increment by 1
cache 20;

--删除序列
DROP SEQUENCE movie_seq;
--创建触发器：
create or replace trigger movie_tig
before insert on movie for each row 
begin
    select to_char(movie_seq.nextval) into:new.v_id from dual;
end movie_tig;
/


--插入数据
insert into movie(v_title,v_class,v_img,v_director,v_writer,v_starring,v_detail,v_time)
    values(
    '心灵奇旅 Soul',
    5,
    'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2626308994.webp',
    '彼特·道格特',
    '彼特·道格特',
    '杰米·福克斯 / 蒂娜·菲 / 菲利西亚·拉斯海德 / 阿米尔-卡利布·汤普森 / 戴维德·迪格斯 / 格拉汉姆·诺顿 / 瑞切尔·豪斯 / 艾莉丝·布拉加 / 理查德·艾欧阿德 / 唐尼尔·罗林斯 / 安吉拉·贝塞特 / 马戈·霍尔 / 罗德莎·琼斯 / 韦斯·斯塔迪 / 沙基纳·贾弗里 / 福琼·费姆斯特 / 卡鲁姆·格兰特 / 泽诺比娅·谢罗夫 / 琼·斯奎布 / 凯茜·卡瓦蒂妮 / 罗纳尔多·德尔·卡门 / Elisapie Isaac / 杰森·佩斯 / 科拉·尚波米耶',
    '究竟是什么塑造了真正的你？电影将聚焦乔伊·高纳（杰米·福克斯配音）。这位中学音乐老师获得了梦寐以求的机会——在纽约最好的爵士俱乐部演奏。但一个小失误把他从纽约的街道带到了一个奇幻的地方“生之来处”（the Great Before）。在那里，灵魂们获得培训，在前往地球之前将获得他们的个性特点和兴趣。决心要回到地球生活的乔伊认识了一个早熟的灵魂“二十二”（蒂娜·菲 配音），二十二一直找不到自己对于人类生活的兴趣。随着乔伊不断试图向二十二展示生命的精彩之处，他也将领悟一些人生终极问题的答案。',
    '2020-12-25'
    );
insert into movie(v_title,v_class,v_img,v_director,v_writer,v_starring,v_detail,v_time)
    values(
    '神奇女侠1984 Wonder Woman 1984',
    3,
    'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2626959989.webp',
    '派蒂·杰金斯',
    '派蒂·杰金斯',
    '盖尔·加朵 / 克里斯·派恩 / 克里斯汀·韦格 / 佩德罗·帕斯卡  / 罗宾·怀特 / 莉莉·阿斯佩尔 / 加布瑞拉·王尔德 / 克里斯托弗·普拉哈 / 贝克维思 / 拉维·帕特尔 / 娜塔莎·罗斯韦尔 / 泰莎·波纳姆·琼斯 / 艾拉·沃克 / 游朝敏 / 谢恩·阿特沃尔 / 奥克莉·布尔 / 科莎·恩格勒 / 小田部阿基 / 康斯坦丁·格雷戈里 / 文森·德·保罗 / 朱利安·费罗 / 罗莎娜·沃尔斯 / 丹尼·摩根 / 克里斯·西尔科克 / 伯纳多·桑托斯 / 菲利普·菲尔玛 / 尼克·欧文福特 / 乔尔·莫里斯 / 贾格·帕特尔 / 温迪·阿尔比斯顿 / 马诺伊·阿南德',
    '故事背景设定在五光十色、充满诱惑的80年代，神奇女侠戴安娜在华盛顿的自然历史博物馆过着与普通人无异的生活，然而在阻止了一场看似平常的劫案后，身边的一切都发生了变化。在强大的神力诱惑下，两位全新劲敌悄然出现——与神奇女侠“相爱相杀”的顶级掠食者豹女， 以及掌控着能改变世界力量的麦克斯·洛德，一场惊天大战在所难免。另外一边，旧爱史蒂夫突然“死而复生”，与戴安娜再续前缘，然而浪漫感动之余，史蒂夫的回归也疑窦丛生。 
　　新时代大幕开启，面对两位强大的邪恶反派和神秘归来的史蒂夫，神奇女侠要如何才能再次拯救世界？',
    '2020-12-18'
    );
insert into movie(v_title,v_class,v_img,v_director,v_writer,v_starring,v_detail,v_time)
    values(
    '电话',
    1,
    'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2625879789.webp',
    '李聪贤',
    '李聪贤',
    '朴信惠 / 全钟瑞 / 金成铃 / 李艾 / 李东辉 / 朴浩山 / 吴政世',
    '一通电话让来自过去和现在的两个女人产生了奇妙的联系，并引发了一场改变未来的危险游戏...她们将渐渐难以自拔。',
    '2020-11-27'
    );
insert into movie(v_title,v_class,v_img,v_director,v_writer,v_starring,v_detail,v_time)
    values(
    '八佰',
    1,
    'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2615992304.webp',
    '管虎',
    '管虎 / 葛瑞',
    '王千源 / 张译 / 姜武 / 黄志忠 / 张俊一 / 欧豪 / 杜淳 / 魏晨 / 张宥浩 / 唐艺昕 / 李九霄 / 李晨 / 梁静 / 侯勇 / 辛柏青 / 俞灏明 / 刘晓庆 / 姚晨 / 郑恺 / 余皑磊 / 黄晓明 / 徐嘉雯 / 张承 / 马精武 / 胡晓光 / 陆思宇 / 白恩 / 曹璐 / 刘云龙 / 杨嘉华 / 中泉英雄 / 高爽 / 郑伟 / 高冬平 / 黄米依 / 曹卫宇 / 宋洋 / 徐乐同 / 徐幸',
    '1937年淞沪会战的最后一役，“八百壮士”奉命坚守上海四行仓库，以少敌多顽强抵抗四天四夜。电影《八佰》由管虎导演，是亚洲首部全片使用IMAX摄影机拍摄的商业电影，将于2020年8月21日全国影院上映。',
    '2020-08-21'
    );
insert into movie(v_title,v_class,v_img,v_director,v_writer,v_starring,v_detail,v_time)
    values(
    '鬼灭之刃 剧场版 无限列车篇 劇場版',
    5,
    'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2595123270.webp',
    '崎春雄',
    'Ufotable / 吾峠呼世晴',
    '花江夏树 / 鬼头明里 / 下野纮 / 松冈祯丞 / 日野聪 / 樱井孝宏 / 小西克幸 / 早见沙织 / 铃村健一 / 关智一 / 杉田智和 / 森川智之 / 佐藤利奈 / 三木真一郎 / 桑岛法子 / 本渡枫 / 大地叶 / 小原好美 / 古贺葵 / 小山力也 / 丰口惠美 / 榎木淳弥 / 伊濑茉莉也 / 笠间淳 / 千本木彩花 / 江口拓也 / 山村响 / 广濑裕也 / 高桥伸也 / 秋保佐永子 / 仲村宗悟 / 中惠光城',
    '该片基于吾峠呼世所著漫画《鬼灭之刃》创作而成，是2019年播出的TV动画的续篇，讲述灶门炭治郎和炼狱杏寿郎与下弦之壹魇梦作战的故事。',
    '2020-10-16'
    );
insert into movie(v_title,v_class,v_img,v_director,v_writer,v_starring,v_detail,v_time)
    values(
    '逃走的女人',
    1,
    'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2615399825.webp',
    '洪常秀',
    '洪常秀',
    '金敏喜 / 徐永嬅 / 宋宣美 / 李恩美 / 金玺碧 / 权海骁',
    '当丈夫出差后，Gamhee(金敏喜饰)与她的三个朋友见了面。她先去三位中的两位的各自家中见了面，而第三位则是在电影院偶然碰到。然而当她们像往常一样进行友好交谈时，各自的内心却早已七上八下、暗潮涌动。',
    ' 2020-02-25'
    );
insert into movie(v_title,v_class,v_img,v_director,v_writer,v_starring,v_detail,v_time)
    values(
    '最初的相遇，最后的别离',
    6,
    'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2626706220.webp',
    '曹译文',
    '周元姣',
    '林更新 / 盖玥希 / 杜淳 / 秦海璐 / 李坤霖 / 林澄 / 冯文娟',
    '前缉毒警严谨在卧底贩毒集团调查陈年疑案时，与“似水流年”咖啡店老板季晓鸥相爱。一桩离奇的杀人案却将两人的爱情拖入深渊。真相迷雾重重，而严谨仿佛坠入无尽的黑暗，他和季晓鸥的爱情又将何去何从……',
    '2020-11-19'
    );
insert into movie(v_title,v_class,v_img,v_director,v_writer,v_starring,v_detail,v_time)
    values(
    '少年的你',
    9,
    'https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2572166063.webp',
    '曾国祥',
    '林咏琛 / 李媛 / 许伊萌',
    '周冬雨 / 易烊千玺 / 尹昉 / 周也 / 吴越 / 黄觉 / 张艺凡 / 张耀 / 张歆怡 / 赵润南 / 郜玄铭 / 谢欣桐 / 刘然 / 何廖侣匀 / 胖虎 / 罗俊林',
    '陈念（周冬雨 饰）是一名即将参加高考的高三学生，同校女生胡晓蝶（张艺凡 饰）的跳楼自杀让她的生活陷入了困顿之中。胡晓蝶死后，陈念遭到了以魏莱（周也 饰）为首的三人组的霸凌，魏莱虽然表面上看来是乖巧的优等生，实际上却心思毒辣，胡晓蝶的死和她有着千丝万缕的联系。 
　　一次偶然中，陈念邂逅了名为小北（易烊千玺 饰）的小混混，随着时间的推移，心心相惜的两人之间产生了真挚的感情。小北答应陈念在暗中保护她免受魏莱的欺凌，没想到这一决定引发了一连串的连锁反应。负责调查胡晓蝶死因的警官郑易（尹昉 饰）隐隐察觉到校园里的古怪气氛，可他的调查却屡屡遭到校方的阻挠。',
    '2019-10-25'
    );
insert into movie(v_title,v_class,v_img,v_director,v_writer,v_starring,v_detail,v_time)
    values(
    '霸王别姬',
    10,
    'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2561716440.webp',
    '陈凯歌',
    '芦苇 / 李碧华',
    '张国荣 / 张丰毅 / 巩俐 / 葛优 / 英达 / 蒋雯丽 / 吴大维 / 吕齐 / 雷汉 / 尹治 / 马明威 / 费振翔 / 智一桐 / 李春 / 赵海龙 / 李丹 / 童弟 / 沈慧芬 / 黄斐 / 徐杰',
    '段小楼（张丰毅）与程蝶衣（张国荣）是一对打小一起长大的师兄弟，两人一个演生，一个饰旦，一向配合天衣无缝，尤其一出《霸王别姬》，更是誉满京城，为此，两人约定合演一辈子《霸王别姬》。但两人对戏剧与人生关系的理解有本质不同，段小楼深知戏非人生，程蝶衣则是人戏不分。 
　　段小楼在认为该成家立业之时迎娶了名妓菊仙（巩俐），致使程蝶衣认定菊仙是可耻的第三者，使段小楼做了叛徒，自此，三人围绕一出《霸王别姬》生出的爱恨情仇战开始随着时代风云的变迁不断升级，终酿成悲剧。',
    '1993-01-01'
    );
insert into movie(v_title,v_class,v_img,v_director,v_writer,v_starring,v_detail,v_time)
    values(
    '神秘巨星 Secret Superstar',
    11,
    'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2508925590.webp',
    '阿德瓦·香登',
    '阿德瓦·香登',
    '塞伊拉·沃西 / 梅·维贾 / 阿米尔·汗 / 拉杰·阿晶 / 提斯·沙马 / 卡比尔·谢赫 / 法如克·贾法尔 / 马努杰·沙玛 / 莫娜·安伯加卡尔 / 尼基塔·阿南德 / 尚 / 莫纳利·塔库尔',
    '少女伊西亚（塞伊拉·沃西 Zaira Wasim 饰）拥有着一副天生的好嗓子，对唱歌充满了热爱的她做梦都想成为一名歌星。然而，伊西亚生活在一个不自由的家庭之中，母亲娜吉玛（梅·维贾 Meher Vij 饰）常常遭到性格爆裂独断专横的父亲法鲁克（拉杰·阿晶 Raj Arjun 饰）的拳脚相向，伊西亚知道，想让父亲支持自己的音乐梦想是完全不可能的事情。 
　　某日，母亲卖掉了金项链给伊西亚买了一台电脑，很快，伊西亚便发现，虽然无法再现实里实现梦想，但是网络中存在着更广阔的舞台。伊西亚录制了一段蒙着脸自弹自唱的视屏上传到了优兔网上，没想到收获了异常热烈的反响，著名音乐人夏克提（阿米尔·汗 Aamir Khan 饰）亦向她抛出了橄榄枝。',
    '2018-01-19'
    );
--查看表
select v_id,v_title,(select c_name from movie_class where c_id = movie.v_class) as v_class,v_img,v_director,v_writer,v_starring,v_detail,v_time from movie;
--=========================

--======================创建评论表
--ID Int 主 评论ID 
--Content Varchar  内容
--Time sysDate  评论时间 
create table movie_msg
(
    m_id  number primary key,
    m_content varchar2(250) not null,
    m_time TIMESTAMP(9) default sysdate
)
-- 创建自增序列
create sequence movie_msg_seq
minvalue 1
maxvalue 999999
start with 1
increment by 1
cache 20;

--删除序列
DROP SEQUENCE movie_msg_seq;
--创建触发器：
create or replace trigger movie_msg_tig
before insert on movie_msg for each row 
begin
    select to_char(movie_msg_seq.nextval) into:new.m_id from dual;
end movie_msg_tig;
/
--===========================


--==============评论关系表
--Book_id Int 外 书本 ID 
--Msg_id Int  评论 ID 
--User_id Int 外 用户 ID 
create table movie_msg_relate
(
    r_movieid  number not null,
    r_msgid number not null,
    r_userid number not null
)
--添加外键
alter table movie_msg_relate add constraint movie_msg_relate_movieid foreign key(r_movieid) references movie(v_id) on delete cascade;
alter table movie_msg_relate add constraint movie_msg_relate_msgid foreign key(r_msgid) references movie_msg(m_id) on delete cascade;
alter table movie_msg_relate add constraint movie_msg_relate_userid foreign key(r_userid) references user_table(u_id) on delete cascade;
--=======================

--======================浏览表
--ID Int 主 浏览 ID 
--Book_id Int 外 书本 ID 
--User_id Int 外 用户 ID 
--time Date  访问时间 
drop table movie_look purge;

create table movie_look
(
    l_id number primary key,
    l_movieid number not null,
    l_userid number not null,
    l_time TIMESTAMP(9) default sysdate
)
--添加外键
alter table movie_look add constraint movie_look_movieid foreign key(l_movieid) references movie(v_id) on delete cascade;
alter table movie_look add constraint movie_look_userid foreign key(l_userid) references user_table(u_id) on delete cascade;
--========================