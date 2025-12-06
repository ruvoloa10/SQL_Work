--Part 1
create table parts (
PartNo number(12) not null,
Description char(100) null,
Quantity number(5) not null,
UnitPrice number(5,2) not null,
constraint pk_parts primary key (PartNo)
);

create table inventories (
BINNO number(12) not null,
Capacity number(10) not null,
Location char(20) not null,
PartNo number(12) not null,
constraint pk_invent primary key (BINNO),
constraint fk_invent_parts foreign key (PartNo) references parts
);

create table departments (
Name char(20) not null,
Phone char(12) not null,
Contact char(50) null,
Account char(20) not null,
Balance number(10, 2) not null,
constraint pk_depart primary key (Name)
);

--junction table
create table classifications (
Department char(20) not null,
Part number(12) not null,
constraint pk_class primary key (Department, Part),
constraint fk_class_depart foreign key (Department) references departments,
constraint fk_class_parts foreign key (Part) references parts
);

create table suppliers (
Name char(45) not null,
Address char(100) not null,
City char(40) not null,
State char(2) not null,
Zip number(5) not null,
Phone char(12) not null,
constraint pk_supp primary key (Name)
);

--junction table
create table vendorproducts (
Supplier char(45) not null,
Part number(12) not null,
constraint pk_vend primary key (Supplier, Part),
constraint fk_vend_supp foreign key (Supplier) references suppliers,
constraint fk_vend_part foreign key (Part) references parts
);

--Part 3
--SQL Question 1
alter table departments add (constraint bal_check check (balance > 0));

--SQL Question 2
alter table inventories add (lockNo number(3) null);
alter table inventories add (passcode number(3) null);

--SQL Question 3
alter table inventories add (constraint location_check check (location in ('Cabin A', 'North Warehouse', 'Front Room')));

--SQL Question 4
alter table inventories add (AccessTime timestamp with time zone null);
