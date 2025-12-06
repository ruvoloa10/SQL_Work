--Find employees who were hired before 1983 and has never received commissions
(select ename
from emp
where hiredate < '01-Jan-1983')
intersect
(select ename
from emp
where comm is null or comm = 0);

--Find employees and their annual income
(select ename, 12*sal+comm
from emp
where comm is not null)
union
(select ename, 12*sal
from emp
where comm is null);

--Find how much additional is needed to have 2% annual increase for all the salesmen,
--4% increase for all clerks, and 6% increase for the rest of the employeez
select sum(increase) from (
(select 12*sal*0.02 as increase
from emp
where job = 'SALESMAN')
union all
(select 12*sal*0.04 as increase
from emp 
where job = 'CLERK')
union all
(select 12*sal*0.06 as increase
from emp
where job not in ('CLERK', 'SALESMAN')));

--Find the departments which have no employees
(select deptno from dept)
minus
(select deptno from emp);
--equivalent to
select deptno
from dept
where deptno not in (select deptno from emp);

--Tuple variables = variables for records in a table
--simplest understanding: a tuple variable = alias of a table

--Find the departments who have the largest total salary
select a.deptno
from emp a
group by a.deptno
having sum(a.sal) >= all (select sum(sal) from emp group by deptno);

--Create a directory that shows employee names, jobs, departments,
--as well as names of the managers
select e.ename, e.job, e.deptno, m.ename 
from emp e inner join emp m on (m.empno = e.mgr);

--Find the employees who make the highest salary in his department
select max(sal)
from emp
group by deptno;

--You will find employees who makes a salary which is 
--the max of another department, not his own
select ename, sal
from emp
where sal in (select max(sal) from emp group by deptno);

select a.ename, a.sal
from emp a
where a.sal = (select max(b.sal) from emp b where b.deptno = a.deptno);

--Find employees who make more than their department average
select a.ename, a.sal
from emp a
where a.sal > (select avg(b.sal) from emp b where b.deptno = a.deptno);


--Find the employee who has the longest history in the company at each location
select a.ename, b.loc, a.hiredate
from emp a inner join dept b on (a.deptno = b.deptno)
where a.hiredate = (select min(c.hiredate) from emp c inner join dept d on (c.deptno = d.deptno) where d.loc = b.loc);

rollback;

--Give a $200 salary increase to the person who has the smallest salary in each location
update emp
set sal = sal + 200
where empno in 
    (select a.empno 
    from emp a inner join dept b on (a.deptno = b.deptno) 
    where a.sal = (select min(c.sal) from emp c inner join dept d on (c.deptno = d.deptno) 
    where d.loc = b.loc)
);

--Find employees who make more than the minimum salaries of those hired in the same year
select a.sal, a.ename, a.hiredate
from emp a
where a.sal > (select min(b.sal) from emp b
where to_char(b.hiredate, 'YYYY') = to_char(a.hiredate, 'YYYY'));

--Data backup
--Create new tables in the remote place
create table myClerks as
select empno, ename, sal, job, deptno
from emp
where job = 'CLERK';

desc myClerks

select * from myClerks;
--Add backup rows to remote table
insert into myClerks
select empno, ename, sal, job, deptno
from emp
where comm= 0 or comm is null;


