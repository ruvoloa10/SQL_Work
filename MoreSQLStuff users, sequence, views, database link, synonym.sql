--user accounts

create user scott
identified by tiger
default tablespace users,
temporary tablespace temp;

alter user scott
identified by tiger;

drop user scott cascade;

--sequence = autonumber generator
create sequence enrollIDSeq
start with 11
increment by 3;

select enrollIDSeq.nextval from dual;

drop sequence enrollIDSeq;

--views = MS Access queries = saved SQL query
describe user_constraints

drop view myConstraints;
create view myConstraints as
select constraint_name, constraint_type, table_name
from user_constraints
where table_name = 'STUDENTS';

select * from myConstraints;

--database link: link to another account on the same of different computer
create database link linktoecourse
connect to scott identified by tiger
using 'ecourse.org:1521/OL8.ecourse.org';

select * from emp@linktoecourse;
describe emp@linktoecourse;
drop database link linktoecourse;

--synonym = alias for another database object
drop synonym ecEmployees;
create synonym ecEmployees for emp@linktoecourse;

select * from ecEmployees;

create public synonym ecDepartments for dept@linktoecourse;
select * from liping.ecDepartments;

select * from scott.dept;


