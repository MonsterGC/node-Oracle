--==================�����û���
create table user_table
(
    u_id  number primary key,
    u_email varchar2(50) not null,
    u_passw varchar2(50) not null
)

-- ������������
create sequence user_table_seq
minvalue 1
maxvalue 999999
start with 1
increment by 1
cache 20;

--������������
create or replace trigger user_table_tig
before insert on user_table for each row 
begin
    select to_char(user_table_seq.nextval) into:new.u_id from dual;
end user_table_tig;
/
--�鿴��ṹ
desc userTable;
--�鿴��
select * from user_table;
--�����û�������
insert into user_table(u_email,u_passw) values('11@qq.com', '123');
insert into user_table(u_email,u_passw) values('12@qq.com', '123');
--=============================

--====================��������
create table movie_class
(
    c_id  number primary key,
    c_name varchar2(50) not null
)
-- ������������
create sequence movie_class_seq
minvalue 1
maxvalue 999999
start with 1
increment by 1
cache 20;

--������������
create or replace trigger movie_class_tig
before insert on movie_class for each row 
begin
    select to_char(movie_class_seq.nextval) into:new.c_id from dual;
end movie_class_tig;
/
--�鿴����
select * from movie_class;
--��������
insert into movie_class(c_name) values('����');
insert into movie_class(c_name) values('ϲ��');
insert into movie_class(c_name) values('����');
insert into movie_class(c_name) values('����');
insert into movie_class(c_name) values('����');
insert into movie_class(c_name) values('����');
insert into movie_class(c_name) values('���');
insert into movie_class(c_name) values('�ֲ�');
insert into movie_class(c_name) values('����');
insert into movie_class(c_name) values('ͬ��');
insert into movie_class(c_name) values('����');
insert into movie_class(c_name) values('����');
insert into movie_class(c_name) values('����');
insert into movie_class(c_name) values('��ʷ');
insert into movie_class(c_name) values('ս��');
insert into movie_class(c_name) values('����');
--============================

--==================������Ӱ��
--v_id	Int	��	��ӰID
--v_title	Varchar		��Ӱ����
--v_Class	Varchar	��	���
--v_img	Varchar		ͼƬ
--v_director	Varchar		����
--v_writer	Varchar		���
--v_starring	Varchar		����
--v_detail	Varchar		����
--v_time	Date		��ӳʱ��
--ɾ����
drop table movie purge;
--������
create table movie
(
    v_id  number primary key,
    v_title varchar2(50) not null,
    v_class number not null,
    v_img VARCHAR2(250) not null,
    v_director VARCHAR2(250) default '����',
    v_writer VARCHAR2(250) default '����',
    v_starring VARCHAR2(500) default '����',
    v_detail VARCHAR2(2500) not null,
    v_time varchar2(50) not null
)
--�������
alter table movie add constraint movie_class foreign key(v_class) references movie_class(c_id) on delete cascade;

-- ������������
create sequence movie_seq
minvalue 1
maxvalue 999999
start with 1
increment by 1
cache 20;

--ɾ������
DROP SEQUENCE movie_seq;
--������������
create or replace trigger movie_tig
before insert on movie for each row 
begin
    select to_char(movie_seq.nextval) into:new.v_id from dual;
end movie_tig;
/


--��������
insert into movie(v_title,v_class,v_img,v_director,v_writer,v_starring,v_detail,v_time)
    values(
    '�������� Soul',
    5,
    'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2626308994.webp',
    '���ء�������',
    '���ء�������',
    '���ס�����˹ / ���ȡ��� / �������ǡ���˹���� / ���׶�-������������ɭ / ��ά�¡��ϸ�˹ / ������ķ��ŵ�� / ���ж�����˹ / ����˿�������� / ���¡���ŷ���� / �����������˹ / �������������� / ��ꡤ���� / �޵�ɯ����˹ / Τ˹��˹���� / ɳ���ɡ��ָ��� / ������ķ˹�� / ��³ķ�������� / ��ŵ��櫡�л�޷� / ��˹���� / ���硤���ߵ��� / ���ɶ��ࡤ�¶������� / Elisapie Isaac / ��ɭ����˹ / �������в���Ү',
    '������ʲô�������������㣿��Ӱ���۽����������ɣ����ס�����˹����������λ��ѧ������ʦ�������������Ļ��ᡪ����ŦԼ��õľ�ʿ���ֲ����ࡣ��һ��Сʧ�������ŦԼ�Ľֵ�������һ����õĵط�����֮��������the Great Before�������������ǻ����ѵ����ǰ������֮ǰ��������ǵĸ����ص����Ȥ������Ҫ�ص����������������ʶ��һ���������ꡰ��ʮ���������ȡ��� ����������ʮ��һֱ�Ҳ����Լ����������������Ȥ����������������ͼ���ʮ��չʾ�����ľ���֮������Ҳ������һЩ�����ռ�����Ĵ𰸡�',
    '2020-12-25'
    );
insert into movie(v_title,v_class,v_img,v_director,v_writer,v_starring,v_detail,v_time)
    values(
    '����Ů��1984 Wonder Woman 1984',
    3,
    'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2626959989.webp',
    '�ɵ١��ܽ�˹',
    '�ɵ١��ܽ�˹',
    '�Ƕ����Ӷ� / ����˹���ɶ� / ����˹͡��Τ�� / ����ޡ���˹��  / �ޱ������� / ���򡤰�˹��� / �Ӳ������������� / ����˹�и��������� / ����ά˼ / ��ά�����ض� / ����ɯ����˹Τ�� / ̩ɯ������ķ����˹ / �������ֿ� / �γ��� / л���������ֶ� / �¿��򡤲��� / ��ɯ�������� / С�ﲿ���� / ��˹̹�������׸��� / ��ɭ���¡����� / ������������ / ��ɯ�ȡ��ֶ�˹ / ���ᡤĦ�� / ����˹�������ƿ� / ���ɶࡤɣ��˹ / �����ա��ƶ��� / ��ˡ�ŷ�ĸ��� / �Ƕ���Ī��˹ / �ָ����ض� / �µϡ�������˹�� / ��ŵ�������ϵ�',
    '���±����趨�����ʮɫ�������ջ��80���������Ů���������ڻ�ʢ�ٵ���Ȼ��ʷ����ݹ�������ͨ����������Ȼ������ֹ��һ������ƽ���Ľٰ�����ߵ�һ�ж������˱仯����ǿ��������ջ��£���λȫ�¾�����Ȼ���֡���������Ů�����మ��ɱ���Ķ�����ʳ�߱�Ů�� �Լ��ƿ����ܸı��������������˹����£�һ�������ս�������⡣����һ�ߣ��ɰ�ʷ�ٷ�ͻȻ�������������������������ǰԵ��Ȼ�������ж�֮�࣬ʷ�ٷ�Ļع�Ҳ�������� 
������ʱ����Ļ�����������λǿ���а���ɺ����ع�����ʷ�ٷ�����Ů��Ҫ��β����ٴ��������磿',
    '2020-12-18'
    );
insert into movie(v_title,v_class,v_img,v_director,v_writer,v_starring,v_detail,v_time)
    values(
    '�绰',
    1,
    'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2625879789.webp',
    '�����',
    '�����',
    '���Ż� / ȫ���� / ����� / � / ��� / �Ӻ�ɽ / ������',
    'һͨ�绰�����Թ�ȥ�����ڵ�����Ů�˲������������ϵ����������һ���ı�δ����Σ����Ϸ...���ǽ����������԰Ρ�',
    '2020-11-27'
    );
insert into movie(v_title,v_class,v_img,v_director,v_writer,v_starring,v_detail,v_time)
    values(
    '�˰�',
    1,
    'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2615992304.webp',
    '�ܻ�',
    '�ܻ� / ����',
    '��ǧԴ / ���� / ���� / ��־�� / �ſ�һ / ŷ�� / �Ŵ� / κ�� / ��嶺� / ����� / ����� / � / ���� / ���� / ������ / ����� / ������ / Ҧ�� / ֣�� / �న�� / ������ / ����� / �ų� / ���� / ������ / ½˼�� / �׶� / ��� / ������ / ��λ� / ��ȪӢ�� / ��ˬ / ֣ΰ / �߶�ƽ / ������ / ������ / ���� / ����ͬ / ����',
    '1937��������ս�����һ�ۣ����˰�׳ʿ�����������Ϻ����вֿ⣬���ٵж���ǿ�ֿ�������ҹ����Ӱ���˰ۡ��ɹܻ����ݣ��������ײ�ȫƬʹ��IMAX��Ӱ���������ҵ��Ӱ������2020��8��21��ȫ��ӰԺ��ӳ��',
    '2020-08-21'
    );
insert into movie(v_title,v_class,v_img,v_director,v_writer,v_starring,v_detail,v_time)
    values(
    '����֮�� �糡�� �����г�ƪ ������',
    5,
    'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2595123270.webp',
    '�鴺��',
    'Ufotable / ��g������',
    '�������� / ��ͷ���� / ��Ұ�� / �ɸ���ة / ��Ұ�� / ӣ��Т�� / С������ / ���ɳ֯ / ��彡һ / ����һ / ɼ���Ǻ� / ɭ����֮ / �������� / ��ľ��һ�� / ɣ������ / ���ɷ� / ���Ҷ / Сԭ���� / �źؿ� / Сɽ��Ҳ / ��ڻ��� / �\ľ���� / ��������Ҳ / �Ҽ䴾 / ǧ��ľ�ʻ� / ������Ҳ / ɽ���� / ����ԣҲ / ������Ҳ / �ﱣ������ / �ٴ����� / �лݹ��',
    '��Ƭ������g������������������֮�С��������ɣ���2019�겥����TV��������ƪ����������̿���ɺ�����������������֮Ҽ������ս�Ĺ��¡�',
    '2020-10-16'
    );
insert into movie(v_title,v_class,v_img,v_director,v_writer,v_starring,v_detail,v_time)
    values(
    '���ߵ�Ů��',
    1,
    'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2615399825.webp',
    '�鳣��',
    '�鳣��',
    '����ϲ / ������ / ������ / ����� / ������ / Ȩ����',
    '���ɷ�����Gamhee(����ϲ��)�������������Ѽ����档����ȥ��λ�е���λ�ĸ��Լ��м����棬������λ�����ڵ�ӰԺżȻ������Ȼ��������������һ�������Ѻý�̸ʱ�����Ե�����ȴ�������ϰ��¡�����ӿ����',
    ' 2020-02-25'
    );
insert into movie(v_title,v_class,v_img,v_director,v_writer,v_starring,v_detail,v_time)
    values(
    '��������������ı���',
    6,
    'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2626706220.webp',
    '������',
    '��Ԫ�',
    '�ָ��� / �ǫhϣ / �Ŵ� / �غ�� / ������ / �ֳ� / ���ľ�',
    'ǰ�������Ͻ����Ե׷������ŵ�������ɰ�ʱ���롰��ˮ���ꡱ���ȵ��ϰ弾��Ÿ�మ��һ׮�����ɱ�˰�ȴ�����˵İ���������Ԩ�������������أ����Ͻ��·�׹���޾��ĺڰ������ͼ���Ÿ�İ����ֽ���ȥ�δӡ���',
    '2020-11-19'
    );
insert into movie(v_title,v_class,v_img,v_director,v_writer,v_starring,v_detail,v_time)
    values(
    '�������',
    9,
    'https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2572166063.webp',
    '������',
    '��ӽ� / ���� / ������',
    '�ܶ��� / ����ǧ�� / ���P / ��Ҳ / ��Խ / �ƾ� / ���շ� / ��ҫ / ����� / ������ / ۬���� / л��ͩ / ��Ȼ / �������� / �ֻ� / �޿���',
    '����ܶ��� �Σ���һ�������μӸ߿��ĸ���ѧ����ͬУŮ�������������շ� �Σ�����¥��ɱ��������������������֮�С����������󣬳����⵽����κ������Ҳ �Σ�Ϊ�׵�������İ��裬κ����Ȼ�����Ͽ����ǹ��ɵ��ŵ�����ʵ����ȴ��˼������������������������ǧ˿���Ƶ���ϵ�� 
����һ��żȻ�У�������������ΪС��������ǧ�� �Σ���С��죬����ʱ������ƣ�������ϧ������֮���������ֿ�ĸ��顣С����Ӧ�����ڰ��б���������κ�������裬û�뵽��һ����������һ������������Ӧ������������������ľ���֣�ף����P �Σ����������У԰��ĹŹ����գ������ĵ���ȴ�����⵽У�������ӡ�',
    '2019-10-25'
    );
insert into movie(v_title,v_class,v_img,v_director,v_writer,v_starring,v_detail,v_time)
    values(
    '������',
    10,
    'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2561716440.webp',
    '�¿���',
    '«έ / ��̻�',
    '�Ź��� / �ŷ��� / ���� / ���� / Ӣ�� / ������ / ���ά / ���� / �׺� / ���� / ������ / ������ / ��һͩ / � / �Ժ��� / � / ͯ�� / ��۷� / ��� / ���',
    '��С¥���ŷ��㣩��̵��£��Ź��٣���һ�Դ�Сһ�𳤴��ʦ�ֵܣ�����һ��������һ���ε���һ����������޷죬����һ���������𼧡��������������ǣ�Ϊ�ˣ�����Լ������һ���ӡ������𼧡��������˶�Ϸ����������ϵ������б��ʲ�ͬ����С¥��֪Ϸ���������̵���������Ϸ���֡� 
������С¥����Ϊ�óɼ���ҵ֮ʱӭȢ�����˾��ɣ�����������ʹ�̵����϶������ǿɳܵĵ����ߣ�ʹ��С¥������ͽ���Դˣ�����Χ��һ���������𼧡������İ������ս��ʼ����ʱ�����Ƶı�Ǩ��������������ɱ��硣',
    '1993-01-01'
    );
insert into movie(v_title,v_class,v_img,v_director,v_writer,v_starring,v_detail,v_time)
    values(
    '���ؾ��� Secret Superstar',
    11,
    'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2508925590.webp',
    '�����ߡ����',
    '�����ߡ����',
    '������������ / ÷��ά�� / ���׶����� / ���ܡ����� / ��˹��ɳ�� / ���ȶ���л�� / ����ˡ��ַ��� / ��Ŭ�ܡ�ɳ�� / Ī�ȡ������ӿ��� / ����������ϵ� / �� / Ī�����������',
    '��Ů�����ǣ������������� Zaira Wasim �Σ�ӵ����һ�������ĺ�ɤ�ӣ��Գ���������Ȱ��������ζ����Ϊһ�����ǡ�Ȼ����������������һ�������ɵļ�֮ͥ�У�ĸ���ȼ��꣨÷��ά�� Meher Vij �Σ������⵽�Ը��Ѷ���ר��ĸ��׷�³�ˣ����ܡ����� Raj Arjun �Σ���ȭ������������֪�������ø���֧���Լ���������������ȫ�����ܵ����顣 
����ĳ�գ�ĸ�������˽�����������������һ̨���ԣ��ܿ죬�����Ǳ㷢�֣���Ȼ�޷�����ʵ��ʵ�����룬���������д����Ÿ���������̨��������¼����һ���������Ե��Գ��������ϴ������������ϣ�û�뵽�ջ����쳣���ҵķ��죬�����������Ŀ��ᣨ���׶����� Aamir Khan �Σ��������׳������֦��',
    '2018-01-19'
    );
--�鿴��
select v_id,v_title,(select c_name from movie_class where c_id = movie.v_class) as v_class,v_img,v_director,v_writer,v_starring,v_detail,v_time from movie;
--=========================

--======================�������۱�
--ID Int �� ����ID 
--Content Varchar  ����
--Time sysDate  ����ʱ�� 
create table movie_msg
(
    m_id  number primary key,
    m_content varchar2(250) not null,
    m_time TIMESTAMP(9) default sysdate
)
-- ������������
create sequence movie_msg_seq
minvalue 1
maxvalue 999999
start with 1
increment by 1
cache 20;

--ɾ������
DROP SEQUENCE movie_msg_seq;
--������������
create or replace trigger movie_msg_tig
before insert on movie_msg for each row 
begin
    select to_char(movie_msg_seq.nextval) into:new.m_id from dual;
end movie_msg_tig;
/
--===========================


--==============���۹�ϵ��
--Book_id Int �� �鱾 ID 
--Msg_id Int  ���� ID 
--User_id Int �� �û� ID 
create table movie_msg_relate
(
    r_movieid  number not null,
    r_msgid number not null,
    r_userid number not null
)
--������
alter table movie_msg_relate add constraint movie_msg_relate_movieid foreign key(r_movieid) references movie(v_id) on delete cascade;
alter table movie_msg_relate add constraint movie_msg_relate_msgid foreign key(r_msgid) references movie_msg(m_id) on delete cascade;
alter table movie_msg_relate add constraint movie_msg_relate_userid foreign key(r_userid) references user_table(u_id) on delete cascade;
--=======================

--======================�����
--ID Int �� ��� ID 
--Book_id Int �� �鱾 ID 
--User_id Int �� �û� ID 
--time Date  ����ʱ�� 
drop table movie_look purge;

create table movie_look
(
    l_id number primary key,
    l_movieid number not null,
    l_userid number not null,
    l_time TIMESTAMP(9) default sysdate
)
--������
alter table movie_look add constraint movie_look_movieid foreign key(l_movieid) references movie(v_id) on delete cascade;
alter table movie_look add constraint movie_look_userid foreign key(l_userid) references user_table(u_id) on delete cascade;
--========================