drop table students cascade constraints;
create table students (
sid number(7) not null,
major char(15) null,
FTID number(7) null,
PTID number(3) null,
constraint pk_stu primary key(sid),
constraint fk_stu_part foreign key(PTID) references parttimers,
constraint fk_stu_full foreign key(FTID) references fulltimers,
constraint chk_arc check (
(PTID is null and FTID is not null)
or
(FTID is null and PTID is not null)
)
);

drop table fulltimers cascade constraints;
create table fulltimers (
admitDate date null,
FTID number(7) not null,
constraint pk_ft primary key(FTID),
constraint chk_admitDate check (admitDate > '01-Jan-1980')
);

drop table parttimers cascade constraints;
create table parttimers (
creditAllowed number(2) null,
PTID number(3) not null,
constraint pk_pt primary key(PTID),
constraint chk_hours check (creditAllowed between 0 and 9)
);

--check your existing tables
--meta table: user_tables

--look up the structure of a table use
describe students
describe user_tables

--list the names of all your tables
select table_name from user_tables;
select table_name, tablespace_name from user_tables;

describe fulltimers

drop table courses cascade constraints;
create table courses (
cno char(8) not null,
title char(100) not null,
constraint pk_crs primary key(cno)
);

drop table classes cascade constraints;
create table classes (
sectionNo number(3) not null,
cap number(3) null,
cno char(8) not null,
constraint pk_cls primary key (cno, sectionNo),
constraint fk_cls_crs foreign key (cno) references courses
);

drop table enrollments cascade constraints;
create table enrollments (
grade char(1) null,
cno char(8) not null,
sectionNO number(3) not null,
sid number(7) not null,
constraint pk_enroll primary key (sid, cno, sectionNO),
constraint fk_enroll_cls foreign key (cno, sectionNO) references classes,
constraint fk_enroll_stu foreign key (sid) references students
);

--look for constraints
--meta tables: user_constraints, user_cons_columns

describe user_constraints

select constraint_name, constraint_type, table_name from user_constraints where table_name = 'ACCOUNTS';

--meta table: user_cons_columns

describe user_cons_columns

select constraint_name, table_name, column_name from user_cons_columns;

create table instructors (
IID number(3) not null,
lastname char(45) not null,
supervisor number(3) null,
constraint pk_ins primary key (IID),
constraint fk_ins foreign key (supervisor) references instructors
);

create table Prerequisites (
course char(8) not null,
prereq char(8) not null,
constraint pk_pre primary key (course, prereq),
constraint fk_pre_cour foreign key (course) references courses,
constraint fk_pre_pre foreign key (prereq) references courses
);

create table TeachingAssignments (
instructor number(3) not null,
sectionNO number(3) not null,
cno char(8) not null,
constraint pk_teach primary key (instructor, sectionNO, cno),
constraint fk_teach_inst foreign key (instructor) references instructors,
constraint fk_teach_class foreign key (cno, sectionNO) references classes
);


--how to change table structures
alter table tableName
add --add column and constraints
modify --change column or constraints
drop --delete columns of constraints

select table_name from user_tables;

describe enrollments
alter table enrollments add (constraint chk_grade check (grade in ('A','B','C','D','F')));

describe enrollments;

select constraint_name, table_name from user_constraints where table_name = 'ENROLLMENTS';

--add column status to enrollments
alter table enrollments add(status char(15) null);

--change column
alter table enrollments modify(status char(20));
