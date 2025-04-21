
create database dbms;

use dbms;

CREATE TABLE department
( Dname VARCHAR(15) NOT NULL,
Dnumber INT NOT NULL,
Mgr_ssn CHAR(9) NOT NULL,
Mgr_start_date DATE,
PRIMARY KEY (Dnumber),
UNIQUE (Dname));

CREATE TABLE employee
( Fname VARCHAR(15) NOT NULL,
Mname CHAR,
Lname VARCHAR(15) NOT NULL,
Ssn CHAR(9) NOT NULL,
Bdate DATE,
Address VARCHAR(30),
Sex CHAR,
Salary DECIMAL(10,2),
Super_ssn CHAR(9),
Dno INT NOT NULL,
PRIMARY KEY (Ssn),
FOREIGN KEY (Super_ssn) REFERENCES employee(Ssn),
FOREIGN KEY (Dno) REFERENCES department(Dnumber) );

alter table department add FOREIGN KEY (Mgr_ssn) REFERENCES employee(Ssn);

CREATE TABLE dept_locations
( Dnumber INT NOT NULL,
Dlocation VARCHAR(15) NOT NULL,
PRIMARY KEY (Dnumber, Dlocation),
FOREIGN KEY (Dnumber) REFERENCES department(Dnumber) );

CREATE TABLE project
( Pname VARCHAR(15) NOT NULL,
Pnumber INT NOT NULL,
Plocation VARCHAR(15),
Dnum INT NOT NULL,
PRIMARY KEY (Pnumber),
UNIQUE (Pname),
FOREIGN KEY (Dnum) REFERENCES department(Dnumber) );

CREATE TABLE works_on
( Essn CHAR(9) NOT NULL,
Pno INT NOT NULL,
Hours DECIMAL(3,1) NOT NULL,
PRIMARY KEY (Essn, Pno),
FOREIGN KEY (Essn) REFERENCES employee(Ssn),
FOREIGN KEY (Pno) REFERENCES project(Pnumber) );

CREATE TABLE dependent
( Essn CHAR(9) NOT NULL,
Dependent_name VARCHAR(15) NOT NULL,
Sex CHAR,
Bdate DATE,
Relationship VARCHAR(8),
PRIMARY KEY (Essn, Dependent_name),
FOREIGN KEY (Essn) REFERENCES employee(Ssn) );


alter table department modify mgr_ssn char(9) null;

insert into department(dname,dnumber) values('Research',5);
insert into department(dname,dnumber) values('Administration',4);
insert into department(dname,dnumber) values('Headquarters',1);

insert into employee(fname,mname,lname,ssn,bdate,address,sex,salary,super_ssn,dno) values('James','E','Borg','888665555','1937-11-10','450 Stone, Houston,TX','M',55000,null,1);
insert into employee(fname,mname,lname,ssn,bdate,address,sex,salary,super_ssn,dno) values('Franklin','T','Wong','333445555','1955-12-08','638 Voss, Houston,TX','F',40000,'888665555',5);
insert into employee(fname,mname,lname,ssn,bdate,address,sex,salary,super_ssn,dno) values('John','B','Smith','123456789','1965-01-09','731 Fondren, Houston,TX','M',30000,'333445555',5);
insert into employee(fname,mname,lname,ssn,bdate,address,sex,salary,super_ssn,dno) values('Jennifer','S','Wallace','987654321','1941-06-20','291 Berry, Bellaire,TX','F',43000,'888665555',4);
insert into employee(fname,mname,lname,ssn,bdate,address,sex,salary,super_ssn,dno) values('Alicia','J','Zelaya','999887777','1968-01-19','3321 Castle, Spring,TX','F',25000,'987654321',4);
insert into employee(fname,mname,lname,ssn,bdate,address,sex,salary,super_ssn,dno) values('Ramesh','K','Narayan','666884444','1962-09-15','975 Fire Oak, Humble,TX','M',38000,'333445555',5);
insert into employee(fname,mname,lname,ssn,bdate,address,sex,salary,super_ssn,dno) values('Joyce','A','English','453453453','1972-07-31','5631 Rice, Houston,TX','F',25000,'333445555',5);
insert into employee(fname,mname,lname,ssn,bdate,address,sex,salary,super_ssn,dno) values('Ahmad','V','Jabbar','987987987','1969-03-29','980 Dallas, Houston,TX','M',25000,'987654321',4);


update department set mgr_ssn='333445555', mgr_start_date='1988-05-22' where dnumber=5;
update department set mgr_ssn='987654321', mgr_start_date='1995-01-01' where dnumber=4;
update department set mgr_ssn='888665555', mgr_start_date='1981-06-19' where dnumber=1;

insert into dept_locations values(1,'Houston');
insert into dept_locations values(4,'Stafford');
insert into dept_locations values(5,'Bellaire');
insert into dept_locations values(5,'Sugarland');
insert into dept_locations values(5,'Houston');
select * from dept_locations;


insert into project values('ProductX',1,'Bellaire',5);
insert into project values('ProductY',2,'Sugarland',5);
insert into project values('ProductZ',3,'Houston',5);
insert into project values('Computarization',10,'Stafford',4);
insert into project values('Reorganization',20,'Houston',1);
insert into project values('Newbenefits',30,'Stafford',4);
select * from project;

insert into dependent values('333445555','Allice','F','1986-04-05','Daughter');
insert into dependent values('333445555','Theodore','M','1983-10-25','Son');
insert into dependent values('333445555','Joy','F','1958-05-03','Spouse');
insert into dependent values('987654321','Abner','M','1942-02-28','Spouse');
insert into dependent values('123456789','Michael','M','1988-01-04','Son');
insert into dependent values('123456789','Allice','F','1988-12-30','Daughter');
insert into dependent values('123456789','Elizabeth','F','1967-05-05','Spouse');
select * from dependent;




insert into works_on values('123456789',1,32.5);
insert into works_on values('123456789',2,7.5);
insert into works_on values('666884444',3,40.0);
insert into works_on values('453453453',1,20.0);
insert into works_on values('453453453',2,20.0);
insert into works_on values('333445555',2,10.0);
insert into works_on values('333445555',3,10.0);
insert into works_on values('333445555',10,10.0);
insert into works_on values('333445555',20,10.0);
insert into works_on values('999887777',30,30.0);
insert into works_on values('999887777',10,10.0);
insert into works_on values('987987987',10,35.0);
insert into works_on values('987987987',30,5.0);
insert into works_on values('987654321',30,20.0);
insert into works_on values('987654321',20,15.0);
alter table works_on modify hours decimal (3,1) null;
insert into works_on values('888665555',20,null);
