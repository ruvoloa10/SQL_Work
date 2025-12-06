select * from emp;
select * from dept;

--1. Find the number of employees hired in January of all years
select count(*)
from emp
where to_char(hiredate, 'MM') = '01';


--2. Find the name of those departments whose employees earn more than 2100 dollars on the average
select dname, avg(sal)
from dept inner join emp on (dept.deptno = emp.deptno)
group by dname
having avg(sal) > 2100; 


--3. Find the number of employees whose name starts with J in each department
select count(*), dname
from dept inner join emp on (dept.deptno = emp.deptno)
where ename like 'J%'
group by dname;


--4. Find those employees who make more than BLAKE does
select ename, sal
from emp
where sal > (select sal from emp where ename = 'BLAKE');


--5. Find those employees who were hired in the same year as JONES
select ename, to_char(hiredate, 'YYYY')
from emp
where to_char(hiredate, 'YYYY') = any (select to_char(hiredate, 'YYYY') from emp where ename = 'JONES');


--6. Find the managers who don't have supervisees
select empno
from emp
where job = 'MANAGER' and empno not in (select mgr from emp where mgr is not null);


--7. Find those jobs whose average salary is more than the average salary of the entire company.
select avg(sal), job
from emp
group by job
having avg(sal) > (select avg(sal) from emp);


--8. Find the employees who are making more than everybody in SALES department
select ename, sal
from emp
where sal > all (select sal from emp inner join dept on (emp.deptno = dept.deptno) where dname = 'SALES');  


--9. Find employees who were hired in the same month as BLAKE
select ename, to_char(hiredate, 'Month')
from emp
where to_char(hiredate, 'Month') = (select to_char(hiredate, 'Month') from emp where ename = 'BLAKE');


--10.Find the clerk who has the highest salary among all clerks
select ename, sal
from emp
where job = 'CLERK' and sal >= all (select sal from emp where job = 'CLERK');