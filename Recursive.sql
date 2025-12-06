--Find a random department

select deptno, dname
from (select * from dept order by dbms_random.value)
where rownum < 2;

--Find the number of employees in a random department
select count(*)
from emp 
where deptno in (
select deptno
from (select * from dept order by dbms_random.value)
where rownum < 2);

--Hierarchical queries
--basic clause: start with (which record to start with)
--connect by (how different records are linked)


--List employess in their management hierarchy starting with president
select empno, ename, job, mgr
from emp
start with empno = (select empno from emp where job = 'PRESIDENT')
connect by prior empno = mgr;

--level == level number in hierarchy
select empno, ename, job, mgr, level, connect_by_root ename
from emp
start with ename = 'KING'
connect by prior empno = mgr;

--dummy column connect_by_root
--sys_connect_by_path() function

select ename, job, level, sys_connect_by_path(ename, '->') as Path
from emp
start with ename = 'KING'
connect by prior empno = mgr;


--use recursive queries to build a result with hierarchical order
with t(empno, ename, job, mgr) as
(
    (select empno, ename, job, mgr from emp where ename = 'KING')
    union all
    (select e.empno, e.ename, e.job, e.mgr from emp e inner join t on (t.empno = e.mgr))
)
select * from t;

--create a query to generate numbers from 1 to 100
with t(n) as
(
    (select 1 as n from dual)
    union all
    (select n + 1 as n from t where n < 100)
)
select * from t;

--Find the years in which the company did not hire any employees
with t(year) as
(
    (select to_number(to_char(min(hiredate), 'YYYY')) as year from emp)
    union all
    (select year + 1 as year from t where year < (select to_number(to_char(max(hiredate), 'YYYY')) from emp))
)
select year
from t
where year not in (select to_number(to_char(hiredate, 'YYYY')) from emp)
order by year asc;