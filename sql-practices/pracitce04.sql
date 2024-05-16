-- 서브쿼리(SUBQUERY) SQL 문제입니다.

-- 문제1.
-- 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
SELECT 
    COUNT(*)
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    s.salary > (SELECT 
            AVG(s.salary)
        FROM
            salaries s
        WHERE
            s.to_date = '9999-01-01')
        AND s.to_date = '9999-01-01';
-- 문제2. (x)
-- 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서 연봉을 조회하세요. 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다. 
SELECT 
    e.emp_no, e.first_name, s.salary
FROM
    departments d,
    dept_emp de,
    employees e,
    salaries s,
    (SELECT 
        de.dept_no, MAX(s.salary) AS max_salary
    FROM
        dept_emp de, salaries s
    WHERE
        s.emp_no = de.emp_no
            AND s.to_date = '9999-01-01'
            AND de.to_date = '9999-01-01'
    GROUP BY de.dept_no) a
WHERE
    d.dept_no = de.dept_no
        AND de.emp_no = e.emp_no
        AND e.emp_no = s.emp_no
        AND s.to_date = '9999-01-01'
        AND de.to_date = '9999-01-01'
        AND a.max_salary = s.salary
        AND a.dept_no = de.dept_no
ORDER BY s.salary DESC;

-- 문제3.
-- 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요 
SELECT 
    e.emp_no, e.first_name, s.salary
FROM
    employees e,
    salaries s,
    dept_emp de,
    (SELECT 
        de.dept_no, AVG(salary) AS avg_salary
    FROM
        dept_emp de
    JOIN salaries s ON s.emp_no = de.emp_no
    WHERE
        s.to_date = '9999-01-01'
            AND de.to_date = '9999-01-01'
    GROUP BY de.dept_no) a
WHERE
    e.emp_no = s.emp_no
        AND s.emp_no = de.emp_no
        AND de.dept_no = a.dept_no
        AND s.to_date = '9999-01-01'
        AND de.to_date = '9999-01-01'
        AND s.salary > a.avg_salary;
-- 문제4.
-- 현재, 사원들의 사번, 이름, 담당 매니저 이름, 부서 이름으로 출력해 보세요.
SELECT 
    e.emp_no, e.first_name, a.first_name, d.dept_name
FROM
    employees e,
    departments d,
    dept_emp de,
    (SELECT 
        dm.emp_no, dm.dept_no, e.first_name
    FROM
        employees e
    JOIN dept_manager dm ON e.emp_no = dm.emp_no
    WHERE
        dm.to_date = '9999-01-01') a
WHERE
    e.emp_no = de.emp_no
        AND de.dept_no = d.dept_no
        AND d.dept_no = a.dept_no
        AND de.to_date = '9999-01-01';
-- 문제5.
-- 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.
SELECT 
    e.emp_no, e.first_name, t.title, s.salary
FROM
    employees e,
    titles t,
    salaries s,
    dept_emp de,
    (SELECT 
        d.dept_no, MAX(av.avg_salary) AS mx
    FROM
        (SELECT 
        de.dept_no, AVG(s.salary) AS avg_salary
    FROM
        dept_emp de
    JOIN salaries s ON de.emp_no = s.emp_no
    WHERE
        s.to_date = '9999-01-01'
            AND de.to_date = '9999-01-01'
    GROUP BY dept_no) av, dept_emp d
    WHERE
        d.to_date = '9999-01-01'
            AND d.dept_no = av.dept_no
    GROUP BY d.dept_no
    ORDER BY mx DESC
    LIMIT 0 , 1) a
WHERE
    e.emp_no = s.emp_no
        AND s.emp_no = t.emp_no
        AND de.emp_no = s.emp_no
        AND de.dept_no = a.dept_no
        AND s.to_date = '9999-01-01'
        AND t.to_date = '9999-01-01'
        AND de.to_date = '9999-01-01'
ORDER BY s.salary ASC;

-- 문제6.
-- 평균 연봉이 가장 높은 부서는? 부서 이름, 평균 연봉
SELECT 
    dn.dept_name, MAX(av.avg_salary) AS mx
FROM
    (SELECT 
        de.dept_no, AVG(s.salary) AS avg_salary
    FROM
        dept_emp de
    JOIN salaries s ON de.emp_no = s.emp_no
    WHERE
        de.to_date = '9999-01-01'
            AND s.to_date = '9999-01-01'
    GROUP BY dept_no) av,
    dept_emp d,
    departments dn
WHERE
    d.dept_no = dn.dept_no
        AND av.dept_no = dn.dept_no
        AND d.to_date = '9999-01-01'
GROUP BY dn.dept_name
ORDER BY mx DESC
LIMIT 0 , 1;

-- 문제7.
-- 평균 연봉이 가장 높은 직책? 직책 이름, 평균 연봉
SELECT 
    ta.title, MAX(av.avg_salary) AS mx
FROM
    (SELECT 
        t.title, AVG(s.salary) AS avg_salary
    FROM
        titles t
    JOIN salaries s ON t.emp_no = s.emp_no
    WHERE
        s.to_date = '9999-01-01'
            AND t.to_date = '9999-01-01'
    GROUP BY t.title) av,
    titles ta
WHERE
    ta.to_date = '9999-01-01'
        AND ta.title = av.title
GROUP BY ta.title
ORDER BY mx DESC
LIMIT 0 , 1;
    
-- 문제8.
-- 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.
select d.dept_name as "부서", e.first_name as "사원 이름", s.salary as "연봉", a.first_name as "매니저 이름", a.salary as "매니저 연봉"
from departments d, dept_emp de, employees e, salaries s, (select e.first_name, s.salary, dm.emp_no, dm.dept_no from employees e, salaries s, dept_manager dm
where e.emp_no = s.emp_no
and s.emp_no = dm.emp_no
and s.to_date = '9999-01-01'
and dm.to_date = '9999-01-01') a
where d.dept_no = de.dept_no
and de.dept_no = a.dept_no
and de.emp_no = e.emp_no
and e.emp_no = s.emp_no
and s.to_date = '9999-01-01'
and de.to_date = '9999-01-01'
and s.salary > a.salary
order by a.salary asc;


