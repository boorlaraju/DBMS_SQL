mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| lab1               |
| lab2               |
| mysql              |
| performance_schema |
| student            |
| sys                |
+--------------------+
7 rows in set (0.01 sec)

mysql> use lab2;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> alter table sailors add constraint primary key(sid);
Query OK, 0 rows affected (0.05 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> alter table reserves add constraint primary key(sid,bid);
Query OK, 0 rows affected (0.06 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> alter table boats add constraint primary key(bid);
Query OK, 0 rows affected (0.04 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> select*from sailors;mysql> select pname from rankings where fname='ODI' and fname='Test' and fname='Twenty20';
Empty set (0.00 sec)

mysql> select r.pname from rankings r join format f on r.fname=f.fname where f.fname='ODI' and f.fname='Test' and f.fname='Twenty20';
Empty set (0.00 sec)


+-----+---------+--------+------+
| sid | sname   | rating | age  |
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

mysql> insert into sailors values(22,"Rajesh",4,24);
ERROR 1062 (23000): Duplicate entry '22' for key 'sailors.PRIMARY'
mysql> select*from reserves;
+-----+-----+------------+
| sid | bid | day        |
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

mysql> insert into reserves values(22,101,1998/12/15);
ERROR 1292 (22007): Incorrect date value: '11.100000000000000000' for column 'day' at row 1
mysql> insert into reserves values(22,101,1998-12-15);
ERROR 1292 (22007): Incorrect date value: '1971' for column 'day' at row 1
mysql> insert into reserves values(22,101,"1998/12/15");
ERROR 1062 (23000): Duplicate entry '22-101' for key 'reserves.PRIMARY'
Query OK, 10 rows affected (0.05 sec)raint foreign key(sid) references sailors(sid);
Records: 10  Duplicates: 0  Warnings: 0

mysql> alter table reserves add constraint foreign key(bid) references boats(bid);
Query OK, 10 rows affected (0.08 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql> 

mysql> insert into reserves values(30,102,"1998/12/15");
ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`lab2`.`reserves`, CONSTRAINT `reserves_ibfk_1` FOREIGN KEY (`sid`) REFERENCES `sailors` (`sid`))
mysql> insert into reserves values(22,104,"1998/12/15");
ERROR 1062 (23000): Duplicate entry '22-104' for key 'reserves.PRIMARY'
mysql> insert into reserves values(24,104,"1998/12/15");
ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`lab2`.`reserves`, CONSTRAINT `reserves_ibfk_1` FOREIGN KEY (`sid`) REFERENCES `sailors` (`sid`))
mysql> insert into reserves values(22,105,"1998/12/15");
ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`lab2`.`reserves`, CONSTRAINT `reserves_ibfk_2` FOREIGN KEY (`bid`) REFERENCES `boats` (`bid`))
mysql> 

select
from 
where
order by
limit
Aggregrate operators:sum(),count(),min(),max(),avg(),between and,like,is NULL,and,or;
(op)-any;
(op)-all;
IN
NOT IN;
mysql> select color from boats where bid=(select bid from reserves where sid=74);
+-------+
| color |
+-------+
| Green |
+-------+
1 row in set (0.00 sec)

mysql> select *from reserves;
+-----+-----+------------+
| sid | bid | day        |
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

mysql> select*from boats;
+-----+-----------+-------+
| bid | bname     | color |
+-----+-----------+-------+
| 101 | Interlake | Blue  |
| 102 | Interlake | Red   |
| 103 | Clipper   | Green |
| 104 | Marine    | Red   |
+-----+-----------+-------+
4 rows in set (0.00 sec)

mysql> select color from boats where bid=(select bid from reserves where sid=64);
ERROR 1242 (21000): Subquery returns more than 1 row
mysql> select color from boats where bid=Any (select bid from reserves where sid=64);
+-------+
| color |
+-------+
| Blue  |
| Red   |
+-------+
2 rows in set (0.00 sec)

mysql> select color from boats where bid=in (select bid from reserves where sid=64);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'in (select bid from reserves where sid=64)' at line 1
mysql> select color from boats where bid=IN (select bid from reserves where sid=64);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'IN (select bid from reserves where sid=64)' at line 1
mysql> select color from boats where bid IN (select bid from reserves where sid=64);
+-------+
| color |
+-------+
| Blue  |
| Red   |
+-------+
2 rows in set (0.00 sec)

mysql> select color from boats where bid NOT IN (select bid from reserves where sid=64);
+-------+
| color |
+-------+
| Green |
| Red   |
+-------+
2 rows in set (0.00 sec)

mysql> select color from boats where bid NOT IN (select bid from reserves where sid=22);
Empty set (0.00 sec)

mysql> select color from boats where bid NOT IN (select bid from reserves where sid=31);
+-------+
| color |
+-------+
| Blue  |
+-------+
1 row in set (0.00 sec)

mysql> select color from boats where bid in (select bid from reserves where sid=(select sid from sailors where sname='lubber');
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '' at line 1
mysql> select color from boats where bid in (select bid from reserves where sid in (select sid from sailors where sname='lubber');
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '' at line 1
mysql> select color from boats where bid in (select bid from reserves where sid in (select sid from sailors where sname='lubber'));
+-------+
| color |
+-------+
| Red   |
| Green |
| Red   |
+-------+
3 rows in set (0.01 sec)

mysql> select color from boats where bid in (select bid from reserves where sid in (select sid from sailors where sname='Brutus'));
Empty set (0.01 sec)

mysql> select color from boats where bid in (select bid from reserves where sid in (select sid from sailors where sname='Dustin'));
+-------+
| color |
+-------+
| Blue  |
| Red   |
| Green |
| Red   |
+-------+
4 rows in set (0.00 sec)

mysql> select color from boats where bid in (select bid from reserves where sid in (select sid from sailors where sname='Zorba'));
Empty set (0.00 sec)

mysql> select color from boats where bid in select bid from reserves where sid in select sid from sailors where sname='Dustin';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'select bid from reserves where sid in select sid from sailors where sname='Dusti' at line 1
mysql> select color from boats where bid in select bid from reserves where sid in select sid from sailors where sname='Lubber';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'select bid from reserves where sid in select sid from sailors where sname='Lubbe' at line 1
mysql> select color from boats where bid in (select bid from reserves where sid in (select sid from sailors where sname='Zorba'));

