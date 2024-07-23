/****************************************************************
	4일차 (day04)
****************************************************************/

-- join 이어서
select count(*)
from employees, departments
where employees.department_id = departments.department_id;

-- inner join > equi
-- 테이블 갯수 -1 where절이 발생 
select 	e.first_name
		, d.department_name
        , e.department_id
        , d.department_id
from employees e, departments d
where e.department_id = d.department_id;

-- 3개 join
select 	e.first_name
		, d.department_name
        , e.department_id
        , d.department_id
        , l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id;

-- 보통 이방법 사용 다른 문법(표현)
-- 테이블 갯수 -1 on 절이 발생 
select e.first_name
		, d.department_name
        , e.department_id
        , d.department_id
from employees e inner join departments d
on e.department_id = d.department_id;

-- 3개 join
select e.first_name
		, d.department_name
        , e.department_id
        , d.department_id
        , l.city
from employees e inner join departments d
on e.department_id = d.department_id
inner join locations l
on d.location_id = l.location_id;

-- 결론 inner join은 null이 있으면 제외되서 나옴
-- null 이 있으면 빠짐 (맞는게 없기 때문에)
select first_name
		, e.department_id
        , d.department_name
from employees e, departments d
where e.department_id = d.department_id;


--  -------------------------------------------------------

-- 두개가 동등하지않을떼 (기준정하기) null도 표현할수있음(기준 테이블의 정보는 다 보이게할수있음)
-- outer join은 null도 포함해서 나옴 
-- outer join > left  빠지면 안되는아이를 왼쪽으로
select e.first_name
		, d.department_name
        , e.department_id
from employees e
left outer join departments d 
on e.department_id = d.department_id;


-- outer join > right  빠지면 안되는아이를 오른쪽으로
select e.first_name
		, d.department_name
        , e.department_id  
from employees e
right outer join departments d 
on e.department_id = d.department_id;

-- 기준 바꿔서 해보기 (바로 위에랑 똑같은 결과가 나옴)
-- right join -> left join
select e.first_name
		, d.department_name
        , e.department_id
from departments d 
left outer join employees e
on e.department_id = d.department_id;


-- outer join > full  양쪽다 빠짐없이 나오게하기 
-- union 사용하기 
-- 중복은 알아서 한번만 적용, select 의 컬럼명과 갯수가 같아야함 (사각형으로 나와야하기때문)
-- 107+122-106 = 123 개
(		-- left join
select e.first_name
		, e.salary
		, d.department_id
        , d.department_name
 -- 	 , count(*)  사각형모양으로 나와야하는데 갯수가 달라서 안됨 
from employees e left outer join departments d
on e.department_id = d.department_id
)
union
(		--  right join 
select e.first_name
		, e.salary
		, d.department_id
        , d.department_name
from employees e right outer join departments d
on e.department_id = d.department_id
);
-- 위의 경우 salary를 빼면 갯수가 다르게 나옴 사번은 다르지만 나머지 정보가 같아서 중복처리되서 사라지는거임
-- 그래서 이런경우를 없애주기 위해선 무조건 다른 정보를 넣어줘서 정보가 빠지지 않도록 해주는게 필요
-- 직원사번(아이디)를 넣어주면 겹치지 않고 다 출력할수있음	(e.employee_id)넣어서 중복 없애주기 


-- -------------------------------------------------------------
-- 조인 연습(equi join, inner join 두가지로 물어볼것)
-- 직원아이디, 이름, 월급, 부서아이디, 부서명, 도시아이디, 도시명
select e.employee_id
		, e.first_name
        , e.salary
        , d.department_id
        , d.department_name
        , l.location_id
        , l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id;

select e.employee_id
		, e.first_name
        , e.salary
        , d.department_id
        , d.department_name
        , l.location_id
        , l.city
from employees e inner join departments d
on e.department_id = d.department_id
inner join locations l
on d.location_id = l.location_id;


-- 직원아이디, 이름, 월급, 부서아이디, 부서명, 도시아이디, 도시명, 나라아이디, 나라명
select e.employee_id
		, e.first_name
        , e.salary
        , d.department_id
        , d.department_name
        , l.location_id
        , l.city
        , c.country_id
        , c.country_name
from employees e, departments d, locations l, countries c
where e.department_id = d.department_id
and d.location_id = l.location_id
and l.country_id = c.country_id;

select e.employee_id
		, e.first_name
        , e.salary
        , d.department_id
        , d.department_name
        , l.location_id
        , l.city
        , c.country_id
        , c.country_name
from employees e inner join departments d
on e.department_id = d.department_id
inner join locations l
on d.location_id = l.location_id
inner join countries c
on l.country_id = c.country_id;


-- 직원아이디, 이름, 월급, 부서아이디, 부서명, 도시아이디, 도시명, 나라아이디, 나라명, 지역아이디, 지역명
select e.employee_id
		, e.first_name
        , e.salary
        , d.department_id
        , d.department_name
        , l.location_id
        , l.city
        , c.country_id
        , c.country_name
        , r.region_id
        , r.region_name
from employees e, departments d, locations l, countries c, regions r
where e.department_id = d.department_id
and d.location_id = l.location_id
and l.country_id = c.country_id
and c.region_id = r.region_id;

select e.employee_id
		, e.first_name
        , e.salary
        , d.department_id
        , d.department_name
        , l.location_id
        , l.city
        , c.country_id
        , c.country_name
		, r.region_id
        , r.region_name
from employees e inner join departments d
on e.department_id = d.department_id
inner join locations l
on d.location_id = l.location_id
inner join countries c
on l.country_id = c.country_id
inner join regions r
on c.region_id = r.region_id;

--  숨겨진 null (Kimberely) 나오게하기 
-- inner -> left
select e.employee_id
		, e.first_name
        , e.salary
        , d.department_id
        , d.department_name
        , l.location_id
        , l.city
        , c.country_id
        , c.country_name
		, r.region_id
        , r.region_name
from employees e left join departments d
on e.department_id = d.department_id
left join locations l
on d.location_id = l.location_id
left join countries c
on l.country_id = c.country_id
left join regions r
on c.region_id = r.region_id;


-- -------------------------------------------------------------
-- Self Join  같은 테이블 별명붙여서 두번 쓰기 (별명 붙여야 두번 사용 가능)
-- 직원아이디, 이름, 이메일, 관리자아이디, 관리자이름, 관리자이메일, 관리자전화번호
-- where 로 표현
select	e.employee_id
		, e.first_name
        , e.email
        , e.manager_id
        , m.first_name		'm_first_name'
        , m.email			'm_email'
        , m.phone_number	'm_phone_number'
from employees e, employees m
where e.manager_id = m.employee_id;

-- inner join (106명)
select	e.employee_id
		, e.first_name
        , e.email
        , e.manager_id
        , m.first_name		'm_first_name'
        , m.email			'm_email'
        , m.phone_number	'm_phone_number'
from employees e inner join employees m
on e.manager_id = m.employee_id;

-- outer join (107명)
select	e.employee_id
		, e.first_name
        , e.email
        , e.manager_id
        , m.first_name		'm_first_name'
        , m.email			'm_email'
        , m.phone_number	'm_phone_number'
from employees e left outer join employees m
on e.manager_id = m.employee_id;


-- -------------------------------------------------------------
-- 잘못된 join (내용은 하나도 안맞음 그냥 겹치는 숫자가 우연히 겹쳐서 같이 나와버리는 상황)
-- 주의할점 오류가 안나기때문에 뭐가 잘못됐는지 모를수있음! 
select *
from employees e, locations l
where e.salary = l.location_id


-- -------------------------------------------------------------

