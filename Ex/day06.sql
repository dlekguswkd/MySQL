/****************************************************************
	6일차 (day06)
****************************************************************/

-- limit 시작번호(0부터), 갯수(몇개)
select	employee_id 
		, first_name
		, salary
from employees
order by employee_id asc
limit 0, 5;		-- 1번부터 5개(0번부터 5번까지 아님)

select	employee_id 
		, first_name
		, salary
from employees
order by employee_id asc
limit 5, 5;		-- 4번부터 5개(5번부터 5번까지 아님)

select *
from employees
order by employee_id asc
limit 5 offset 0;	-- 1번부터 5개(5번부터 0번까지 아님)

select employee_id 
		, first_name
		, salary
from employees
order by employee_id asc
limit 7;	-- 처음부터 7개
-- = limit 0, 7

-- 예제 
--  07년에 입사한 직원중 급여가 많은 직원중 3에서 7등의 이름 급여 입사일은?
select first_name
		, salary
		, hire_date
from employees
where hire_date between 070101 and 071231
order by salary desc
limit 2, 5;

select first_name
		, salary
		, hire_date
from employees
where date_format(hire_date, '%y') = 07
order by salary desc
limit 2, 5;

select year(hire_date)
		, month(hire_date)
        , day(hire_date)    
from employees;

select first_name
		, salary
		, hire_date
from employees
where substr(date_format(hire_date, '%y'), 1, 4 )= 07
order by salary desc
limit 2, 5;



-------------------------------------------------
-- ----------------------------------------------
-- root에서 계정 관리 (DCL)
-- ----------------------------------------------
-------------------------------------------------

-- 계정 만들기
create user 'web'@'%' identified by '1234';

-- 계정 비밀번호 수정
alter user 'web'@'%' identified by 'web';

-- 데이터베이스 = 스키마 접속권한 부여
grant all privileges on web_db.* to 'web'@'%';

-- 계정삭제 
drop user 'web'@"%";

-- 변경내용 바로반영 
flush privileges;

-- ---------------------------------------------

-- [문제] 계정명 book, 비번 book, 모든곳에서 접속 가능한 계정을 만드세요
-- 권한은 book_db 데이타베이스의 모든 테이블에 모든 권한을 갖도록 하세요

-- 계정삭제 (만약 있으면 if exists) (만들기보다 위에 있으면 초기화할때 편함 위에부터 실행되니까)
drop user if exists 'book'@'%';
 
 -- 계정 만들기
 create user 'book'@'%' identified by 'book';
 
 -- 데이터베이스 = 스키마 접속권한 부여
 grant all privileges on book_db.* to 'book'@'%';
 
-- 변경내용 바로반영 
flush privileges;



------------------------------------------------
-- ----------------------------------------------
-- book에서 데이터베이스 관리 (DDL)
-- ----------------------------------------------
------------------------------------------------

-- 데이터베이스 삭제 (위에서부터 실행하기위해 만약 존재한다면 (if exists) 넣어주기)
drop database if exists book_db;


-- 데이터베이스 생성
create database book_db
	default character set utf8mb4
	collate utf8mb4_general_ci
	default encryption='n'
;
    
    
-- 데이터베이스 선택(사용)
use book_db;


-- 데이터베이스 조회(출력)    
show databases;    


-- ----------------------------------------------
-- 테이블 관리
-- ----------------------------------------------
-- 어디에 할지
use book_db;

-- 테이블 만들기 
create table book(
	book_id integer
    , title varchar(50)
    , author varchar(20)
    , pub_date datetime
);

show tables;

-- 컬럼 추가
alter table book add pubs varchar(50);
-- 			테이블명	 추가할컬럼명

-- 확인해보기 (조회)
select *from book;

-- 컬럼 수정 (modify 수정) 
alter table book modify title varchar(100);  -- (varchar(50) -> varchar(100))
alter table book rename column title to subject;  -- title -> subject

-- 컬럼 삭제 (데이터도 같이 삭제됨)
alter table book drop author;


-- 테이블명 수정  (book -> article)
rename table book to article;

-- 확인해보기 (조회)
select *from article;

-- 테이블 삭제
drop table article;


-- ----------------------------------------------
-- 테이블 관리 제약조건
-- ----------------------------------------------
-- author 테이블 만들기 
create table author(
	author_id integer primary key
    , author_name varchar(100) not null
    , author_desc varchar(500)
);

-- 확인해보기 (조회)
show tables;
select * from author;


-- book 테이블 만들기
create table book(
	book_id integer primary key
    , title varchar(100) not null
    , pubs varchar(100)
    , pub_date datetime
    , author_id integer
    , constraint book_fk foreign key(author_id)		
    references author(author_id)		-- author 부터 만들어야함
); 


-- ----------------------------------------------
-- DML 조작 (등록, 수정, 삭제)
-- ----------------------------------------------

-- 작가(author) 테이블에 데이터 등록
insert into author values(1, '박경리', '토지 작가');

/*insert into author		-- 오류남 (이미 있는것을 또 넣어서)
values (	
	1					-- -> 바로 이 pk(null도 안되고 중복도 안됨)
    , '박경리'
    , '토지 작가'
);

insert into author 
values(						-- 오류남 (not null)
	2					
    , null				-- -> 바로 여기 null은 들어가면 안된다
    , '경북 영양'
);*/

insert into author 
values(
	2
    , '이문열'
    , null
);
-- 어느것이 null인 경우 또다른방법
insert into author(author_id, author_name)
values(3, '기안84');


-- 작가 테이블에 데이터 수정
update author 
set author_name = '이다현'
	, author_desc = '학생'
where author_id = 2;		-- where 절이 생략되면 모든 레코드에 적용(주의)


-- 작가 테이블에 데이터 삭제
delete from author
where author_id = 2;	-- pk로 하는게 좋음 그래야 딱 뭐인지 알수있어서 
						-- 조건이 없으면 모든 데이터 삭제(주의)


-- 확인 (조회)
select * from author;


-- ----------------------------------------------
-- auto_increment (연속적인 일렬번호 생성 → PK에 주로 사용됨)
-- ----------------------------------------------

drop table book;
drop table author;

-- 일련번호 비어있는거 너무 신경쓰지않아도됨 중요한건 겹치지 않는것
-- 테이블 생성시 사용
create table author(
	author_id integer primary key auto_increment
    , author_name varchar(100) not null
    , author_desc varchar(500)
);

insert into author
values(null, '황일영', '강사');		-- null이라고 하면 알아서 번호 매겨줌

insert into author
values(null, '기안84', '웹툰작가');	

-- 확인(조회)
select * from author;

-- 현재값을 조회할때 (어디까지 했는지)
select last_insert_id();

-- 연속적인 일렬번호 변경할때 (강제로 시작번호 바꿀때)
alter table author auto_increment = 50;
-- 그리고 새로 insert하면 일련번호 50번부터 시작

