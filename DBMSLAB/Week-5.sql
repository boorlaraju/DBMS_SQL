user@varun-thota:~$ sudo mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 10
Server version: 8.0.35-0ubuntu0.20.04.1 (Ubuntu)

Copyright (c) 2000, 2023, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| demo               |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| week1              |
| week2              |
| yt                 |
+--------------------+
8 rows in set (0.00 sec)

mysql> use week2;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> select * from Sailors;
+-----+---------+--------+------+
| Sid | Sname   | rating | age  |
+-----+---------+--------+------+
|  22 | Dustin  |      7 |   45 |
|  29 | Brutus  |      1 |   33 |
|  31 | Lubber  |      8 | 55.5 |
|  32 | Andy    |      8 | 25.5 |
|  58 | Rusty   |     10 |   35 |
|  64 | Horatio |      7 |   35 |
|  71 | Zorba   |     10 |   16 |
|  74 | Horatio |      9 |   40 |
|  85 | Art     |      3 | 25.5 |
|  95 | Bob     |      3 | 63.5 |
+-----+---------+--------+------+
10 rows in set (0.00 sec)

mysql> select * from reserves;
+-----+-----+------------+
| Sid | bid | day        |
+-----+-----+------------+
|  22 | 101 | 1998-10-10 |
|  22 | 102 | 1998-10-10 |
|  22 | 103 | 1998-10-08 |
|  22 | 104 | 1998-10-07 |
|  31 | 102 | 1998-11-10 |
|  31 | 103 | 1998-11-06 |
|  31 | 104 | 1998-11-12 |
|  64 | 101 | 1998-09-05 |
|  64 | 102 | 1998-09-08 |
|  74 | 103 | 1998-09-08 |
+-----+-----+------------+
10 rows in set (0.00 sec)

mysql> select * from boats;
+-----+-----------+-------+
| bid | bname     | color |
+-----+-----------+-------+
| 101 | Interlake | blue  |
| 102 | Interlake | red   |
| 103 | Clipper   | green |
| 104 | Marine    | red   |
+-----+-----------+-------+
4 rows in set (0.00 sec)

mysql> select Sname from Sailors where Sid in(select Sid from reserves where bid=103);
+---------+
| Sname   |
+---------+
| Dustin  |
| Lubber  |
| Horatio |
+---------+
3 rows in set (0.00 sec)

mysql> select Sname from Sailors s where EXISTS (select * from reserves r where r.bid=103 and r.Sid=s.Sid);
+---------+
| Sname   |
+---------+
| Dustin  |
| Lubber  |
| Horatio |
+---------+
3 rows in set (0.00 sec)

mysql> select Sname from Sailors s where NOT  EXISTS (select * from reserves r where r.bid=103 and r.Sid=s.Sid);
+---------+
| Sname   |
+---------+
| Brutus  |
| Andy    |
| Rusty   |
| Horatio |
| Zorba   |
| Art     |
| Bob     |
+---------+
7 rows in set (0.00 sec)

mysql> select Sname from Sailors where EXISTS (select * from reserves );
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

mysql> select Sname from Sailors where Sid EXISTS(select * from reserves)
    -> ;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'EXISTS(select * from reserves)' at line 1
mysql> select Sname from Sailors s where EXISTS(select * from reserves r where s.Sid=r.s.Sid);
ERROR 1054 (42S22): Unknown column 'r.s.Sid' in 'where clause'
mysql> select Sname from Sailors s where EXISTS(select * from reserves r where s.Sid=r.Sid);
+---------+
| Sname   |
+---------+
| Dustin  |
| Lubber  |
| Horatio |
| Horatio |
+---------+
4 rows in set (0.00 sec)

mysql> select Sid from reserves group by Sid having count(*)=(select count(bid) from boats);
+-----+
| Sid |
+-----+
|  22 |
+-----+
1 row in set (0.00 sec)

mysql> select Sname from Sailors where Sid in(select Sid from reserves group by Sid having count(*)=(select count(bid) from boats));
+--------+
| Sname  |
+--------+
| Dustin |
+--------+
1 row in set (0.01 sec)

mysql> //above question is to find the Sailors name who reserved all boats;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '//above question is to find the Sailors name who reserved all boats' at line 1
mysql> 
mysql> 


