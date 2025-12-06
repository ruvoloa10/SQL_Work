--Find the employee who makes less than the average of the employees under the same manager
select e.ename, e.sal, e.mgr
from emp e
where e.sal < (select avg(sal) from emp where e.mgr = mgr);

desc requests;
desc responses;

--create regular index for entire column values
create index enameIndex on emp(ename);

--create index for each token inside a text
create index requestIndex on requests(text)
indextype is ctxsys.context
parameters('Sync (on commit)');

create index responseIndex on responses(text)
indextype is ctxsys.context
parameters('Sync (on commit)');


--contains('Santa loves America', 'America') > 0
--contains('Santa loves America', 'America and loves') > 0
--contains('Santa loves America', 'America or loves') > 0
--contains('Santa loves America', 'America near loves') > 0 (near means the words have to be close to each other)
--contains('Santa loves America', 'America and {and}') > 0 (Looks for America and the word and)
--contains('Santa loves America', '?Amrica and !Snta') > 0
--contains('Santa loves America', 'America and $love') > 0

--Find the responses that contain word 'unix' or 'VC++'
select id, text
from responses
where contains(text, 'unix or vc++') > 0;

--Find the responses that contains both words 'unix' and 'windows' or 'vc++'
select id, text
from responses
where contains(text, 'unix and windows or vc++') > 0;

--Find the responses which contain a variant of the word 'support' and a word as dignostics, which may be misspelled
select id, text
from responses
where contains(text, '$support and ?dignostics') > 0;

--Find the responses which contains a word that sounds like uniqs
select id, text
from responses
where contains(text, '!uniqs') > 0;

select * from emp;

--Find the top three salary earners
select ename, sal
from (select ename, sal from emp order by sal desc)
where rownum < 4;

--Find 5 most recent hires
select ename, hiredate
from (select ename, hiredate from emp order by hiredate desc)
where rownum < 6;

--OR use common table expression CTE for a query result
with t(ename, hiredate) as
(select ename, hiredate from emp order by hiredate desc)
select ename, hiredate
from t
where rownum < 6;

--Find top salary earner
select a.ename, a.sal
from emp a
where a.sal = (select max(sal) from emp);

--Find two random employees
select ename, job
from (select ename, hiredate, job from emp order by dbms_random.value)
where rownum < 3;

--Find all departments and their employees listed under each department
select d.deptno, d.dname, d.loc, 
cursor(select c.ename, c.empno, c.job from emp c where c.deptno = d.deptno)
from dept d inner join emp e on (d.deptno = e.deptno);

--Find employees who make the max in his department
select a.ename, a.sal, a.deptno
from emp a
where a.sal = (select max(sal) from emp where deptno = a.deptno);

--Find employees' commissions with ranks
select ename, comm, rank() over(order by comm desc nulls last)
from emp
order by comm desc nulls last;

--Order departments by count of employees
select deptno, count(*), rank() over (order by count(*) desc)
from emp
group by deptno;

