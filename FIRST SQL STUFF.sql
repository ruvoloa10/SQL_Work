desc dept
desc emp

select * from dept;

select * from emp;

--insert new employees
insert into emp (ename, job, hiredate, sal, deptno, empno)
values ('JONES', 'CLERK', '23-Jun-1998', 2500, 40, 9000);

insert into emp
values (9001, 'LISA', null, null, sysdate, null, null, 10);
--sysdate is the current system date

--referential integrity rule #2: Values for FK column must preexist in the PK column

create sequence empnoSEQ
start with 9003
increment by 3;

insert into emp (ename, empno, hiredate)
values ('LAURA', empnoSEQ.nextval, to_date('12/3/2025', 'MM/DD/YYYY'));

--to_date function converts a text into a date

select * from emp;

--update
update emp
set job = upper('manager'), mgr = 7839
where ename = 'LISA';

--give 200 dollars to lisa as a salary increase
update emp
set sal = sal + 200
where ename = 'LISA';

--delete lisa
delete from emp
where ename like 'LISA';

--delete employees who have no job titles
delete from emp
where job is null;

--select statement
--find employees who make over 2000 dollars

select *
from emp
where sal > 2000;

--find salesmen who made no commissions
select ename, comm
from emp
where (comm is null or comm = 0) and job = 'SALESMAN';

--find managers who were hired after 1980
select ename, job, hiredate
from emp
where job = 'MANAGER' and hiredate > '31-Dec-1980';

select *
from emp
where to_char(hiredate, 'YYYY') > '1980' and job = 'MANAGER';

--find employees whose name starts with letter K

select *
from emp
where ename like 'K%';

--K is in the name
select *
from emp
where ename like '%K%';

--K is at the end of the name
select *
from emp
where ename like '%K';

