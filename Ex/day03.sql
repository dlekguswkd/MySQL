/****************************************************************
	3일차 (day03)
****************************************************************/

-- 그룹함수 

select first_name			-- 기본
		, salary
from employees;

-- avg() 평균 구하기 
select first_name			-- 불가 결과는 사각형으로만 나올수있음 
		, avg(salary)		-- 이름은 여러개, 평균은 한개 
from employees;

select avg(salary)			-- 가능 평균만 딱 나옴 
from employees;

-- count() 수 세기 
select count(*)					-- null 포함된 숫자가 나옴 
from employees;

select count(commission_pct)	-- null이 제외된 숫자가 나옴 
from employees;

-- 월급이 16000 초과 되는 직원의 수는? 
select count(*)					-- 3
		, count(manager_id)		-- 2 null 제외하고 나옴 
from employees
where salary > 16000;

-- sum() 더하기 
-- 전체직원의 급여의 합
select sum(salary) as total			-- null 제외하고 더함 
from employees;

-- 계산은 되지만 의미에 맞지 않다
select sum(employee_id)			-- 의미없는 덧셈 아이디번호를 더한것 
from employees;

-- avg() 평균구하기  -- null 포함여부 주의 
select count(*)
		, sum(salary)
        , avg(salary)				-- null 빼고 계산됨 
        , avg(ifnull(salary, 0))	-- null 을 0으로 바꾸고 평균내기 
from employees;

-- max()  min() 최대값 최소값 
select count(*)
		, max(salary)		-- null 제외 
        , min(salary)		-- null 제외 
from employees;

select max(salary)			-- 불가 1개
		, first_name 		-- 여러개 
from employees;


/****************************************************************
	group by절  
****************************************************************/
-- group by을 사용할땐 select에는 group by에 참여한 컬럼이나 그룹함수만 올수있다 
-- 그룹별로 월급의 합계를 구하세요 
select department_id		-- 그룹으로 나눈 수와 똑같아서 가능sum(salary)
		, sum(salary)
        , avg(salary)		-- 그룹안에서의 평균 
from employees
group by department_id
order by department_id asc;

select department_id
		, job_id
		, sum(salary)
from employees
group by department_id, job_id
order by department_id asc;

-- 예제 부서별로 부서의 부서 번호와 , 인원수, 월급합계를 출력하세요
select 	department_id 부서번호 
		, count(*) 인원수 
		, sum(salary) 월급합계
from employees
group by department_id
order by department_id asc;

-- group by에서의 where
-- having 절 (group by에서만 쓰임)
-- 월급(salary)의 합계가 20000 이상인 부서의 부서 번호와 , 인원수, 월급합계를 출력하세요
select 	department_id 
		, count(*) 
		, sum(salary) 
from employees
-- where sum(salary) >= 20000		사용불가
group by department_id
having sum(salary) >= 20000			-- 대신 사용 
-- and employee_id >= 150		-- having 절에는 그룹함수와 group by에 참여한 컬럼만 사용가능 
and department_id >= 80
order by department_id asc;


/****************************************************************
	IF ~ ELSE 문 /CASE ~ END 문 
****************************************************************/

 -- if(조건문, 참일때값, 거짓일때값)
 select first_name
		, salary
		, commission_pct
        , ifnull(commission_pct, 0) as commission_pct2
        , if(commission_pct is null, 0 , commission_pct) as state
 from employees;
 
-- case ~ end 문: if~else if~else if~else
/* 직원아이디, 월급, 업무아이디, 실제월급(realSalary)을 출력하세요.
실제월급은 job_id 가 'AC_ACCOUNT' 면 월급+월급*0.1,
				 'SA_REP' 월급+월급*0.2,
				 'ST_CLERK' 면 월급+월급*0.3
				 그외에는 월급으로 계산하세요
*/
select 	employee_id
		, salary
		, job_id
        , case when job_id = 'AC_ACCOUNT' then salary + salary*0.1
			   when job_id = 'SA_REP' then salary + salary*0.2
               when job_id = 'ST_CLERK' then salary + salary*0.3
			   else salary
		  end as realSalary
from employees;

-- 예제 
/* 직원의 이름, 부서번호(부서아이디), 팀을 출력하세요
팀은 코드로 결정하며 부서코드가 10~50 이면 'A-TEAM'
					   60~100이면 'B-TEAM' 
					   110~150이면 'C-TEAM' 
					   나머지는 '팀없음' 으로 출력하세요
*/
select first_name
		, department_id
        , case when department_id between 10 and 50 then 'A-TEAM'
        	   when department_id between 60 and 100 then 'B-TEAM'  
               when department_id between 110 and 150 then 'C-TEAM' 
			   else '팀없음'
		end as 부서코드
from employees
order by department_id asc;


/****************************************************************
	JOIN
****************************************************************/
-- 이름 월급 부서명 출력
select first_name
		, salary
        , department_name
from employees, departments;
select * from employees;		-- 107
select * from departments;		-- 27
select 107*27 from dual;		-- 카티젼 프로덕트 
-- 두개의 테이블을 동시에 불러옴
-- 107*27 row값이 생김
-- 두테이블의 모든 컬럼이 한개로 합쳐진다
-- (department_id 컬럼은 양쪽 테이블에 같은이름으로 있음)

-- join 의 기본 (where 절을 써야함)
select employee_id
		, first_name
        , salary
        , department_name
        -- , department_id			-- 양쪽에 있어서 두개라 어느것인지 정확하게 말해야됨
        , employees.department_id
        , departments.department_id
from employees, departments
where employees.department_id = departments.department_id;

-- 줄여쓰기 
select employee_id
		, first_name
        , salary
        , department_name
        , e.department_id
        , d.department_id
from employees e, departments d
where e.department_id = d.department_id;


------------------------------------------------
