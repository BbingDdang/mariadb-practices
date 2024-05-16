--
-- subquery
-- 

-- 
-- 1) select 절, insert into t1 values(...)
--

SELECT (SELECT 1 + 2 FROM DUAL) FROM DUAL;

SELECT 
    a.*
FROM
    (SELECT 1 + 2 FROM DUAL) a;
    
-- 2) from 절의 서브 쿼리
SELECT NOW() AS n, SYSDATE() AS s, 3 + 1 AS r FROM DUAL;

SELECT 
    *
FROM
    (SELECT NOW() AS n, SYSDATE() AS s, 3 + 1 AS r FROM DUAL) a;

-- 3) where 절의 서브 쿼리
-- ex) 현재, Fai bale이 근무하는 부서에서 근무하는 다른 직원의 사번 이름을 출력하세요
SELECT 
    e.emp_no, first_name
FROM
    employees AS e
        JOIN
    dept_emp AS de ON e.emp_no = de.emp_no
WHERE
    de.dept_no = (SELECT 
            dept_no
        FROM
            dept_emp de
                JOIN
            employees e ON de.emp_no = e.emp_no
        WHERE
            first_name = 'Fai'
                AND de.to_date = '9999-01-01'
                AND last_name = 'Bale');

-- 3-1) 단일행 연산자 : =, >, <, >=, <=, !=
-- 현재, 전체 사원의 평균 연봉보다 적은 급여를 받는 사원의 이름과 급여 출력
SELECT 
    first_name, salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    s.salary < (SELECT 
            AVG(s.salary)
        FROM
            salaries s
        WHERE
            s.to_date = '9999-01-01')
        AND s.to_date = '9999-01-01'
ORDER BY s.salary DESC;

-- 현재, 직책별 평균 급여 중에 가장 작은 직책의 직책과 그 평균 급여를 출력
-- 1)
SELECT 
    t.title, AVG(s.salary) AS avg_salary
FROM
    titles t
        JOIN
    salaries s ON t.emp_no = s.emp_no
WHERE
    t.to_date = '9999-01-01'
        AND s.to_date = '9999-01-01'
GROUP BY t.title;
-- 2)
SELECT 
    MIN(avg_salary)
FROM
    (SELECT 
        t.title, AVG(s.salary) AS avg_salary
    FROM
        titles t
    JOIN salaries s ON t.emp_no = s.emp_no
    WHERE
        t.to_date = '9999-01-01'
            AND s.to_date = '9999-01-01'
    GROUP BY t.title) a;
-- final)
SELECT 
    t.title, AVG(salary)
FROM
    titles t,
    salaries s
WHERE
    t.emp_no = s.emp_no
        AND t.to_date = '9999-01-01'
        AND s.to_date = '9999-01-01'
GROUP BY t.title
HAVING AVG(salary) = (SELECT 
        MIN(avg_salary)
    FROM
        (SELECT 
            t.title, AVG(s.salary) AS avg_salary
        FROM
            titles t
        JOIN salaries s ON t.emp_no = s.emp_no
        WHERE
            t.to_date = '9999-01-01'
                AND s.to_date = '9999-01-01'
        GROUP BY t.title) a);
        
-- 4) sol2: top-k(limit)
SELECT 
    t.title, AVG(s.salary) AS avg_salary
FROM
    titles t
        JOIN
    salaries s ON t.emp_no = s.emp_no
WHERE
    t.to_date = '9999-01-01'
        AND s.to_date = '9999-01-01'
GROUP BY t.title
ORDER BY avg_salary ASC
LIMIT 0, 1; -- 게시판 페이징할 때

-- 3-2) 복수행 연산자 : in, not in, 비교연산자 any, 비교연산자 all

-- any 사용법 使い方法
-- 1. =any: in
-- 2. >any, >=any: 최소값
-- 3. <any, <=any: 최대값
-- 4. <>any, !=any: not in

-- all 使い方法
-- 1. =all: (x)
-- 2. >all, a>all: 최대값
-- 3. <all, a<all: 최소값
-- 4. <>all, !=all 

-- 실습문제
-- 현재 급여가 50000이상인 직원의 이름과 급여를 출력
-- 1) join
SELECT 
    e.first_name, s.salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    s.salary > 50000
        AND s.to_date = '9999-01-01'
ORDER BY s.salary ASC;
        
-- 2) in
SELECT 
    emp_no, salary
FROM
    salaries
WHERE
    to_date = '9999-01-01'
        AND salary > 50000;

SELECT 
    e.first_name, s.salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    s.to_date = '9999-01-01'
        AND (e.emp_no , s.salary) IN (SELECT 
            emp_no, salary
        FROM
            salaries
        WHERE
            to_date = '9999-01-01'
                AND salary > 50000)
ORDER BY s.salary ASC;
-- 3) any
SELECT 
    e.first_name, s.salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    s.to_date = '9999-01-01'
        AND (e.emp_no , s.salary) = ANY (SELECT 
            emp_no, salary
        FROM
            salaries
        WHERE
            to_date = '9999-01-01'
                AND salary > 50000)
ORDER BY s.salary ASC;

-- 실습 문제
-- 현재, 각 부서별로 최고 급여를 받고 있는 직원의 부서, 이름과 월급을 출력
SELECT 
    de.dept_no, MAX(s.salary)
FROM
    dept_emp de,
    salaries s
WHERE
    s.emp_no = de.emp_no
        AND s.to_date = '9999-01-01'
        AND de.to_date = '9999-01-01'
GROUP BY de.dept_no;
-- 1) where : subquery
SELECT 
    d.dept_name, e.first_name, s.salary
FROM
    departments d,
    employees e,
    salaries s,
    dept_emp de
WHERE
    d.dept_no = de.dept_no
        AND e.emp_no = de.emp_no
        AND s.emp_no = e.emp_no
        AND s.to_date = '9999-01-01'
        AND de.to_date = '9999-01-01'
        AND (de.dept_no , s.salary) IN (SELECT 
            de.dept_no, MAX(s.salary)
        FROM
            dept_emp de,
            salaries s
        WHERE
            s.emp_no = de.emp_no
                AND s.to_date = '9999-01-01'
                AND de.to_date = '9999-01-01'
        GROUP BY de.dept_no);

-- 2) from : subquery & join
SELECT 
    d.dept_name, e.first_name, s.salary
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
        AND a.dept_no = de.dept_no;