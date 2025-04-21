sudo mysql
[sudo] password for user: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 8
Server version: 8.0.35-0ubuntu0.22.04.1 (Ubuntu)

Copyright (c) 2000, 2023, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sailors            |
| student            |
| sys                |
+--------------------+
6 rows in set (0.01 sec)

mysql> use sailors;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> select * from sailors;
+-----+---------+--------+------+
| Sid | Sname   | Rating | Age  |
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
|  95 | Bolo    |      3 | 63.5 |
+-----+---------+--------+------+
10 rows in set (0.00 sec)

mysql> select *from reserves;
+-----+-----+------------+
| Sid | Bid | Day        |
+-----+-----+------------+
|  22 | 101 | 1999-10-10 |
|  22 | 102 | 1998-10-10 |
|  22 | 103 | 1998-10-08 |
|  22 | 104 | 1998-10-07 |
|  31 | 102 | 1998-11-10 |
|  31 | 103 | 1998-11-06 |
|  64 | 101 | 1998-09-05 |
|  64 | 102 | 1998-09-08 |
|  74 | 103 | 1998-09-08 |
+-----+-----+------------+
9 rows in set (0.00 sec)




mysql> select * from boats;
+-----+-----------+-------+
| Bid | Bname     | Color |
+-----+-----------+-------+
| 101 | Interlake | Blue  |
| 102 | Interlake | Red   |
| 103 | Interlake | Green |
| 104 | Marine    | Red   |
+-----+-----------+-------+
4 rows in set (0.00 sec)

mysql> update boats set  color='yellow' where Bid=104;
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from boats;
+-----+-----------+--------+
| Bid | Bname     | Color  |
+-----+-----------+--------+
| 101 | Interlake | Blue   |
| 102 | Interlake | Red    |
| 103 | Interlake | Green  |
| 104 | Marine    | yellow |
+-----+-----------+--------+
4 rows in set (0.00 sec)

mysql> select * Sname of sailors;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'Sname of sailors' at line 1
mysql> select * Sname from  sailors;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'Sname from  sailors' at line 1
mysql> select Sname from sailors;
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
| Bolo    |
+---------+
10 rows in set (0.00 sec)


mysql> select count(Sname) from sailors;
+--------------+
| count(Sname) |
+--------------+
|           10 |
+--------------+
1 row in set (0.00 sec)

mysql> select * color from boats;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'color from boats' at line 1
mysql> select  color from boats;
+--------+
| color  |
+--------+
| Blue   |
| Red    |
| Green  |
| yellow |
+--------+
4 rows in set (0.00 sec)


mysql> select color from boats where Bname='interlake';
+-------+
| color |
+-------+
| Blue  |
| Red   |
| Green |
+-------+
3 rows in set (0.00 sec)

mysql> select Sname from sailors where(select Bid from reserves where(select Bid from sailors where Bid='interlake'));
Empty set, 1 warning (0.00 sec)

mysql> select Sname from sailors where(select Sid from reserves where(select Bid from sailors where Bname='interlake'));
ERROR 1054 (42S22): Unknown column 'Bname' in 'where clause'
mysql> select Sname from sailors where(select Sid from reserves where(select Bid from sailors where Bid='interlake'));
Empty set, 1 warning (0.00 sec)

mysql> select Sname from sailors where age=>40;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '=>40' at line 1
mysql> select Sname, Rating from sailors where age>40;
+--------+--------+
| Sname  | Rating |
+--------+--------+
| Dustin |      7 |
| Lubber |      8 |
| Bolo   |      3 |
+--------+--------+
3 rows in set (0.00 sec)

mysql> select Sid, Sname from sailors where rating=8;
+-----+--------+
| Sid | Sname  |
+-----+--------+
|  31 | Lubber |
|  32 | Andy   |
+-----+--------+
2 rows in set (0.00 sec)

mysql> select Sid,Sname,Rating,Age from sailors where rating=orderbydesc;
ERROR 1054 (42S22): Unknown column 'orderbydesc' in 'where clause'
mysql> select Sid,Sname,Rating,Age from sailors where rating=orderby(desc);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'desc)' at line 1
mysql> select Sid,Sname,Rating,Age from sailors where rating orderby(desc);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'orderby(desc)' at line 1
mysql> select Sid,Sname,Rating,Age from sailors where Rating orderby(desc);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'orderby(desc)' at line 1
mysql> select Sid,Sname,Age from sailors where Rating orderby(desc);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'orderby(desc)' at line 1
mysql> select * from sailors where Rating orderby(desc);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'orderby(desc)' at line 1
mysql> select * from sailors where Rating orderby desc;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'orderby desc' at line 1
mysql> select * from sailors where Rating orderby asce;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'orderby asce' at line 1
mysql> select Sname from sailors ;
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
| Bolo    |
+---------+
10 rows in set (0.00 sec)

mysql> select Sname from sailors where Rating >=8;;
+---------+
| Sname   |
+---------+
| Lubber  |
| Andy    |
| Rusty   |
| Zorba   |
| Horatio |
+---------+
5 rows in set (0.00 sec)

ERROR: 
No query specified

mysql> select Sname from sailors where Rating  max;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'max' at line 1
mysql> select Sname from sailors where Rating  max();
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'max()' at line 1
mysql> select Sname from sailors where Rating = max();
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ')' at line 1
mysql> select Sname from sailors where Rating = Max();
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ')' at line 1
mysql> select Bid from boats where saiors Sid=22;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'Sid=22' at line 1
mysql> select * from sailors order by rating;
+-----+---------+--------+------+
| Sid | Sname   | Rating | Age  |
+-----+---------+--------+------+
|  29 | Brutus  |      1 |   33 |
|  85 | Art     |      3 | 25.5 |
|  95 | Bolo    |      3 | 63.5 |
|  22 | Dustin  |      7 |   45 |
|  64 | Horatio |      7 |   35 |
|  31 | Lubber  |      8 | 55.5 |
|  32 | Andy    |      8 | 25.5 |
|  74 | Horatio |      9 |   40 |
|  58 | Rusty   |     10 |   35 |
|  71 | Zorba   |     10 |   16 |
+-----+---------+--------+------+
10 rows in set (0.00 sec)

mysql> select * from sailors order by rating desc;
+-----+---------+--------+------+
| Sid | Sname   | Rating | Age  |
+-----+---------+--------+------+
|  58 | Rusty   |     10 |   35 |
|  71 | Zorba   |     10 |   16 |
|  74 | Horatio |      9 |   40 |
|  31 | Lubber  |      8 | 55.5 |
|  32 | Andy    |      8 | 25.5 |
|  22 | Dustin  |      7 |   45 |
|  64 | Horatio |      7 |   35 |
|  85 | Art     |      3 | 25.5 |
|  95 | Bolo    |      3 | 63.5 |
|  29 | Brutus  |      1 |   33 |
+-----+---------+--------+------+
10 rows in set (0.00 sec)

mysql> select Bid from boats where Sid=22;
ERROR 1054 (42S22): Unknown column 'Sid' in 'where clause'
mysql> select Bid from reserves where Sid=22;
+-----+
| Bid |
+-----+
| 101 |
| 102 |
| 103 |
| 104 |
+-----+
4 rows in set (0.00 sec)

mysql> select Bid from reserves where Sname='dustin';
ERROR 1054 (42S22): Unknown column 'Sname' in 'where clause'
mysql> select Bid from reserves where (select Sid from sailors where Sname='dustin');
+-----+
| Bid |
+-----+
| 101 |
| 101 |
| 102 |
| 102 |
| 102 |
| 103 |
| 103 |
| 103 |
| 104 |
+-----+
9 rows in set (0.01 sec)




