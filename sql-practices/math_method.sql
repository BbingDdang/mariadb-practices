--
-- math method
--

-- abs
select abs(1), abs(-1) from dual;

-- ceil
select ceil(3.14), ceiling(3.14) from dual;

-- floor
select floor(3.14) from dual;

-- mod
select mod(10, 3), 10 % 3 from dual;

-- round(x) : nearest to x
select round(1.498), round(1.501) from dual;

-- round(x, d) : nearest to x by floor d
select round(1.498, 1) from dual;

-- power(x, y), pow(x, y) : x ^ y
select power(2,10), pow(2, 10) from dual;

-- sign(x) : + -> 1, - -> -1, 0 -> 1
select sign(1), sign(-1), sign(0) from dual;

-- greatest(x, y, ...) least(x, y, ...)
select greatest(10, 40, 20, 50), least(10, 40, 20, 50) from dual;
select greatest('b','A','c','d'), least('bello','belLo','becco','bedo') from dual;






