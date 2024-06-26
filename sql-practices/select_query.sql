-- 1) 집계쿼리: select 절에 통계함수(count, max, min, sum, avg, variance, stddev, ...)
SELECT 
    AVG(salary), SUM(salary)
FROM
    salaries;

-- 2) select 절에 집계합수(그룹함수)가 있는 경우, 어떤 칼럼도 select절에 올 수 없다!!
-- 	emp_no는 아무 의미가 없다.
-- 	오류!!
SELECT 
    emp_no, AVG(salary)
FROM
    salaries;

-- 3) query 순서 
-- 1. from: 접근 테이블 확인
-- 2. where: 조건에 맞는 row를 선택(임시 테이블)
-- 3. 집계(결과 테이블)
-- 4. projection
-- 예제) 사번이 10060인 사원이 받은 평균 월급
SELECT 
    AVG(salary)
FROM
    salaries
WHERE
    emp_no = 10060;

-- 4) group by 에 참여하고 있는 컬럼은 projection이 가능하다.: select 절에 올 수 있다.
-- 예제 : 사원별 평균 월급은?
SELECT 
    AVG(salary)
FROM
    salaries
GROUP BY emp_no;

-- 5) having
-- 	집계결과(결과 테이블)에서 row를 선택해야 하는 경우
-- 	이미 where절은 실행이 되었기 때문에 having 절에 이 조건을 주어야 한다.
-- 예제) 평균 월급이 60000 달러 이상인 사원의 사번과 평균 월급을 출력하세요.
SELECT 
    emp_no, AVG(salary) AS avg_salary
FROM
    salaries
GROUP BY emp_no
HAVING avg_salary >= 60000
ORDER BY avg_salary ASC;
-- 6) order by
-- 	order by 는 항상 맨 마지막 출력(projection)전에 한다.

-- 주의) 사번이 10060인 사원의 사번, 평균 월급, 급여 총합을 출력
-- 문법적으로 오류, 의미적으론 맞음
SELECT 
    emp_no, AVG(salary), SUM(salary)
FROM
    salaries
WHERE
    emp_no = 10060;
-- 이게 옳음
SELECT 
    emp_no, AVG(salary), SUM(salary)
FROM
    salaries
GROUP BY emp_no
HAVING emp_no = '10060';

