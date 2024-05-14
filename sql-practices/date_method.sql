--
-- Date Method
--

-- curdate(), current_date
select curdate(), current_date from dual;

-- curtime(), current_time
select curtime(), current_time from dual;

-- now() vs sysdate() now : 쿼리가 실행된 타임 , sysdate : 명령이 실행된 타임
select now(), sysdate() from dual;
-- select now(), sleep(2), now() from dual; 
-- select now(), sleep(2), sysdate() from dual;

-- date_format
-- default format: %Y-%m-%d %h:%i:%s
select date_format(now(), "%Y-%m-%d %h:%i:%s") from dual;
select date_format(now(), "%d %b") from dual;

-- period_diff
-- ex) 근무 개월 구하라
-- 포맷팅 : yymm, yyyymm
select first_name, hire_date, period_diff(date_format(curdate(), "%y%m"), date_format(hire_date, "%y%m")) as "근속 개월" from employees;

-- date_add(=adddate), date_sub(=subdate)
-- 날짜를 date 타입의 컬럼이나 값에 type(year, month, day)의 표현식으로 더하거나 뺄 수 있다.
-- ex) 각 사원의 근속 년수가 5년이 되는날에 휴가를 보내준다면 각 사원의 5년근속휴가날짜는
select first_name, hire_date, date_add(hire_date, interval 5 year) from employees;


-- cast

 select date_format(cast("2023-01-09" as date), '%Y년-%m월-%d일') from dual;