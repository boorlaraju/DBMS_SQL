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

mysql> show databases
    -> ;
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

mysql> use week2
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> show tables;
+-----------------+
| Tables_in_week2 |
+-----------------+
| Sailors         |
| boats           |
| reserves        |
+-----------------+
3 rows in set (0.00 sec)

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

mysql> selevt min(age) from Sailors;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'selevt min(age) from Sailors' at line 1
mysql> select min(age) from Sailors;
+----------+
| min(age) |
+----------+
|       16 |
+----------+
1 row in set (0.00 sec)

mysql> select Sname,min(age) from Sailors;
ERROR 1140 (42000): In aggregated query without GROUP BY, expression #1 of SELECT list contains nonaggregated column 'week2.Sailors.Sname'; this is incompatible with sql_mode=only_full_group_by
mysql> select min(age),name from Sailors where age=(select min(age) from Sailors);
ERROR 1054 (42S22): Unknown column 'name' in 'field list'
mysql> select min(age),Sname from Sailors where age=(select min(age) from Sailors);
ERROR 1140 (42000): In aggregated query without GROUP BY, expression #2 of SELECT list contains nonaggregated column 'week2.Sailors.Sname'; this is incompatible with sql_mode=only_full_group_by
mysql> select min(age),Sname from Sailors;
ERROR 1140 (42000): In aggregated query without GROUP BY, expression #2 of SELECT list contains nonaggregated column 'week2.Sailors.Sname'; this is incompatible with sql_mode=only_full_group_by
mysql> select age,Sname from Sailors group by Sname;
ERROR 1055 (42000): Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'week2.Sailors.age' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by
mysql> select min(age),Sname from Sailors group by Sname;
+----------+---------+
| min(age) | Sname   |
+----------+---------+
|       45 | Dustin  |
|       33 | Brutus  |
|     55.5 | Lubber  |
|     25.5 | Andy    |
|       35 | Rusty   |
|       35 | Horatio |
|       16 | Zorba   |
|     25.5 | Art     |
|     63.5 | Bob     |
+----------+---------+
9 rows in set (0.00 sec)

mysql> select rating,min(age) from Sailors group by rating;
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

mysql> select rating ,count(*) from Sailors group by rating;
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

mysql> select Sname,age from Sailors where age=(select min(age) from Sailors);
+-------+------+
| Sname | age  |
+-------+------+
| Zorba |   16 |
+-------+------+
1 row in set (0.00 sec)

mysql> select Sname,rating from Sailors where age=(select min(age) from Sailors);
+-------+--------+
| Sname | rating |
+-------+--------+
| Zorba |     10 |
+-------+--------+
1 row in set (0.00 sec)

mysql> select Sname from Sailors where rating>Any(select rating from Sailors where Sname='Horatio');
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

mysql> select Sname from Sailors where rating>All(select rating from Sailors where Sname='Horatio');
+-------+
| Sname |
+-------+
| Rusty |
| Zorba |
+-------+
2 rows in set (0.00 sec)

mysql> select Sname from Sailors where age =(select max(age) from Sailors rating=10);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '=10)' at line 1
mysql> select Sname from Sailors where age =(select max(age) from Sailors where rating=10);
+---------+
| Sname   |
+---------+
| Rusty   |
| Horatio |
+---------+
2 rows in set (0.00 sec)

mysql> select Sname from Sailors where age>any(select max(age) from Sailors where rating=10);
+---------+
| Sname   |
+---------+
| Dustin  |
| Lubber  |
| Horatio |
| Bob     |
+---------+
4 rows in set (0.00 sec)

mysql> select Sname from Sailors where age>35;
+---------+
| Sname   |
+---------+
| Dustin  |
| Lubber  |
| Horatio |
| Bob     |
+---------+
4 rows in set (0.00 sec)

mysql> select count(bid) from reserves where Sid in(select sid from Sailors);
+------------+
| count(bid) |
+------------+
|         10 |
+------------+
1 row in set (0.00 sec)

mysql> select count(*) from reserves where Sid in(select sid from Sailors);
+----------+
| count(*) |
+----------+
|       10 |
+----------+
1 row in set (0.00 sec)

mysql> select count(bid) from boats where bid in(select bid from Sailors);
+------------+
| count(bid) |
+------------+
|          4 |
+------------+
1 row in set (0.00 sec)

mysql> select Sname, count(bid) from boats group by bid;
ERROR 1054 (42S22): Unknown column 'Sname' in 'field list'
mysql> select Sid, count(bid) from  reserves group by bid;
ERROR 1055 (42000): Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'week2.reserves.Sid' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by
mysql> select Sid, count(bid) from  reserves group by Sid;
+-----+------------+
| Sid | count(bid) |
+-----+------------+
|  22 |          4 |
|  31 |          3 |
|  64 |          2 |
|  74 |          1 |
+-----+------------+
4 rows in set (0.00 sec)

mysql> select count(bid),color from boats group by color;
+------------+-------+
| count(bid) | color |
+------------+-------+
|          1 | blue  |
|          2 | red   |
|          1 | green |
+------------+-------+
3 rows in set (0.00 sec)

mysql> select Sid from Sailors where bid=103;
ERROR 1054 (42S22): Unknown column 'bid' in 'where clause'
mysql> select Sid, count(bid) from  reserves group by Sid;
+-----+------------+
| Sid | count(bid) |
+-----+------------+
|  22 |          4 |
|  31 |          3 |
|  64 |          2 |
|  74 |          1 |
+-----+------------+
4 rows in set (0.00 sec)

mysql> select Sid from reserves where bid=103;
+-----+
| Sid |
+-----+
|  22 |
|  31 |
|  74 |
+-----+
3 rows in set (0.01 sec)

mysql> select Sid from reserves where bid in(select bid from boats where color='red');
+-----+
| Sid |
+-----+
|  22 |
|  31 |
|  64 |
|  22 |
|  31 |
+-----+
5 rows in set (0.00 sec)

mysql> select distinct Sid from reserves where bid in(select bid from boats where color='red');
+-----+
| Sid |
+-----+
|  22 |
|  31 |
|  64 |
+-----+
3 rows in set (0.00 sec)

mysql> select distinct Sid from reserves where bid =(select bid from boats where color='red');
ERROR 1242 (21000): Subquery returns more than 1 row
mysql> select Sname from Sailors where Sid=(select Sid from boats bid=103);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '=103)' at line 1
mysql> select Sname from Sailors where Sid=(select Sid from reserves bid=103);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '=103)' at line 1
mysql> select Sname from Sailors where Sid in (select Sid from reserves where bid=103);
+---------+
| Sname   |
+---------+
| Dustin  |
| Lubber  |
| Horatio |
+---------+
3 rows in set (0.00 sec)

mysql> select Sname from Sailors where Sid = (select Sid from reserves where bid=103);
ERROR 1242 (21000): Subquery returns more than 1 row
mysql> select Sname from Sailors where Sid in (select Sid from reserves where bid=103);
+---------+
| Sname   |
+---------+
| Dustin  |
| Lubber  |
| Horatio |
+---------+
3 rows in set (0.00 sec)

mysql> select Sname from Sailors where Sid in(select Sid from reserves where bid in(select bid from boats where color='red'));
+---------+
| Sname   |
+---------+
| Dustin  |
| Lubber  |
| Horatio |
+---------+
3 rows in set (0.00 sec)

mysql> select Sname from Sailors where Sid in(select Sid from reserves );
+---------+
| Sname   |
+---------+
| Dustin  |
| Lubber  |
| Horatio |
| Horatio |
+---------+
4 rows in set (0.00 sec)

mysql> select Sname from Sailors where Sid not in(select Sid from reserves );
+--------+
| Sname  |
+--------+
| Brutus |
| Andy   |
| Rusty  |
| Zorba  |
| Art    |
| Bob    |
+--------+
6 rows in set (0.00 sec)

mysql> select Sname from Sailors where age<50 and select bid from reserves where bid in(select bid from boats where color='green');
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'select bid from reserves where bid in(select bid from boats where color='green')' at line 1
mysql> select Sname from Sailors where age<50 and select sid from reserves where bid in(select bid from boats where color='green');
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'select sid from reserves where bid in(select bid from boats where color='green')' at line 1
mysql> select Sname from Sailors where( age<50 and select sid from reserves where bid in(select bid from boats where color='green'));
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'select sid from reserves where bid in(select bid from boats where color='green')' at line 1
mysql> select Sname from Sailors where age<50 and select sid from reserves where bid in(select bid from boats where color='green');
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'select sid from reserves where bid in(select bid from boats where color='green')' at line 1
mysql> select Sname from Sailors where age<50 and Sid in(select sid from reserves where bid in(select bid from boats where color='green');
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '' at line 1
mysql> select Sname from Sailors where age<50 and Sid in(select Sid from reserves where bid in(select bid from boats where color='green');
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '' at line 1
mysql> select Sname from Sailors where age<50 and Sid in(select Sid from reserves where bid in(select bid from boats where color='green'));
+---------+
| Sname   |
+---------+
| Dustin  |
| Horatio |
+---------+
2 rows in set (0.00 sec)

mysql> select color from boats where bid in (select bid from reserves where Sid in(select Sid from Sailors where Sname='Lubber'));
+-------+
| color |
+-------+
| red   |
| green |
| red   |
+-------+
3 rows in set (0.00 sec)

mysql> select bid from reserves where sid in(select sid from Sailors where Sname='Lubber');
+-----+
| bid |
+-----+
| 102 |
| 103 |
| 104 |
+-----+
3 rows in set (0.00 sec)

mysql> select bid from boats where bid not in select color from boats where bid in (select bid from reserves where Sid in(select Sid from Sailors where Sname='Lubber'));
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'select color from boats where bid in (select bid from reserves where Sid in(sele' at line 1
mysql> select bid from boats where bid not in (select bid from reserves where Sid in(select Sid from Sailors where Sname='Lubber'));
+-----+
| bid |
+-----+
| 101 |
+-----+
1 row in set (0.00 sec)

mysql> select bid from boats where bid not in select bid from reserves where Sid in(select Sid from Sailors where Sname='Lubber');
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'select bid from reserves where Sid in(select Sid from Sailors where Sname='Lubbe' at line 1
mysql> select bid from boats where bid not in select bid from reserves where Sid in(select Sid from Sailors where Sname='Lubber');
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'select bid from reserves where Sid in(select Sid from Sailors where Sname='Lubbe' at line 1
mysql> select bid from boats where bid not in( select bid from reserves where Sid in(select Sid from Sailors where Sname='Lubber'));
+-----+
| bid |
+-----+
| 101 |
+-----+
1 row in set (0.00 sec)

mysql> select * from Sailors,reserves;
+-----+---------+--------+------+-----+-----+------------+
| Sid | Sname   | rating | age  | Sid | bid | day        |
+-----+---------+--------+------+-----+-----+------------+
|  95 | Bob     |      3 | 63.5 |  22 | 101 | 1998-10-10 |
|  85 | Art     |      3 | 25.5 |  22 | 101 | 1998-10-10 |
|  74 | Horatio |      9 |   40 |  22 | 101 | 1998-10-10 |
|  71 | Zorba   |     10 |   16 |  22 | 101 | 1998-10-10 |
|  64 | Horatio |      7 |   35 |  22 | 101 | 1998-10-10 |
|  58 | Rusty   |     10 |   35 |  22 | 101 | 1998-10-10 |
|  32 | Andy    |      8 | 25.5 |  22 | 101 | 1998-10-10 |
|  31 | Lubber  |      8 | 55.5 |  22 | 101 | 1998-10-10 |
|  29 | Brutus  |      1 |   33 |  22 | 101 | 1998-10-10 |
|  22 | Dustin  |      7 |   45 |  22 | 101 | 1998-10-10 |
|  95 | Bob     |      3 | 63.5 |  22 | 102 | 1998-10-10 |
|  85 | Art     |      3 | 25.5 |  22 | 102 | 1998-10-10 |
|  74 | Horatio |      9 |   40 |  22 | 102 | 1998-10-10 |
|  71 | Zorba   |     10 |   16 |  22 | 102 | 1998-10-10 |
|  64 | Horatio |      7 |   35 |  22 | 102 | 1998-10-10 |
|  58 | Rusty   |     10 |   35 |  22 | 102 | 1998-10-10 |
|  32 | Andy    |      8 | 25.5 |  22 | 102 | 1998-10-10 |
|  31 | Lubber  |      8 | 55.5 |  22 | 102 | 1998-10-10 |
|  29 | Brutus  |      1 |   33 |  22 | 102 | 1998-10-10 |
|  22 | Dustin  |      7 |   45 |  22 | 102 | 1998-10-10 |
|  95 | Bob     |      3 | 63.5 |  22 | 103 | 1998-10-08 |
|  85 | Art     |      3 | 25.5 |  22 | 103 | 1998-10-08 |
|  74 | Horatio |      9 |   40 |  22 | 103 | 1998-10-08 |
|  71 | Zorba   |     10 |   16 |  22 | 103 | 1998-10-08 |
|  64 | Horatio |      7 |   35 |  22 | 103 | 1998-10-08 |
|  58 | Rusty   |     10 |   35 |  22 | 103 | 1998-10-08 |
|  32 | Andy    |      8 | 25.5 |  22 | 103 | 1998-10-08 |
|  31 | Lubber  |      8 | 55.5 |  22 | 103 | 1998-10-08 |
|  29 | Brutus  |      1 |   33 |  22 | 103 | 1998-10-08 |
|  22 | Dustin  |      7 |   45 |  22 | 103 | 1998-10-08 |
|  95 | Bob     |      3 | 63.5 |  22 | 104 | 1998-10-07 |
|  85 | Art     |      3 | 25.5 |  22 | 104 | 1998-10-07 |
|  74 | Horatio |      9 |   40 |  22 | 104 | 1998-10-07 |
|  71 | Zorba   |     10 |   16 |  22 | 104 | 1998-10-07 |
|  64 | Horatio |      7 |   35 |  22 | 104 | 1998-10-07 |
|  58 | Rusty   |     10 |   35 |  22 | 104 | 1998-10-07 |
|  32 | Andy    |      8 | 25.5 |  22 | 104 | 1998-10-07 |
|  31 | Lubber  |      8 | 55.5 |  22 | 104 | 1998-10-07 |
|  29 | Brutus  |      1 |   33 |  22 | 104 | 1998-10-07 |
|  22 | Dustin  |      7 |   45 |  22 | 104 | 1998-10-07 |
|  95 | Bob     |      3 | 63.5 |  31 | 102 | 1998-11-10 |
|  85 | Art     |      3 | 25.5 |  31 | 102 | 1998-11-10 |
|  74 | Horatio |      9 |   40 |  31 | 102 | 1998-11-10 |
|  71 | Zorba   |     10 |   16 |  31 | 102 | 1998-11-10 |
|  64 | Horatio |      7 |   35 |  31 | 102 | 1998-11-10 |
|  58 | Rusty   |     10 |   35 |  31 | 102 | 1998-11-10 |
|  32 | Andy    |      8 | 25.5 |  31 | 102 | 1998-11-10 |
|  31 | Lubber  |      8 | 55.5 |  31 | 102 | 1998-11-10 |
|  29 | Brutus  |      1 |   33 |  31 | 102 | 1998-11-10 |
|  22 | Dustin  |      7 |   45 |  31 | 102 | 1998-11-10 |
|  95 | Bob     |      3 | 63.5 |  31 | 103 | 1998-11-06 |
|  85 | Art     |      3 | 25.5 |  31 | 103 | 1998-11-06 |
|  74 | Horatio |      9 |   40 |  31 | 103 | 1998-11-06 |
|  71 | Zorba   |     10 |   16 |  31 | 103 | 1998-11-06 |
|  64 | Horatio |      7 |   35 |  31 | 103 | 1998-11-06 |
|  58 | Rusty   |     10 |   35 |  31 | 103 | 1998-11-06 |
|  32 | Andy    |      8 | 25.5 |  31 | 103 | 1998-11-06 |
|  31 | Lubber  |      8 | 55.5 |  31 | 103 | 1998-11-06 |
|  29 | Brutus  |      1 |   33 |  31 | 103 | 1998-11-06 |
|  22 | Dustin  |      7 |   45 |  31 | 103 | 1998-11-06 |
|  95 | Bob     |      3 | 63.5 |  31 | 104 | 1998-11-12 |
|  85 | Art     |      3 | 25.5 |  31 | 104 | 1998-11-12 |
|  74 | Horatio |      9 |   40 |  31 | 104 | 1998-11-12 |
|  71 | Zorba   |     10 |   16 |  31 | 104 | 1998-11-12 |
|  64 | Horatio |      7 |   35 |  31 | 104 | 1998-11-12 |
|  58 | Rusty   |     10 |   35 |  31 | 104 | 1998-11-12 |
|  32 | Andy    |      8 | 25.5 |  31 | 104 | 1998-11-12 |
|  31 | Lubber  |      8 | 55.5 |  31 | 104 | 1998-11-12 |
|  29 | Brutus  |      1 |   33 |  31 | 104 | 1998-11-12 |
|  22 | Dustin  |      7 |   45 |  31 | 104 | 1998-11-12 |
|  95 | Bob     |      3 | 63.5 |  64 | 101 | 1998-09-05 |
|  85 | Art     |      3 | 25.5 |  64 | 101 | 1998-09-05 |
|  74 | Horatio |      9 |   40 |  64 | 101 | 1998-09-05 |
|  71 | Zorba   |     10 |   16 |  64 | 101 | 1998-09-05 |
|  64 | Horatio |      7 |   35 |  64 | 101 | 1998-09-05 |
|  58 | Rusty   |     10 |   35 |  64 | 101 | 1998-09-05 |
|  32 | Andy    |      8 | 25.5 |  64 | 101 | 1998-09-05 |
|  31 | Lubber  |      8 | 55.5 |  64 | 101 | 1998-09-05 |
|  29 | Brutus  |      1 |   33 |  64 | 101 | 1998-09-05 |
|  22 | Dustin  |      7 |   45 |  64 | 101 | 1998-09-05 |
|  95 | Bob     |      3 | 63.5 |  64 | 102 | 1998-09-08 |
|  85 | Art     |      3 | 25.5 |  64 | 102 | 1998-09-08 |
|  74 | Horatio |      9 |   40 |  64 | 102 | 1998-09-08 |
|  71 | Zorba   |     10 |   16 |  64 | 102 | 1998-09-08 |
|  64 | Horatio |      7 |   35 |  64 | 102 | 1998-09-08 |
|  58 | Rusty   |     10 |   35 |  64 | 102 | 1998-09-08 |
|  32 | Andy    |      8 | 25.5 |  64 | 102 | 1998-09-08 |
|  31 | Lubber  |      8 | 55.5 |  64 | 102 | 1998-09-08 |
|  29 | Brutus  |      1 |   33 |  64 | 102 | 1998-09-08 |
|  22 | Dustin  |      7 |   45 |  64 | 102 | 1998-09-08 |
|  95 | Bob     |      3 | 63.5 |  74 | 103 | 1998-09-08 |
|  85 | Art     |      3 | 25.5 |  74 | 103 | 1998-09-08 |
|  74 | Horatio |      9 |   40 |  74 | 103 | 1998-09-08 |
|  71 | Zorba   |     10 |   16 |  74 | 103 | 1998-09-08 |
|  64 | Horatio |      7 |   35 |  74 | 103 | 1998-09-08 |
|  58 | Rusty   |     10 |   35 |  74 | 103 | 1998-09-08 |
|  32 | Andy    |      8 | 25.5 |  74 | 103 | 1998-09-08 |
|  31 | Lubber  |      8 | 55.5 |  74 | 103 | 1998-09-08 |
|  29 | Brutus  |      1 |   33 |  74 | 103 | 1998-09-08 |
|  22 | Dustin  |      7 |   45 |  74 | 103 | 1998-09-08 |
+-----+---------+--------+------+-----+-----+------------+
100 rows in set (0.00 sec)

mysql> select * reserves,boats;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'reserves,boats' at line 1
mysql> select * from reserves,boats;
+-----+-----+------------+-----+-----------+-------+
| Sid | bid | day        | bid | bname     | color |
+-----+-----+------------+-----+-----------+-------+
|  22 | 101 | 1998-10-10 | 104 | Marine    | red   |
|  22 | 101 | 1998-10-10 | 103 | Clipper   | green |
|  22 | 101 | 1998-10-10 | 102 | Interlake | red   |
|  22 | 101 | 1998-10-10 | 101 | Interlake | blue  |
|  22 | 102 | 1998-10-10 | 104 | Marine    | red   |
|  22 | 102 | 1998-10-10 | 103 | Clipper   | green |
|  22 | 102 | 1998-10-10 | 102 | Interlake | red   |
|  22 | 102 | 1998-10-10 | 101 | Interlake | blue  |
|  22 | 103 | 1998-10-08 | 104 | Marine    | red   |
|  22 | 103 | 1998-10-08 | 103 | Clipper   | green |
|  22 | 103 | 1998-10-08 | 102 | Interlake | red   |
|  22 | 103 | 1998-10-08 | 101 | Interlake | blue  |
|  22 | 104 | 1998-10-07 | 104 | Marine    | red   |
|  22 | 104 | 1998-10-07 | 103 | Clipper   | green |
|  22 | 104 | 1998-10-07 | 102 | Interlake | red   |
|  22 | 104 | 1998-10-07 | 101 | Interlake | blue  |
|  31 | 102 | 1998-11-10 | 104 | Marine    | red   |
|  31 | 102 | 1998-11-10 | 103 | Clipper   | green |
|  31 | 102 | 1998-11-10 | 102 | Interlake | red   |
|  31 | 102 | 1998-11-10 | 101 | Interlake | blue  |
|  31 | 103 | 1998-11-06 | 104 | Marine    | red   |
|  31 | 103 | 1998-11-06 | 103 | Clipper   | green |
|  31 | 103 | 1998-11-06 | 102 | Interlake | red   |
|  31 | 103 | 1998-11-06 | 101 | Interlake | blue  |
|  31 | 104 | 1998-11-12 | 104 | Marine    | red   |
|  31 | 104 | 1998-11-12 | 103 | Clipper   | green |
|  31 | 104 | 1998-11-12 | 102 | Interlake | red   |
|  31 | 104 | 1998-11-12 | 101 | Interlake | blue  |
|  64 | 101 | 1998-09-05 | 104 | Marine    | red   |
|  64 | 101 | 1998-09-05 | 103 | Clipper   | green |
|  64 | 101 | 1998-09-05 | 102 | Interlake | red   |
|  64 | 101 | 1998-09-05 | 101 | Interlake | blue  |
|  64 | 102 | 1998-09-08 | 104 | Marine    | red   |
|  64 | 102 | 1998-09-08 | 103 | Clipper   | green |
|  64 | 102 | 1998-09-08 | 102 | Interlake | red   |
|  64 | 102 | 1998-09-08 | 101 | Interlake | blue  |
|  74 | 103 | 1998-09-08 | 104 | Marine    | red   |
|  74 | 103 | 1998-09-08 | 103 | Clipper   | green |
|  74 | 103 | 1998-09-08 | 102 | Interlake | red   |
|  74 | 103 | 1998-09-08 | 101 | Interlake | blue  |
+-----+-----+------------+-----+-----------+-------+
40 rows in set (0.00 sec)

mysql> select * from Sailors,reserves,boats;
+-----+---------+--------+------+-----+-----+------------+-----+-----------+-------+
| Sid | Sname   | rating | age  | Sid | bid | day        | bid | bname     | color |
+-----+---------+--------+------+-----+-----+------------+-----+-----------+-------+
|  95 | Bob     |      3 | 63.5 |  22 | 101 | 1998-10-10 | 101 | Interlake | blue  |
|  95 | Bob     |      3 | 63.5 |  22 | 101 | 1998-10-10 | 102 | Interlake | red   |
|  95 | Bob     |      3 | 63.5 |  22 | 101 | 1998-10-10 | 103 | Clipper   | green |
|  95 | Bob     |      3 | 63.5 |  22 | 101 | 1998-10-10 | 104 | Marine    | red   |
|  85 | Art     |      3 | 25.5 |  22 | 101 | 1998-10-10 | 101 | Interlake | blue  |
|  85 | Art     |      3 | 25.5 |  22 | 101 | 1998-10-10 | 102 | Interlake | red   |
|  85 | Art     |      3 | 25.5 |  22 | 101 | 1998-10-10 | 103 | Clipper   | green |
|  85 | Art     |      3 | 25.5 |  22 | 101 | 1998-10-10 | 104 | Marine    | red   |
|  74 | Horatio |      9 |   40 |  22 | 101 | 1998-10-10 | 101 | Interlake | blue  |
|  74 | Horatio |      9 |   40 |  22 | 101 | 1998-10-10 | 102 | Interlake | red   |
|  74 | Horatio |      9 |   40 |  22 | 101 | 1998-10-10 | 103 | Clipper   | green |
|  74 | Horatio |      9 |   40 |  22 | 101 | 1998-10-10 | 104 | Marine    | red   |
|  71 | Zorba   |     10 |   16 |  22 | 101 | 1998-10-10 | 101 | Interlake | blue  |
|  71 | Zorba   |     10 |   16 |  22 | 101 | 1998-10-10 | 102 | Interlake | red   |
|  71 | Zorba   |     10 |   16 |  22 | 101 | 1998-10-10 | 103 | Clipper   | green |
|  71 | Zorba   |     10 |   16 |  22 | 101 | 1998-10-10 | 104 | Marine    | red   |
|  64 | Horatio |      7 |   35 |  22 | 101 | 1998-10-10 | 101 | Interlake | blue  |
|  64 | Horatio |      7 |   35 |  22 | 101 | 1998-10-10 | 102 | Interlake | red   |
|  64 | Horatio |      7 |   35 |  22 | 101 | 1998-10-10 | 103 | Clipper   | green |
|  64 | Horatio |      7 |   35 |  22 | 101 | 1998-10-10 | 104 | Marine    | red   |
|  58 | Rusty   |     10 |   35 |  22 | 101 | 1998-10-10 | 101 | Interlake | blue  |
|  58 | Rusty   |     10 |   35 |  22 | 101 | 1998-10-10 | 102 | Interlake | red   |
|  58 | Rusty   |     10 |   35 |  22 | 101 | 1998-10-10 | 103 | Clipper   | green |
|  58 | Rusty   |     10 |   35 |  22 | 101 | 1998-10-10 | 104 | Marine    | red   |
|  32 | Andy    |      8 | 25.5 |  22 | 101 | 1998-10-10 | 101 | Interlake | blue  |
|  32 | Andy    |      8 | 25.5 |  22 | 101 | 1998-10-10 | 102 | Interlake | red   |
|  32 | Andy    |      8 | 25.5 |  22 | 101 | 1998-10-10 | 103 | Clipper   | green |
|  32 | Andy    |      8 | 25.5 |  22 | 101 | 1998-10-10 | 104 | Marine    | red   |
|  31 | Lubber  |      8 | 55.5 |  22 | 101 | 1998-10-10 | 101 | Interlake | blue  |
|  31 | Lubber  |      8 | 55.5 |  22 | 101 | 1998-10-10 | 102 | Interlake | red   |
|  31 | Lubber  |      8 | 55.5 |  22 | 101 | 1998-10-10 | 103 | Clipper   | green |
|  31 | Lubber  |      8 | 55.5 |  22 | 101 | 1998-10-10 | 104 | Marine    | red   |
|  29 | Brutus  |      1 |   33 |  22 | 101 | 1998-10-10 | 101 | Interlake | blue  |
|  29 | Brutus  |      1 |   33 |  22 | 101 | 1998-10-10 | 102 | Interlake | red   |
|  29 | Brutus  |      1 |   33 |  22 | 101 | 1998-10-10 | 103 | Clipper   | green |
|  29 | Brutus  |      1 |   33 |  22 | 101 | 1998-10-10 | 104 | Marine    | red   |
|  22 | Dustin  |      7 |   45 |  22 | 101 | 1998-10-10 | 101 | Interlake | blue  |
|  22 | Dustin  |      7 |   45 |  22 | 101 | 1998-10-10 | 102 | Interlake | red   |
|  22 | Dustin  |      7 |   45 |  22 | 101 | 1998-10-10 | 103 | Clipper   | green |
|  22 | Dustin  |      7 |   45 |  22 | 101 | 1998-10-10 | 104 | Marine    | red   |
|  95 | Bob     |      3 | 63.5 |  22 | 102 | 1998-10-10 | 101 | Interlake | blue  |
|  95 | Bob     |      3 | 63.5 |  22 | 102 | 1998-10-10 | 102 | Interlake | red   |
|  95 | Bob     |      3 | 63.5 |  22 | 102 | 1998-10-10 | 103 | Clipper   | green |
|  95 | Bob     |      3 | 63.5 |  22 | 102 | 1998-10-10 | 104 | Marine    | red   |
|  85 | Art     |      3 | 25.5 |  22 | 102 | 1998-10-10 | 101 | Interlake | blue  |
|  85 | Art     |      3 | 25.5 |  22 | 102 | 1998-10-10 | 102 | Interlake | red   |
|  85 | Art     |      3 | 25.5 |  22 | 102 | 1998-10-10 | 103 | Clipper   | green |
|  85 | Art     |      3 | 25.5 |  22 | 102 | 1998-10-10 | 104 | Marine    | red   |
|  74 | Horatio |      9 |   40 |  22 | 102 | 1998-10-10 | 101 | Interlake | blue  |
|  74 | Horatio |      9 |   40 |  22 | 102 | 1998-10-10 | 102 | Interlake | red   |
|  74 | Horatio |      9 |   40 |  22 | 102 | 1998-10-10 | 103 | Clipper   | green |
|  74 | Horatio |      9 |   40 |  22 | 102 | 1998-10-10 | 104 | Marine    | red   |
|  71 | Zorba   |     10 |   16 |  22 | 102 | 1998-10-10 | 101 | Interlake | blue  |
|  71 | Zorba   |     10 |   16 |  22 | 102 | 1998-10-10 | 102 | Interlake | red   |
|  71 | Zorba   |     10 |   16 |  22 | 102 | 1998-10-10 | 103 | Clipper   | green |
|  71 | Zorba   |     10 |   16 |  22 | 102 | 1998-10-10 | 104 | Marine    | red   |
|  64 | Horatio |      7 |   35 |  22 | 102 | 1998-10-10 | 101 | Interlake | blue  |
|  64 | Horatio |      7 |   35 |  22 | 102 | 1998-10-10 | 102 | Interlake | red   |
|  64 | Horatio |      7 |   35 |  22 | 102 | 1998-10-10 | 103 | Clipper   | green |
|  64 | Horatio |      7 |   35 |  22 | 102 | 1998-10-10 | 104 | Marine    | red   |
|  58 | Rusty   |     10 |   35 |  22 | 102 | 1998-10-10 | 101 | Interlake | blue  |
|  58 | Rusty   |     10 |   35 |  22 | 102 | 1998-10-10 | 102 | Interlake | red   |
|  58 | Rusty   |     10 |   35 |  22 | 102 | 1998-10-10 | 103 | Clipper   | green |
|  58 | Rusty   |     10 |   35 |  22 | 102 | 1998-10-10 | 104 | Marine    | red   |
|  32 | Andy    |      8 | 25.5 |  22 | 102 | 1998-10-10 | 101 | Interlake | blue  |
|  32 | Andy    |      8 | 25.5 |  22 | 102 | 1998-10-10 | 102 | Interlake | red   |
|  32 | Andy    |      8 | 25.5 |  22 | 102 | 1998-10-10 | 103 | Clipper   | green |
|  32 | Andy    |      8 | 25.5 |  22 | 102 | 1998-10-10 | 104 | Marine    | red   |
|  31 | Lubber  |      8 | 55.5 |  22 | 102 | 1998-10-10 | 101 | Interlake | blue  |
|  31 | Lubber  |      8 | 55.5 |  22 | 102 | 1998-10-10 | 102 | Interlake | red   |
|  31 | Lubber  |      8 | 55.5 |  22 | 102 | 1998-10-10 | 103 | Clipper   | green |
|  31 | Lubber  |      8 | 55.5 |  22 | 102 | 1998-10-10 | 104 | Marine    | red   |
|  29 | Brutus  |      1 |   33 |  22 | 102 | 1998-10-10 | 101 | Interlake | blue  |
|  29 | Brutus  |      1 |   33 |  22 | 102 | 1998-10-10 | 102 | Interlake | red   |
|  29 | Brutus  |      1 |   33 |  22 | 102 | 1998-10-10 | 103 | Clipper   | green |
|  29 | Brutus  |      1 |   33 |  22 | 102 | 1998-10-10 | 104 | Marine    | red   |
|  22 | Dustin  |      7 |   45 |  22 | 102 | 1998-10-10 | 101 | Interlake | blue  |
|  22 | Dustin  |      7 |   45 |  22 | 102 | 1998-10-10 | 102 | Interlake | red   |
|  22 | Dustin  |      7 |   45 |  22 | 102 | 1998-10-10 | 103 | Clipper   | green |
|  22 | Dustin  |      7 |   45 |  22 | 102 | 1998-10-10 | 104 | Marine    | red   |
|  95 | Bob     |      3 | 63.5 |  22 | 103 | 1998-10-08 | 101 | Interlake | blue  |
|  95 | Bob     |      3 | 63.5 |  22 | 103 | 1998-10-08 | 102 | Interlake | red   |
|  95 | Bob     |      3 | 63.5 |  22 | 103 | 1998-10-08 | 103 | Clipper   | green |
|  95 | Bob     |      3 | 63.5 |  22 | 103 | 1998-10-08 | 104 | Marine    | red   |
|  85 | Art     |      3 | 25.5 |  22 | 103 | 1998-10-08 | 101 | Interlake | blue  |
|  85 | Art     |      3 | 25.5 |  22 | 103 | 1998-10-08 | 102 | Interlake | red   |
|  85 | Art     |      3 | 25.5 |  22 | 103 | 1998-10-08 | 103 | Clipper   | green |
|  85 | Art     |      3 | 25.5 |  22 | 103 | 1998-10-08 | 104 | Marine    | red   |
|  74 | Horatio |      9 |   40 |  22 | 103 | 1998-10-08 | 101 | Interlake | blue  |
|  74 | Horatio |      9 |   40 |  22 | 103 | 1998-10-08 | 102 | Interlake | red   |
|  74 | Horatio |      9 |   40 |  22 | 103 | 1998-10-08 | 103 | Clipper   | green |
|  74 | Horatio |      9 |   40 |  22 | 103 | 1998-10-08 | 104 | Marine    | red   |
|  71 | Zorba   |     10 |   16 |  22 | 103 | 1998-10-08 | 101 | Interlake | blue  |
|  71 | Zorba   |     10 |   16 |  22 | 103 | 1998-10-08 | 102 | Interlake | red   |
|  71 | Zorba   |     10 |   16 |  22 | 103 | 1998-10-08 | 103 | Clipper   | green |
|  71 | Zorba   |     10 |   16 |  22 | 103 | 1998-10-08 | 104 | Marine    | red   |
|  64 | Horatio |      7 |   35 |  22 | 103 | 1998-10-08 | 101 | Interlake | blue  |
|  64 | Horatio |      7 |   35 |  22 | 103 | 1998-10-08 | 102 | Interlake | red   |
|  64 | Horatio |      7 |   35 |  22 | 103 | 1998-10-08 | 103 | Clipper   | green |
|  64 | Horatio |      7 |   35 |  22 | 103 | 1998-10-08 | 104 | Marine    | red   |
|  58 | Rusty   |     10 |   35 |  22 | 103 | 1998-10-08 | 101 | Interlake | blue  |
|  58 | Rusty   |     10 |   35 |  22 | 103 | 1998-10-08 | 102 | Interlake | red   |
|  58 | Rusty   |     10 |   35 |  22 | 103 | 1998-10-08 | 103 | Clipper   | green |
|  58 | Rusty   |     10 |   35 |  22 | 103 | 1998-10-08 | 104 | Marine    | red   |
|  32 | Andy    |      8 | 25.5 |  22 | 103 | 1998-10-08 | 101 | Interlake | blue  |
|  32 | Andy    |      8 | 25.5 |  22 | 103 | 1998-10-08 | 102 | Interlake | red   |
|  32 | Andy    |      8 | 25.5 |  22 | 103 | 1998-10-08 | 103 | Clipper   | green |
|  32 | Andy    |      8 | 25.5 |  22 | 103 | 1998-10-08 | 104 | Marine    | red   |
|  31 | Lubber  |      8 | 55.5 |  22 | 103 | 1998-10-08 | 101 | Interlake | blue  |
|  31 | Lubber  |      8 | 55.5 |  22 | 103 | 1998-10-08 | 102 | Interlake | red   |
|  31 | Lubber  |      8 | 55.5 |  22 | 103 | 1998-10-08 | 103 | Clipper   | green |
|  31 | Lubber  |      8 | 55.5 |  22 | 103 | 1998-10-08 | 104 | Marine    | red   |
|  29 | Brutus  |      1 |   33 |  22 | 103 | 1998-10-08 | 101 | Interlake | blue  |
|  29 | Brutus  |      1 |   33 |  22 | 103 | 1998-10-08 | 102 | Interlake | red   |
|  29 | Brutus  |      1 |   33 |  22 | 103 | 1998-10-08 | 103 | Clipper   | green |
|  29 | Brutus  |      1 |   33 |  22 | 103 | 1998-10-08 | 104 | Marine    | red   |
|  22 | Dustin  |      7 |   45 |  22 | 103 | 1998-10-08 | 101 | Interlake | blue  |
|  22 | Dustin  |      7 |   45 |  22 | 103 | 1998-10-08 | 102 | Interlake | red   |
|  22 | Dustin  |      7 |   45 |  22 | 103 | 1998-10-08 | 103 | Clipper   | green |
|  22 | Dustin  |      7 |   45 |  22 | 103 | 1998-10-08 | 104 | Marine    | red   |
|  95 | Bob     |      3 | 63.5 |  22 | 104 | 1998-10-07 | 101 | Interlake | blue  |
|  95 | Bob     |      3 | 63.5 |  22 | 104 | 1998-10-07 | 102 | Interlake | red   |
|  95 | Bob     |      3 | 63.5 |  22 | 104 | 1998-10-07 | 103 | Clipper   | green |
|  95 | Bob     |      3 | 63.5 |  22 | 104 | 1998-10-07 | 104 | Marine    | red   |
|  85 | Art     |      3 | 25.5 |  22 | 104 | 1998-10-07 | 101 | Interlake | blue  |
|  85 | Art     |      3 | 25.5 |  22 | 104 | 1998-10-07 | 102 | Interlake | red   |
|  85 | Art     |      3 | 25.5 |  22 | 104 | 1998-10-07 | 103 | Clipper   | green |
|  85 | Art     |      3 | 25.5 |  22 | 104 | 1998-10-07 | 104 | Marine    | red   |
|  74 | Horatio |      9 |   40 |  22 | 104 | 1998-10-07 | 101 | Interlake | blue  |
|  74 | Horatio |      9 |   40 |  22 | 104 | 1998-10-07 | 102 | Interlake | red   |
|  74 | Horatio |      9 |   40 |  22 | 104 | 1998-10-07 | 103 | Clipper   | green |
|  74 | Horatio |      9 |   40 |  22 | 104 | 1998-10-07 | 104 | Marine    | red   |
|  71 | Zorba   |     10 |   16 |  22 | 104 | 1998-10-07 | 101 | Interlake | blue  |
|  71 | Zorba   |     10 |   16 |  22 | 104 | 1998-10-07 | 102 | Interlake | red   |
|  71 | Zorba   |     10 |   16 |  22 | 104 | 1998-10-07 | 103 | Clipper   | green |
|  71 | Zorba   |     10 |   16 |  22 | 104 | 1998-10-07 | 104 | Marine    | red   |
|  64 | Horatio |      7 |   35 |  22 | 104 | 1998-10-07 | 101 | Interlake | blue  |
|  64 | Horatio |      7 |   35 |  22 | 104 | 1998-10-07 | 102 | Interlake | red   |
|  64 | Horatio |      7 |   35 |  22 | 104 | 1998-10-07 | 103 | Clipper   | green |
|  64 | Horatio |      7 |   35 |  22 | 104 | 1998-10-07 | 104 | Marine    | red   |
|  58 | Rusty   |     10 |   35 |  22 | 104 | 1998-10-07 | 101 | Interlake | blue  |
|  58 | Rusty   |     10 |   35 |  22 | 104 | 1998-10-07 | 102 | Interlake | red   |
|  58 | Rusty   |     10 |   35 |  22 | 104 | 1998-10-07 | 103 | Clipper   | green |
|  58 | Rusty   |     10 |   35 |  22 | 104 | 1998-10-07 | 104 | Marine    | red   |
|  32 | Andy    |      8 | 25.5 |  22 | 104 | 1998-10-07 | 101 | Interlake | blue  |
|  32 | Andy    |      8 | 25.5 |  22 | 104 | 1998-10-07 | 102 | Interlake | red   |
|  32 | Andy    |      8 | 25.5 |  22 | 104 | 1998-10-07 | 103 | Clipper   | green |
|  32 | Andy    |      8 | 25.5 |  22 | 104 | 1998-10-07 | 104 | Marine    | red   |
|  31 | Lubber  |      8 | 55.5 |  22 | 104 | 1998-10-07 | 101 | Interlake | blue  |
|  31 | Lubber  |      8 | 55.5 |  22 | 104 | 1998-10-07 | 102 | Interlake | red   |
|  31 | Lubber  |      8 | 55.5 |  22 | 104 | 1998-10-07 | 103 | Clipper   | green |
|  31 | Lubber  |      8 | 55.5 |  22 | 104 | 1998-10-07 | 104 | Marine    | red   |
|  29 | Brutus  |      1 |   33 |  22 | 104 | 1998-10-07 | 101 | Interlake | blue  |
|  29 | Brutus  |      1 |   33 |  22 | 104 | 1998-10-07 | 102 | Interlake | red   |
|  29 | Brutus  |      1 |   33 |  22 | 104 | 1998-10-07 | 103 | Clipper   | green |
|  29 | Brutus  |      1 |   33 |  22 | 104 | 1998-10-07 | 104 | Marine    | red   |
|  22 | Dustin  |      7 |   45 |  22 | 104 | 1998-10-07 | 101 | Interlake | blue  |
|  22 | Dustin  |      7 |   45 |  22 | 104 | 1998-10-07 | 102 | Interlake | red   |
|  22 | Dustin  |      7 |   45 |  22 | 104 | 1998-10-07 | 103 | Clipper   | green |
|  22 | Dustin  |      7 |   45 |  22 | 104 | 1998-10-07 | 104 | Marine    | red   |
|  95 | Bob     |      3 | 63.5 |  31 | 102 | 1998-11-10 | 101 | Interlake | blue  |
|  95 | Bob     |      3 | 63.5 |  31 | 102 | 1998-11-10 | 102 | Interlake | red   |
|  95 | Bob     |      3 | 63.5 |  31 | 102 | 1998-11-10 | 103 | Clipper   | green |
|  95 | Bob     |      3 | 63.5 |  31 | 102 | 1998-11-10 | 104 | Marine    | red   |
|  85 | Art     |      3 | 25.5 |  31 | 102 | 1998-11-10 | 101 | Interlake | blue  |
|  85 | Art     |      3 | 25.5 |  31 | 102 | 1998-11-10 | 102 | Interlake | red   |
|  85 | Art     |      3 | 25.5 |  31 | 102 | 1998-11-10 | 103 | Clipper   | green |
|  85 | Art     |      3 | 25.5 |  31 | 102 | 1998-11-10 | 104 | Marine    | red   |
|  74 | Horatio |      9 |   40 |  31 | 102 | 1998-11-10 | 101 | Interlake | blue  |
|  74 | Horatio |      9 |   40 |  31 | 102 | 1998-11-10 | 102 | Interlake | red   |
|  74 | Horatio |      9 |   40 |  31 | 102 | 1998-11-10 | 103 | Clipper   | green |
|  74 | Horatio |      9 |   40 |  31 | 102 | 1998-11-10 | 104 | Marine    | red   |
|  71 | Zorba   |     10 |   16 |  31 | 102 | 1998-11-10 | 101 | Interlake | blue  |
|  71 | Zorba   |     10 |   16 |  31 | 102 | 1998-11-10 | 102 | Interlake | red   |
|  71 | Zorba   |     10 |   16 |  31 | 102 | 1998-11-10 | 103 | Clipper   | green |
|  71 | Zorba   |     10 |   16 |  31 | 102 | 1998-11-10 | 104 | Marine    | red   |
|  64 | Horatio |      7 |   35 |  31 | 102 | 1998-11-10 | 101 | Interlake | blue  |
|  64 | Horatio |      7 |   35 |  31 | 102 | 1998-11-10 | 102 | Interlake | red   |
|  64 | Horatio |      7 |   35 |  31 | 102 | 1998-11-10 | 103 | Clipper   | green |
|  64 | Horatio |      7 |   35 |  31 | 102 | 1998-11-10 | 104 | Marine    | red   |
|  58 | Rusty   |     10 |   35 |  31 | 102 | 1998-11-10 | 101 | Interlake | blue  |
|  58 | Rusty   |     10 |   35 |  31 | 102 | 1998-11-10 | 102 | Interlake | red   |
|  58 | Rusty   |     10 |   35 |  31 | 102 | 1998-11-10 | 103 | Clipper   | green |
|  58 | Rusty   |     10 |   35 |  31 | 102 | 1998-11-10 | 104 | Marine    | red   |
|  32 | Andy    |      8 | 25.5 |  31 | 102 | 1998-11-10 | 101 | Interlake | blue  |
|  32 | Andy    |      8 | 25.5 |  31 | 102 | 1998-11-10 | 102 | Interlake | red   |
|  32 | Andy    |      8 | 25.5 |  31 | 102 | 1998-11-10 | 103 | Clipper   | green |
|  32 | Andy    |      8 | 25.5 |  31 | 102 | 1998-11-10 | 104 | Marine    | red   |
|  31 | Lubber  |      8 | 55.5 |  31 | 102 | 1998-11-10 | 101 | Interlake | blue  |
|  31 | Lubber  |      8 | 55.5 |  31 | 102 | 1998-11-10 | 102 | Interlake | red   |
|  31 | Lubber  |      8 | 55.5 |  31 | 102 | 1998-11-10 | 103 | Clipper   | green |
|  31 | Lubber  |      8 | 55.5 |  31 | 102 | 1998-11-10 | 104 | Marine    | red   |
|  29 | Brutus  |      1 |   33 |  31 | 102 | 1998-11-10 | 101 | Interlake | blue  |
|  29 | Brutus  |      1 |   33 |  31 | 102 | 1998-11-10 | 102 | Interlake | red   |
|  29 | Brutus  |      1 |   33 |  31 | 102 | 1998-11-10 | 103 | Clipper   | green |
|  29 | Brutus  |      1 |   33 |  31 | 102 | 1998-11-10 | 104 | Marine    | red   |
|  22 | Dustin  |      7 |   45 |  31 | 102 | 1998-11-10 | 101 | Interlake | blue  |
|  22 | Dustin  |      7 |   45 |  31 | 102 | 1998-11-10 | 102 | Interlake | red   |
|  22 | Dustin  |      7 |   45 |  31 | 102 | 1998-11-10 | 103 | Clipper   | green |
|  22 | Dustin  |      7 |   45 |  31 | 102 | 1998-11-10 | 104 | Marine    | red   |
|  95 | Bob     |      3 | 63.5 |  31 | 103 | 1998-11-06 | 101 | Interlake | blue  |
|  95 | Bob     |      3 | 63.5 |  31 | 103 | 1998-11-06 | 102 | Interlake | red   |
|  95 | Bob     |      3 | 63.5 |  31 | 103 | 1998-11-06 | 103 | Clipper   | green |
|  95 | Bob     |      3 | 63.5 |  31 | 103 | 1998-11-06 | 104 | Marine    | red   |
|  85 | Art     |      3 | 25.5 |  31 | 103 | 1998-11-06 | 101 | Interlake | blue  |
|  85 | Art     |      3 | 25.5 |  31 | 103 | 1998-11-06 | 102 | Interlake | red   |
|  85 | Art     |      3 | 25.5 |  31 | 103 | 1998-11-06 | 103 | Clipper   | green |
|  85 | Art     |      3 | 25.5 |  31 | 103 | 1998-11-06 | 104 | Marine    | red   |
|  74 | Horatio |      9 |   40 |  31 | 103 | 1998-11-06 | 101 | Interlake | blue  |
|  74 | Horatio |      9 |   40 |  31 | 103 | 1998-11-06 | 102 | Interlake | red   |
|  74 | Horatio |      9 |   40 |  31 | 103 | 1998-11-06 | 103 | Clipper   | green |
|  74 | Horatio |      9 |   40 |  31 | 103 | 1998-11-06 | 104 | Marine    | red   |
|  71 | Zorba   |     10 |   16 |  31 | 103 | 1998-11-06 | 101 | Interlake | blue  |
|  71 | Zorba   |     10 |   16 |  31 | 103 | 1998-11-06 | 102 | Interlake | red   |
|  71 | Zorba   |     10 |   16 |  31 | 103 | 1998-11-06 | 103 | Clipper   | green |
|  71 | Zorba   |     10 |   16 |  31 | 103 | 1998-11-06 | 104 | Marine    | red   |
|  64 | Horatio |      7 |   35 |  31 | 103 | 1998-11-06 | 101 | Interlake | blue  |
|  64 | Horatio |      7 |   35 |  31 | 103 | 1998-11-06 | 102 | Interlake | red   |
|  64 | Horatio |      7 |   35 |  31 | 103 | 1998-11-06 | 103 | Clipper   | green |
|  64 | Horatio |      7 |   35 |  31 | 103 | 1998-11-06 | 104 | Marine    | red   |
|  58 | Rusty   |     10 |   35 |  31 | 103 | 1998-11-06 | 101 | Interlake | blue  |
|  58 | Rusty   |     10 |   35 |  31 | 103 | 1998-11-06 | 102 | Interlake | red   |
|  58 | Rusty   |     10 |   35 |  31 | 103 | 1998-11-06 | 103 | Clipper   | green |
|  58 | Rusty   |     10 |   35 |  31 | 103 | 1998-11-06 | 104 | Marine    | red   |
|  32 | Andy    |      8 | 25.5 |  31 | 103 | 1998-11-06 | 101 | Interlake | blue  |
|  32 | Andy    |      8 | 25.5 |  31 | 103 | 1998-11-06 | 102 | Interlake | red   |
|  32 | Andy    |      8 | 25.5 |  31 | 103 | 1998-11-06 | 103 | Clipper   | green |
|  32 | Andy    |      8 | 25.5 |  31 | 103 | 1998-11-06 | 104 | Marine    | red   |
|  31 | Lubber  |      8 | 55.5 |  31 | 103 | 1998-11-06 | 101 | Interlake | blue  |
|  31 | Lubber  |      8 | 55.5 |  31 | 103 | 1998-11-06 | 102 | Interlake | red   |
|  31 | Lubber  |      8 | 55.5 |  31 | 103 | 1998-11-06 | 103 | Clipper   | green |
|  31 | Lubber  |      8 | 55.5 |  31 | 103 | 1998-11-06 | 104 | Marine    | red   |
|  29 | Brutus  |      1 |   33 |  31 | 103 | 1998-11-06 | 101 | Interlake | blue  |
|  29 | Brutus  |      1 |   33 |  31 | 103 | 1998-11-06 | 102 | Interlake | red   |
|  29 | Brutus  |      1 |   33 |  31 | 103 | 1998-11-06 | 103 | Clipper   | green |
|  29 | Brutus  |      1 |   33 |  31 | 103 | 1998-11-06 | 104 | Marine    | red   |
|  22 | Dustin  |      7 |   45 |  31 | 103 | 1998-11-06 | 101 | Interlake | blue  |
|  22 | Dustin  |      7 |   45 |  31 | 103 | 1998-11-06 | 102 | Interlake | red   |
|  22 | Dustin  |      7 |   45 |  31 | 103 | 1998-11-06 | 103 | Clipper   | green |
|  22 | Dustin  |      7 |   45 |  31 | 103 | 1998-11-06 | 104 | Marine    | red   |
|  95 | Bob     |      3 | 63.5 |  31 | 104 | 1998-11-12 | 101 | Interlake | blue  |
|  95 | Bob     |      3 | 63.5 |  31 | 104 | 1998-11-12 | 102 | Interlake | red   |
|  95 | Bob     |      3 | 63.5 |  31 | 104 | 1998-11-12 | 103 | Clipper   | green |
|  95 | Bob     |      3 | 63.5 |  31 | 104 | 1998-11-12 | 104 | Marine    | red   |
|  85 | Art     |      3 | 25.5 |  31 | 104 | 1998-11-12 | 101 | Interlake | blue  |
|  85 | Art     |      3 | 25.5 |  31 | 104 | 1998-11-12 | 102 | Interlake | red   |
|  85 | Art     |      3 | 25.5 |  31 | 104 | 1998-11-12 | 103 | Clipper   | green |
|  85 | Art     |      3 | 25.5 |  31 | 104 | 1998-11-12 | 104 | Marine    | red   |
|  74 | Horatio |      9 |   40 |  31 | 104 | 1998-11-12 | 101 | Interlake | blue  |
|  74 | Horatio |      9 |   40 |  31 | 104 | 1998-11-12 | 102 | Interlake | red   |
|  74 | Horatio |      9 |   40 |  31 | 104 | 1998-11-12 | 103 | Clipper   | green |
|  74 | Horatio |      9 |   40 |  31 | 104 | 1998-11-12 | 104 | Marine    | red   |
|  71 | Zorba   |     10 |   16 |  31 | 104 | 1998-11-12 | 101 | Interlake | blue  |
|  71 | Zorba   |     10 |   16 |  31 | 104 | 1998-11-12 | 102 | Interlake | red   |
|  71 | Zorba   |     10 |   16 |  31 | 104 | 1998-11-12 | 103 | Clipper   | green |
|  71 | Zorba   |     10 |   16 |  31 | 104 | 1998-11-12 | 104 | Marine    | red   |
|  64 | Horatio |      7 |   35 |  31 | 104 | 1998-11-12 | 101 | Interlake | blue  |
|  64 | Horatio |      7 |   35 |  31 | 104 | 1998-11-12 | 102 | Interlake | red   |
|  64 | Horatio |      7 |   35 |  31 | 104 | 1998-11-12 | 103 | Clipper   | green |
|  64 | Horatio |      7 |   35 |  31 | 104 | 1998-11-12 | 104 | Marine    | red   |
|  58 | Rusty   |     10 |   35 |  31 | 104 | 1998-11-12 | 101 | Interlake | blue  |
|  58 | Rusty   |     10 |   35 |  31 | 104 | 1998-11-12 | 102 | Interlake | red   |
|  58 | Rusty   |     10 |   35 |  31 | 104 | 1998-11-12 | 103 | Clipper   | green |
|  58 | Rusty   |     10 |   35 |  31 | 104 | 1998-11-12 | 104 | Marine    | red   |
|  32 | Andy    |      8 | 25.5 |  31 | 104 | 1998-11-12 | 101 | Interlake | blue  |
|  32 | Andy    |      8 | 25.5 |  31 | 104 | 1998-11-12 | 102 | Interlake | red   |
|  32 | Andy    |      8 | 25.5 |  31 | 104 | 1998-11-12 | 103 | Clipper   | green |
|  32 | Andy    |      8 | 25.5 |  31 | 104 | 1998-11-12 | 104 | Marine    | red   |
|  31 | Lubber  |      8 | 55.5 |  31 | 104 | 1998-11-12 | 101 | Interlake | blue  |
|  31 | Lubber  |      8 | 55.5 |  31 | 104 | 1998-11-12 | 102 | Interlake | red   |
|  31 | Lubber  |      8 | 55.5 |  31 | 104 | 1998-11-12 | 103 | Clipper   | green |
|  31 | Lubber  |      8 | 55.5 |  31 | 104 | 1998-11-12 | 104 | Marine    | red   |
|  29 | Brutus  |      1 |   33 |  31 | 104 | 1998-11-12 | 101 | Interlake | blue  |
|  29 | Brutus  |      1 |   33 |  31 | 104 | 1998-11-12 | 102 | Interlake | red   |
|  29 | Brutus  |      1 |   33 |  31 | 104 | 1998-11-12 | 103 | Clipper   | green |
|  29 | Brutus  |      1 |   33 |  31 | 104 | 1998-11-12 | 104 | Marine    | red   |
|  22 | Dustin  |      7 |   45 |  31 | 104 | 1998-11-12 | 101 | Interlake | blue  |
|  22 | Dustin  |      7 |   45 |  31 | 104 | 1998-11-12 | 102 | Interlake | red   |
|  22 | Dustin  |      7 |   45 |  31 | 104 | 1998-11-12 | 103 | Clipper   | green |
|  22 | Dustin  |      7 |   45 |  31 | 104 | 1998-11-12 | 104 | Marine    | red   |
|  95 | Bob     |      3 | 63.5 |  64 | 101 | 1998-09-05 | 101 | Interlake | blue  |
|  95 | Bob     |      3 | 63.5 |  64 | 101 | 1998-09-05 | 102 | Interlake | red   |
|  95 | Bob     |      3 | 63.5 |  64 | 101 | 1998-09-05 | 103 | Clipper   | green |
|  95 | Bob     |      3 | 63.5 |  64 | 101 | 1998-09-05 | 104 | Marine    | red   |
|  85 | Art     |      3 | 25.5 |  64 | 101 | 1998-09-05 | 101 | Interlake | blue  |
|  85 | Art     |      3 | 25.5 |  64 | 101 | 1998-09-05 | 102 | Interlake | red   |
|  85 | Art     |      3 | 25.5 |  64 | 101 | 1998-09-05 | 103 | Clipper   | green |
|  85 | Art     |      3 | 25.5 |  64 | 101 | 1998-09-05 | 104 | Marine    | red   |
|  74 | Horatio |      9 |   40 |  64 | 101 | 1998-09-05 | 101 | Interlake | blue  |
|  74 | Horatio |      9 |   40 |  64 | 101 | 1998-09-05 | 102 | Interlake | red   |
|  74 | Horatio |      9 |   40 |  64 | 101 | 1998-09-05 | 103 | Clipper   | green |
|  74 | Horatio |      9 |   40 |  64 | 101 | 1998-09-05 | 104 | Marine    | red   |
|  71 | Zorba   |     10 |   16 |  64 | 101 | 1998-09-05 | 101 | Interlake | blue  |
|  71 | Zorba   |     10 |   16 |  64 | 101 | 1998-09-05 | 102 | Interlake | red   |
|  71 | Zorba   |     10 |   16 |  64 | 101 | 1998-09-05 | 103 | Clipper   | green |
|  71 | Zorba   |     10 |   16 |  64 | 101 | 1998-09-05 | 104 | Marine    | red   |
|  64 | Horatio |      7 |   35 |  64 | 101 | 1998-09-05 | 101 | Interlake | blue  |
|  64 | Horatio |      7 |   35 |  64 | 101 | 1998-09-05 | 102 | Interlake | red   |
|  64 | Horatio |      7 |   35 |  64 | 101 | 1998-09-05 | 103 | Clipper   | green |
|  64 | Horatio |      7 |   35 |  64 | 101 | 1998-09-05 | 104 | Marine    | red   |
|  58 | Rusty   |     10 |   35 |  64 | 101 | 1998-09-05 | 101 | Interlake | blue  |
|  58 | Rusty   |     10 |   35 |  64 | 101 | 1998-09-05 | 102 | Interlake | red   |
|  58 | Rusty   |     10 |   35 |  64 | 101 | 1998-09-05 | 103 | Clipper   | green |
|  58 | Rusty   |     10 |   35 |  64 | 101 | 1998-09-05 | 104 | Marine    | red   |
|  32 | Andy    |      8 | 25.5 |  64 | 101 | 1998-09-05 | 101 | Interlake | blue  |
|  32 | Andy    |      8 | 25.5 |  64 | 101 | 1998-09-05 | 102 | Interlake | red   |
|  32 | Andy    |      8 | 25.5 |  64 | 101 | 1998-09-05 | 103 | Clipper   | green |
|  32 | Andy    |      8 | 25.5 |  64 | 101 | 1998-09-05 | 104 | Marine    | red   |
|  31 | Lubber  |      8 | 55.5 |  64 | 101 | 1998-09-05 | 101 | Interlake | blue  |
|  31 | Lubber  |      8 | 55.5 |  64 | 101 | 1998-09-05 | 102 | Interlake | red   |
|  31 | Lubber  |      8 | 55.5 |  64 | 101 | 1998-09-05 | 103 | Clipper   | green |
|  31 | Lubber  |      8 | 55.5 |  64 | 101 | 1998-09-05 | 104 | Marine    | red   |
|  29 | Brutus  |      1 |   33 |  64 | 101 | 1998-09-05 | 101 | Interlake | blue  |
|  29 | Brutus  |      1 |   33 |  64 | 101 | 1998-09-05 | 102 | Interlake | red   |
|  29 | Brutus  |      1 |   33 |  64 | 101 | 1998-09-05 | 103 | Clipper   | green |
|  29 | Brutus  |      1 |   33 |  64 | 101 | 1998-09-05 | 104 | Marine    | red   |
|  22 | Dustin  |      7 |   45 |  64 | 101 | 1998-09-05 | 101 | Interlake | blue  |
|  22 | Dustin  |      7 |   45 |  64 | 101 | 1998-09-05 | 102 | Interlake | red   |
|  22 | Dustin  |      7 |   45 |  64 | 101 | 1998-09-05 | 103 | Clipper   | green |
|  22 | Dustin  |      7 |   45 |  64 | 101 | 1998-09-05 | 104 | Marine    | red   |
|  95 | Bob     |      3 | 63.5 |  64 | 102 | 1998-09-08 | 101 | Interlake | blue  |
|  95 | Bob     |      3 | 63.5 |  64 | 102 | 1998-09-08 | 102 | Interlake | red   |
|  95 | Bob     |      3 | 63.5 |  64 | 102 | 1998-09-08 | 103 | Clipper   | green |
|  95 | Bob     |      3 | 63.5 |  64 | 102 | 1998-09-08 | 104 | Marine    | red   |
|  85 | Art     |      3 | 25.5 |  64 | 102 | 1998-09-08 | 101 | Interlake | blue  |
|  85 | Art     |      3 | 25.5 |  64 | 102 | 1998-09-08 | 102 | Interlake | red   |
|  85 | Art     |      3 | 25.5 |  64 | 102 | 1998-09-08 | 103 | Clipper   | green |
|  85 | Art     |      3 | 25.5 |  64 | 102 | 1998-09-08 | 104 | Marine    | red   |
|  74 | Horatio |      9 |   40 |  64 | 102 | 1998-09-08 | 101 | Interlake | blue  |
|  74 | Horatio |      9 |   40 |  64 | 102 | 1998-09-08 | 102 | Interlake | red   |
|  74 | Horatio |      9 |   40 |  64 | 102 | 1998-09-08 | 103 | Clipper   | green |
|  74 | Horatio |      9 |   40 |  64 | 102 | 1998-09-08 | 104 | Marine    | red   |
|  71 | Zorba   |     10 |   16 |  64 | 102 | 1998-09-08 | 101 | Interlake | blue  |
|  71 | Zorba   |     10 |   16 |  64 | 102 | 1998-09-08 | 102 | Interlake | red   |
|  71 | Zorba   |     10 |   16 |  64 | 102 | 1998-09-08 | 103 | Clipper   | green |
|  71 | Zorba   |     10 |   16 |  64 | 102 | 1998-09-08 | 104 | Marine    | red   |
|  64 | Horatio |      7 |   35 |  64 | 102 | 1998-09-08 | 101 | Interlake | blue  |
|  64 | Horatio |      7 |   35 |  64 | 102 | 1998-09-08 | 102 | Interlake | red   |
|  64 | Horatio |      7 |   35 |  64 | 102 | 1998-09-08 | 103 | Clipper   | green |
|  64 | Horatio |      7 |   35 |  64 | 102 | 1998-09-08 | 104 | Marine    | red   |
|  58 | Rusty   |     10 |   35 |  64 | 102 | 1998-09-08 | 101 | Interlake | blue  |
|  58 | Rusty   |     10 |   35 |  64 | 102 | 1998-09-08 | 102 | Interlake | red   |
|  58 | Rusty   |     10 |   35 |  64 | 102 | 1998-09-08 | 103 | Clipper   | green |
|  58 | Rusty   |     10 |   35 |  64 | 102 | 1998-09-08 | 104 | Marine    | red   |
|  32 | Andy    |      8 | 25.5 |  64 | 102 | 1998-09-08 | 101 | Interlake | blue  |
|  32 | Andy    |      8 | 25.5 |  64 | 102 | 1998-09-08 | 102 | Interlake | red   |
|  32 | Andy    |      8 | 25.5 |  64 | 102 | 1998-09-08 | 103 | Clipper   | green |
|  32 | Andy    |      8 | 25.5 |  64 | 102 | 1998-09-08 | 104 | Marine    | red   |
|  31 | Lubber  |      8 | 55.5 |  64 | 102 | 1998-09-08 | 101 | Interlake | blue  |
|  31 | Lubber  |      8 | 55.5 |  64 | 102 | 1998-09-08 | 102 | Interlake | red   |
|  31 | Lubber  |      8 | 55.5 |  64 | 102 | 1998-09-08 | 103 | Clipper   | green |
|  31 | Lubber  |      8 | 55.5 |  64 | 102 | 1998-09-08 | 104 | Marine    | red   |
|  29 | Brutus  |      1 |   33 |  64 | 102 | 1998-09-08 | 101 | Interlake | blue  |
|  29 | Brutus  |      1 |   33 |  64 | 102 | 1998-09-08 | 102 | Interlake | red   |
|  29 | Brutus  |      1 |   33 |  64 | 102 | 1998-09-08 | 103 | Clipper   | green |
|  29 | Brutus  |      1 |   33 |  64 | 102 | 1998-09-08 | 104 | Marine    | red   |
|  22 | Dustin  |      7 |   45 |  64 | 102 | 1998-09-08 | 101 | Interlake | blue  |
|  22 | Dustin  |      7 |   45 |  64 | 102 | 1998-09-08 | 102 | Interlake | red   |
|  22 | Dustin  |      7 |   45 |  64 | 102 | 1998-09-08 | 103 | Clipper   | green |
|  22 | Dustin  |      7 |   45 |  64 | 102 | 1998-09-08 | 104 | Marine    | red   |
|  95 | Bob     |      3 | 63.5 |  74 | 103 | 1998-09-08 | 101 | Interlake | blue  |
|  95 | Bob     |      3 | 63.5 |  74 | 103 | 1998-09-08 | 102 | Interlake | red   |
|  95 | Bob     |      3 | 63.5 |  74 | 103 | 1998-09-08 | 103 | Clipper   | green |
|  95 | Bob     |      3 | 63.5 |  74 | 103 | 1998-09-08 | 104 | Marine    | red   |
|  85 | Art     |      3 | 25.5 |  74 | 103 | 1998-09-08 | 101 | Interlake | blue  |
|  85 | Art     |      3 | 25.5 |  74 | 103 | 1998-09-08 | 102 | Interlake | red   |
|  85 | Art     |      3 | 25.5 |  74 | 103 | 1998-09-08 | 103 | Clipper   | green |
|  85 | Art     |      3 | 25.5 |  74 | 103 | 1998-09-08 | 104 | Marine    | red   |
|  74 | Horatio |      9 |   40 |  74 | 103 | 1998-09-08 | 101 | Interlake | blue  |
|  74 | Horatio |      9 |   40 |  74 | 103 | 1998-09-08 | 102 | Interlake | red   |
|  74 | Horatio |      9 |   40 |  74 | 103 | 1998-09-08 | 103 | Clipper   | green |
|  74 | Horatio |      9 |   40 |  74 | 103 | 1998-09-08 | 104 | Marine    | red   |
|  71 | Zorba   |     10 |   16 |  74 | 103 | 1998-09-08 | 101 | Interlake | blue  |
|  71 | Zorba   |     10 |   16 |  74 | 103 | 1998-09-08 | 102 | Interlake | red   |
|  71 | Zorba   |     10 |   16 |  74 | 103 | 1998-09-08 | 103 | Clipper   | green |
|  71 | Zorba   |     10 |   16 |  74 | 103 | 1998-09-08 | 104 | Marine    | red   |
|  64 | Horatio |      7 |   35 |  74 | 103 | 1998-09-08 | 101 | Interlake | blue  |
|  64 | Horatio |      7 |   35 |  74 | 103 | 1998-09-08 | 102 | Interlake | red   |
|  64 | Horatio |      7 |   35 |  74 | 103 | 1998-09-08 | 103 | Clipper   | green |
|  64 | Horatio |      7 |   35 |  74 | 103 | 1998-09-08 | 104 | Marine    | red   |
|  58 | Rusty   |     10 |   35 |  74 | 103 | 1998-09-08 | 101 | Interlake | blue  |
|  58 | Rusty   |     10 |   35 |  74 | 103 | 1998-09-08 | 102 | Interlake | red   |
|  58 | Rusty   |     10 |   35 |  74 | 103 | 1998-09-08 | 103 | Clipper   | green |
|  58 | Rusty   |     10 |   35 |  74 | 103 | 1998-09-08 | 104 | Marine    | red   |
|  32 | Andy    |      8 | 25.5 |  74 | 103 | 1998-09-08 | 101 | Interlake | blue  |
|  32 | Andy    |      8 | 25.5 |  74 | 103 | 1998-09-08 | 102 | Interlake | red   |
|  32 | Andy    |      8 | 25.5 |  74 | 103 | 1998-09-08 | 103 | Clipper   | green |
|  32 | Andy    |      8 | 25.5 |  74 | 103 | 1998-09-08 | 104 | Marine    | red   |
|  31 | Lubber  |      8 | 55.5 |  74 | 103 | 1998-09-08 | 101 | Interlake | blue  |
|  31 | Lubber  |      8 | 55.5 |  74 | 103 | 1998-09-08 | 102 | Interlake | red   |
|  31 | Lubber  |      8 | 55.5 |  74 | 103 | 1998-09-08 | 103 | Clipper   | green |
|  31 | Lubber  |      8 | 55.5 |  74 | 103 | 1998-09-08 | 104 | Marine    | red   |
|  29 | Brutus  |      1 |   33 |  74 | 103 | 1998-09-08 | 101 | Interlake | blue  |
|  29 | Brutus  |      1 |   33 |  74 | 103 | 1998-09-08 | 102 | Interlake | red   |
|  29 | Brutus  |      1 |   33 |  74 | 103 | 1998-09-08 | 103 | Clipper   | green |
|  29 | Brutus  |      1 |   33 |  74 | 103 | 1998-09-08 | 104 | Marine    | red   |
|  22 | Dustin  |      7 |   45 |  74 | 103 | 1998-09-08 | 101 | Interlake | blue  |
|  22 | Dustin  |      7 |   45 |  74 | 103 | 1998-09-08 | 102 | Interlake | red   |
|  22 | Dustin  |      7 |   45 |  74 | 103 | 1998-09-08 | 103 | Clipper   | green |
|  22 | Dustin  |      7 |   45 |  74 | 103 | 1998-09-08 | 104 | Marine    | red   |
+-----+---------+--------+------+-----+-----+------------+-----+-----------+-------+
400 rows in set (0.00 sec)

mysql> 

