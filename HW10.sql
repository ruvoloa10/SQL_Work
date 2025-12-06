select * from emp;


--1. Delete those employees whose name starts with A and who is under the supervision of BLAKE

delete from emp
where ename like 'A%' and mgr = (select empno from emp where ename = 'BLAKE');


--2. Find the minimum salary of each department among the people who was hired before 1980

select deptno, min(sal)
from emp
where to_char(hiredate, 'YYYY') < '1980'
group by deptno;


--3. Find the employee in each job who makes the smallest salary in their job titles

select a.ename, a.job, a.sal
from emp a
where a.sal <= (select min(sal) from emp where job = a.job);


--4. Find employees who make more than their departmental median salary

select a.ename, a.deptno, a.sal
from emp a
where a.sal > (select median(sal) from emp where deptno = a.deptno);


--5. Find employees who have not been assigned a manager yet

select ename, mgr
from emp
where mgr is null;


--6. Find the total amount of money needed in order to give 5% salary increase to all managers, 8% to all clerks,  and 4% increase to everybody else

select sum(increase) from (
(select 12*sal*0.05 as increase
from emp
where job = 'MANAGER')
union all
(select 12*sal*0.08 as increase
from emp 
where job = 'CLERK')
union all
(select 12*sal*0.04 as increase
from emp
where job not in ('MANAGER', 'CLERK')));


--7. Find each employee who is making more than the average of the employees hired in the same year of his or her

select a.ename, a.sal, to_char(a.hiredate, 'YYYY')
from emp a
where a.sal > (select avg(sal) from emp where to_char(hiredate, 'YYYY') = to_char(a.hiredate, 'YYYY'));


--8. Give 500 commission to the employee who has the longest employment in the company

update emp
set comm = nvl(comm, 0) + 500
where hiredate = (select min(hiredate) from emp);


--9. Give everybody 10% salary increase in the departments whose maximum salaries are less than 2000

update emp a
set a.sal = a.sal * 1.1
where 2000 > (select max(sal) from emp where a.deptno = deptno);


--10. For all the employees supervised by KING, give them a salary increase, which is equal to the 2% of the company’s average salary

update emp 
set sal = sal + (0.02*(select avg(sal) from emp))
where mgr = (select empno from emp where ename = 'KING');

