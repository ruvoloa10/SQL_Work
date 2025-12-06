select * from emp;
select * from dept;

-- 	SMITH is now promoted to be a manager. His new salary is the smallest salary of all managers
update emp
set job = 'MANAGER', sal = (select min(sal) from emp where job = 'MANAGER')
where ename = 'SMITH';

-- 	Find the total annual pay (salary *12 + commission) for each employee 
select ename, 12*sal + nvl(comm, 0) as AnnualIncome
from emp;

--Give 8% increase to employees hired before 1981 and his salary < 1300
update emp
set sal = sal*1.08
where to_char(hiredate, 'YYYY') < 1981 and sal < 1300;

-- Except for managers, for all the people working in Boston, change their job title to OPERATORS and add $50 to their salaries 
update emp
set job = 'OPERATOR', sal = sal + 50
where job != 'MANAGER' and deptno in (select deptno from dept where loc = 'BOSTON');

-- James now reports to KING. Update his record 
update emp
set mgr = (select empno from emp where ename = 'KING')
where ename = 'JAMES';

--Give 500 sal inc to person who ahs the smallest sal in the company
update emp
set sal = sal + 500
where sal = (select min(sal) from emp);

--Fire those salesmen who were hired before 1981 and never received commissions; 
delete from emp
where to_char(hiredate, 'YYYY') < 1981 and nvl(comm, 0) = 0;

-- Delete all the employees who report to BLAKE;
delete from emp
where mgr = (select empno from emp where ename = 'BLAKE');

--A new manager, with EMPNO 9289 and name Ellen, is just hired. Her salary is $2400. Insert her record
insert into emp (job, empno, ename, hiredate, sal)
values ('MANAGER', 9289, 'ELLEN', sysdate, 2400);

-- •	For those departments with at least 2 employees, find their number of employees hired after 1974. Sort the result by the department names 
select dname, count(*)
from dept inner join emp on (dept.deptno = emp.deptno)
where to_char(hiredate, 'YYYY') > 1974
group by dname
having count(*) > 2
order by dname asc;

-- •	Find those job categories whose average salary is more than 1200
select job, avg(sal)
from emp
group by job
having avg(sal) > 1200;

-- •	Find the employees whose salary is larger than the maximum salary in Dallas.
select ename, sal
from emp
where sal > (select max(sal) from emp inner join dept on (emp.deptno = dept.deptno) where loc = 'DALLAS');

-- •	Find those employees who earns more than the President
select ename, sal
from emp
where sal > (select sal from emp where job = 'PRESIDENT');

--•	Find those employees who were hired after all the salesmen:
select ename, hiredate
from emp
where hiredate > all (select hiredate from emp where job = 'SALESMAN');

-- •	Find those employees whose salary is less than the average salary of all salesman
select ename, sal
from emp
where sal < (select avg(sal) from emp where job = 'SALESMAN');

--•	Find the number of employees in DALLAS
select count(*)
from emp inner join dept on (emp.deptno = dept.deptno)
where loc = 'DALLAS';

--•	Find the employees supervised by King
select ename, mgr
from emp
where mgr = (select empno from emp where ename = 'KING');

--•	Find the person who makes the maximum salary in Dallas 
select ename
from emp inner join dept on (emp.deptno = dept.deptno)
where loc = 'DALLAS' and sal = (select max(sal) from emp inner join dept on (emp.deptno = dept.deptno) where loc = 'DALLAS');

-- •	Find the name of those departments whose employees earn more than 2100 dollars on the average 
select dname
from dept inner join emp on (dept.deptno = emp.deptno)
group by dname
having avg(sal) > 2100;

--•	Find the total number of employees who have never received commissions 
select count(*)
from emp
where nvl(comm, 0) = 0;

--•	Given 200 dollars commission to those who has smallest salary in the company
update emp
set comm = nvl(comm, 0) + 200
where sal = (select min(sal) from emp);

--•	Find those jobs that have the maximum average salary of all the jobs
select job
from emp
group by job
having avg(sal) >= all (select avg(sal) from emp group by job); 

--•	Find all the employees hired before 09/08/1895
select ename, hiredate
from emp
where hiredate < to_date('09/08/1895', 'MM/DD/YY'); 

--Find those analysts whose name starts with T?
select ename, job
from emp
where ename like 'T%' and job = 'ANALYST';

--•	Find those employees hired before 1/1/1980 but have never received commissions
select ename, hiredate, comm
from emp
where hiredate < to_date('1/1/1980', 'MM/DD/YY') and nvl(comm, 0) = 0;

--•	Find the total number of employees who have never received commissions
select count(*)
from emp
where nvl(comm, 0) = 0;

--•	Find the name of those departments whose employees earn more than 2100 dollars on the average
select dname
from dept inner join emp on (dept.deptno = emp.deptno)
group by dname
having avg(sal) > 2100;

--•	Find the number of employees whose name starts with J in each department 
select count(*), deptno
from emp
where ename like 'J%'
group by deptno;

--•	Find the average salary of each department from EMP
select avg(sal), deptno
from emp
group by deptno;

--•	Find those departments whose minimum salary is less than 1800:
select dname
from dept inner join emp on (dept.deptno = emp.deptno)
group by dname
having min(sal) < 1800;

-- •	Find the maximum salary earner in Dallas:
select ename, sal
from emp inner join dept on (emp.deptno = dept.deptno)
where loc = 'DALLAS' and sal >= (select max(sal) from emp inner join dept on (emp.deptno = dept.deptno) where loc = 'DALLAS');

--•	Find the number of employees in DALLAS:
select count(*)
from emp inner join dept on (emp.deptno = dept.deptno)
where loc = 'DALLAS';

--•	Find those job categories whose average salary is more than 1200:
select job, avg(sal)
from emp
group by job
having avg(sal) > 1200;

--•	Find the minimum salary of each department among the people who was hired before 1980?
select min(sal)
from emp
where to_char(hiredate, 'YYYY') < 1980
group by deptno;

--•	Find the gap of salaries of each department in descending order
select max(sal)-min(sal) as gap, deptno
from emp
group by deptno
order by gap desc;

--•	Find those departments whose minimum salary is more than 2000
select min(sal), deptno
from emp
group by deptno
having min(sal) > 2000;

--•	Find the number of employees in each department
select count(*), deptno
from emp
group by deptno;

--•	Find the most recent employment among those hired before 1980 for each department
select max(hiredate), deptno
from emp
where to_char(hiredate, 'YYYY') < 1982
group by deptno;

--•	Find the average salary of those employees whose name starts with J in each department
select avg(sal), deptno
from emp
where ename like 'J%'
group by deptno;

--•	Find those job categories whose maximum salary among the people hired after 1980 is more than 2500
select job, max(sal)
from emp
where to_char(hiredate, 'YYYY') > 1980
group by job
having max(sal) > 2500;

--•	Find the employment age of each employee?
select sysdate-hiredate, ename
from emp;

--•	Find all the employees hired before 09/08/1895
select ename, hiredate
from emp
where hiredate < to_date('09/08/1895', 'mm/dd/yyyy');

--•	Find employees who make more than BLAKE;
select ename, sal
from emp
where sal > (select sal from emp where ename = 'BLAKE');

--•	Find the employees who is in the same department as WARD
select ename, deptno
from emp
where deptno = (select deptno from emp where ename = 'WARD');

--•	Find the average salary of people who are working in Dallas
select avg(sal)
from emp inner join dept on (emp.deptno = dept.deptno)
where loc = 'DALLAS';

--•	Find all salesmen who makes more than the average salary of all salesmen
select ename, job
from emp
where job = 'SALESMAN' and sal > (select avg(sal) from emp where job = 'SALESMAN');