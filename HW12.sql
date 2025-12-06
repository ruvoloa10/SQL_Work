select * from emp;

--1. Give 100 dollars commission to a random employee

update emp
set comm = nvl(comm, 0) + 100
where empno in (select empno from (select empno from emp order by dbms_random.value)
where rownum < 2);

--2. Find the rank of each department in terms of total salary

select deptno, sum(sal) as Total, rank() over (order by sum(sal) desc nulls last)
from emp
group by deptno;

--3. Find top 2 largest departments in terms of number of employees

select deptno, empcount
from (select deptno, count(*) as empcount from emp group by deptno order by count(*) desc)
where rownum < 3;

--4. Find two random employees with the same random job title

with jobtable as 
((select job
from (select job from emp order by dbms_random.value())
where rownum < 2))
select ename, job
from (select ename, job from emp where job = (select job from jobtable) order by dbms_random.value())
where rownum < 3;

--5. Create a directory that lists each manager's name, hire date, department number, and all the supervisees managed by the manager as a sub window

select a.ename, a.hiredate, a.deptno, cursor(select ename from emp where a.empno = mgr)
from emp a
where job = 'MANAGER';

--6. Find employees who make less than the average of employees hired in his or her hire year

select a.ename, a.sal, to_char(a.hiredate, 'YYYY')
from emp a
where a.sal < (select avg(sal) from emp where to_char(a.hiredate, 'YYYY') = to_char(hiredate, 'YYYY'));