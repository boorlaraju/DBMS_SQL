

create database UniversityDB;

use UniversityDB;

create table department (dept_name varchar(20), building varchar(6), budget int, primary key (dept_name));

insert into department values('Physics','AB-I',100000);

insert into department values('Computer Science','AB-II',150000);

insert into department values('Maths','AB-III',80000);

select * from department;

create table instructor 
( id int primary key,
name varchar(10) ,
dept_name varchar(20) ,
salary int,
foreign key (dept_name) references department(dept_name) );



insert into instructor values(22222,'Einstein','Physics',95000);

insert into instructor values(33333,'Korth','Computer Science',75000);


insert into instructor values(45454 ,'Mozart','Maths',60000);


insert into instructor values(55555,'Navathe','Computer Science',100000);

select * from instructor;




create table student 
(id int primary key,
name varchar(10) ,
dept_name varchar(20),
tot_cred int ,
foreign key (dept_name) references department(dept_name) );


insert into student values(1000,'Kshitiz','Computer Science',80);


insert into student values(1001,'Mike','Computer Science',70);


insert into student values(2000,'Virtuos','Maths',60);

select * from student;


create table course( course_id varchar(7) primary key, title varchar(10),dept_name varchar(20),credits int,foreign key (dept_name) references department(dept_name));



insert into course values('CS-2201','DBMS','Computer Science',4);

insert into course values('CS-3201','OS','Computer Science',4);


insert into course values('MA-201','PS','Maths',3);

insert into course values('PH-101','Physics-1','Physics',3);

select * from course;


create table classroom( building varchar(5), room_no int ,capacity int,primary key(building,room_no));




insert into classroom values('AB-II',112,100);


insert into classroom values('AB-I',111,80);


insert into classroom values('AB-II',101,70);


select * from classroom;


create table section( course_id varchar(7),sec_id varchar(7),semester int,year char(2),building varchar(5),room_no int,primary key(course_id,sec_id,semester,year),foreign key (building,room_no) references
 classroom(building,room_no));


insert into section values('CS-2201','CS-21',1,'E2','AB-II',112);


insert into section values('PH-101','PUC-11',1,'P1','AB-I',111);


insert into section values('MA-201','CS-21',1,'E2','AB-II',112);


insert into section values('CS-3201','CS-31',1,'E3','AB-II',101);


select * from section;


create table teaches( id int, course_id varchar(7),sec_id varchar(7),semester int,year char(2),foreign key (id) references instructor(id),foreign key(course_id,sec_id,semester,year) references section(course_id,sec_id,semester,year),primary key(id,course_id,sec_id,semester,year));


insert into teaches values(22222,'CS-2201','CS-21',1,'E2');


insert into teaches values(22222,'CS-3201','CS-31',1,'E3');



insert into teaches values(45454,'MA-201','CS-21',1,'E2');

select * from teaches;



create table takes( id int, course_id varchar(7),sec_id varchar(7),semester int,year char(2),grade char,foreign key (id) references student(id),foreign key(course_id,sec_id,semester,year) references section(course_id,sec_id,semester,year),primary key(id,course_id,sec_id,semester,year));


insert into takes values(1000,'CS-2201','CS-21',1,'E2','A');


insert into takes values(1001,'CS-3201','CS-31',1,'E3','A');


insert into takes values(1000,'MA-201','CS-21',1,'E2','B');


insert into takes values(1001,'CS-2201','CS-21',1,'E2','A');

select * from takes;



