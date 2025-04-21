 select r.bid ,count(r.sid) from reserves r,boats b where r.bid=b.bid group by r.bid;
+------+--------------+
| bid  | count(r.sid) |
+------+--------------+
|  101 |            2 |
|  102 |            3 |
|  103 |            3 |
|  104 |            2 |
+------+--------------+
4 rows in set (0.00 sec)

mysql> select s.sname,b.color from reserves r,boats b,sailors s where s.sid=r.sid and r.bid=b.bid and s.rating=10;
Empty set (0.00 sec)

mysql> select rating from sailors where sid in(select sid from reserves group by sid having count(bid)=(select count(bid) from boats));
+--------+
| rating |
+--------+
|      7 |
+--------+
1 row in set (0.04 sec)

mysql> alter table sailors add(Address varchar(20);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '' at line 1
mysql> alter table sailors add(Address varchar(20));
Query OK, 0 rows affected (0.03 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> select *from sailors;
+-----+---------+--------+------+---------+
| sid | sname   | rating | age  | Address |
+-----+---------+--------+------+---------+
|  22 | Dustin  |      7 |   45 | NULL    |
|  29 | Brutus  |      1 |   33 | NULL    |
|  31 | Lubber  |      8 | 55.5 | NULL    |
|  32 | Andy    |      8 | 25.5 | NULL    |
|  58 | Rusty   |     10 |   35 | NULL    |
|  64 | Horatio |      7 |   35 | NULL    |
|  71 | Zorba   |     10 |   16 | NULL    |
|  74 | Horatio |      9 |   40 | NULL    |
|  85 | Art     |      3 | 25.5 | NULL    |
|  95 | Bob     |      3 | 63.5 | NULL    |
+-----+---------+--------+------+---------+
10 rows in set (0.00 sec)

mysql> update sailors set Address='Houston'  where sname like 'D%';
Query OK, 1 row affected (0.03 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select *from sailors;
+-----+---------+--------+------+---------+
| sid | sname   | rating | age  | Address |
+-----+---------+--------+------+---------+
|  22 | Dustin  |      7 |   45 | Houston |
|  29 | Brutus  |      1 |   33 | NULL    |
|  31 | Lubber  |      8 | 55.5 | NULL    |
|  32 | Andy    |      8 | 25.5 | NULL    |
|  58 | Rusty   |     10 |   35 | NULL    |
|  64 | Horatio |      7 |   35 | NULL    |
|  71 | Zorba   |     10 |   16 | NULL    |
|  74 | Horatio |      9 |   40 | NULL    |
|  85 | Art     |      3 | 25.5 | NULL    |
|  95 | Bob     |      3 | 63.5 | NULL    |
+-----+---------+--------+------+---------+
10 rows in set (0.00 sec)

mysql> 

Employee 
select Fname,Mname,Lname from employee where Ssn in(select Essn from works_on where Pno in(select Pnumber from project where Pname='ProductX')) and Ssn in(select Essn from works_on where Pno in(select Pnumber from project where Pname='ProductY')) ;
+-------+-------+---------+
| Fname | Mname | Lname   |
+-------+-------+---------+
| John  | B     | Smith   |
| Joyce | A     | English |
+-------+-------+---------+
2 rows in set (0.00 sec)
select Essn,sum(hours) from works_on group by Essn;
+-----------+------------+
| Essn      | sum(hours) |
+-----------+------------+
| 123456789 |       40.0 |
| 333445555 |       40.0 |
| 453453453 |       40.0 |
| 666884444 |       40.0 |
| 888665555 |       NULL |
| 987654321 |       35.0 |
| 987987987 |       40.0 |
| 999887777 |       40.0 |
+-----------+------------+
8 rows in set (0.00 sec)

select Dnumber,Dname,mgr_ssn,Address from employee e,department d where d.Dnumber=e.Dno;
+---------+----------------+-----------+-------------------------+
| Dnumber | Dname          | mgr_ssn   | Address                 |
+---------+----------------+-----------+-------------------------+
|       1 | Headquarters   | 888665555 | 450 Stone, Houston,TX   |
|       4 | Administration | 987654321 | 291 Berry, Bellaire,TX  |
|       4 | Administration | 987654321 | 980 Dallas, Houston,TX  |
|       4 | Administration | 987654321 | 3321 Castle, Spring,TX  |
|       5 | Research       | 333445555 | 731 Fondren, Houston,TX |
|       5 | Research       | 333445555 | 638 Voss, Houston,TX    |
|       5 | Research       | 333445555 | 5631 Rice, Houston,TX   |
|       5 | Research       | 333445555 | 975 Fire Oak, Humble,TX |
+---------+----------------+-----------+-------------------------+
select Dname,count(*) from department d,works_on w,project p where Plocation='Houston' and  Pnumber=pno and Dnumber=Dnum  group by pno;
+--------------+----------+
| Dname        | count(*) |
+--------------+----------+
| Research     |        2 |
| Headquarters |        3 |
+--------------+----------+


