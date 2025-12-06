select * from emp;
select * from requests;
rollback;

--1. Delete the employee who has the longest employment in the company
delete from emp 
where hiredate = (select min(hiredate) from emp);

--2. Find the total amount of money needed in order to give 5% salary increase to all mangers and 4% increase to everybody else
select sum(increase) 
from ((select sal*0.05 as increase
from emp
where job = 'MANAGER')
union all
(select sal*0.04 as increase
from emp
where job not in ('MANAGER')));

--3. Give each clerk a salary increase, which is 3% of all clerks’ average salary to each clerk
update emp
set sal = sal + (0.03*(select avg(sal) from emp where job = 'CLERK'))
where job = 'CLERK';

--4. Find employees who are making less than the average of the employees hired in the same year
select a.ename, a.sal, to_char(a.hiredate, 'YYYY')
from emp a
where a.sal < (select avg(sal) from emp where to_char(hiredate, 'YYYY') = to_char(a.hiredate, 'YYYY'));

--5. Give 3% salary increase to those employees who have the smallest salary in their respective departments
update emp a
set a.sal = 1.03*a.sal
where a.sal = (select min(sal) from emp where deptno = a.deptno);

--6. Find the requests that has a word that sounds like uniqs and another word which is (mis)spelled as wendow
select id, text
from requests
where contains(text, '!uniqs and ?wendow') > 0;

--7. Give 100 dollars commission to a random employee
update emp
set comm = nvl(comm, 0) + 100
where empno in (select empno from (select empno from emp order by dbms_random.value)
where rownum < 2);

--8. Find the rank of each department in terms of total salary
select deptno, sum(sal), rank() over(order by sum(sal) desc nulls last)
from emp
group by deptno;

--9. Find all managers and, for each manager, a list all the employees that manager supervises as a sub window. 
select a.ename, a.empno, cursor(select ename from emp where a.empno = mgr)
from emp a
where job = 'MANAGER';

--10. Find top 2 largest departments in terms of number of employees
select deptno, empcount
from (select deptno, count(*) as empcount from emp group by deptno order by count(*) desc)
where rownum < 3;