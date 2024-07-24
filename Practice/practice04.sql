/****************************************************************
	practice04		서브쿼리(SUBQUERY) SQL 문제
****************************************************************/

/*
문제1.
평균 월급보다 적은 월급을 받는 직원은 몇명인지 구하시요.  (56건)
*/

/*
-- 평균월급
select avg(salary)
from employees;

-- 6461보다 적은 월급 받는 직원 수
select count(salary)
from employees
where salary < 6461;
*/

-- 합치기
select count(salary)
from employees
where salary < (select avg(salary)
				from employees);


/*
문제2.
평균월급 이상, 최대월급 이하의 월급을 받는 사원의 직원번호(employee_id), 이름(first_name),
월급(salary), 평균월급, 최대월급을 월급의 오름차순으로 정렬하여 출력하세요  (51건)
*/

/*
-- 평균월급
select avg(salary)
from employees;

-- 최대월급
select max(salary)
from employees;

-- 6461 이상, 24000 이하 월급 받는 사원의 리스트
select employee_id
		, first_name
        , salary
from employees
where salary >= 6461
and salary <= 24000;
*/

-- 합치기
select 	employee_id
		, first_name
        , salary
		, a.avg
        , m.max
from employees, (select avg(salary) avg from employees) a, (select max(salary) max from employees) m
where salary >= (select avg(salary)
				 from employees)
and salary <= (select max(salary)
				from employees)
order by salary asc;


/*
문제3.
직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소를 알아보려고 한다.
도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city),
주(state_province), 나라아이디(country_id) 를 출력하세요  (1건)
*/

-- ------------------------------------


/*
문제4.
job_id 가 'ST_MAN' 인 직원의 월급보다 작은 직원의 사번,이름,월급을 월급의 내림차순으로 출력하세요 
-- -ANY연산자 사용  (74건)
*/

/*
-- job_id 가 'ST_MAN' 인 직원의 월급  --> 가장 작은 월급 5800
select job_id
		, salary
from employees
where job_id = 'ST_MAN';

-- 5800 보다 작은 직원의 리스트
select employee_id
		, first_name
        , salary
from employees
where salary < 5800;
*/

-- 합치기
select employee_id
		, first_name
        , salary
from employees
where salary <any (select salary
				   from employees
				   where job_id = 'ST_MAN')
order by salary desc;


/*
문제5.
각 부서별로 최고의 월급을 받는 사원의 직원번호(employee_id), 이름(first_name)과 월급(salary)
부서번호(department_id)를 조회하세요
단 조회결과는 월급의 내림차순으로 정렬되어 나타나야 합니다. 조건절비교, 테이블조인 2가지 방법으로 작성하세요  (11건)
*/

/*
-- 각 부서별 최고의 월급
select 	department_id
		, max(salary)
from employees
group by department_id;
*/

-- 조건절 비교
select employee_id
		, first_name
        , salary
        , department_id
from employees
where (department_id, salary) in (	select department_id
											  , max(salary)
										from employees
										group by department_id)
order by salary desc;


-- 테이블조인
select e.employee_id
		, e.first_name
        , m.msalary
        , m.department_id
from employees e, (select department_id
						  , max(salary) msalary
					from employees
					group by department_id) m
where e.department_id = m.department_id
and e.salary = m.msalary
order by salary desc;


/*
문제6.
각 업무(job) 별로 월급(salary)의 총합을 구하고자 합니다.
월급 총합이 가장 높은 업무부터 업무명(job_title)과 월급 총합을 조회하시오  (19건)
*/

