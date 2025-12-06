-- create HELP Desk database

--delete existing tables
drop table responses;
drop table requests;

--create REQUESTS table
create table requests(
ID number(4) primary key,
Text varchar2(800) not null,
Priority number(1) not null check (priority in (1,2,3,4)),
Authorized char(1) default 'N' check (Authorized in ('Y','N')));

--create RESPONSES table
create table responses(
ID number(4) primary key,
Text varchar2(800) not null,
CreatedBY varchar2(30) not null,
DateCreated Date not null,
ModifiedBy varchar2(30),
DateModified Date,
RequestID number(4) not null,
foreign key (RequestID) references requests);

--insert sample data

insert into requests (ID, TEXT, Priority, Authorized)
values (1001,'Visual C++ 6 Professional does not compile my code ported from UNIX', 2,'Y');

insert into requests (ID, TEXT, Priority, Authorized)
values (1002,'MS Excel functions are not working', 1,'N');

insert into requests (ID, TEXT, Priority, Authorized)
values (1005,'My Oracle Form is not loading', 1,'Y');

insert into responses (ID, text, CreatedBy, DateCreated, RequestID)
values (0234, 'The library <stdio.h> is not supported by VC++ by default. You may consider to use <streamio.h> instead', 'John Hacker', to_date('10-Dec-1998','dd-Mon-yyyy'),1001);

insert into responses (ID, text, CreatedBy, DateCreated,RequestID)
values (0236, 'variable types are different between Unix and windows', 'Smith Hacker Jr.', to_date('12-Dec-1998','dd-Mon-yyyy'),1001);

insert into responses (ID, text, CreatedBy, DateCreated, RequestID)
values (0235, 'Make sure you enable macros when opening the excel sheet', 'John Hacker', to_date('10-Dec-1998','dd-Mon-yyyy'),1002);

insert into responses (ID, text, CreatedBy, DateCreated,RequestID)
values (0237, 'Check if JVM is working. Then reintall Forms runtime, which you may download from Oracle.com', 'Smith Hacker Jr.', to_date('12-Dec-1998','dd-Mon-yyyy'),1005);

insert into responses (ID, text, CreatedBy, DateCreated, RequestID)
values (0239, 'Check if you are using correct compiler. cpp is for C++ while gcc is for traditional C', 'John Hacker', to_date('10-Dec-1998','dd-Mon-yyyy'),1001);

insert into responses (ID, text, CreatedBy, DateCreated,RequestID)
values (0223, 'You need to check file paths and change them if necessary', 'Smith Hacker Jr.', to_date('12-Dec-1998','dd-Mon-yyyy'),1001);

insert into responses (ID, text, CreatedBy, DateCreated, RequestID)
values (0289, 'The library <stdio.h> is no longer supported by VC++. You may consider to use <streamio.h> instead', 'John Hacker', to_date('10-Dec-1998','dd-Mon-yyyy'),1005);

insert into responses (ID, text, CreatedBy, DateCreated,RequestID)
values (0298, 'Oracle Forms 10g appears not working for Windows 7 and up', 'Smith Hacker Jr.', to_date('12-Dec-1998','dd-Mon-yyyy'),1005);
