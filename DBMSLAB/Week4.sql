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
8 rows in set (0.01 sec)

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
10 rows in set (0.01 sec)

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
10 rows in set (0.01 sec)

mysql> select * from boats;
+-----+-----------+-------+
| bid | bname     | color |
+-----+-----------+-------+
| 101 | Interlake | blue  |
| 102 | Interlake | red   |
| 103 | Clipper   | green |
| 104 | Marine    | red   |
+-----+-----------+-------+
4 rows in set (0.01 sec)

mysql> select bid from reserves where Sid not in(select Sid from Sailors where Sname='Lubber');
+-----+
| bid |
+-----+
| 101 |
| 101 |
| 102 |
| 102 |
| 103 |
| 103 |
| 104 |
+-----+
7 rows in set (0.01 sec)

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

mysql> select * from Sailors,reserves where Sailors.Sid=reserves.Sid;
+-----+---------+--------+------+-----+-----+------------+
| Sid | Sname   | rating | age  | Sid | bid | day        |
+-----+---------+--------+------+-----+-----+------------+
|  22 | Dustin  |      7 |   45 |  22 | 101 | 1998-10-10 |
|  22 | Dustin  |      7 |   45 |  22 | 102 | 1998-10-10 |
|  22 | Dustin  |      7 |   45 |  22 | 103 | 1998-10-08 |
|  22 | Dustin  |      7 |   45 |  22 | 104 | 1998-10-07 |
|  31 | Lubber  |      8 | 55.5 |  31 | 102 | 1998-11-10 |
|  31 | Lubber  |      8 | 55.5 |  31 | 103 | 1998-11-06 |
|  31 | Lubber  |      8 | 55.5 |  31 | 104 | 1998-11-12 |
|  64 | Horatio |      7 |   35 |  64 | 101 | 1998-09-05 |
|  64 | Horatio |      7 |   35 |  64 | 102 | 1998-09-08 |
|  74 | Horatio |      9 |   40 |  74 | 103 | 1998-09-08 |
+-----+---------+--------+------+-----+-----+------------+
10 rows in set (0.00 sec)

mysql> select * from reserves,boats  where reserves.bid=boats.bid
    -> ;
+-----+-----+------------+-----+-----------+-------+
| Sid | bid | day        | bid | bname     | color |
+-----+-----+------------+-----+-----------+-------+
|  22 | 101 | 1998-10-10 | 101 | Interlake | blue  |
|  64 | 101 | 1998-09-05 | 101 | Interlake | blue  |
|  22 | 102 | 1998-10-10 | 102 | Interlake | red   |
|  31 | 102 | 1998-11-10 | 102 | Interlake | red   |
|  64 | 102 | 1998-09-08 | 102 | Interlake | red   |
|  22 | 103 | 1998-10-08 | 103 | Clipper   | green |
|  31 | 103 | 1998-11-06 | 103 | Clipper   | green |
|  74 | 103 | 1998-09-08 | 103 | Clipper   | green |
|  22 | 104 | 1998-10-07 | 104 | Marine    | red   |
|  31 | 104 | 1998-11-12 | 104 | Marine    | red   |
+-----+-----+------------+-----+-----------+-------+
10 rows in set (0.00 sec)

mysql> select * from Sailors,reserves where Sailors.Sid=reserves.Sid and bid=103;
+-----+---------+--------+------+-----+-----+------------+
| Sid | Sname   | rating | age  | Sid | bid | day        |
+-----+---------+--------+------+-----+-----+------------+
|  22 | Dustin  |      7 |   45 |  22 | 103 | 1998-10-08 |
|  31 | Lubber  |      8 | 55.5 |  31 | 103 | 1998-11-06 |
|  74 | Horatio |      9 |   40 |  74 | 103 | 1998-09-08 |
+-----+---------+--------+------+-----+-----+------------+
3 rows in set (0.00 sec)

mysql> select Sname from Sailors,reserves where Sailors.Sid=reserves.Sid and bid=103;
+---------+
| Sname   |
+---------+
| Dustin  |
| Lubber  |
| Horatio |
+---------+
3 rows in set (0.00 sec)

mysql> select Sname,day from Sailors,reserves where Sailors.Sid=reserves.Sid;
+---------+------------+
| Sname   | day        |
+---------+------------+
| Dustin  | 1998-10-10 |
| Dustin  | 1998-10-10 |
| Dustin  | 1998-10-08 |
| Dustin  | 1998-10-07 |
| Lubber  | 1998-11-10 |
| Lubber  | 1998-11-06 |
| Lubber  | 1998-11-12 |
| Horatio | 1998-09-05 |
| Horatio | 1998-09-08 |
| Horatio | 1998-09-08 |
+---------+------------+
10 rows in set (0.00 sec)

mysql> select Sname,day from Sailors,reserves where Sailors.Sid=reserves.Sid and bid=103;
+---------+------------+
| Sname   | day        |
+---------+------------+
| Dustin  | 1998-10-08 |
| Lubber  | 1998-11-06 |
| Horatio | 1998-09-08 |
+---------+------------+
3 rows in set (0.00 sec)

mysql> select Sname,day,bid from Sailors,reserves where Sailors.Sid=reserves.Sid;
+---------+------------+-----+
| Sname   | day        | bid |
+---------+------------+-----+
| Dustin  | 1998-10-10 | 101 |
| Dustin  | 1998-10-10 | 102 |
| Dustin  | 1998-10-08 | 103 |
| Dustin  | 1998-10-07 | 104 |
| Lubber  | 1998-11-10 | 102 |
| Lubber  | 1998-11-06 | 103 |
| Lubber  | 1998-11-12 | 104 |
| Horatio | 1998-09-05 | 101 |
| Horatio | 1998-09-08 | 102 |
| Horatio | 1998-09-08 | 103 |
+---------+------------+-----+
10 rows in set (0.00 sec)

mysql> select Sname from Sailors where Sid in(select Sid from reserves where bid in(select bid from boats where color='green' or color='red'));
+---------+
| Sname   |
+---------+
| Dustin  |
| Lubber  |
| Horatio |
| Horatio |
+---------+
4 rows in set (0.00 sec)

mysql> select Sname from Sailors where Sid in(select Sid from reserves where bid in(select bid from boats where color='green' and color='red'));
Empty set (0.01 sec)

mysql> select Sname from Sailors where Sid in(select Sid from reserves where bid in(select bid from boats where color='green' and color='red'));
Empty set (0.00 sec)

mysql> select Sname from Sailors s,reserves r1,reserves r2 where s.Sid=r1.Sid and r1.Sid=r2.Sid and r1.bid!=r2.bid;
+---------+
| Sname   |
+---------+
| Dustin  |
| Dustin  |
| Dustin  |
| Horatio |
| Dustin  |
| Dustin  |
| Dustin  |
| Lubber  |
| Lubber  |
| Horatio |
| Dustin  |
| Dustin  |
| Dustin  |
| Lubber  |
| Lubber  |
| Dustin  |
| Dustin  |
| Dustin  |
| Lubber  |
| Lubber  |
+---------+
20 rows in set (0.01 sec)

mysql> select Sname,r1.bid,r2.bid from Sailors s,reserves r1,reserves r2 where s.Sid=r1.Sid and r1.Sid=r2.Sid and r1.bid!=r2.bid;
+---------+-----+-----+
| Sname   | bid | bid |
+---------+-----+-----+
| Dustin  | 101 | 102 |
| Dustin  | 101 | 103 |
| Dustin  | 101 | 104 |
| Horatio | 101 | 102 |
| Dustin  | 102 | 101 |
| Dustin  | 102 | 103 |
| Dustin  | 102 | 104 |
| Lubber  | 102 | 103 |
| Lubber  | 102 | 104 |
| Horatio | 102 | 101 |
| Dustin  | 103 | 101 |
| Dustin  | 103 | 102 |
| Dustin  | 103 | 104 |
| Lubber  | 103 | 102 |
| Lubber  | 103 | 104 |
| Dustin  | 104 | 101 |
| Dustin  | 104 | 102 |
| Dustin  | 104 | 103 |
| Lubber  | 104 | 102 |
| Lubber  | 104 | 103 |
+---------+-----+-----+
20 rows in set (0.00 sec)

mysql> select distinct  Sname,r1.bid,r2.bid from Sailors s,reserves r1,reserves r2 where s.Sid=r1.Sid and r1.Sid=r2.Sid and r1.bid!=r2.bid;
+---------+-----+-----+
| Sname   | bid | bid |
+---------+-----+-----+
| Dustin  | 101 | 102 |
| Dustin  | 101 | 103 |
| Dustin  | 101 | 104 |
| Horatio | 101 | 102 |
| Dustin  | 102 | 101 |
| Dustin  | 102 | 103 |
| Dustin  | 102 | 104 |
| Lubber  | 102 | 103 |
| Lubber  | 102 | 104 |
| Horatio | 102 | 101 |
| Dustin  | 103 | 101 |
| Dustin  | 103 | 102 |
| Dustin  | 103 | 104 |
| Lubber  | 103 | 102 |
| Lubber  | 103 | 104 |
| Dustin  | 104 | 101 |
| Dustin  | 104 | 102 |
| Dustin  | 104 | 103 |
| Lubber  | 104 | 102 |
| Lubber  | 104 | 103 |
+---------+-----+-----+
20 rows in set (0.00 sec)

mysql> select distinct( Sname),r1.bid,r2.bid from Sailors s,reserves r1,reserves r2 where s.Sid=r1.Sid and r1.Sid=r2.Sid and r1.bid!=r2.bid;
+---------+-----+-----+
| Sname   | bid | bid |
+---------+-----+-----+
| Dustin  | 101 | 102 |
| Dustin  | 101 | 103 |
| Dustin  | 101 | 104 |
| Horatio | 101 | 102 |
| Dustin  | 102 | 101 |
| Dustin  | 102 | 103 |
| Dustin  | 102 | 104 |
| Lubber  | 102 | 103 |
| Lubber  | 102 | 104 |
| Horatio | 102 | 101 |
| Dustin  | 103 | 101 |
| Dustin  | 103 | 102 |
| Dustin  | 103 | 104 |
| Lubber  | 103 | 102 |
| Lubber  | 103 | 104 |
| Dustin  | 104 | 101 |
| Dustin  | 104 | 102 |
| Dustin  | 104 | 103 |
| Lubber  | 104 | 102 |
| Lubber  | 104 | 103 |
+---------+-----+-----+
20 rows in set (0.00 sec)

mysql> select Sid,count(*) from reserves group by Sid;
+-----+----------+
| Sid | count(*) |
+-----+----------+
|  22 |        4 |
|  31 |        3 |
|  64 |        2 |
|  74 |        1 |
+-----+----------+
4 rows in set (0.00 sec)

mysql> select Sid,count(*) from reserves group by Sid having count(*)=4;
+-----+----------+
| Sid | count(*) |
+-----+----------+
|  22 |        4 |
+-----+----------+
1 row in set (0.00 sec)

mysql> select Sid,count(*) from reserves group by Sid having count(*)>=2;
+-----+----------+
| Sid | count(*) |
+-----+----------+
|  22 |        4 |
|  31 |        3 |
|  64 |        2 |
+-----+----------+
3 rows in set (0.00 sec)

mysql> select Sname from Sailors where Sid in(select Sid from reserves group by Sid having count(*)>=2);
+---------+
| Sname   |
+---------+
| Dustin  |
| Lubber  |
| Horatio |
+---------+
3 rows in set (0.01 sec)

mysql> select Sname from Sailors where Sid in(select Sid,count(*) from reserves group by Sid having count(*)>=2);
ERROR 1241 (21000): Operand should contain 1 column(s)
mysql> select bid from boats where color='red' or color='green';
+-----+
| bid |
+-----+
| 102 |
| 103 |
| 104 |
+-----+
3 rows in set (0.00 sec)

mysql> select bid from boats where color='red' and  color='green';
Empty set (0.00 sec)

mysql> select Sid from Sailors where Sid in (select Sid from reserves where bid in(select bid from boats where bid in(select bid from boats where color='red') and bid in(select bid from boats where color='green')));
Empty set (0.01 sec)

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

mysql> select Sid from reserves where bid in(select bid from boats where color='green');
+-----+
| Sid |
+-----+
|  22 |
|  31 |
|  74 |
+-----+
3 rows in set (0.00 sec)

mysql> select Sid from reserves where bid in(select bid from boats where color='green' and select bid from boats where color='green');
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'select bid from boats where color='green')' at line 1
mysql> (select Sid from reserves where bid in(select bid from boats where color='green') intersect(select Sid from reserves where bid in(select bid from boats where color='red');
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '' at line 1
mysql> (select Sid from reserves where bid in(select bid from boats where color='green') intersect(select Sid from reserves where bid in(select bid from boats where color='red'));
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '' at line 1
mysql> (select Sid from reserves where bid in(select bid from boats where color='green'))intersect(select Sid from reserves where bid in(select bid from boats where color='red'));
+-----+
| Sid |
+-----+
|  22 |
|  31 |
+-----+
2 rows in set (0.00 sec)

mysql> select Sname from Sailors where Sid in(select Sid from reserves where bid in(select bid from boats where color='green'))intersect(select Sid from reserves where bid in(select
bid from boats where color='red'));
Empty set (0.00 sec)

mysql> select Sname from Sailors in(select Sid from reserves where bid in(select bid from boats where color='green'))intersect(select Sid from reserves where bid in(select bid from boats where color='red'));
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'in(select Sid from reserves where bid in(select bid from boats where color='gree' at line 1
mysql> select Sname from Sailors where Sid in((select Sid from reserves where bid in(select bid from boats where color='green'))intersect(select Sid from reserves where bid in(select
 bid from boats where color='red')));
+--------+
| Sname  |
+--------+
| Dustin |
| Lubber |
+--------+
2 rows in set (0.00 sec)

mysql> select Sname from Sailors where Sid in((select Sid from reserves where bid in(select bid from boats where color='green'))minus(select Sid from reserves where bid in(select bid
 from boats where color='red')));
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'minus(select Sid from reserves where bid in(select bid from boats where color='r' at line 1
mysql> select Sname from Sailors where Sid in((select Sid from reserves where bid in(select bid from boats where color='green'))except(select Sid from reserves where bid in(select bi
d from boats where color='red')));
+---------+
| Sname   |
+---------+
| Horatio |
+---------+
1 row in set (0.00 sec)

mysql> select Sname from Sailors where Sid in((select Sid from reserves where bid in(select bid from boats where color='red'))and Sid not in(select Sid from reserves where bid in(sel
ect bid from boats where color='green')));
ERROR 1242 (21000): Subquery returns more than 1 row
mysql> select Sname from Sailors where Sid in((select Sid from reserves where bid in(select bid from boats where color='red'))and (Sid not in(select Sid from reserves where bid in(select bid from boats where color='green'))));
ERROR 1242 (21000): Subquery returns more than 1 row
mysql> select Sname from Sailors where Sid in(select Sid from reserves where bid in(select bid from boats where color='red')) and Sid not in(select Sid from reserves where bid in(sel
ect bid from boats where color='green'));
+---------+
| Sname   |
+---------+
| Horatio |
+---------+
1 row in set (0.00 sec)

mysql> select Sname from Sailors where Sid in(select Sid from reserves where bid in(select bid from boats where color='red'))union all(select Sid from reserves where bid in(select bi
d from boats where color='green'));
+---------+
| Sname   |
+---------+
| Dustin  |
| Lubber  |
| Horatio |
| 22      |
| 31      |
| 74      |
+---------+
6 rows in set (0.00 sec)

mysql> (select Sid from reserves where bid in(select bid from boats where color='red'))union all(select Sid from reserves where bid in(select bid from boats where color='green'));
+-----+
| Sid |
+-----+
|  22 |
|  31 |
|  64 |
|  22 |
|  31 |
|  22 |
|  31 |
|  74 |
+-----+
8 rows in set (0.00 sec)

mysql> (select Sid from reserves where bid in(select bid from boats where color='red'))union all(select Sid from reserves where bid in(select bid from boats where color='green'));
+-----+
| Sid |
+-----+
|  22 |
|  31 |
|  64 |
|  22 |
|  31 |
|  22 |
|  31 |
|  74 |
+-----+
8 rows in set (0.00 sec)

mysql> 


