/**********************************************
 복습
**********************************************/
-- 기본구조 select문 = select절, from절
select * 
from employees; 

-- 특수한경우
select now() from dual;	  -- 가상의 테이블 dual
select now();  -- mySQL에서만 가능 

-- 4칙연산 
-- 사칙연산 가능, as 생략가능 
select	first_name 'f-name'
		, salary as 월급
		, salary*12 '연 봉' 
from employees;

-- 컬럼 합치기
select	first_name 이름 
		, last_name 성 
        , concat(first_name, ' ', last_name) 성명
from employees;

-- where 절 
select first_name
		, salary
from employees
where salary >= 17000;

-- 비교연산자, 조건이 여러개일때, between, in 

-- -------------------------------------------------------------
/****************************************************************
	2일차 (day02)
****************************************************************/
select first_name
		, salary
from employees
where first_name = 'Lex';


-- **like 연산자
-- % 기호, _ 기호 
select first_name
		, salary
from employees
where first_name like 'L%'; -- L로 시작하는것을 의미함 L%

select first_name
		, salary
from employees
where first_name like '%L'; -- L로 끝나는것을 의미함 %L

select first_name
		, salary
from employees
where first_name like '%L%';  -- 어디에든 L이 들어가는것

select first_name
		, salary
from employees
where first_name like 'L__';  -- _는 글자 자리수, _두개임 세글자중에 L로 시작하는걸 의미함 

-- 예제 
-- 이름에 am 을 포함한 사원의 이름과 월급을 출력하세요
select	first_name
		, salary
from employees
where first_name like '%am%';

-- 이름의 두번째 글자가 a 인 사원의 이름과 월급을 출력하세요
select	first_name
		, salary
from employees
where first_name like '_a%';

-- 이름의 네번째 글자가 a 인 사원의 이름을 출력하세요
select	first_name
from employees
where first_name like '___a%';

-- 이름이 4글자인 사원중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요
select	first_name
from employees
where first_name like '__a_';


-- **Null 은 계산되지 않는다 (계속 null)
-- 수당을 계산하세요 (between 13000 and 15000)
select	first_name
		, salary
		, commission_pct
        , salary * commission_pct + 200 수당 
from employees
where salary between 13000 and 15000;
-- where salary >= 13000 and salary <=15000

-- null 인것은 안나오게 하기
-- is not null (where commision_pct != null 은 잘못된 표현)
select first_name
		, salary
		, commission_pct
		, salary * commission_pct 수당 
from employees
where commission_pct is not null
and salary between 13000 and 15000;

-- 커미션비율이 있는 사원의 이름과 월급 커미션비율을 출력하세요
select first_name
		, salary
		, commission_pct
from employees
where commission_pct is not null;

-- 담당매니저가 없고 커미션비율이 없는 직원의 이름과 매니저아이디 커미션 비율을 출력하세요
select first_name
		, manager_id
        , commission_pct
from employees
where manager_id is null
and commission_pct is null;

-- 부서가 없는 직원의 이름과 월급을 출력하세요
select first_name
		, salary
        , department_id
from employees
where department_id is null;


-- **order by 절 
-- 직원의 이름과 월급을 월급이 많은 직원부터 출력하세요
select first_name
		, salary
from employees
order by salary desc;  -- 큰거부터 : 내림차순 

select first_name
		, salary
from employees
order by salary asc;  -- 작은거부터: 오름차순 

-- 월급이 9000이상인 직원의 이름과 월급을 월급이 많은 직원부터 출력하세요
select	first_name
		, salary
from employees
where salary >= 9000
order by salary desc;

-- 1. 월급이 높은사람부터 desc, 2. 동률일때 이름의 내림차순(Z->A) desc
select	first_name
		, salary
from employees
where salary >= 9000
order by salary desc, first_name desc;

-- 예제 
-- 부서번호를 오름차순으로 정렬하고 부서번호, 월급, 이름을 출력하세요
select department_id
		, salary
        , first_name
from employees
order by department_id asc;

-- 월급이 10000 이상인 직원의 이름 월급을 월급이 큰직원부터 출력하세요
select first_name
		, salary
from employees
where salary >= 10000
order by salary desc;

-- 부서번호를 오름차순으로 정렬하고 부서번호가 같으면 월급이 높은 사람부터 부서번호 월급 이름을 출력하세요 
select department_id
		, salary
        , first_name
from employees
order by department_id asc, salary desc;

-- 직원의 이름, 급여, 입사일을 이름의 알파벳 올림차순으로 출력하세요
select first_name
		, salary
		, hire_date
from employees
order by first_name asc;

-- 직원의 이름, 급여, 입사일을 입사일이 빠른 사람 부터 출력하세요
select first_name
		, salary
		, hire_date
from employees
order by hire_date asc;


-- **select from where order by절 처리방법
-- 실행순서 공부
select first_name n 
		, salary s 
from employees
where salary >= 10000
-- where s >= 10000 	--불가능
order by s desc;		-- 가능 

/****************************************************************
	단일행 함수 
****************************************************************/
-- 단일행함수 > 숫자 함수

-- **round() : 반올림
select round(123.123, 2)		-- 123.12 (소수점 2쨰자리까지표현)
		, round(123.126, 2)		-- 123.13 (소수점 3째자리에서 반올림)
		, round(234.567, 0)		-- 235  
        , round(123.456, 0)		-- 123
        , round(123.456)		-- 123 (안쓰면 0이랑 똑같음)
		, round(123.126, -1)	-- 120 (일의 자리에서 반올림)
        , round(125.126, -1)	-- 130
        , round(123.126, -2)	-- 100 (10의 자리에서 반올림)
from dual;

-- **ceil() : 올림 (일의자리에서만 가능)
select ceil(123.456)			-- 124
		, ceil(123.789)			-- 124
        , ceil(123.7892313)		-- 124
		, ceil(987.1234)		-- 988
from dual;

-- **floor() : 내림 (일의자리에서만 가능)
select floor(123.456)		-- 123
		, floor(123.789)	-- 123
        , floor(123.7892313)	-- 123
		, floor(987.1234)		-- 987
from dual;

-- **truncate() : 자리수 버림 
select truncate(1234.34567, 2)  	-- 1234.34		-- (소수점 2쨰자리까지표현)
		, truncate(1234.34567, 3)	-- 1234.345
        , truncate(1234.34567, 0)	-- 1234
        , truncate(1234.34567, -2)	-- 1200		-- (10의 자리에서 반올림)
from dual;

-- **power(), pow() : 숫자의 n승 
select pow(12, 2)			-- 144
		, power(12, 2)		-- 144
from dual; 

-- **sqrt(): 숫자의 제곱근
select sqrt(144)
from dual;

-- **sign(숫자): 숫자가 음수이면 -1, 0이면 0, 양수이면 1
select	sign(123)
		, sign(0)
		, sign(-123)
from dual;

-- **abs(숫자): 절대값
select	abs(123)			-- 123
		,abs(0)			-- 0
        , abs(-123)		-- 123
from dual;

-- **greatest(x, y, z, ...): 괄호안의 값중 가장 큰값 
select	greatest(2, 0, -2)		-- 2
		, greatest(4, 3.2, 5.25)	-- 5.25
        , greatest('B', 'A', 'C', 'c')	-- c (소문자가 더 크다)
from dual;

-- **least(x, y, z, ...): 괄호안의 값중 가장 작은값
select least(2, 0, -2)				-- -2
		, least(4, 3.2, 5.25)		-- 3.2	
        , least('B', 'A', 'C', 'c')	-- A (대문자가 더 작다)
from dual;


-- -----------------------------------------------------------------
-- 단일행함수 > 문자 함수

--  **concat(str1, str2, ..., strn): str1, str2, ..., strn을 연결 
select concat('안녕', '하세요')
		, concat('안녕', '-', '하세요');
        
select concat(first_name, ' ', last_name)
from employees;

-- **concat_ws(s, str1, str2, ..., strn): str1, str2, ..., strn을 연결할때 사이에 s 로 연결
-- *with seperator
select concat_ws('-', 'abc', '123', '가나다');

select concat_ws('-', first_name, last_name, phone_number)
from employees;

-- **lcase(str), lower(str): str의 모든 대문자를 소문자로 변환
select first_name
		, lcase(first_name)
        , lower(first_name)
        , lower('ABCabc!#$%')
        , lower('가나다')			-- 변동없음 
from employees;

-- **ucase(str),  upper(str): str의 모든 소문자를 대문자로 변환
select first_name
		, ucase(first_name)
        , upper(first_name)
        , upper('ABCabc!#$%')
        , upper('가나다')			-- 변동없음
from employees;

-- **length(str): str의 길이를 바이트로 반환 (영어)
-- **char_length(str), character_length(): str의 문자열 길이를 반환 (한글)
select first_name
		, length(first_name)    -- 바이트수 
        , char_length(first_name)		-- 글자수 
        , character_length(first_name)	-- 글자수 
from employees;

select length('유재석') 				-- 바이트수 
		, char_length('유재석')		-- 글자수
        , character_length('유재석')	-- 글자수
from dual;

-- **substring(str, pos, len), substr(str, pos, len): str의 pos 위치에서 시작하여 len 길이의 문자열 반환
select first_name
		, substr(first_name, 1, 3)		-- ste
        , substr(first_name, 2, 3)		-- tev
        , substr(first_name, -3, 2)		-- ve  (-n은 뒤에서부터 n번째부터 뒤로(오른쪽으로)몇번째까지) 
from employees;

select substr('981111-123456', 8,1)		-- 성별
		, substr('981111-123456', -7,1)	-- 성별
        , substr('981111-123456', 3,2)	-- 월
        , substr('981111-123456', 5,2)	-- 일
from dual;

-- **lpad(str, len, padstr): 
-- str 문자열 왼쪽에 padstr 문자열을 추가하여, 전체 문자열의 길이가 len이 되도록 만듬
select first_name
		, lpad(first_name, 10, '******')
from employees;

-- **rpad(str, len, padstr)
-- str 문자열 오른쪽에 padstr 문자열을 추가하여, 전체 문자열의 길이가 len이 되도록 만듬
select first_name
		, rpad(first_name, 10, '******')
from employees;

-- **trim(str): str의 양쪽에 있는 공백 문자를 제거
-- **ltrim(str): str의 왼쪽에 있는 공백 문자를 제거
-- **rtrim(str): str의 오른쪽에 있는 공백 문자를 제거
select concat('|', '      안녕하세요      ','|')
		, concat('|', trim('      안녕하세요      '),'|')
        , concat('|', ltrim('      안녕하세요      '),'|')
        , concat('|', rtrim('      안녕하세요      '),'|')
        , trim(concat('|', ('      안녕하세요      '),'|'))
from dual;

-- **replace(str, from_str, to_str): str에서 from_str을 to_str로 변경 (대소문자 구분함)
select first_name
		, replace(first_name, 'a' , '*')
        , substr(first_name, 2, 3)
        , replace(first_name, substr(first_name, 2, 3), '***')
from employees;


-- -----------------------------------------------------------------
-- 단일행함수 > 날짜/시간 함수
-- '1970-01-01 00:00:00' UTC를 기준으로 저장됩니다. (1초에 1씩)

-- **current_date(), curdate(): 현재 날짜를 반환
select current_date()
from dual;

-- **current_time(), curtime(): 현재 시간을 반환
select current_time()
from dual;

-- **current_timestamp(), now(): 현재 날짜와시간을 반환
select current_timestamp()
		, now() 
from dual;

-- **adddate(), date_add(): 날짜 시간 더하기
select adddate('2021-06-20 00:00:00', interval 1 year)
		, adddate('2021-06-20 00:00:00', interval 1 month)
        , adddate('2021-06-20 00:00:00', interval 1 week)
        , adddate('2021-06-20 00:00:00', interval 1 day)
        , adddate('2021-06-20 00:00:00', interval 1 hour)
        , adddate('2021-06-20 00:00:00', interval 1 minute)
        , adddate('2021-06-20 00:00:00', interval 1 second)
from dual;

-- **subdate(), date_sub(): 날짜 시간 빼기
select subdate('2021-06-20 00:00:00', interval 1 year)
		, subdate('2021-06-20 00:00:00', interval 1 month)
        , subdate('2021-06-20 00:00:00', interval 1 week)
        , subdate('2021-06-20 00:00:00', interval 1 day)
        , subdate('2021-06-20 00:00:00', interval 1 hour)
        , subdate('2021-06-20 00:00:00', interval 1 minute)
        , subdate('2021-06-20 00:00:00', interval 1 second)
from dual;

-- **datediff(): 두 날짜간 일수차
select datediff('2021-06-21 01:05:05', '2021-06-22 01:00:00')
from dual;

-- **timediff(): 두 날짜시간 간 시간차
select timediff('2021-06-21 01:05:05', '2021-06-20 01:00:00')
from dual;

-- 문제 현재까지 근무년수
select first_name
		, hire_date
        , floor(datediff(now(), hire_date)/365) workyear
from employees
order by workyear desc;


-- -----------------------------------------------------------------
-- 단일행함수 > 변환 함수

-- 변환함수: 날짜(숫자)→문자열
-- **date_format(date, format): date를 format형식으로 변환
select now()
		, date_format(now(), '%Y/%m/%d')	-- 2024/07/19
        , date_format(now(), '%y-%b-%d %H:%i:%s')	-- 24-Jul-19 16:23:56
from dual;

-- **format(숫자, p): 숫자에 콤마(,) 를 추가, 소수점 p자리까지 출력
select format(1234567.89, 2)
		, format(1234567.89, 0)		-- 반올림됨
        , format(1234567.89, -5)	-- 소수점까지만 되는듯 
from dual;

select first_name
		, salary
        , format(salary, 2)		-- 그대로 나옴 
        , format(salary, 0)		-- 소수점 빼고
from employees;

-- **ifnull(컬럼명, null일때값): 컬럼의 값이 null일때 정해진값을 출력
select first_name
		, salary
		, commission_pct
		, salary * ifnull(commission_pct, 0) + 500	보너스	-- 월급*커미션퍼센트 +500
        , ifnull(commission_pct, '없음')
from employees;

-- ------------------------------------------------------------------

