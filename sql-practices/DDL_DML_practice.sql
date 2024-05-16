-- DDL/ DML 연습
drop table member;
CREATE TABLE member (
    no INT NOT NULL AUTO_INCREMENT,
    email VARCHAR(200) NOT NULL DEFAULT '',
    password VARCHAR(64) NOT NULL,
    name VARCHAR(50) NOT NULL,
    department VARCHAR(100),
    PRIMARY KEY (no)
);

desc member;

alter table member add column juminbunho char(13) not null;
desc member;

alter table member drop column juminbunho;
desc member;

alter table member add column juminbunho char(13) not null after email;
desc member;

alter table member change column department dept varchar(100);
desc member;

alter table member add column self_intro text;
desc member;

alter table member drop column juminbunho;
desc member;

-- insert
insert into member values (null, 'bbingddang@gmail.com', password('1234'), '임병준', '개발팀', null);
SELECT 
    *
FROM
    member;

insert into member(no, email, name, dept, password)
values (null, 'bbingddang2@gmail.com', '임병준2', '개발팀2', password('1234'));
SELECT 
    *
FROM
    member;

-- update
update member
set email='bbingddang3@gmail.com', password=password('4321')
where no = 2;
SELECT 
    *
FROM
    member;
    
-- delete
delete
from member
where no = 2;
SELECT 
    *
FROM
    member;

-- transaction
SELECT 
    no, email
FROM
    member;
    
SELECT @@autocommit;
insert into member(no, email, name, dept, password) values(null, 'bbingddang2@gmail.com', 'bbingddang1', 'eng', '1313');
select no, email from member;

-- transaction begin
set autocommit = 0;
select @@autocommit;
insert into member(no, email, name, dept, password) values(null, 'bbingddang3@gmail.com', 'bbingddang3', 'eng', password('1313'));
select no, email from member;
-- +----+-----------------------+
-- | no | email                 |
-- +----+-----------------------+
-- |  1 | bbingddang@gmail.com  |
-- |  3 | bbingddang2@gmail.com |
-- +----+-----------------------+

-- transaction end
commit;
select no, email from member;
-- +----+-----------------------+
-- | no | email                 |
-- +----+-----------------------+
-- |  1 | bbingddang@gmail.com  |
-- |  3 | bbingddang2@gmail.com |
-- |  4 | bbingddang3@gmail.com |
-- +----+-----------------------+


