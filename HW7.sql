select * from emp;

select * from dept;

--1. Finds all managers whose salary is more than 200
select *
from emp
where JOB = 'MANAGER' and SAL > 200;


--2. The company just started a new marketing department in Chicago. 
--The department ID is 50. Insert a new record into the database.
insert into dept (DEPTNO, DNAME, LOC)
values (50, 'MARKETING', 'CHICAGO');


--3. Give those employees 100 dollars of commission if they never received one before
update emp
set COMM = COMM + 100
where COMM = 0 or COMM is null;

--4. Delete those managers who were hired before 1979
delete from emp
where JOB = 'MANAGER' and to_char(hiredate, 'YYYY') < '1979';


--5. Find salesmen whose names end with letter T.
select *
from emp
where JOB = 'SALESMAN' and ENAME like '%T';