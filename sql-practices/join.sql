--
-- inner join
--

-- 예제1) 현재 근무하고 있는 직원의 이름과 직책을 모두 출력하세요.
SELECT 
    first_name, title
FROM
    employees AS e,
    titles AS t
WHERE
    e.emp_no = t.emp_no
        AND t.to_date = '9999-01-01'; -- row 선택 조건
    
-- 예제2) 현재 근무하고 있는 직원의 이름과 직책을 출력하되 여성 엔지니어만 출력
SELECT 
    first_name, title
FROM
    employees AS e,
    titles AS t
WHERE
    e.emp_no = t.emp_no
        AND t.to_date = '9999-01-01'
        AND e.gender = 'F'
        AND t.title = 'Engineer';
        
--
-- ansi/iso 표준 sql1999 join 표준 문법
--

-- 실습문제1
-- 현재 직원별 근무 부서를 출력해 보세요.
-- 사번, 직원이름, 부서명 순 출력
SELECT 
    e.emp_no, first_name, dept_name
FROM
    employees AS e,
    dept_emp AS de,
    departments AS d
WHERE
    e.emp_no = de.emp_no
        AND de.dept_no = d.dept_no;

-- 실습 문제 2
-- 현재, 지급되고 있는 급여 출력
-- 사번, 이름, 급여 순으로 출력
SELECT 
    e.emp_no, first_name, salary
FROM
    employees AS e,
    salaries AS s
WHERE
    e.emp_no = s.emp_no
        AND s.to_date = '9999-01-01';

-- 1) natural join
-- 	조인 대상이 되는 두 테이블에 이름이 같은 공통 컬럼이 있으면
-- 	조인 조건을 명시하지 않고 암묵적 조인이 된다.
select e.first_name, t.title
from employees as e natural join titles as t
where t.to_date = '9999-01-01';

-- 2) join ~ using
-- 	natural join 의 문제점
SELECT 
    COUNT(*)
FROM
    salaries s
        NATURAL JOIN
    titles t
WHERE
    s.to_date = '9999-01-01'
        AND t.to_date = '9999-01-01';
        
SELECT 
    COUNT(*)
FROM
    salaries s
        JOIN
    titles t USING (emp_no)
WHERE
    s.to_date = '9999-01-01'
        AND t.to_date = '9999-01-01';
        
-- 3) join ~ on
-- 	예제) 현재, 직책별 평균 연봉을 큰 순서대로 출력하세요.
SELECT 
    title, AVG(salary)
FROM
    salaries s
        JOIN
    titles t ON s.emp_no = t.emp_no
WHERE
    s.to_date = '9999-01-01'
        AND t.to_date = '9999-01-01'
GROUP BY t.title
ORDER BY AVG(salary) DESC;

-- 실습문제 3
-- 현재, 직책별 평균연봉과 직원수를 구하라
SELECT 
    title, AVG(salary), COUNT(*)
FROM
    titles t
        JOIN
    salaries s ON t.emp_no = s.emp_no
WHERE
    s.to_date = '9999-01-01'
        AND t.to_date = '9999-01-01'
GROUP BY t.title
HAVING COUNT(*) >= 100;

-- 실습문제 4
-- 현재, 부서별로 직책이 Engineer인 직원들에 대해서만 평균 연봉을 구하시오.
-- 부서 이름, 평균 연봉 
SELECT 
    d.dept_name, AVG(s.salary)
FROM
    dept_emp de,
    departments d,
    salaries s,
    titles t
WHERE
    s.emp_no = t.emp_no
        AND s.emp_no = de.emp_no
        AND de.dept_no = d.dept_no
        AND t.title = 'Engineer'
        AND s.to_date = '9999-01-01'
        AND t.to_date = '9999-01-01'
        AND de.to_date = '9999-01-01'
GROUP BY de.dept_no
ORDER BY AVG(s.salary) DESC;
