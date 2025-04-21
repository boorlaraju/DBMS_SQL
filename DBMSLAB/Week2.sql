user@varun-thota:~$ sudo mysql
[sudo] password for user: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 8
Server version: 8.0.35-0ubuntu0.20.04.1 (Ubuntu)

Copyright (c) 2000, 2023, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> create database week2;
Query OK, 1 row affected (0.01 sec)

mysql> use week2;
Database changed
mysql> create table Sailors(Sid integer,Sname varchar(30),rating integer ,age float);
Query OK, 0 rows affected (0.02 sec)

mysql> select * from sailors;
ERROR 1146 (42S02): Table 'week2.sailors' doesn't exist
mysql> select * from Sailors;
Empty set (0.01 sec)
mysql> 
mysql> insert into Sailors values(22,'Dustin',7,45),(29,'Brutus',1,33),(31,'Lubber',8,55.5),(32,'Andy',8.25.5),(58,'Rusty',10,35),(64,'Horatio',7,35),
mysql> ;
ERROR: 
No query specified

mysql> insert into Sailors values(22,'Dustin',7,45),
    -> (29,'Brutus',1,33),
    -> (31,'Lubber',8,55.5),
    -> (32,'Andy',8,25.5),
    -> (58,'Rusty',10,35),
    -> (64,'Horatio',7,35),
    -> (71,'Zorba',10,16),
    -> (74,'Horatio',9,40),
    -> (85,'Art',3,25.5),
    -> (95,'Bob',3,63.5);
Query OK, 10 rows affected (0.01 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql> select * from Sailors;
+------+---------+--------+------+
| Sid  | Sname   | rating | age  |
+------+---------+--------+------+
|   22 | Dustin  |      7 |   45 |
|   29 | Brutus  |      1 |   33 |
|   31 | Lubber  |      8 | 55.5 |
|   32 | Andy    |      8 | 25.5 |
|   58 | Rusty   |     10 |   35 |
|   64 | Horatio |      7 |   35 |
|   71 | Zorba   |     10 |   16 |
|   74 | Horatio |      9 |   40 |
|   85 | Art     |      3 | 25.5 |
|   95 | Bob     |      3 | 63.5 |
+------+---------+--------+------+
10 rows in set (0.00 sec)

mysql> craete table reserves(Sid integer,bid,integer,day Date);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'craete table reserves(Sid integer,bid,integer,day Date)' at line 1
mysql> create table reserves(Sid integer,bid,integer,day Date);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ',integer,day Date)' at line 1
mysql> create table reserves(Sid integer,bid integer,day Date);
Query OK, 0 rows affected (0.02 sec)

mysql> insert into reserves values(22,101,1998/10/10);
ERROR 1292 (22007): Incorrect date value: '19.980000000000000000' for column 'day' at row 1
mysql> drop table reserves;
Query OK, 0 rows affected (0.01 sec)

mysql> create table reserves(Sid integer,bid integer,day Date(20));
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '(20))' at line 1
mysql> create table reserves(Sid integer,bid integer,day Date);
Query OK, 0 rows affected (0.02 sec)

mysql> insert into reserves values(22,101,'1998/10/10');
Query OK, 1 row affected, 1 warning (0.01 sec)

mysql> select * from reserves;
+------+------+------------+
| Sid  | bid  | day        |
+------+------+------------+
|   22 |  101 | 1998-10-10 |
+------+------+------------+
1 row in set (0.00 sec)

mysql> insert into reserves values(22,102,1998-10-10);
ERROR 1292 (22007): Incorrect date value: '1978' for column 'day' at row 1
mysql> insert into reserves values(22,102,'1998/10/10');
Query OK, 1 row affected, 1 warning (0.01 sec)

mysql> select * from reserves;
+------+------+------------+
| Sid  | bid  | day        |
+------+------+------------+
|   22 |  101 | 1998-10-10 |
|   22 |  102 | 1998-10-10 |
+------+------+------------+
2 rows in set (0.00 sec)

mysql> insert into reserves values(22,103,'1998/10/08'),
    -> (22,104,'1998/10/07'),
    -> (31,102,'1998/11/10'),
    -> (31,103,'1998/,11/06'),
    -> (31,104,1998/11/12'),
    '> 
    '> ;
    '> ;
    '> (2');
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ''),

;
;
(2')' at line 5
mysql> insert into reserves values(22,103,'1998/10/08'),
    -> (22,104,'1998/10/07'),
    -> (31,102,'1998/11/10'),
    -> (31,103,'1998/,11/06'),
    -> ;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '' at line 4
mysql> insert into reserves values(22,103,'1998/10/08'),
    -> (22,104,'1998/10/07'),
    -> (31,102,'1998/11/10'),
    -> (31,103,'1998/11/06'),
    -> (31,104,'1998/11/12'),
    -> (63,101,'1998/09/05'),
    -> (64,102,'1998/09/08'),
    -> (74,103,'1998/09/08');
Query OK, 8 rows affected, 8 warnings (0.02 sec)
Records: 8  Duplicates: 0  Warnings: 8

mysql> select * from reserves;
+------+------+------------+
| Sid  | bid  | day        |
+------+------+------------+
|   22 |  101 | 1998-10-10 |
|   22 |  102 | 1998-10-10 |
|   22 |  103 | 1998-10-08 |
|   22 |  104 | 1998-10-07 |
|   31 |  102 | 1998-11-10 |
|   31 |  103 | 1998-11-06 |
|   31 |  104 | 1998-11-12 |
|   63 |  101 | 1998-09-05 |
|   64 |  102 | 1998-09-08 |
|   74 |  103 | 1998-09-08 |
+------+------+------------+
10 rows in set (0.00 sec)

mysql> update Sailors set Sid=64 where day='1998/09/05';
ERROR 1054 (42S22): Unknown column 'day' in 'where clause'
mysql> update Sailors set Sid=64 where day='1998/09/05';
ERROR 1054 (42S22): Unknown column 'day' in 'where clause'
mysql> 
mysql> clear
mysql> update reerves set Sid=64 where day=('1998/09/05');
ERROR 1146 (42S02): Table 'week2.reerves' doesn't exist
mysql> update reserves set Sid=64 where day=('1998/09/05');
Query OK, 1 row affected, 1 warning (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 1

mysql> select * from student;
ERROR 1146 (42S02): Table 'week2.student' doesn't exist
mysql> select * from reserves;
+------+------+------------+
| Sid  | bid  | day        |
+------+------+------------+
|   22 |  101 | 1998-10-10 |
|   22 |  102 | 1998-10-10 |
|   22 |  103 | 1998-10-08 |
|   22 |  104 | 1998-10-07 |
|   31 |  102 | 1998-11-10 |
|   31 |  103 | 1998-11-06 |
|   31 |  104 | 1998-11-12 |
|   64 |  101 | 1998-09-05 |
|   64 |  102 | 1998-09-08 |
|   74 |  103 | 1998-09-08 |
+------+------+------------+
10 rows in set (0.00 sec)

mysql> create table boats(bid integer,bname varchar (20),color varchar(20));
Query OK, 0 rows affected (0.02 sec)

mysql> insert into boats values(101,'Interlake','blue'),
    -> (102,'Interlake','red'),
    -> (103,'Clipper','green'),
    -> (104,'Marine','red');
Query OK, 4 rows affected (0.01 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> select * from boats;
+------+-----------+-------+
| bid  | bname     | color |
+------+-----------+-------+
|  101 | Interlake | blue  |
|  102 | Interlake | red   |
|  103 | Clipper   | green |
|  104 | Marine    | red   |
+------+-----------+-------+
4 rows in set (0.00 sec)

mysql> select * from Sailors;
+------+---------+--------+------+
| Sid  | Sname   | rating | age  |
+------+---------+--------+------+
|   22 | Dustin  |      7 |   45 |
|   29 | Brutus  |      1 |   33 |
|   31 | Lubber  |      8 | 55.5 |
|   32 | Andy    |      8 | 25.5 |
|   58 | Rusty   |     10 |   35 |
|   64 | Horatio |      7 |   35 |
|   71 | Zorba   |     10 |   16 |
|   74 | Horatio |      9 |   40 |
|   85 | Art     |      3 | 25.5 |
|   95 | Bob     |      3 | 63.5 |
+------+---------+--------+------+
10 rows in set (0.00 sec)

mysql> select * from reserves;
+------+------+------------+
| Sid  | bid  | day        |
+------+------+------------+
|   22 |  101 | 1998-10-10 |
|   22 |  102 | 1998-10-10 |
|   22 |  103 | 1998-10-08 |
|   22 |  104 | 1998-10-07 |
|   31 |  102 | 1998-11-10 |
|   31 |  103 | 1998-11-06 |
|   31 |  104 | 1998-11-12 |
|   64 |  101 | 1998-09-05 |
|   64 |  102 | 1998-09-08 |
|   74 |  103 | 1998-09-08 |
+------+------+------------+
10 rows in set (0.00 sec)

mysql> select * from boats;
+------+-----------+-------+
| bid  | bname     | color |
+------+-----------+-------+
|  101 | Interlake | blue  |
|  102 | Interlake | red   |
|  103 | Clipper   | green |
|  104 | Marine    | red   |
+------+-----------+-------+
4 rows in set (0.00 sec)

mysql> select Sname from Sailers;
ERROR 1146 (42S02): Table 'week2.Sailers' doesn't exist
mysql> select Sname from Sailors;
+---------+
| Sname   |
+---------+
| Dustin  |
| Brutus  |
| Lubber  |
| Andy    |
| Rusty   |
| Horatio |
| Zorba   |
| Horatio |
| Art     |
| Bob     |
+---------+
10 rows in set (0.00 sec)

mysql> select count(Sname) from Sailors;
+--------------+
| count(Sname) |
+--------------+
|           10 |
+--------------+
1 row in set (0.01 sec)

mysql> select color from boats;
+-------+
| color |
+-------+
| blue  |
| red   |
| green |
| red   |
+-------+
4 rows in set (0.00 sec)

mysql> select distinct(color) from boats;
+-------+
| color |
+-------+
| blue  |
| red   |
| green |
+-------+
3 rows in set (0.00 sec)

mysql> select color from boats where bname='Interlake';
+-------+
| color |
+-------+
| blue  |
| red   |
+-------+
2 rows in set (0.00 sec)

mysql> select color from boats where bname='Inter lake';
Empty set (0.00 sec)

mysql> select color from boats where bname='Interlake';
+-------+
| color |
+-------+
| blue  |
| red   |
+-------+
2 rows in set (0.00 sec)

mysql> select ratings from sailors where  age>40;
ERROR 1146 (42S02): Table 'week2.sailors' doesn't exist
mysql> select ratings from Sailors where age>40;
ERROR 1054 (42S22): Unknown column 'ratings' in 'field list'
mysql> select rating from Sailors where age>40;
+--------+
| rating |
+--------+
|      7 |
|      8 |
|      3 |
+--------+
3 rows in set (0.00 sec)

mysql> select sid,names from sailors where rating=8;
ERROR 1146 (42S02): Table 'week2.sailors' doesn't exist
mysql> select sid,Sname from sailors where rating=8;
ERROR 1146 (42S02): Table 'week2.sailors' doesn't exist
mysql> select sid,Sname from Sailors where rating=8;
+------+--------+
| sid  | Sname  |
+------+--------+
|   31 | Lubber |
|   32 | Andy   |
+------+--------+
2 rows in set (0.00 sec)

mysql> select * from Sailors order by asc(rating);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'asc(rating)' at line 1
mysql> select * from Sailors order by rating asc;
+------+---------+--------+------+
| Sid  | Sname   | rating | age  |
+------+---------+--------+------+
|   29 | Brutus  |      1 |   33 |
|   85 | Art     |      3 | 25.5 |
|   95 | Bob     |      3 | 63.5 |
|   22 | Dustin  |      7 |   45 |
|   64 | Horatio |      7 |   35 |
|   31 | Lubber  |      8 | 55.5 |
|   32 | Andy    |      8 | 25.5 |
|   74 | Horatio |      9 |   40 |
|   58 | Rusty   |     10 |   35 |
|   71 | Zorba   |     10 |   16 |
+------+---------+--------+------+
10 rows in set (0.01 sec)

mysql> select Sname from Sailors where rating=(select max(rating) from student);
ERROR 1146 (42S02): Table 'week2.student' doesn't exist
mysql> select Sname from Sailors where rating=(select max(rating) from Sailors);
+-------+
| Sname |
+-------+
| Rusty |
| Zorba |
+-------+
2 rows in set (0.00 sec)

mysql> select bid from boats where Sid =22;
ERROR 1054 (42S22): Unknown column 'Sid' in 'where clause'
mysql> select bid from boats where Sid =22;
ERROR 1054 (42S22): Unknown column 'Sid' in 'where clause'
mysql> select bid from reserves where Sid =22;
+------+
| bid  |
+------+
|  101 |
|  102 |
|  103 |
|  104 |
+------+
4 rows in set (0.00 sec)

mysql> select Sname from Sailors where 
    -> select Sname from Sailors where age=(select nax(age) from Sailors);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'select Sname from Sailors where age=(select nax(age) from Sailors)' at line 2
mysql> select Sname from Sailors where age=(select nax(age) from Sailors);
ERROR 1305 (42000): FUNCTION week2.nax does not exist
mysql> select Sname from Sailors where age=(select max(age) from Sailors);
+-------+
| Sname |
+-------+
| Bob   |
+-------+
1 row in set (0.00 sec)

mysql> select bid from boats where Sid=(select Sid from Sailors where name='Dustin');
ERROR 1054 (42S22): Unknown column 'Sid' in 'where clause'
mysql> select bid from reserves where Sid=(select Sid from Sailors where name='Dustin');
ERROR 1054 (42S22): Unknown column 'name' in 'where clause'
mysql> select bid from reserves where Sid=(select Sid from Sailors where Sname='Dustin');
+------+
| bid  |
+------+
|  101 |
|  102 |
|  103 |
|  104 |
+------+
4 rows in set (0.00 sec)

mysql> select count(bid) from reserves where Sid=22;
+------------+
| count(bid) |
+------------+
|          4 |
+------------+
1 row in set (0.00 sec)

mysql> select color from boats where Sid=(select Sid from reserves where Sid=31);
ERROR 1054 (42S22): Unknown column 'Sid' in 'where clause'
mysql> select color from boats where bid=(select Sid from reserves);
ERROR 1242 (21000): Subquery returns more than 1 row
mysql> select color from boats where bid=(select Sid in reserves);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'reserves)' at line 1
mysql> select color from boats where bid=(select bid from reserves where Sid=31);
ERROR 1242 (21000): Subquery returns more than 1 row
mysql> select color from boats where bid IN (select bid from reserves where Sid=31);
+-------+
| color |
+-------+
| red   |
| green |
| red   |
+-------+
3 rows in set (0.01 sec)

mysql> select color from boats where bid in (select bid from reserves where Sid=31);
+-------+
| color |
+-------+
| red   |
| green |
| red   |
+-------+
3 rows in set (0.00 sec)

mysql> 


