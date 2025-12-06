--tuple variables

--Find employees who make more than the average salary of those in the same job
select a.ename, a.job, a.sal
from emp a
where a.sal > (select avg(sal) from emp where job = a.job);

--Find employees who are the smallest salary earner in his or her hire year
select a.ename, a.hiredate, a.sal
from emp a
where a.sal = (select min(sal) from emp where to_char(hiredate, 'YYYY') = to_char(a.hiredate, 'YYYY'));

--Give 500 dollars to those who are the smallest salary earner in his or her hire year
update emp a
set a.sal = a.sal + 500
where a.sal = (select min(sal) from emp where to_char(hiredate, 'YYYY') = to_char(a.hiredate, 'YYYY'));

--List job title and all employees with the job as a subwindow (cursor = result set)
select a.job, cursor(select ename, sal, hiredate from emp where job = a.job)
from emp a;

--Expressions: to_char, to_date, nvl, upper, lower, decode

select job, decode(job, 'PRESIDENT', 1, 'MANAGER', 2, 'SALESMAN', 3, 4)
from emp;

--soundex() == sounds like

--Find employees whose name sounds like smis
select ename
from emp
where soundex(ename) = soundex('smis');

--Find employees whose job title sounds like 'clark'
select ename, job
from emp
where soundex(job) = soundex('clark');

--similarity search based on spelling: UTL_MATCH package in oracle
--edit_distance == the number of edits to make one word into another word

--edit distance between Steve and Stephan

select UTL_MATCH.edit_distance('steve', 'stephan')
from dual;

select utl_match.edit_distance_similarity('steve', 'stephan')
from dual;

--find employees who have similar names using edit_distance
select a.ename, b.ename
from emp a, emp b
where a.empno != b.empno and UTL_MATCH.edit_distance_similarity(a.ename, b.ename) > 40;

--Jaro_winkler() == agreement between words

select utl_match.jaro_winkler('steve', 'stephan')
from dual;

select utl_match.jaro_winkler_similarity('steve', 'stephan')
from dual;

select a.ename, b.ename
from emp a, emp b
where a.empno != b.empno and utl_match.jaro_winkler_similarity(a.ename, b.ename) > 70;

--Find possible duplicate records using ename and sal
select a.ename, a.sal, b.ename, b.sal
from emp a, emp b
where abs(a.sal - b.sal) < 50 and utl_match.jaro_winkler_similarity(a.ename, b.ename) > 70 and a.empno != b.empno;

--

