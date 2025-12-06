drop table customers cascade constraints;
create table customers (
cid number(8) not null,
clname char(45) null,
state char(2) not null,
constraint pk_cust primary key (cid)
);

drop table accounts cascade constraints;
create table accounts (
acctno number(12) not null,
balance number(10, 2) null,
opendate date not null,
constraint pk_acct primary key (acctno)
);

drop table transactions cascade constraints;
create table transactions (
tid number(12) not null,
tdate date not null,
type char(10) not null,
accountNO number(12) not null,
constraint pk_tran primary key (tid),
constraint fk_tran_acct foreign key (accountNO) references accounts
);

drop table employees cascade constraints;
create table employees (
eid number(12) not null,
elname char(45) not null,
job char(20) null,
constraint pk_emp primary key (eid)
);

drop table customerlines cascade constraints;
create table customerlines (
customerID number(8) not null,
accountNO number(12) not null,
constraint pk_cl primary key (customerID, accountNO),
constraint fk_cl_cust foreign key (customerID) references customers,
constraint fk_cl_acct foreign key (accountNO) references accounts
);

drop table transactionlines cascade constraints;
create table transactionlines (
transactionID number(12) not null,
employeeID number(12) not null,
constraint pk_tl primary key (transactionID, employeeID),
constraint fk_tl_tran foreign key (transactionID) references transactions,
constraint fk_tl_emp foreign key (employeeID) references employees
);


