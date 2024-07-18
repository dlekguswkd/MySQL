/****************************
select 문(조회)
******************************/

-- **select ~ from 절 (테이블이름)
-- 테이블 전체 조회하기
select * from employees;
select * from departments;
select * from locations;
select * from countries;
select * from regions;
select * from jobs;
select * from job_history;
select * from JOB_HISTORY;  -- 대소문자 구분이 없다
SELECT * FrOM joB_hIstOrY;

-- 원하는 컬럼만 조회하기
select * from employees;
select first_name from employees;
select first_name, phone_number from employees;

-- 예제 풀기
-- 모든 직원의 이름(fisrt_name)과 전화번호 입사일 월급을 출력하세요
select * from employees;
select first_name, phone_number, hire_date, salary from employees;

-- 모든 직원의 이름(first_name)과 성(last_name), 월급, 전화번호, 이메일, 입사일을 출력하세요
select	first_name, 
		last_name, 
		salary, 
		phone_number, 
		email, 
		hire_date 
from employees;

-- **컬럼명에 별명 사용하기
select first_name as 이름, last_name as 성 from employees;

-- 예제 
-- 직원의 이름(fisrt_name)과 전화번호, 입사일, 월급 으로 표시되도록 출력하세요
select	first_name as 이름
		, phone_number as 전화번호
        , hire_date as 입사일
        , salary as 월급
from employees;

-- 직원의 직원아이디를 사 번, 이름(first_name), 성(last_name), 월급, 전화번호, 이메일,
-- 입사일로 표시되도록 출력하세요
-- 별명 이름을 정해줄때 공백이나 특수문자 하고싶으면 ' '로 묶어주기
-- as 생략가능 
select	employee_id as '사 번'
		, first_name 이름
        , last_name as 성
        , salary as 월급
        , phone_number as 전화번호
        , email as 이메일
        , hire_date as 입사일
from employees;

-- 직원아이디, 이름, 월급을 출력하세요. 
-- 단 직원아이디는 empNO, 이름은 "f-name", 월급은 "월 급" 으로 컬럼명을 출력하세요
select employee_id as empNO
		, first_name 'f-name'
        , salary '월 급'
from employees;

-- -----------------------------------------------------------------

-- **산술 연산자 사용하기
-- 정수/정수 소수점까지 계산됨
select	salary 월급
		, salary-100 '월급-식대'
		,salary*12 연봉
		, salary*12+5000 '연봉+보너스'
        , salary/30 일급
        , employee_id%3 나머지  
        , employee_id/3 소수점도다나옴
from employees;

-- 연산시 문자열은 0으로 처리 -> 오류가 나지 않으므로 주의 
select job_id*12
from employees;


-- **컬럼 합치기
select	first_name
		, last_name
		, concat(first_name, last_name)
        , concat(first_name, last_name) as 이름
        , concat(first_name, ' ' , last_name) as 이름
        , concat(first_name, ' ' , last_name, ' 입사일은 ', hire_date, ' 입니다') 이름2
from employees;

-- 예제
-- 전체직원의 정보를 다음과 같이 출력하세요
select	concat(first_name, '-' , last_name) 성명
		, salary 월급
        , salary*12 연봉
        , salary*12+5000 보너스
        , phone_number 전화번호
from employees;


-- **없는 컬럼 만들기 
select first_name
		, salary
        , '2024-07-18' as 기준일
        , now() as 실행하는오늘날짜
        , 3 as 옵션
        , '자바ex' 회사명
from employees;

-- 테이블이 필요없을때 테이블명을 생략할때도 있다 
select now()
from dual;  -- 가상의 테이블 생략가능

select now();


-- **비교연산자 
-- 이름, 부서아이디 출력하세요
select first_name
		, department_id
from employees
where department_id=10;  -- 부서아이디가 10인사람만 보여줘 

-- 예제
-- 월급이 15000 이상인 사원들의 이름과 월급을 출력하세요
select	first_name
		,salary
from employees
where salary >= 15000;

-- 07/01/01 일 이후에 입사한 사원들의 이름과 입사일을 출력하세요
select first_name
		, hire_date
from employees
where hire_date >= '07/01/01';

-- 이름이 Lex인 직원의 이름과 월급을 출력하세요 
select first_name
		, salary
from employees
where binary first_name = 'Lex';
-- - 문자열 대소문자를 구별하지 않는다. 구별하려면 binary 사용 


-- **조건이 2개이상 일때 한꺼번에 조회하기
-- 월급이 14000이상 17000이하인 사원의 이름과 월급을 구하시오
select first_name
		, salary
from employees
where salary >= 14000
and salary <= 17000;

-- 예제
-- 월급이 14000 이하이거나 17000 이상인 사원의 이름과 월급을 출력하세요
select first_name
		, salary
from employees
where salary <= 14000
or salary >= 17000;

-- 입사일이 04/01/01 에서 05/12/31 사이의 사원의 이름과 입사일을 출력하세요
select first_name
		, hire_date
from employees
where hire_date >= '04/01/01'
and hire_date <= '05/12/31';


-- ** between 작은값 and 큰값 (between 연산자로 특정구간 값 출력하기)
-- 월급이 14000 이상 17000이하인 사원의 이름과 월급을 구하시오
select first_name
		, salary
from employees
where salary between 14000 and 17000;


-- ** in 연산자
 -- 월급이 2100, 3100, 4100, 5100 인 사원의 이름과 월급을 구하시오
select first_name
		, salary
from employees
where salary = 2100
or salary = 3100
or salary = 4100
or salary = 5100;
-- -> in 사용 
select first_name
		, salary
from employees
where salary in(2100, 3100, 4100, 5100);

-- Neena, Lex, John 의 이름, 성, 월급의 구하시오
select first_name
		, last_name
        , salary
from employees
where first_name in('neena', 'lex', 'john');

-- --------------------------------------------------------


