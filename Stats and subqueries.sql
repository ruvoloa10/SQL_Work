--Find the year the company hired 3 or more employees
select to_char(hiredate, 'YYYY')
from emp
group by to_char(hiredate, 'YYYY')
having count(*) >= 3;

--Find the job whose minimum salary is less than 1000
select job
from emp
group by job
having min(sal) < 1000;

--Find correlation between tenure and salary for each job
select corr(sal, sysdate-hiredate), job
from emp
group by job;

--President claims his company's average salary is 5000. Test this.
--Ho: mu = 5000 HA: mu != 5000
select STATS_T_TEST_ONE(sal, 5000, 'STATISTIC') as t,
STATS_T_TEST_ONE(sal, 5000, 'TWO_SIDED_SIG') as p
from emp;
--the p-value is the probability that the actual results would happen assuming the null hypothesis is true

--Are location and job independent?
select STATS_CROSSTAB(loc, job, 'CHISQ_OBS') as chi,
stats_crosstab(loc, job, 'CHISQ_SIG') as p,
stats_crosstab(loc, job, 'CRAMERS_V') as coefficient
from dept inner join emp on (dept.deptno = emp.deptno);

--Find the linear regression model to predict salary using tenure
select REGR_Intercept(sysdate - hiredate, sal) as a,
REGR_Slope(sysdate - hiredate, sal) as b,
REGR_R2(sysdate - hiredate, sal) as R2
from emp;

--Subquery is used to find unknowns in a query
--Find employees who make more than BLACK

select ename
from emp
where sal > all (select sal from emp where ename = 'BLACK');

--Find all the employees hired before SMITH
select ename
from emp
where hiredate < all (select hiredate from emp where ename = 'SMITH');

--FInd all employees who have the same job as SMITH
select ename, job
from emp
where job = (select job from emp where ename = 'SMITH');

--Find the employees who are supervised by BLAKE
select ename, mgr
from emp
where mgr = (select empno from emp where ename = 'BLAKE');

--Find the employees located in DALLAS
select ename, loc
from dept inner join emp on (dept.deptno = emp.deptno)
where loc = 'DALLAS';

select ename
from emp
where deptno in (select deptno from dept where loc = 'DALLAS');

--Find the employees who make more than all salesman
select ename
from emp
where sal > all (select sal from emp where job = 'SALESMAN');

--Find the jobs that have the maximum average salary of all the jobs
select job
from emp
group by job
having avg(sal) >= all (select avg(sal) from emp where job is not null group by job);

--Find the largest department
select deptno
from emp
group by deptno
having count(*) >= all (select count(*) from emp group by deptno);

select deptno
from emp
group by deptno
having sum(sal) >= all (select sum(sal) from emp group by deptno);

--SMITH is promoted to be a manager and his salary is going to be the smallest of current managers salary
update emp
set job = 'MANAGER', sal = (select min(sal) from emp where job = 'MANAGER')
where ename = 'SMITH';

rollback;

select * from emp;

--Lisa has the same job as Smith, the current date as hiredate, supervised by BLAKE

update emp
set job = (select job from emp where ename = 'SMITH'), hiredate = sysdate, mgr = (select empno from emp where ename = 'BLAKE')
where ename = 'LISA';


