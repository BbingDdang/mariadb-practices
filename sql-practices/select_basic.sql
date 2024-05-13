-- like 검색
-- 입사일이 1989년인 회사원의 이름과 입사일 출력
select first_name, hire_date
from employees
where hire_date like "1989%";


-- 예제 3: 남자 직원의 이름, 성별, 입사일을 입사일순(선임순)으로 출력
select first_name, gender, hire_date
from employees
where gender = 'M'
order by hire_date asc;


-- 예제 4: 직원의 사번, 월급을 사번(asc), 월급(desc)로 출력
select emp_no, salary
from salaries
order by emp_no asc, salary desc;