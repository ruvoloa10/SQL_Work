select * from emp;
select * from dept;


--1. Find those employees whose name has letter K inside
select ename
from emp
where ename like '%K%';


--2. Change ADAMS name to ADAM and his job title to MANAGER
update emp
set ename = 'ADAM', job = 'MANAGER'
where ename = 'ADAMS';


--3. Find all employees in DALLAS who were hired after 6/1/1980
select ename
from emp inner join dept on (emp.deptno = dept.deptno)
where loc = 'DALLAS' and hiredate > '01-Jun-1980';


--4. Insert a record for a new saleswoman SUSAN who was hired on February 27, 1986. 
--Her initial salary is 1400 dollars. 
--She has been assigned with an employee number 8045
insert into emp (empno, ename, job, hiredate, sal)
values (8045, 'SUSAN', 'SALESMAN', '27-Feb-1986', 1400);


--5. Give an employee 8% salary increases if he or she is hired before 1981 and has salary less than 1200
update emp
set sal = sal*1.08
where hiredate < '01-Jan-1981' and sal < 1200;


--6. Find the number of all employees who does not have any commission
select count(*)
from emp
where comm is null or comm = 0;


--7. Find average salary of each job
select avg(sal), job
from emp
group by job;


--8. Finds the average salary of all salesmen who are making less than 1500 dollars
select avg(sal)
from emp
where job = 'SALESMAN' and sal < 1500;


--9. For all the employees working in Dallas, list the name of each one and 
--the number of years he has been employed by the company.
select ename, (to_char(sysdate, 'YYYY') - to_char(hiredate,'YYYY')) as EmployedYears
from emp inner join dept on (emp.deptno = dept.deptno)
where loc = 'DALLAS';


--10. Find the maximum salary of the employees at each location
select max(sal), loc
from emp inner join dept on (emp.deptno = dept.deptno)
group by loc;


