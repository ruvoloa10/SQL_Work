select * from dept;
select * from emp;

-- give 100 commission to all salesmen
update emp
set comm = nvl(comm,0) + 100
where job = 'SALESMAN' and comm is not null;

select nvl(comm, 0) from emp;

-- Find the total annual pay (salary*12 + commission) for each employee
select 12*sal + nvl(comm,0) as AnnualIncome, ename
from emp;

--make a sentence using the data
--John is a salesman with salary 2000
select ''|| ename ||' is a '|| lower(job) ||' with salary '|| sal ||''
from emp;

--John was hired on December 23, 2009
select ''|| ename ||' was hired on '|| to_char(hiredate, 'Month DD, YYYY') ||''
from emp;

--merge data sources
--implicit outer join = join wirhout join clause, standard in old SQL
--Every point in one set matches with every point in other set
select dept.deptno, dname, loc, empno, ename, job, sal, hiredate, mgr, comm, emp.deptno
from dept, emp;

--implicit inner join = combine records that are matching 
select dept.deptno, dname, loc, empno, ename, job, sal, hiredate, emp.deptno
from dept, emp
where dept.deptno = emp.deptno;

--explicit join - merge data using join clause
--left join
select * from dept;
insert into dept
values (50, 'MARKETING', 'AKRON');

select * from emp;

select dept.deptno, dname, loc, empno, ename, sal, emp.deptno
from dept left join emp on (dept.deptno = emp.deptno);


-- right join
select *
from dept right join emp on (dept.deptno = emp.deptno);

--inner join gives only departments that have employees and only employees that have departments
select *
from dept inner join emp on (dept.deptno = emp.deptno);

--full outer join
select *
from dept full outer join emp on (dept.deptno = emp.deptno);

--save the result of query into a table
drop table DepartmentEmployees;
create table DepartmentEmployees as
select dept.deptno, dname, loc, empno, ename, sal, hiredate
from dept inner join emp on (dept.deptno = emp.deptno);

select * from DepartmentEmployees;

--find employees in DALLAS
select ename, loc
from emp inner join dept on (emp.deptno = dept.deptno)
where loc = 'DALLAS';

select ename, loc
from dept, emp
where dept.deptno = emp.deptno and loc = 'DALLAS';

--Find all employee names and their department names regardless whether the employee has a department or not
select ename, dname
from emp left join dept on (emp.deptno = dept.deptno);

--Find all department names and their employee names regardless whether the department has employees
select dname, ename
from dept left join emp on (dept.deptno = emp.deptno);

--aggregate functions = summarize column values: sum, count, avg, median, variance, std dev, correlation
-- find total salary
select sum(sal)
from emp;

select round(variance(sal), 3)
from emp;

select count(*)
from emp;

select max(hiredate)
from emp;

select min(hiredate)
from emp;

--find correlation between salary and tenure
select corr(sal, sysdate - hiredate)
from emp;

--find # of employees in DALLAS
select count(*) 
from emp inner join dept on (dept.deptno = emp.deptno)
where loc = 'DALLAS';

--find the total number of employees and the total amount of salary
select count(*), sum(sal), stddev(sal), listagg(ename, ',') as Employees
from emp;

--Find the average salary of each department
select avg(sal), deptno
from emp
group by deptno;

select round(avg(sal),2), dname
from emp inner join dept on (dept.deptno = emp.deptno)
group by dname;

--Find the departments whose minimal salary is less than 1000
select dname
from emp inner join dept on (dept.deptno = emp.deptno)
group by dname
having min(sal) < 1000;

--Find the departments whose average salary is greater than 2000
select round(avg(sal),2), dname
from emp inner join dept on (dept.deptno = emp.deptno)
group by dname
having avg(sal) > 2000;

--Find the job categories whose average salary is greater than 2000
select round(avg(sal),2), job
from emp
group by job
having avg(sal) > 2000;

--find the job titles in sales department 
select distinct job, dname
from emp inner join dept on (dept.deptno = emp.deptno)
where dname = 'SALES';

--Find the most recent hiredate for each department
select max(hiredate), deptno
from emp
group by deptno;

--Find the most recent hiredate among those hired before 1982 for each department
select max(hiredate)
from emp
where hiredate < '01-Jan-1982'
group by deptno;

--Find the average salary of those employees whose name starts with J in each department
select avg(sal), deptno
from emp
where ename like 'J%'
group by deptno;

--Find those job categories whose maximum salary among the people hired after 1980 is more than 2500
select job
from emp
where hiredate > '31-Dec-1980'
group by job
having max(sal) > 2500
order by job desc;

--What job does Smith take?
select job, ename
from emp
where ename = 'SMITH';

--which year was smith hired?
select to_char(hiredate, 'YYYY') as HireYear, ename
from emp
where ename = 'SMITH';

--find the year the company hired 2 or more employees
select to_char(hiredate, 'YYYY') as HireYear
from emp
group by to_char(hiredate, 'YYYY')
having count(*) >= 2;

--# of employees after 1981
select count(*)
from emp
where hiredate > '31-Dec-1981';

--average salary for saleman
select avg(sal)
from emp
where job = 'SALESMAN';

select avg(sal)
from emp
group by job
having job = 'SALESMAN';

--Find total number of employees hired each month
select count(*), to_char(hiredate, 'Month')
from emp
group by to_char(hiredate, 'Month');

--Which month did the company hire the most employees
select count(*), to_char(hiredate, 'Month')
from emp
group by to_char(hiredate, 'Month')
having max(count(*));

--Find the correlation of work tenure and salary for each job
select corr(sysdate - hiredate, sal), job
from emp
group by job;

--Make an oredered list of the names of employees from each department
select listagg(ename, ', ') within group (order by ename asc)
from emp
group by deptno;

--