--
-- String method
--

-- upper
select upper('seoul'), ucase('SeouL') from dual;
select upper(first_name) from employees;

-- lower
select lower("SEOUL"), lcase("SeouL") from dual;
select lower(first_name) from employees;

-- substring(string, index, length)
select substring('Hello World', 3, 2) from dual;

-- ex : 1989년에 입사한 직원들의 이름, 입사 일 출력하라. 
select first_name, substring(hire_date, 9, 2) from employees
where hire_date like '1989%';

-- lpad(우정렬), rpad(좌정렬)
select lpad('1234', 10, '-') from dual; 
select rpad('1234', 10, '-') from dual; 

-- 예제) 직원들의 월급을 오른쪽 정렬(빈공간은 *)
select lpad(salary, length(salary)+ 2, '*') from salaries;

-- trim, ltrim, rtrim -> except space
select 
concat("---", ltrim("     hello    "), "---"),
concat("---", rtrim("     hello    "), "---"),
concat("---", trim(leading 'x' from "xxxhelloxxx"), "---"),
concat("---", trim(trailing 'x' from "xxxhelloxxx"), "---"),
concat("---", trim(both 'x' from "xxxhelloxxx"), "---")
from dual;

-- length()
select length("Hello World") from dual;


