EMPLOYEE DB;

1.display the names of the employee who are working for both productX and productY projects. 
 
mysql> select concat(fname,' ',mname,'.',lname) as ename from employee e,works_on w ,project p where w.pno=p.pnumber and p.pname='productX' and p.pname='producty';
Empty set (0.00 sec)


2.display the total no of hours worked by each employee on the project.

 mysql> select pname,concat(fname,' ',mname,'.',lname) as ename,sum(hours) from employee e,works_on w,project p where w.pno=p.pnumber and p.dnum=e.dno group by ename,pno;
+-----------------+--------------------+------------+
| pname           | ename              | sum(hours) |
+-----------------+--------------------+------------+
| ProductX        | John B.Smith       |       52.5 |
| ProductX        | Franklin T.Wong    |       52.5 |
| ProductX        | Joyce A.English    |       52.5 |
| ProductX        | Ramesh K.Narayan   |       52.5 |
| ProductY        | John B.Smith       |       37.5 |
| ProductY        | Franklin T.Wong    |       37.5 |
| ProductY        | Joyce A.English    |       37.5 |
| ProductY        | Ramesh K.Narayan   |       37.5 |
| ProductZ        | John B.Smith       |       50.0 |
| ProductZ        | Franklin T.Wong    |       50.0 |
| ProductZ        | Joyce A.English    |       50.0 |
| ProductZ        | Ramesh K.Narayan   |       50.0 |
| Computarization | Jennifer S.Wallace |       55.0 |
| Computarization | Ahmad V.Jabbar     |       55.0 |
| Computarization | Alicia J.Zelaya    |       55.0 |
| Reorganization  | James E.Borg       |       25.0 |
| Newbenefits     | Jennifer S.Wallace |       55.0 |
| Newbenefits     | Ahmad V.Jabbar     |       55.0 |
| Newbenefits     | Alicia J.Zelaya    |       55.0 |
+-----------------+--------------------+------------+
19 rows in set (0.00 sec


3.display dept_no,dept_name,mgr_name,mgr_address for each department.

mysql> select dnumber,dname,concat(fname,' ',mname,'.',lname) as mgrname,address from employee e, department d where  d.dnumber=e.dno and e.ssn=d.mgr_ssn ;
+---------+----------------+--------------------+------------------------+
| dnumber | dname          | mgrname            | address                |
+---------+----------------+--------------------+------------------------+
|       1 | Headquarters   | James E.Borg       | 450 Stone, Houston,TX  |
|       4 | Administration | Jennifer S.Wallace | 291 Berry, Bellaire,TX |
|       5 | Research       | Franklin T.Wong    | 638 Voss, Houston,TX   |
+---------+----------------+--------------------+------------------------+
3 rows in set (0.01 sec)


4.for the project located at houston display the controlling dept_no and the no of the employees working in that dept.

select Dnumber,count(Ssn),Plocation from employee e, department d ,project p where e.Dno=d.Dnumber and p.Dnum=e.Dno and p.Dnum=d.Dnumber and Plocation="Houston" group by  Pnumber;
+---------+------------+-----------+
| Dnumber | count(Ssn) | Plocation |
+---------+------------+-----------+
|       5 |          4 | Houston   |
|       1 |          1 | Houston   |
+---------+------------+-----------+
2 rows in set (0.00 sec)







SAILORS DB;

1.display the following details boat wise boat_id,no of sailors who have reserves that boat.
mysql> select bid ,count(*) from reserves group by bid;
+------+----------+
| bid  | count(*) |
+------+----------+
|  101 |        2 |
|  102 |        3 |
|  103 |        3 |
|  104 |        2 |
+------+----------+
4 rows in set (0.01 sec)


2.display name and color of boats reserved by sailor with rating 10.

mysql> select bname,color from boats where bid in(select bid from reserves where sid in(select sid from sailors where rating=10));
Empty set (0.00 sec)


3.display the rating of sailors who have reserved all the boats .

mysql> select rating from sailors where sid in(select sid from reserves group
by sid having count(*)=(select count(bid) from boats));
+--------+
| rating |
+--------+
|      7 |
+--------+
1 row in set (0.00 sec)



4.add an attribute to the sailors table address string and update the value of the address as houston for the sailors whose name starts with d.

mysql> alter table sailors add column address varchar(20);
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> update sailors set address='houston' where sname like 'd%';
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from sailors;
+-----+---------+--------+------+---------+
| sid | sname   | rating | age  | address |
+-----+---------+--------+------+---------+
|  22 | dustin  |      7 |   45 | houston |
|  29 | brutus  |      1 |   33 | NULL    |
|  31 | lubber  |      8 | 55.5 | NULL    |
|  32 | andy    |      8 | 25.5 | NULL    |
|  58 | rusty   |     10 |   35 | NULL    |
|  64 | horatio |      7 |   35 | NULL    |
|  71 | zorba   |     10 |   16 | NULL    |
|  74 | horatio |      9 |   40 | NULL    |
|  85 | art     |      3 | 25.5 | NULL    |
|  95 | bob     |      3 | 63.5 | NULL    |
+-----+---------+--------+------+---------+
10 rows in set (0.00 sec)




