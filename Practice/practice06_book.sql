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









