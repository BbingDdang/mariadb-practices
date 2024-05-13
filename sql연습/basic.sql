select version(), current_date() from dual;

-- 수학함수, 사칙연산도 된다.

select sin(pi()/4),1+2*3-4 from dual;

-- 대소문자 구분이 없다.
SELECT VERSION();


-- table 생성: DDL
create table pet(
   name varchar(100),
    owner varchar(50),
    species varchar(20),
    gender char(1),
    birth date,
    death date
);

-- schema 확인
describe pet;
desc pet;

-- table 삭제
drop table pet;
show tables;

-- insert DML(C)
insert into pet values('멍멍이','김세윤','dog','m','2024-01-01',null);

-- select DML(R)
select * from pet;

-- update DML(U)
update pet set name='멍멍멍이' where name='멍멍이';

-- delete DML(D)
delete from pet where name='멍멍멍이';

-- load data: mysql(CLI) 전용
load data local infile '/root/pet.txt' into table pet;

-- select 연습
select name, species from pet
where name='bowser';

select name,species,birth
from pet
where birth>='1998-01-01';

select name,species,gender
from pet
where species = 'dog' and gender='f';


select name,species
from pet
where species = 'bird' or species='snake';

select name,birth
from pet
order by birth asc;

select name,birth
from pet
order by birth desc;

select name, birth, death
from pet
where death != null;

select name
from pet
where name like 'b%';

select name
from pet
where name like '%fy';

select name
from pet
where name like '%w%';

-- 언더바 개수만큼 이름 길이
select name
from pet
where name like '__';

SELECT 
    name
FROM
    pet
WHERE
    name LIKE 'b____';
    

select count(*)
from pet;

-- null이 아닌것만 count
select count(death)
from pet;


