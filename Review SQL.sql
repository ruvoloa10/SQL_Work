--30)	List each job title along with a sub window showing employees who have the job title
select a.job, cursor(select ename from emp where a.job = job)
from emp a;

--29)	Find the rank of each job in terms of the total # of employee in the job
select job, count(*), rank() over (order by count(*) desc)
from emp
group by job;

