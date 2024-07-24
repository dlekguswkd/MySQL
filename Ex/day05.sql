/****************************************************************
	5일차 (day05)
****************************************************************/

-- subQuery : 하나의 SQL 질의문 속에 다른 SQL 질의문이 포함되어 있는 형태
-- SubQuery 부분은 where 절의 연산자 오른쪽에 위치해야 하며 괄호로 묶어야한다.

-- 'Den' 보다 월급을 많은 사람의 이름과 월급은?
-- Den의 월급  --> 11000
select first_name					-- 서브커리
		, salary
from employees
where first_name = 'Den';

-- 11000 보다 많은 사람 리스트
select first_name
		, salary
from employees
where salary >= 11000;

-- 두개를 합쳐서 1개의 질문으로 만든다 (질문 안에 질문 넣기)
select first_name						-- 출력하고 싶은 정보 다 넣기
		, salary
from employees
where salary >= (select salary			-- 딱 필요한 정보만 넣기 (이름 넣으면 안됨) - 서브커리
				from employees
				where first_name = 'Den')
order by salary desc;

-- 단일행 SubQuery (연산자 : = , > , >=, < , <=, !=(같지않다),<>(같지않다) 사용)
-- 예제
-- 월급을 가장 적게 받는 사람의 이름, 월급, 사원번호는?
-- 가장 적은 월급  --> 2100
select min(salary)
from employees;

-- 2100을 받는 사람의 리스트              
select first_name
		, salary
		, employee_id
from employees
where salary = 2100;

-- 두 질문 합치기               
select first_name
		, salary
		, employee_id
from employees
where salary = (select min(salary)
				from employees);

-- --------------------------------------------------------
-- 평균 월급보다 적게 받는 사람의 이름, 월급을 출력하세요?
-- 평균 월급  --> 6461.
select avg(salary)
from employees;

-- 6461보다 적게 받는사람 리스트
select first_name
		, salary
from employees
where salary <= 6461;

-- 두 질문 합치기
select first_name
		, salary
from employees
where salary <= (select avg(salary)
				from employees)
order by salary desc;


-- --------------------------------------------------------
-- 다중행 SubQuery (연산자 : ANY, ALL, IN … 사용) -> (데이터가 한개 이상일때)
-- 부서번호가 110인 직원의 월급와 같은 월급을 받는 모든 직원의 사번, 이름, 월급를 출력하세요  --> (in 사용)
-- 부서번호 110의 월급  --> 12008, 8300
select salary
from employees
where department_id = 110;

-- 월급 12008, 8300 인 직원의 리스트
select employee_id
		, first_name
		, salary
from employees 
where salary = 12008
or salary = 8300;

-- 똑같은 상황 다르게 표현 (월급 12008, 8300 인 직원의 리스트)
select employee_id
		, first_name
		, salary
from employees 
where salary in (12008, 8300);

-- 두 질문 합치기
select employee_id
		, first_name
		, salary
from employees 
where salary in (select salary
				 from employees
				 where department_id = 110);

-- --------------------------------------------------------
-- 예제
-- 각 부서별로 최고급여를 받는 사원의 이름과 월급을 출력하세요		--> (in 사용)
-- 각 부서별 최고급여  --> 여러개  (한줄에 데이터가 두개)
select department_id
		, max(salary)
from employees
group by department_id;					-- --> (group by 사용)

-- 데이터가 한줄에 두개?
select *
from employees 
where department_id = 50 and salary = 8200 -- > 8200은 50번 부서에서는 최고금액이지만 다른 부서 100번에서도 8200이 있지만 최고금액 X
or department_id = 10 and salary = 4400;
-- ... 두개를 비교해서 구해야함 월급과 부서번호가 동시에 맞아야함 (한줄에 데이터가 두개)
-- where (department_id, salary) in ((50, 8200), (10, 4400)) ...

-- 두 질문 합치기
select  department_id
		,first_name
		, salary
from employees
where (department_id, salary) in (select department_id
										, max(salary)
								from employees
								group by department_id)
order by department_id asc;


-- 다중행 SubQuery (연산자 : ANY, ALL, IN … 사용)
-- 부서번호가 110인 직원의 월급 중 가장 작은 월급 보다 월급이 많은 모든 직원의 이름, 급여를 출력하세요.
-- (or연산--> 8300보다 큰)  			--> (any(or) 사용)
-- 부서번호가 110인 직원의 월급	--> 12008, 8300
select salary
from employees
where department_id = 110;

-- 8300 보다 월급이 많은 직원의 리스트
select first_name
		, salary
from employees
where salary >= 8300;
-- where salary >= 8300		이거 사용
-- or salary >= 12008

-- 두 질문 합치기
select first_name
		, salary
from employees
where salary >any (select salary
				 from employees
				 where department_id = 110);


-- 다중행 SubQuery (연산자 : ANY, ALL, IN … 사용)
-- 부서번호가 110인 직원의 월급 중 가장 많은 월급 보다 월급이 많은 모든 직원의 이름, 급여를 출력하세요.
-- (and연산--> 12008보다 큰)				--> (all(and) 사용)
select first_name
		, salary
from employees
where salary >= 12008;
-- where salary >= 8300
-- and salary >= 12008    이거 사용

select first_name
		, salary
from employees
where salary >all (select salary
				 from employees
				 where department_id = 110);

-- --------------------------------------------------------
--  조건절에서 비교 vs 테이블에서 조인  *두개의 결과값 비교해볼것
-- 각 부서별로 최고월급을 받는 사원의 부서번호, 직원번호, 이름, 월급을 출력하세요.
--  조건절에서 비교
select department_id
		, employee_id
        , first_name
		, salary
from employees
where (department_id, salary) in (select department_id
										, max(salary)
                                  from employees
                                  group by department_id);
                                  

-- 테이블에서 조인 (없는 테이블을 만들어냄, 문장이 끝나면 사라짐)
-- 1) 각 그룹별로 최고월급 데이터가 있는 테이블이 있으면 구할수있다
-- 이 부분은 생각해 내야함
select 	e.department_id
		, max(salary)
from employees e
group by e.department_id;

-- 2) 전체구조
/*
select *
from employees e, (maxSalary-> 1)에서 만든 테이블 사용) s
where e.department_id = s.department_id
and e.salary = s.maxsalary;
*/

-- 3) 합치기
select 	s.department_id
		, e.employee_id
        , e.first_name
		, s.msalary
from employees e, (select department_id
						  , max(salary) as msalary		-- salary라고 이름을 지어준것
					from employees						-- s는 employees가 갖고있는 정보를 다 갖고있는게 아닌
                    group by department_id) s			-- select에 출력한것만 갖고있는것
where e.department_id = s.department_id
and e.salary = s.msalary;



-- ------------------------------------------------------

