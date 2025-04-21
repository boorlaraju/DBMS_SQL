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

mysql> show databases
    -> -;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '-' at line 2
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
6 rows in set (0.00 sec)

mysql> use sailors;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> select * sailors;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'sailors' at line 1
mysql> show tables;
+-------------------+
| Tables_in_sailors |
+-------------------+
| boats             |
| reserves          |
| sailors           |
+-------------------+
3 rows in set (0.01 sec)

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
10 rows in set (0.01 sec)

mysql> select  min(age) from sailors;
+----------+
| min(age) |
+----------+
|       16 |
+----------+
1 row in set (0.01 sec)

mysql> select Sname from sailors min(age from sailors);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'min(age from sailors)' at line 1
mysql> select Sname from sailors min(age) from sailors;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'min(age) from sailors' at line 1
mysql> select Sname ,min(age) from sailors ;
ERROR 1140 (42000): In aggregated query without GROUP BY, expression #1 of SELECT list contains nonaggregated column 'sailors.sailors.Sname'; this is incompatible with sql_mode=only_full_group_by
mysql> select Sname ,min(age) from sailors group by Sname;
+---------+----------+
| Sname   | min(age) |
+---------+----------+
| Dustin  |       45 |
| Brutus  |       33 |
| Lubber  |     55.5 |
| Andy    |     25.5 |
| Rusty   |       35 |
| Horatio |       35 |
| Zorba   |       16 |
| Art     |     25.5 |
| Bolo    |     63.5 |
+---------+----------+
9 rows in set (0.01 sec)

mysql> select rating ,min(age) from sailors group by rating;
+--------+----------+
| rating | min(age) |
+--------+----------+
|      7 |       35 |
|      1 |       33 |
|      8 |     25.5 |
|     10 |       16 |
|      9 |       40 |
|      3 |     25.5 |
+--------+----------+
6 rows in set (0.00 sec)

mysql> select rating ,count(*) from sailors group by rating;
+--------+----------+
| rating | count(*) |
+--------+----------+
|      7 |        2 |
|      1 |        1 |
|      8 |        2 |
|     10 |        2 |
|      9 |        1 |
|      3 |        2 |
+--------+----------+
6 rows in set (0.00 sec)

mysql> select Sname from sailors where age=(select min(age) from sailors);
+-------+
| Sname |
+-------+
| Zorba |
+-------+
1 row in set (0.00 sec)

mysql> select Sname,Age from sailors where age=(select min(age) from sailors);
+-------+------+
| Sname | Age  |
+-------+------+
| Zorba |   16 |
+-------+------+
1 row in set (0.00 sec)

mysql> select Sname from sailors where rating >Horatio;
ERROR 1054 (42S22): Unknown column 'Horatio' in 'where clause'
mysql> select Sname from sailors where rating >All (Horatio);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'Horatio)' at line 1
mysql> select Sname from sailors where Rating >All (Horatio);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'Horatio)' at line 1
mysql> select Sname from sailors where Rating >ANy (Horatio);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'Horatio)' at line 1
mysql> select Sname from sailors where Rating >any (select rating from sailors where Sname ='Horatio');
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

mysql> select Sname from sailors where >any (select age from sailors where Rating=10);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '>any (select age from sailors where Rating=10)' at line 1
mysql> select Sname from sailors where >any (select max(age) from sailors where Rating=10);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '>any (select max(age) from sailors where Rating=10)' at line 1
mysql> select Sname from sailors where age >any (select max(age) from sailors where Rating=10);
+---------+
| Sname   |
+---------+
| Dustin  |
| Lubber  |
| Horatio |
| Bolo    |
+---------+
4 rows in set (0.00 sec)

mysql> select Sname from sailors where Rating >all (select rating from sailors where Sname ='Horatio');
+-------+
| Sname |
+-------+
| Rusty |
| Zorba |
+-------+
2 rows in set (0.00 sec)

mysql> select count(*) from boats;
+----------+
| count(*) |
+----------+
|        4 |
+----------+
1 row in set (0.01 sec)

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

mysql> select * from reserves;
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
9 rows in set (0.01 sec)

mysql> select count(color) from boats;
+--------------+
| count(color) |
+--------------+
|            4 |
+--------------+
1 row in set (0.00 sec)

mysql> select count(*) from boats group by color;
+----------+
| count(*) |
+----------+
|        1 |
|        1 |
|        1 |
|        1 |
+----------+
4 rows in set (0.00 sec)

mysql> select count(*) from boats group by sailors;
ERROR 1054 (42S22): Unknown column 'sailors' in 'group statement'
mysql> select count(*) from reserves group by sailors;
ERROR 1054 (42S22): Unknown column 'sailors' in 'group statement'
mysql> select count(*) from reserves group by reserves;
ERROR 1054 (42S22): Unknown column 'reserves' in 'group statement'
mysql> select count(*) from boats group by reserves;
ERROR 1054 (42S22): Unknown column 'reserves' in 'group statement'
mysql> select Sid, count(Bid)from reserves  group by Sid;
+-----+------------+
| Sid | count(Bid) |
+-----+------------+
|  22 |          4 |
|  31 |          2 |
|  64 |          2 |
|  74 |          1 |
+-----+------------+
4 rows in set (0.00 sec)

mysql> select Sid,Sname from sailors where Bid=103;
ERROR 1054 (42S22): Unknown column 'Bid' in 'where clause'
mysql> select Sid, from reserves  where Bid=103;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'from reserves  where Bid=103' at line 1
mysql> select Sid, from reserves  where Bid='103';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'from reserves  where Bid='103'' at line 1
mysql> select Sid from reserves  where Bid='103';
+-----+
| Sid |
+-----+
|  22 |
|  31 |
|  74 |
+-----+
3 rows in set (0.00 sec)

mysql> select Sname.Sid from reserves  where Bid='103';
ERROR 1054 (42S22): Unknown column 'Sname.Sid' in 'field list'
mysql> select Sname,Sid from reserves  where Bid='103';
ERROR 1054 (42S22): Unknown column 'Sname' in 'field list'
mysql> select Sname from sailors  where Bid='103';
ERROR 1054 (42S22): Unknown column 'Bid' in 'where clause'
mysql> select Sname from sailors  where Sid(select Sid from reserves where Bid=103);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'select Sid from reserves where Bid=103)' at line 1
mysql> select Sname from sailors  where(select Sid from reserves where Bid=103);
ERROR 1242 (21000): Subquery returns more than 1 row
mysql> select Sname from sailors  where(select Sid from reserves where Bid='103');
ERROR 1242 (21000): Subquery returns more than 1 row
mysql> select Sname from sailors  where Sid(select Sid from reserves where Bid='103');
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'select Sid from reserves where Bid='103')' at line 1
mysql> select Sname from sailors  where (select Sid from reserves where Bid='103');
ERROR 1242 (21000): Subquery returns more than 1 row
mysql> select Sid from reserves where color='Red';
ERROR 1054 (42S22): Unknown column 'color' in 'where clause'
mysql> select Sid from reserves where Color='Red';
ERROR 1054 (42S22): Unknown column 'Color' in 'where clause'
mysql> select Sid from reserves where Bid='102';
+-----+
| Sid |
+-----+
|  22 |
|  31 |
|  64 |
+-----+
3 rows in set (0.00 sec)

mysql> select Sid from reserves where Bid in (select Bid from boats where color='Red');
+-----+
| Sid |
+-----+
|  22 |
|  31 |
|  64 |
+-----+
3 rows in set (0.00 sec)

mysql> select Sname from sailors  where Sid in(select Sid from reserves where Bid='103');
+---------+
| Sname   |
+---------+
| Dustin  |
| Lubber  |
| Horatio |
+---------+
3 rows in set (0.00 sec)

mysql> select Sname from sailors where Bid in(select Bid from boats where color=Red);
ERROR 1054 (42S22): Unknown column 'Bid' in 'IN/ALL/ANY subquery'
mysql> select Sname from sailors where Bid in(select Bid from reserves where color=Red);
ERROR 1054 (42S22): Unknown column 'Bid' in 'IN/ALL/ANY subquery'
mysql> select Sname from sailors where Bid in(select Bid from reserves where Color=Red);
ERROR 1054 (42S22): Unknown column 'Bid' in 'IN/ALL/ANY subquery'
mysql> select Sname from sailors where Sid in(select Sid from reserves where Color=Red);
ERROR 1054 (42S22): Unknown column 'Color' in 'where clause'
mysql> select Sname from sailors where Sid in(select Sid from reserves where Color='Red');
ERROR 1054 (42S22): Unknown column 'Color' in 'where clause'
mysql> select Sname from sailors where Sid in (select Sid from reserves  where Bid in(select Bid from boats where Color=Red));
ERROR 1054 (42S22): Unknown column 'Red' in 'where clause'
mysql> select Sname from sailors where Sid in (select Sid from reserves  where Bid in(select Bid from boats where Color='Red'));
+---------+
| Sname   |
+---------+
| Dustin  |
| Lubber  |
| Horatio |
+---------+
3 rows in set (0.01 sec)

mysql> select Sname from sailors where Sid in (select Sid from reserves  where Bid is not null);
+---------+
| Sname   |
+---------+
| Dustin  |
| Lubber  |
| Horatio |
| Horatio |
+---------+
4 rows in set (0.00 sec)

mysql> select Sname from sailors where Sid in (select Sid from reserves  where Bid is  null);
Empty set (0.00 sec)

mysql> select Sname from sailors where Sid not in  (select Sid from reserves  where Bid is not  null);
+--------+
| Sname  |
+--------+
| Brutus |
| Andy   |
| Rusty  |
| Zorba  |
| Art    |
| Bolo   |
+--------+
6 rows in set (0.00 sec)

mysql> select Sname from sailors where Age in(select Age from reserves where Age<50 in(select Age from boats where color='Green'));
Empty set (0.00 sec)

mysql> select Sname from sailors where Age in(select Age from reserves where Age<50 in(select Bid from boats where color='Green'));
Empty set (0.00 sec)

mysql> select Sname from sailors where Age<50 in(select Age from reserves where Bid in(select Bid from boats where color='Green'));
Empty set (0.00 sec)

mysql> select Sname from sailors where Age<50 in(select Age from reserves where Bid in(select Bid from boats where Color='Green'));
Empty set (0.00 sec)

mysql> select Sname from sailors where Age<50 in(select Sid from reserves where Bid in(select Bid from boats where Color='Green'));
Empty set (0.00 sec)

mysql> select Sname from sailors where Age<50 and Sid in(select Sid from reserves where Bid in(select Bid from boats where Color='Green'));
+---------+
| Sname   |
+---------+
| Dustin  |
| Horatio |
+---------+
2 rows in set (0.01 sec)

mysql> select Color from boats where Bid in(select Bid from reserves where Sid in(select Sid from boats where Sname='lubber'));
ERROR 1054 (42S22): Unknown column 'Sname' in 'where clause'
mysql> select Color from boats where Bid in(select Bid from reserves where Sid in(select Sid from sailors where Sname='lubber'));
+-------+
| Color |
+-------+
| Red   |
| Green |
+-------+
2 rows in set (0.00 sec)

mysql> select Color from boats where Bid not in(select Bid from reserves where Sid in(select Sid from boats where Sname='lubber'));
ERROR 1054 (42S22): Unknown column 'Sname' in 'where clause'
mysql> select Bid from boats where Bid not in(select Bid from reserves where Sid in(select Sid from boats where Sname='lubber'));
ERROR 1054 (42S22): Unknown column 'Sname' in 'where clause'
mysql> select Bid from boats where Bid not in(select Bid from reserves where Sid in(select Sid from sailors where Sname='lubber'));
+-----+
| Bid |
+-----+
| 101 |
| 104 |
+-----+
2 rows in set (0.00 sec)

mysql> select color from boats where Bid not in(select Bid from reserves where Sid in(select Sid from sailors where Sname='lubber'));
+--------+
| color  |
+--------+
| Blue   |
| yellow |
+--------+
2 rows in set (0.00 sec)

mysql> select Bid from boats where Bid not in(select Bid from reserves where Sid in(select Sid from sailors where Sname='lubber'));
+-----+
| Bid |
+-----+
| 101 |
| 104 |
+-----+
2 rows in set (0.00 sec)

mysql> ^C
mysql> select * from sailors,reserves;
+-----+---------+--------+------+-----+-----+------------+
| Sid | Sname   | Rating | Age  | Sid | Bid | Day        |
+-----+---------+--------+------+-----+-----+------------+
|  22 | Dustin  |      7 |   45 |  74 | 103 | 1998-09-08 |
|  22 | Dustin  |      7 |   45 |  64 | 102 | 1998-09-08 |
|  22 | Dustin  |      7 |   45 |  64 | 101 | 1998-09-05 |
|  22 | Dustin  |      7 |   45 |  31 | 103 | 1998-11-06 |
|  22 | Dustin  |      7 |   45 |  31 | 102 | 1998-11-10 |
|  22 | Dustin  |      7 |   45 |  22 | 104 | 1998-10-07 |
|  22 | Dustin  |      7 |   45 |  22 | 103 | 1998-10-08 |
|  22 | Dustin  |      7 |   45 |  22 | 102 | 1998-10-10 |
|  22 | Dustin  |      7 |   45 |  22 | 101 | 1999-10-10 |
|  29 | Brutus  |      1 |   33 |  74 | 103 | 1998-09-08 |
|  29 | Brutus  |      1 |   33 |  64 | 102 | 1998-09-08 |
|  29 | Brutus  |      1 |   33 |  64 | 101 | 1998-09-05 |
|  29 | Brutus  |      1 |   33 |  31 | 103 | 1998-11-06 |
|  29 | Brutus  |      1 |   33 |  31 | 102 | 1998-11-10 |
|  29 | Brutus  |      1 |   33 |  22 | 104 | 1998-10-07 |
|  29 | Brutus  |      1 |   33 |  22 | 103 | 1998-10-08 |
|  29 | Brutus  |      1 |   33 |  22 | 102 | 1998-10-10 |
|  29 | Brutus  |      1 |   33 |  22 | 101 | 1999-10-10 |
|  31 | Lubber  |      8 | 55.5 |  74 | 103 | 1998-09-08 |
|  31 | Lubber  |      8 | 55.5 |  64 | 102 | 1998-09-08 |
|  31 | Lubber  |      8 | 55.5 |  64 | 101 | 1998-09-05 |
|  31 | Lubber  |      8 | 55.5 |  31 | 103 | 1998-11-06 |
|  31 | Lubber  |      8 | 55.5 |  31 | 102 | 1998-11-10 |
|  31 | Lubber  |      8 | 55.5 |  22 | 104 | 1998-10-07 |
|  31 | Lubber  |      8 | 55.5 |  22 | 103 | 1998-10-08 |
|  31 | Lubber  |      8 | 55.5 |  22 | 102 | 1998-10-10 |
|  31 | Lubber  |      8 | 55.5 |  22 | 101 | 1999-10-10 |
|  32 | Andy    |      8 | 25.5 |  74 | 103 | 1998-09-08 |
|  32 | Andy    |      8 | 25.5 |  64 | 102 | 1998-09-08 |
|  32 | Andy    |      8 | 25.5 |  64 | 101 | 1998-09-05 |
|  32 | Andy    |      8 | 25.5 |  31 | 103 | 1998-11-06 |
|  32 | Andy    |      8 | 25.5 |  31 | 102 | 1998-11-10 |
|  32 | Andy    |      8 | 25.5 |  22 | 104 | 1998-10-07 |
|  32 | Andy    |      8 | 25.5 |  22 | 103 | 1998-10-08 |
|  32 | Andy    |      8 | 25.5 |  22 | 102 | 1998-10-10 |
|  32 | Andy    |      8 | 25.5 |  22 | 101 | 1999-10-10 |
|  58 | Rusty   |     10 |   35 |  74 | 103 | 1998-09-08 |
|  58 | Rusty   |     10 |   35 |  64 | 102 | 1998-09-08 |
|  58 | Rusty   |     10 |   35 |  64 | 101 | 1998-09-05 |
|  58 | Rusty   |     10 |   35 |  31 | 103 | 1998-11-06 |
|  58 | Rusty   |     10 |   35 |  31 | 102 | 1998-11-10 |
|  58 | Rusty   |     10 |   35 |  22 | 104 | 1998-10-07 |
|  58 | Rusty   |     10 |   35 |  22 | 103 | 1998-10-08 |
|  58 | Rusty   |     10 |   35 |  22 | 102 | 1998-10-10 |
|  58 | Rusty   |     10 |   35 |  22 | 101 | 1999-10-10 |
|  64 | Horatio |      7 |   35 |  74 | 103 | 1998-09-08 |
|  64 | Horatio |      7 |   35 |  64 | 102 | 1998-09-08 |
|  64 | Horatio |      7 |   35 |  64 | 101 | 1998-09-05 |
|  64 | Horatio |      7 |   35 |  31 | 103 | 1998-11-06 |
|  64 | Horatio |      7 |   35 |  31 | 102 | 1998-11-10 |
|  64 | Horatio |      7 |   35 |  22 | 104 | 1998-10-07 |
|  64 | Horatio |      7 |   35 |  22 | 103 | 1998-10-08 |
|  64 | Horatio |      7 |   35 |  22 | 102 | 1998-10-10 |
|  64 | Horatio |      7 |   35 |  22 | 101 | 1999-10-10 |
|  71 | Zorba   |     10 |   16 |  74 | 103 | 1998-09-08 |
|  71 | Zorba   |     10 |   16 |  64 | 102 | 1998-09-08 |
|  71 | Zorba   |     10 |   16 |  64 | 101 | 1998-09-05 |
|  71 | Zorba   |     10 |   16 |  31 | 103 | 1998-11-06 |
|  71 | Zorba   |     10 |   16 |  31 | 102 | 1998-11-10 |
|  71 | Zorba   |     10 |   16 |  22 | 104 | 1998-10-07 |
|  71 | Zorba   |     10 |   16 |  22 | 103 | 1998-10-08 |
|  71 | Zorba   |     10 |   16 |  22 | 102 | 1998-10-10 |
|  71 | Zorba   |     10 |   16 |  22 | 101 | 1999-10-10 |
|  74 | Horatio |      9 |   40 |  74 | 103 | 1998-09-08 |
|  74 | Horatio |      9 |   40 |  64 | 102 | 1998-09-08 |
|  74 | Horatio |      9 |   40 |  64 | 101 | 1998-09-05 |
|  74 | Horatio |      9 |   40 |  31 | 103 | 1998-11-06 |
|  74 | Horatio |      9 |   40 |  31 | 102 | 1998-11-10 |
|  74 | Horatio |      9 |   40 |  22 | 104 | 1998-10-07 |
|  74 | Horatio |      9 |   40 |  22 | 103 | 1998-10-08 |
|  74 | Horatio |      9 |   40 |  22 | 102 | 1998-10-10 |
|  74 | Horatio |      9 |   40 |  22 | 101 | 1999-10-10 |
|  85 | Art     |      3 | 25.5 |  74 | 103 | 1998-09-08 |
|  85 | Art     |      3 | 25.5 |  64 | 102 | 1998-09-08 |
|  85 | Art     |      3 | 25.5 |  64 | 101 | 1998-09-05 |
|  85 | Art     |      3 | 25.5 |  31 | 103 | 1998-11-06 |
|  85 | Art     |      3 | 25.5 |  31 | 102 | 1998-11-10 |
|  85 | Art     |      3 | 25.5 |  22 | 104 | 1998-10-07 |
|  85 | Art     |      3 | 25.5 |  22 | 103 | 1998-10-08 |
|  85 | Art     |      3 | 25.5 |  22 | 102 | 1998-10-10 |
|  85 | Art     |      3 | 25.5 |  22 | 101 | 1999-10-10 |
|  95 | Bolo    |      3 | 63.5 |  74 | 103 | 1998-09-08 |
|  95 | Bolo    |      3 | 63.5 |  64 | 102 | 1998-09-08 |
|  95 | Bolo    |      3 | 63.5 |  64 | 101 | 1998-09-05 |
|  95 | Bolo    |      3 | 63.5 |  31 | 103 | 1998-11-06 |
|  95 | Bolo    |      3 | 63.5 |  31 | 102 | 1998-11-10 |
|  95 | Bolo    |      3 | 63.5 |  22 | 104 | 1998-10-07 |
|  95 | Bolo    |      3 | 63.5 |  22 | 103 | 1998-10-08 |
|  95 | Bolo    |      3 | 63.5 |  22 | 102 | 1998-10-10 |
|  95 | Bolo    |      3 | 63.5 |  22 | 101 | 1999-10-10 |
+-----+---------+--------+------+-----+-----+------------+
90 rows in set (0.00 sec)

mysql> select * from sailors,reserves,boats;
+-----+---------+--------+------+-----+-----+------------+-----+-----------+--------+
| Sid | Sname   | Rating | Age  | Sid | Bid | Day        | Bid | Bname     | Color  |
+-----+---------+--------+------+-----+-----+------------+-----+-----------+--------+
|  22 | Dustin  |      7 |   45 |  74 | 103 | 1998-09-08 | 101 | Interlake | Blue   |
|  22 | Dustin  |      7 |   45 |  74 | 103 | 1998-09-08 | 102 | Interlake | Red    |
|  22 | Dustin  |      7 |   45 |  74 | 103 | 1998-09-08 | 103 | Interlake | Green  |
|  22 | Dustin  |      7 |   45 |  74 | 103 | 1998-09-08 | 104 | Marine    | yellow |
|  22 | Dustin  |      7 |   45 |  64 | 102 | 1998-09-08 | 101 | Interlake | Blue   |
|  22 | Dustin  |      7 |   45 |  64 | 102 | 1998-09-08 | 102 | Interlake | Red    |
|  22 | Dustin  |      7 |   45 |  64 | 102 | 1998-09-08 | 103 | Interlake | Green  |
|  22 | Dustin  |      7 |   45 |  64 | 102 | 1998-09-08 | 104 | Marine    | yellow |
|  22 | Dustin  |      7 |   45 |  64 | 101 | 1998-09-05 | 101 | Interlake | Blue   |
|  22 | Dustin  |      7 |   45 |  64 | 101 | 1998-09-05 | 102 | Interlake | Red    |
|  22 | Dustin  |      7 |   45 |  64 | 101 | 1998-09-05 | 103 | Interlake | Green  |
|  22 | Dustin  |      7 |   45 |  64 | 101 | 1998-09-05 | 104 | Marine    | yellow |
|  22 | Dustin  |      7 |   45 |  31 | 103 | 1998-11-06 | 101 | Interlake | Blue   |
|  22 | Dustin  |      7 |   45 |  31 | 103 | 1998-11-06 | 102 | Interlake | Red    |
|  22 | Dustin  |      7 |   45 |  31 | 103 | 1998-11-06 | 103 | Interlake | Green  |
|  22 | Dustin  |      7 |   45 |  31 | 103 | 1998-11-06 | 104 | Marine    | yellow |
|  22 | Dustin  |      7 |   45 |  31 | 102 | 1998-11-10 | 101 | Interlake | Blue   |
|  22 | Dustin  |      7 |   45 |  31 | 102 | 1998-11-10 | 102 | Interlake | Red    |
|  22 | Dustin  |      7 |   45 |  31 | 102 | 1998-11-10 | 103 | Interlake | Green  |
|  22 | Dustin  |      7 |   45 |  31 | 102 | 1998-11-10 | 104 | Marine    | yellow |
|  22 | Dustin  |      7 |   45 |  22 | 104 | 1998-10-07 | 101 | Interlake | Blue   |
|  22 | Dustin  |      7 |   45 |  22 | 104 | 1998-10-07 | 102 | Interlake | Red    |
|  22 | Dustin  |      7 |   45 |  22 | 104 | 1998-10-07 | 103 | Interlake | Green  |
|  22 | Dustin  |      7 |   45 |  22 | 104 | 1998-10-07 | 104 | Marine    | yellow |
|  22 | Dustin  |      7 |   45 |  22 | 103 | 1998-10-08 | 101 | Interlake | Blue   |
|  22 | Dustin  |      7 |   45 |  22 | 103 | 1998-10-08 | 102 | Interlake | Red    |
|  22 | Dustin  |      7 |   45 |  22 | 103 | 1998-10-08 | 103 | Interlake | Green  |
|  22 | Dustin  |      7 |   45 |  22 | 103 | 1998-10-08 | 104 | Marine    | yellow |
|  22 | Dustin  |      7 |   45 |  22 | 102 | 1998-10-10 | 101 | Interlake | Blue   |
|  22 | Dustin  |      7 |   45 |  22 | 102 | 1998-10-10 | 102 | Interlake | Red    |
|  22 | Dustin  |      7 |   45 |  22 | 102 | 1998-10-10 | 103 | Interlake | Green  |
|  22 | Dustin  |      7 |   45 |  22 | 102 | 1998-10-10 | 104 | Marine    | yellow |
|  22 | Dustin  |      7 |   45 |  22 | 101 | 1999-10-10 | 101 | Interlake | Blue   |
|  22 | Dustin  |      7 |   45 |  22 | 101 | 1999-10-10 | 102 | Interlake | Red    |
|  22 | Dustin  |      7 |   45 |  22 | 101 | 1999-10-10 | 103 | Interlake | Green  |
|  22 | Dustin  |      7 |   45 |  22 | 101 | 1999-10-10 | 104 | Marine    | yellow |
|  29 | Brutus  |      1 |   33 |  74 | 103 | 1998-09-08 | 101 | Interlake | Blue   |
|  29 | Brutus  |      1 |   33 |  74 | 103 | 1998-09-08 | 102 | Interlake | Red    |
|  29 | Brutus  |      1 |   33 |  74 | 103 | 1998-09-08 | 103 | Interlake | Green  |
|  29 | Brutus  |      1 |   33 |  74 | 103 | 1998-09-08 | 104 | Marine    | yellow |
|  29 | Brutus  |      1 |   33 |  64 | 102 | 1998-09-08 | 101 | Interlake | Blue   |
|  29 | Brutus  |      1 |   33 |  64 | 102 | 1998-09-08 | 102 | Interlake | Red    |
|  29 | Brutus  |      1 |   33 |  64 | 102 | 1998-09-08 | 103 | Interlake | Green  |
|  29 | Brutus  |      1 |   33 |  64 | 102 | 1998-09-08 | 104 | Marine    | yellow |
|  29 | Brutus  |      1 |   33 |  64 | 101 | 1998-09-05 | 101 | Interlake | Blue   |
|  29 | Brutus  |      1 |   33 |  64 | 101 | 1998-09-05 | 102 | Interlake | Red    |
|  29 | Brutus  |      1 |   33 |  64 | 101 | 1998-09-05 | 103 | Interlake | Green  |
|  29 | Brutus  |      1 |   33 |  64 | 101 | 1998-09-05 | 104 | Marine    | yellow |
|  29 | Brutus  |      1 |   33 |  31 | 103 | 1998-11-06 | 101 | Interlake | Blue   |
|  29 | Brutus  |      1 |   33 |  31 | 103 | 1998-11-06 | 102 | Interlake | Red    |
|  29 | Brutus  |      1 |   33 |  31 | 103 | 1998-11-06 | 103 | Interlake | Green  |
|  29 | Brutus  |      1 |   33 |  31 | 103 | 1998-11-06 | 104 | Marine    | yellow |
|  29 | Brutus  |      1 |   33 |  31 | 102 | 1998-11-10 | 101 | Interlake | Blue   |
|  29 | Brutus  |      1 |   33 |  31 | 102 | 1998-11-10 | 102 | Interlake | Red    |
|  29 | Brutus  |      1 |   33 |  31 | 102 | 1998-11-10 | 103 | Interlake | Green  |
|  29 | Brutus  |      1 |   33 |  31 | 102 | 1998-11-10 | 104 | Marine    | yellow |
|  29 | Brutus  |      1 |   33 |  22 | 104 | 1998-10-07 | 101 | Interlake | Blue   |
|  29 | Brutus  |      1 |   33 |  22 | 104 | 1998-10-07 | 102 | Interlake | Red    |
|  29 | Brutus  |      1 |   33 |  22 | 104 | 1998-10-07 | 103 | Interlake | Green  |
|  29 | Brutus  |      1 |   33 |  22 | 104 | 1998-10-07 | 104 | Marine    | yellow |
|  29 | Brutus  |      1 |   33 |  22 | 103 | 1998-10-08 | 101 | Interlake | Blue   |
|  29 | Brutus  |      1 |   33 |  22 | 103 | 1998-10-08 | 102 | Interlake | Red    |
|  29 | Brutus  |      1 |   33 |  22 | 103 | 1998-10-08 | 103 | Interlake | Green  |
|  29 | Brutus  |      1 |   33 |  22 | 103 | 1998-10-08 | 104 | Marine    | yellow |
|  29 | Brutus  |      1 |   33 |  22 | 102 | 1998-10-10 | 101 | Interlake | Blue   |
|  29 | Brutus  |      1 |   33 |  22 | 102 | 1998-10-10 | 102 | Interlake | Red    |
|  29 | Brutus  |      1 |   33 |  22 | 102 | 1998-10-10 | 103 | Interlake | Green  |
|  29 | Brutus  |      1 |   33 |  22 | 102 | 1998-10-10 | 104 | Marine    | yellow |
|  29 | Brutus  |      1 |   33 |  22 | 101 | 1999-10-10 | 101 | Interlake | Blue   |
|  29 | Brutus  |      1 |   33 |  22 | 101 | 1999-10-10 | 102 | Interlake | Red    |
|  29 | Brutus  |      1 |   33 |  22 | 101 | 1999-10-10 | 103 | Interlake | Green  |
|  29 | Brutus  |      1 |   33 |  22 | 101 | 1999-10-10 | 104 | Marine    | yellow |
|  31 | Lubber  |      8 | 55.5 |  74 | 103 | 1998-09-08 | 101 | Interlake | Blue   |
|  31 | Lubber  |      8 | 55.5 |  74 | 103 | 1998-09-08 | 102 | Interlake | Red    |
|  31 | Lubber  |      8 | 55.5 |  74 | 103 | 1998-09-08 | 103 | Interlake | Green  |
|  31 | Lubber  |      8 | 55.5 |  74 | 103 | 1998-09-08 | 104 | Marine    | yellow |
|  31 | Lubber  |      8 | 55.5 |  64 | 102 | 1998-09-08 | 101 | Interlake | Blue   |
|  31 | Lubber  |      8 | 55.5 |  64 | 102 | 1998-09-08 | 102 | Interlake | Red    |
|  31 | Lubber  |      8 | 55.5 |  64 | 102 | 1998-09-08 | 103 | Interlake | Green  |
|  31 | Lubber  |      8 | 55.5 |  64 | 102 | 1998-09-08 | 104 | Marine    | yellow |
|  31 | Lubber  |      8 | 55.5 |  64 | 101 | 1998-09-05 | 101 | Interlake | Blue   |
|  31 | Lubber  |      8 | 55.5 |  64 | 101 | 1998-09-05 | 102 | Interlake | Red    |
|  31 | Lubber  |      8 | 55.5 |  64 | 101 | 1998-09-05 | 103 | Interlake | Green  |
|  31 | Lubber  |      8 | 55.5 |  64 | 101 | 1998-09-05 | 104 | Marine    | yellow |
|  31 | Lubber  |      8 | 55.5 |  31 | 103 | 1998-11-06 | 101 | Interlake | Blue   |
|  31 | Lubber  |      8 | 55.5 |  31 | 103 | 1998-11-06 | 102 | Interlake | Red    |
|  31 | Lubber  |      8 | 55.5 |  31 | 103 | 1998-11-06 | 103 | Interlake | Green  |
|  31 | Lubber  |      8 | 55.5 |  31 | 103 | 1998-11-06 | 104 | Marine    | yellow |
|  31 | Lubber  |      8 | 55.5 |  31 | 102 | 1998-11-10 | 101 | Interlake | Blue   |
|  31 | Lubber  |      8 | 55.5 |  31 | 102 | 1998-11-10 | 102 | Interlake | Red    |
|  31 | Lubber  |      8 | 55.5 |  31 | 102 | 1998-11-10 | 103 | Interlake | Green  |
|  31 | Lubber  |      8 | 55.5 |  31 | 102 | 1998-11-10 | 104 | Marine    | yellow |
|  31 | Lubber  |      8 | 55.5 |  22 | 104 | 1998-10-07 | 101 | Interlake | Blue   |
|  31 | Lubber  |      8 | 55.5 |  22 | 104 | 1998-10-07 | 102 | Interlake | Red    |
|  31 | Lubber  |      8 | 55.5 |  22 | 104 | 1998-10-07 | 103 | Interlake | Green  |
|  31 | Lubber  |      8 | 55.5 |  22 | 104 | 1998-10-07 | 104 | Marine    | yellow |
|  31 | Lubber  |      8 | 55.5 |  22 | 103 | 1998-10-08 | 101 | Interlake | Blue   |
|  31 | Lubber  |      8 | 55.5 |  22 | 103 | 1998-10-08 | 102 | Interlake | Red    |
|  31 | Lubber  |      8 | 55.5 |  22 | 103 | 1998-10-08 | 103 | Interlake | Green  |
|  31 | Lubber  |      8 | 55.5 |  22 | 103 | 1998-10-08 | 104 | Marine    | yellow |
|  31 | Lubber  |      8 | 55.5 |  22 | 102 | 1998-10-10 | 101 | Interlake | Blue   |
|  31 | Lubber  |      8 | 55.5 |  22 | 102 | 1998-10-10 | 102 | Interlake | Red    |
|  31 | Lubber  |      8 | 55.5 |  22 | 102 | 1998-10-10 | 103 | Interlake | Green  |
|  31 | Lubber  |      8 | 55.5 |  22 | 102 | 1998-10-10 | 104 | Marine    | yellow |
|  31 | Lubber  |      8 | 55.5 |  22 | 101 | 1999-10-10 | 101 | Interlake | Blue   |
|  31 | Lubber  |      8 | 55.5 |  22 | 101 | 1999-10-10 | 102 | Interlake | Red    |
|  31 | Lubber  |      8 | 55.5 |  22 | 101 | 1999-10-10 | 103 | Interlake | Green  |
|  31 | Lubber  |      8 | 55.5 |  22 | 101 | 1999-10-10 | 104 | Marine    | yellow |
|  32 | Andy    |      8 | 25.5 |  74 | 103 | 1998-09-08 | 101 | Interlake | Blue   |
|  32 | Andy    |      8 | 25.5 |  74 | 103 | 1998-09-08 | 102 | Interlake | Red    |
|  32 | Andy    |      8 | 25.5 |  74 | 103 | 1998-09-08 | 103 | Interlake | Green  |
|  32 | Andy    |      8 | 25.5 |  74 | 103 | 1998-09-08 | 104 | Marine    | yellow |
|  32 | Andy    |      8 | 25.5 |  64 | 102 | 1998-09-08 | 101 | Interlake | Blue   |
|  32 | Andy    |      8 | 25.5 |  64 | 102 | 1998-09-08 | 102 | Interlake | Red    |
|  32 | Andy    |      8 | 25.5 |  64 | 102 | 1998-09-08 | 103 | Interlake | Green  |
|  32 | Andy    |      8 | 25.5 |  64 | 102 | 1998-09-08 | 104 | Marine    | yellow |
|  32 | Andy    |      8 | 25.5 |  64 | 101 | 1998-09-05 | 101 | Interlake | Blue   |
|  32 | Andy    |      8 | 25.5 |  64 | 101 | 1998-09-05 | 102 | Interlake | Red    |
|  32 | Andy    |      8 | 25.5 |  64 | 101 | 1998-09-05 | 103 | Interlake | Green  |
|  32 | Andy    |      8 | 25.5 |  64 | 101 | 1998-09-05 | 104 | Marine    | yellow |
|  32 | Andy    |      8 | 25.5 |  31 | 103 | 1998-11-06 | 101 | Interlake | Blue   |
|  32 | Andy    |      8 | 25.5 |  31 | 103 | 1998-11-06 | 102 | Interlake | Red    |
|  32 | Andy    |      8 | 25.5 |  31 | 103 | 1998-11-06 | 103 | Interlake | Green  |
|  32 | Andy    |      8 | 25.5 |  31 | 103 | 1998-11-06 | 104 | Marine    | yellow |
|  32 | Andy    |      8 | 25.5 |  31 | 102 | 1998-11-10 | 101 | Interlake | Blue   |
|  32 | Andy    |      8 | 25.5 |  31 | 102 | 1998-11-10 | 102 | Interlake | Red    |
|  32 | Andy    |      8 | 25.5 |  31 | 102 | 1998-11-10 | 103 | Interlake | Green  |
|  32 | Andy    |      8 | 25.5 |  31 | 102 | 1998-11-10 | 104 | Marine    | yellow |
|  32 | Andy    |      8 | 25.5 |  22 | 104 | 1998-10-07 | 101 | Interlake | Blue   |
|  32 | Andy    |      8 | 25.5 |  22 | 104 | 1998-10-07 | 102 | Interlake | Red    |
|  32 | Andy    |      8 | 25.5 |  22 | 104 | 1998-10-07 | 103 | Interlake | Green  |
|  32 | Andy    |      8 | 25.5 |  22 | 104 | 1998-10-07 | 104 | Marine    | yellow |
|  32 | Andy    |      8 | 25.5 |  22 | 103 | 1998-10-08 | 101 | Interlake | Blue   |
|  32 | Andy    |      8 | 25.5 |  22 | 103 | 1998-10-08 | 102 | Interlake | Red    |
|  32 | Andy    |      8 | 25.5 |  22 | 103 | 1998-10-08 | 103 | Interlake | Green  |
|  32 | Andy    |      8 | 25.5 |  22 | 103 | 1998-10-08 | 104 | Marine    | yellow |
|  32 | Andy    |      8 | 25.5 |  22 | 102 | 1998-10-10 | 101 | Interlake | Blue   |
|  32 | Andy    |      8 | 25.5 |  22 | 102 | 1998-10-10 | 102 | Interlake | Red    |
|  32 | Andy    |      8 | 25.5 |  22 | 102 | 1998-10-10 | 103 | Interlake | Green  |
|  32 | Andy    |      8 | 25.5 |  22 | 102 | 1998-10-10 | 104 | Marine    | yellow |
|  32 | Andy    |      8 | 25.5 |  22 | 101 | 1999-10-10 | 101 | Interlake | Blue   |
|  32 | Andy    |      8 | 25.5 |  22 | 101 | 1999-10-10 | 102 | Interlake | Red    |
|  32 | Andy    |      8 | 25.5 |  22 | 101 | 1999-10-10 | 103 | Interlake | Green  |
|  32 | Andy    |      8 | 25.5 |  22 | 101 | 1999-10-10 | 104 | Marine    | yellow |
|  58 | Rusty   |     10 |   35 |  74 | 103 | 1998-09-08 | 101 | Interlake | Blue   |
|  58 | Rusty   |     10 |   35 |  74 | 103 | 1998-09-08 | 102 | Interlake | Red    |
|  58 | Rusty   |     10 |   35 |  74 | 103 | 1998-09-08 | 103 | Interlake | Green  |
|  58 | Rusty   |     10 |   35 |  74 | 103 | 1998-09-08 | 104 | Marine    | yellow |
|  58 | Rusty   |     10 |   35 |  64 | 102 | 1998-09-08 | 101 | Interlake | Blue   |
|  58 | Rusty   |     10 |   35 |  64 | 102 | 1998-09-08 | 102 | Interlake | Red    |
|  58 | Rusty   |     10 |   35 |  64 | 102 | 1998-09-08 | 103 | Interlake | Green  |
|  58 | Rusty   |     10 |   35 |  64 | 102 | 1998-09-08 | 104 | Marine    | yellow |
|  58 | Rusty   |     10 |   35 |  64 | 101 | 1998-09-05 | 101 | Interlake | Blue   |
|  58 | Rusty   |     10 |   35 |  64 | 101 | 1998-09-05 | 102 | Interlake | Red    |
|  58 | Rusty   |     10 |   35 |  64 | 101 | 1998-09-05 | 103 | Interlake | Green  |
|  58 | Rusty   |     10 |   35 |  64 | 101 | 1998-09-05 | 104 | Marine    | yellow |
|  58 | Rusty   |     10 |   35 |  31 | 103 | 1998-11-06 | 101 | Interlake | Blue   |
|  58 | Rusty   |     10 |   35 |  31 | 103 | 1998-11-06 | 102 | Interlake | Red    |
|  58 | Rusty   |     10 |   35 |  31 | 103 | 1998-11-06 | 103 | Interlake | Green  |
|  58 | Rusty   |     10 |   35 |  31 | 103 | 1998-11-06 | 104 | Marine    | yellow |
|  58 | Rusty   |     10 |   35 |  31 | 102 | 1998-11-10 | 101 | Interlake | Blue   |
|  58 | Rusty   |     10 |   35 |  31 | 102 | 1998-11-10 | 102 | Interlake | Red    |
|  58 | Rusty   |     10 |   35 |  31 | 102 | 1998-11-10 | 103 | Interlake | Green  |
|  58 | Rusty   |     10 |   35 |  31 | 102 | 1998-11-10 | 104 | Marine    | yellow |
|  58 | Rusty   |     10 |   35 |  22 | 104 | 1998-10-07 | 101 | Interlake | Blue   |
|  58 | Rusty   |     10 |   35 |  22 | 104 | 1998-10-07 | 102 | Interlake | Red    |
|  58 | Rusty   |     10 |   35 |  22 | 104 | 1998-10-07 | 103 | Interlake | Green  |
|  58 | Rusty   |     10 |   35 |  22 | 104 | 1998-10-07 | 104 | Marine    | yellow |
|  58 | Rusty   |     10 |   35 |  22 | 103 | 1998-10-08 | 101 | Interlake | Blue   |
|  58 | Rusty   |     10 |   35 |  22 | 103 | 1998-10-08 | 102 | Interlake | Red    |
|  58 | Rusty   |     10 |   35 |  22 | 103 | 1998-10-08 | 103 | Interlake | Green  |
|  58 | Rusty   |     10 |   35 |  22 | 103 | 1998-10-08 | 104 | Marine    | yellow |
|  58 | Rusty   |     10 |   35 |  22 | 102 | 1998-10-10 | 101 | Interlake | Blue   |
|  58 | Rusty   |     10 |   35 |  22 | 102 | 1998-10-10 | 102 | Interlake | Red    |
|  58 | Rusty   |     10 |   35 |  22 | 102 | 1998-10-10 | 103 | Interlake | Green  |
|  58 | Rusty   |     10 |   35 |  22 | 102 | 1998-10-10 | 104 | Marine    | yellow |
|  58 | Rusty   |     10 |   35 |  22 | 101 | 1999-10-10 | 101 | Interlake | Blue   |
|  58 | Rusty   |     10 |   35 |  22 | 101 | 1999-10-10 | 102 | Interlake | Red    |
|  58 | Rusty   |     10 |   35 |  22 | 101 | 1999-10-10 | 103 | Interlake | Green  |
|  58 | Rusty   |     10 |   35 |  22 | 101 | 1999-10-10 | 104 | Marine    | yellow |
|  64 | Horatio |      7 |   35 |  74 | 103 | 1998-09-08 | 101 | Interlake | Blue   |
|  64 | Horatio |      7 |   35 |  74 | 103 | 1998-09-08 | 102 | Interlake | Red    |
|  64 | Horatio |      7 |   35 |  74 | 103 | 1998-09-08 | 103 | Interlake | Green  |
|  64 | Horatio |      7 |   35 |  74 | 103 | 1998-09-08 | 104 | Marine    | yellow |
|  64 | Horatio |      7 |   35 |  64 | 102 | 1998-09-08 | 101 | Interlake | Blue   |
|  64 | Horatio |      7 |   35 |  64 | 102 | 1998-09-08 | 102 | Interlake | Red    |
|  64 | Horatio |      7 |   35 |  64 | 102 | 1998-09-08 | 103 | Interlake | Green  |
|  64 | Horatio |      7 |   35 |  64 | 102 | 1998-09-08 | 104 | Marine    | yellow |
|  64 | Horatio |      7 |   35 |  64 | 101 | 1998-09-05 | 101 | Interlake | Blue   |
|  64 | Horatio |      7 |   35 |  64 | 101 | 1998-09-05 | 102 | Interlake | Red    |
|  64 | Horatio |      7 |   35 |  64 | 101 | 1998-09-05 | 103 | Interlake | Green  |
|  64 | Horatio |      7 |   35 |  64 | 101 | 1998-09-05 | 104 | Marine    | yellow |
|  64 | Horatio |      7 |   35 |  31 | 103 | 1998-11-06 | 101 | Interlake | Blue   |
|  64 | Horatio |      7 |   35 |  31 | 103 | 1998-11-06 | 102 | Interlake | Red    |
|  64 | Horatio |      7 |   35 |  31 | 103 | 1998-11-06 | 103 | Interlake | Green  |
|  64 | Horatio |      7 |   35 |  31 | 103 | 1998-11-06 | 104 | Marine    | yellow |
|  64 | Horatio |      7 |   35 |  31 | 102 | 1998-11-10 | 101 | Interlake | Blue   |
|  64 | Horatio |      7 |   35 |  31 | 102 | 1998-11-10 | 102 | Interlake | Red    |
|  64 | Horatio |      7 |   35 |  31 | 102 | 1998-11-10 | 103 | Interlake | Green  |
|  64 | Horatio |      7 |   35 |  31 | 102 | 1998-11-10 | 104 | Marine    | yellow |
|  64 | Horatio |      7 |   35 |  22 | 104 | 1998-10-07 | 101 | Interlake | Blue   |
|  64 | Horatio |      7 |   35 |  22 | 104 | 1998-10-07 | 102 | Interlake | Red    |
|  64 | Horatio |      7 |   35 |  22 | 104 | 1998-10-07 | 103 | Interlake | Green  |
|  64 | Horatio |      7 |   35 |  22 | 104 | 1998-10-07 | 104 | Marine    | yellow |
|  64 | Horatio |      7 |   35 |  22 | 103 | 1998-10-08 | 101 | Interlake | Blue   |
|  64 | Horatio |      7 |   35 |  22 | 103 | 1998-10-08 | 102 | Interlake | Red    |
|  64 | Horatio |      7 |   35 |  22 | 103 | 1998-10-08 | 103 | Interlake | Green  |
|  64 | Horatio |      7 |   35 |  22 | 103 | 1998-10-08 | 104 | Marine    | yellow |
|  64 | Horatio |      7 |   35 |  22 | 102 | 1998-10-10 | 101 | Interlake | Blue   |
|  64 | Horatio |      7 |   35 |  22 | 102 | 1998-10-10 | 102 | Interlake | Red    |
|  64 | Horatio |      7 |   35 |  22 | 102 | 1998-10-10 | 103 | Interlake | Green  |
|  64 | Horatio |      7 |   35 |  22 | 102 | 1998-10-10 | 104 | Marine    | yellow |
|  64 | Horatio |      7 |   35 |  22 | 101 | 1999-10-10 | 101 | Interlake | Blue   |
|  64 | Horatio |      7 |   35 |  22 | 101 | 1999-10-10 | 102 | Interlake | Red    |
|  64 | Horatio |      7 |   35 |  22 | 101 | 1999-10-10 | 103 | Interlake | Green  |
|  64 | Horatio |      7 |   35 |  22 | 101 | 1999-10-10 | 104 | Marine    | yellow |
|  71 | Zorba   |     10 |   16 |  74 | 103 | 1998-09-08 | 101 | Interlake | Blue   |
|  71 | Zorba   |     10 |   16 |  74 | 103 | 1998-09-08 | 102 | Interlake | Red    |
|  71 | Zorba   |     10 |   16 |  74 | 103 | 1998-09-08 | 103 | Interlake | Green  |
|  71 | Zorba   |     10 |   16 |  74 | 103 | 1998-09-08 | 104 | Marine    | yellow |
|  71 | Zorba   |     10 |   16 |  64 | 102 | 1998-09-08 | 101 | Interlake | Blue   |
|  71 | Zorba   |     10 |   16 |  64 | 102 | 1998-09-08 | 102 | Interlake | Red    |
|  71 | Zorba   |     10 |   16 |  64 | 102 | 1998-09-08 | 103 | Interlake | Green  |
|  71 | Zorba   |     10 |   16 |  64 | 102 | 1998-09-08 | 104 | Marine    | yellow |
|  71 | Zorba   |     10 |   16 |  64 | 101 | 1998-09-05 | 101 | Interlake | Blue   |
|  71 | Zorba   |     10 |   16 |  64 | 101 | 1998-09-05 | 102 | Interlake | Red    |
|  71 | Zorba   |     10 |   16 |  64 | 101 | 1998-09-05 | 103 | Interlake | Green  |
|  71 | Zorba   |     10 |   16 |  64 | 101 | 1998-09-05 | 104 | Marine    | yellow |
|  71 | Zorba   |     10 |   16 |  31 | 103 | 1998-11-06 | 101 | Interlake | Blue   |
|  71 | Zorba   |     10 |   16 |  31 | 103 | 1998-11-06 | 102 | Interlake | Red    |
|  71 | Zorba   |     10 |   16 |  31 | 103 | 1998-11-06 | 103 | Interlake | Green  |
|  71 | Zorba   |     10 |   16 |  31 | 103 | 1998-11-06 | 104 | Marine    | yellow |
|  71 | Zorba   |     10 |   16 |  31 | 102 | 1998-11-10 | 101 | Interlake | Blue   |
|  71 | Zorba   |     10 |   16 |  31 | 102 | 1998-11-10 | 102 | Interlake | Red    |
|  71 | Zorba   |     10 |   16 |  31 | 102 | 1998-11-10 | 103 | Interlake | Green  |
|  71 | Zorba   |     10 |   16 |  31 | 102 | 1998-11-10 | 104 | Marine    | yellow |
|  71 | Zorba   |     10 |   16 |  22 | 104 | 1998-10-07 | 101 | Interlake | Blue   |
|  71 | Zorba   |     10 |   16 |  22 | 104 | 1998-10-07 | 102 | Interlake | Red    |
|  71 | Zorba   |     10 |   16 |  22 | 104 | 1998-10-07 | 103 | Interlake | Green  |
|  71 | Zorba   |     10 |   16 |  22 | 104 | 1998-10-07 | 104 | Marine    | yellow |
|  71 | Zorba   |     10 |   16 |  22 | 103 | 1998-10-08 | 101 | Interlake | Blue   |
|  71 | Zorba   |     10 |   16 |  22 | 103 | 1998-10-08 | 102 | Interlake | Red    |
|  71 | Zorba   |     10 |   16 |  22 | 103 | 1998-10-08 | 103 | Interlake | Green  |
|  71 | Zorba   |     10 |   16 |  22 | 103 | 1998-10-08 | 104 | Marine    | yellow |
|  71 | Zorba   |     10 |   16 |  22 | 102 | 1998-10-10 | 101 | Interlake | Blue   |
|  71 | Zorba   |     10 |   16 |  22 | 102 | 1998-10-10 | 102 | Interlake | Red    |
|  71 | Zorba   |     10 |   16 |  22 | 102 | 1998-10-10 | 103 | Interlake | Green  |
|  71 | Zorba   |     10 |   16 |  22 | 102 | 1998-10-10 | 104 | Marine    | yellow |
|  71 | Zorba   |     10 |   16 |  22 | 101 | 1999-10-10 | 101 | Interlake | Blue   |
|  71 | Zorba   |     10 |   16 |  22 | 101 | 1999-10-10 | 102 | Interlake | Red    |
|  71 | Zorba   |     10 |   16 |  22 | 101 | 1999-10-10 | 103 | Interlake | Green  |
|  71 | Zorba   |     10 |   16 |  22 | 101 | 1999-10-10 | 104 | Marine    | yellow |
|  74 | Horatio |      9 |   40 |  74 | 103 | 1998-09-08 | 101 | Interlake | Blue   |
|  74 | Horatio |      9 |   40 |  74 | 103 | 1998-09-08 | 102 | Interlake | Red    |
|  74 | Horatio |      9 |   40 |  74 | 103 | 1998-09-08 | 103 | Interlake | Green  |
|  74 | Horatio |      9 |   40 |  74 | 103 | 1998-09-08 | 104 | Marine    | yellow |
|  74 | Horatio |      9 |   40 |  64 | 102 | 1998-09-08 | 101 | Interlake | Blue   |
|  74 | Horatio |      9 |   40 |  64 | 102 | 1998-09-08 | 102 | Interlake | Red    |
|  74 | Horatio |      9 |   40 |  64 | 102 | 1998-09-08 | 103 | Interlake | Green  |
|  74 | Horatio |      9 |   40 |  64 | 102 | 1998-09-08 | 104 | Marine    | yellow |
|  74 | Horatio |      9 |   40 |  64 | 101 | 1998-09-05 | 101 | Interlake | Blue   |
|  74 | Horatio |      9 |   40 |  64 | 101 | 1998-09-05 | 102 | Interlake | Red    |
|  74 | Horatio |      9 |   40 |  64 | 101 | 1998-09-05 | 103 | Interlake | Green  |
|  74 | Horatio |      9 |   40 |  64 | 101 | 1998-09-05 | 104 | Marine    | yellow |
|  74 | Horatio |      9 |   40 |  31 | 103 | 1998-11-06 | 101 | Interlake | Blue   |
|  74 | Horatio |      9 |   40 |  31 | 103 | 1998-11-06 | 102 | Interlake | Red    |
|  74 | Horatio |      9 |   40 |  31 | 103 | 1998-11-06 | 103 | Interlake | Green  |
|  74 | Horatio |      9 |   40 |  31 | 103 | 1998-11-06 | 104 | Marine    | yellow |
|  74 | Horatio |      9 |   40 |  31 | 102 | 1998-11-10 | 101 | Interlake | Blue   |
|  74 | Horatio |      9 |   40 |  31 | 102 | 1998-11-10 | 102 | Interlake | Red    |
|  74 | Horatio |      9 |   40 |  31 | 102 | 1998-11-10 | 103 | Interlake | Green  |
|  74 | Horatio |      9 |   40 |  31 | 102 | 1998-11-10 | 104 | Marine    | yellow |
|  74 | Horatio |      9 |   40 |  22 | 104 | 1998-10-07 | 101 | Interlake | Blue   |
|  74 | Horatio |      9 |   40 |  22 | 104 | 1998-10-07 | 102 | Interlake | Red    |
|  74 | Horatio |      9 |   40 |  22 | 104 | 1998-10-07 | 103 | Interlake | Green  |
|  74 | Horatio |      9 |   40 |  22 | 104 | 1998-10-07 | 104 | Marine    | yellow |
|  74 | Horatio |      9 |   40 |  22 | 103 | 1998-10-08 | 101 | Interlake | Blue   |
|  74 | Horatio |      9 |   40 |  22 | 103 | 1998-10-08 | 102 | Interlake | Red    |
|  74 | Horatio |      9 |   40 |  22 | 103 | 1998-10-08 | 103 | Interlake | Green  |
|  74 | Horatio |      9 |   40 |  22 | 103 | 1998-10-08 | 104 | Marine    | yellow |
|  74 | Horatio |      9 |   40 |  22 | 102 | 1998-10-10 | 101 | Interlake | Blue   |
|  74 | Horatio |      9 |   40 |  22 | 102 | 1998-10-10 | 102 | Interlake | Red    |
|  74 | Horatio |      9 |   40 |  22 | 102 | 1998-10-10 | 103 | Interlake | Green  |
|  74 | Horatio |      9 |   40 |  22 | 102 | 1998-10-10 | 104 | Marine    | yellow |
|  74 | Horatio |      9 |   40 |  22 | 101 | 1999-10-10 | 101 | Interlake | Blue   |
|  74 | Horatio |      9 |   40 |  22 | 101 | 1999-10-10 | 102 | Interlake | Red    |
|  74 | Horatio |      9 |   40 |  22 | 101 | 1999-10-10 | 103 | Interlake | Green  |
|  74 | Horatio |      9 |   40 |  22 | 101 | 1999-10-10 | 104 | Marine    | yellow |
|  85 | Art     |      3 | 25.5 |  74 | 103 | 1998-09-08 | 101 | Interlake | Blue   |
|  85 | Art     |      3 | 25.5 |  74 | 103 | 1998-09-08 | 102 | Interlake | Red    |
|  85 | Art     |      3 | 25.5 |  74 | 103 | 1998-09-08 | 103 | Interlake | Green  |
|  85 | Art     |      3 | 25.5 |  74 | 103 | 1998-09-08 | 104 | Marine    | yellow |
|  85 | Art     |      3 | 25.5 |  64 | 102 | 1998-09-08 | 101 | Interlake | Blue   |
|  85 | Art     |      3 | 25.5 |  64 | 102 | 1998-09-08 | 102 | Interlake | Red    |
|  85 | Art     |      3 | 25.5 |  64 | 102 | 1998-09-08 | 103 | Interlake | Green  |
|  85 | Art     |      3 | 25.5 |  64 | 102 | 1998-09-08 | 104 | Marine    | yellow |
|  85 | Art     |      3 | 25.5 |  64 | 101 | 1998-09-05 | 101 | Interlake | Blue   |
|  85 | Art     |      3 | 25.5 |  64 | 101 | 1998-09-05 | 102 | Interlake | Red    |
|  85 | Art     |      3 | 25.5 |  64 | 101 | 1998-09-05 | 103 | Interlake | Green  |
|  85 | Art     |      3 | 25.5 |  64 | 101 | 1998-09-05 | 104 | Marine    | yellow |
|  85 | Art     |      3 | 25.5 |  31 | 103 | 1998-11-06 | 101 | Interlake | Blue   |
|  85 | Art     |      3 | 25.5 |  31 | 103 | 1998-11-06 | 102 | Interlake | Red    |
|  85 | Art     |      3 | 25.5 |  31 | 103 | 1998-11-06 | 103 | Interlake | Green  |
|  85 | Art     |      3 | 25.5 |  31 | 103 | 1998-11-06 | 104 | Marine    | yellow |
|  85 | Art     |      3 | 25.5 |  31 | 102 | 1998-11-10 | 101 | Interlake | Blue   |
|  85 | Art     |      3 | 25.5 |  31 | 102 | 1998-11-10 | 102 | Interlake | Red    |
|  85 | Art     |      3 | 25.5 |  31 | 102 | 1998-11-10 | 103 | Interlake | Green  |
|  85 | Art     |      3 | 25.5 |  31 | 102 | 1998-11-10 | 104 | Marine    | yellow |
|  85 | Art     |      3 | 25.5 |  22 | 104 | 1998-10-07 | 101 | Interlake | Blue   |
|  85 | Art     |      3 | 25.5 |  22 | 104 | 1998-10-07 | 102 | Interlake | Red    |
|  85 | Art     |      3 | 25.5 |  22 | 104 | 1998-10-07 | 103 | Interlake | Green  |
|  85 | Art     |      3 | 25.5 |  22 | 104 | 1998-10-07 | 104 | Marine    | yellow |
|  85 | Art     |      3 | 25.5 |  22 | 103 | 1998-10-08 | 101 | Interlake | Blue   |
|  85 | Art     |      3 | 25.5 |  22 | 103 | 1998-10-08 | 102 | Interlake | Red    |
|  85 | Art     |      3 | 25.5 |  22 | 103 | 1998-10-08 | 103 | Interlake | Green  |
|  85 | Art     |      3 | 25.5 |  22 | 103 | 1998-10-08 | 104 | Marine    | yellow |
|  85 | Art     |      3 | 25.5 |  22 | 102 | 1998-10-10 | 101 | Interlake | Blue   |
|  85 | Art     |      3 | 25.5 |  22 | 102 | 1998-10-10 | 102 | Interlake | Red    |
|  85 | Art     |      3 | 25.5 |  22 | 102 | 1998-10-10 | 103 | Interlake | Green  |
|  85 | Art     |      3 | 25.5 |  22 | 102 | 1998-10-10 | 104 | Marine    | yellow |
|  85 | Art     |      3 | 25.5 |  22 | 101 | 1999-10-10 | 101 | Interlake | Blue   |
|  85 | Art     |      3 | 25.5 |  22 | 101 | 1999-10-10 | 102 | Interlake | Red    |
|  85 | Art     |      3 | 25.5 |  22 | 101 | 1999-10-10 | 103 | Interlake | Green  |
|  85 | Art     |      3 | 25.5 |  22 | 101 | 1999-10-10 | 104 | Marine    | yellow |
|  95 | Bolo    |      3 | 63.5 |  74 | 103 | 1998-09-08 | 101 | Interlake | Blue   |
|  95 | Bolo    |      3 | 63.5 |  74 | 103 | 1998-09-08 | 102 | Interlake | Red    |
|  95 | Bolo    |      3 | 63.5 |  74 | 103 | 1998-09-08 | 103 | Interlake | Green  |
|  95 | Bolo    |      3 | 63.5 |  74 | 103 | 1998-09-08 | 104 | Marine    | yellow |
|  95 | Bolo    |      3 | 63.5 |  64 | 102 | 1998-09-08 | 101 | Interlake | Blue   |
|  95 | Bolo    |      3 | 63.5 |  64 | 102 | 1998-09-08 | 102 | Interlake | Red    |
|  95 | Bolo    |      3 | 63.5 |  64 | 102 | 1998-09-08 | 103 | Interlake | Green  |
|  95 | Bolo    |      3 | 63.5 |  64 | 102 | 1998-09-08 | 104 | Marine    | yellow |
|  95 | Bolo    |      3 | 63.5 |  64 | 101 | 1998-09-05 | 101 | Interlake | Blue   |
|  95 | Bolo    |      3 | 63.5 |  64 | 101 | 1998-09-05 | 102 | Interlake | Red    |
|  95 | Bolo    |      3 | 63.5 |  64 | 101 | 1998-09-05 | 103 | Interlake | Green  |
|  95 | Bolo    |      3 | 63.5 |  64 | 101 | 1998-09-05 | 104 | Marine    | yellow |
|  95 | Bolo    |      3 | 63.5 |  31 | 103 | 1998-11-06 | 101 | Interlake | Blue   |
|  95 | Bolo    |      3 | 63.5 |  31 | 103 | 1998-11-06 | 102 | Interlake | Red    |
|  95 | Bolo    |      3 | 63.5 |  31 | 103 | 1998-11-06 | 103 | Interlake | Green  |
|  95 | Bolo    |      3 | 63.5 |  31 | 103 | 1998-11-06 | 104 | Marine    | yellow |
|  95 | Bolo    |      3 | 63.5 |  31 | 102 | 1998-11-10 | 101 | Interlake | Blue   |
|  95 | Bolo    |      3 | 63.5 |  31 | 102 | 1998-11-10 | 102 | Interlake | Red    |
|  95 | Bolo    |      3 | 63.5 |  31 | 102 | 1998-11-10 | 103 | Interlake | Green  |
|  95 | Bolo    |      3 | 63.5 |  31 | 102 | 1998-11-10 | 104 | Marine    | yellow |
|  95 | Bolo    |      3 | 63.5 |  22 | 104 | 1998-10-07 | 101 | Interlake | Blue   |
|  95 | Bolo    |      3 | 63.5 |  22 | 104 | 1998-10-07 | 102 | Interlake | Red    |
|  95 | Bolo    |      3 | 63.5 |  22 | 104 | 1998-10-07 | 103 | Interlake | Green  |
|  95 | Bolo    |      3 | 63.5 |  22 | 104 | 1998-10-07 | 104 | Marine    | yellow |
|  95 | Bolo    |      3 | 63.5 |  22 | 103 | 1998-10-08 | 101 | Interlake | Blue   |
|  95 | Bolo    |      3 | 63.5 |  22 | 103 | 1998-10-08 | 102 | Interlake | Red    |
|  95 | Bolo    |      3 | 63.5 |  22 | 103 | 1998-10-08 | 103 | Interlake | Green  |
|  95 | Bolo    |      3 | 63.5 |  22 | 103 | 1998-10-08 | 104 | Marine    | yellow |
|  95 | Bolo    |      3 | 63.5 |  22 | 102 | 1998-10-10 | 101 | Interlake | Blue   |
|  95 | Bolo    |      3 | 63.5 |  22 | 102 | 1998-10-10 | 102 | Interlake | Red    |
|  95 | Bolo    |      3 | 63.5 |  22 | 102 | 1998-10-10 | 103 | Interlake | Green  |
|  95 | Bolo    |      3 | 63.5 |  22 | 102 | 1998-10-10 | 104 | Marine    | yellow |
|  95 | Bolo    |      3 | 63.5 |  22 | 101 | 1999-10-10 | 101 | Interlake | Blue   |
|  95 | Bolo    |      3 | 63.5 |  22 | 101 | 1999-10-10 | 102 | Interlake | Red    |
|  95 | Bolo    |      3 | 63.5 |  22 | 101 | 1999-10-10 | 103 | Interlake | Green  |
|  95 | Bolo    |      3 | 63.5 |  22 | 101 | 1999-10-10 | 104 | Marine    | yellow |
+-----+---------+--------+------+-----+-----+------------+-----+-----------+--------+
360 rows in set (0.00 sec)

mysql> 


