-- ----------------------------------------------
-- root 계정에서 할일
-- ----------------------------------------------
-- root에 뭐가있나 확인
use mysql;
select * from user;

-- book 계정만들기
create user 'book'@'%' identified by 'book';

-- book 권한부여
grant all privileges on book_db.* to 'book'@'%';

-- book_db 만들기
create database book_db
	default character set utf8mb4
	collate utf8mb4_general_ci
	default encryption='n'
;

-- book_db 조회
show databases;


-- ------------------------------------------------------------------------
-- ----------------------------------------------
-- book 계정에서 할일
-- ----------------------------------------------
-- ------------------------------------------------------------------------
-- 데이터베이스 선택(사용) 어디에 할지
use book_db;

-- 작가 테이블 만들기
create table author (
	author_id int primary key auto_increment
    , author_name varchar(100) not null
    , author_desc varchar(500)
);

-- 책 테이블 만들기
create table book (
	book_id int primary key auto_increment
    , title varchar(100) not null
    , pubs varchar(100)
    , pub_date datetime
    , author_id int
    , constraint book_fk foreign key (author_id)
    references author(author_id)
);


-- 작가 등록 (6개)
insert into author
values (null, '이문열', '경북 영양');

insert into author
values (null, '박경리', '경상남도 통영');

insert into author
values (null, '유시민', '17대 국회의원');

insert into author
values (null, '기안84', '기안동에서 산 84년생');

insert into author
values (null, '강풀', '온라인 만화가 1세대');

insert into author
values (null, '김영하', '알쓸신잡');


-- 책 등록(8개)
insert into book
values (null, '우리들의 일그러진 영웅', '다림', '1998-02-22', '1');

insert into book
values (null, '삼국지', '민음사', '2002-03-01', '1');

insert into book
values (null, '토지', '마로니에북스', '2012-08-15', '2');

insert into book
values (null, '유시민의 글쓰기 특강', '생각의길', '2015-04-01', '3');

insert into book
values (null, '패션왕', '중앙북스(books)', '2012-02-22', '4');

insert into book
values (null, '순정만화', '재미주의', '2011-08-03', '5');

insert into book
values (null, '오직두사람', '문학동네', '2017-05-04', '6');

insert into book
values (null, '26년', '재미주의 ', '2012-02-04', '5');


-- 책 + 작가 리스트 출력
select * from author;
select * from book;

select b.book_id
		, b.title
        , b.pubs
        , b.pub_date
        , a.author_id
        , a.author_name
        , a.author_desc
from author a, book b
where a.author_id = b.author_id;

-- 강풀정보 변경
update author
set author_name = '강풀' , 
author_desc = '서울특별시' 
where author_id = 5 ;


-- 책 + 작가 리스트 출력
select * from author;
select * from book;

select b.book_id
		, b.title
        , b.pubs
        , b.pub_date
        , a.author_id
        , a.author_name
        , a.author_desc
from author a, book b
where a.author_id = b.author_id;

-- 기안84 작가 삭제
-- --> 오류발생 이유 생각해보기
delete from author
where author_id = 4;

-- > author_id는 primary key이기 때문이다
-- >pk는 null도 입력이 안되고 중복값도 입력이 불가하다 이들은 삭제가 불가함


-- -------------------------------------------------------------

-- 나머지 배운 명령어 해보기

--  조건을 만족하는 레코드를 삭제
delete from author
where author_id = 9;

-- 연속적인 일렬번호 현재값을 조회할때
SELECT LAST_INSERT_ID();

-- 연속적인 일렬번호를 변경할때
alter table author auto_increment = 7;


-- -------------------------------------------------------------