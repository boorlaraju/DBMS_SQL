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
| yt                 |
+--------------------+
7 rows in set (0.01 sec)

mysql> use week1;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> create table rgukt;
ERROR 4028 (HY000): A table must have at least one visible column.
mysql> create table rgukt(ID char(10),Name varchar(30),Marks Integer,Branch char(3),Grade char);
Query OK, 0 rows affected (0.02 sec)

mysql> insert into rgukt values('B201330','Varun',36,CSE,'P');
ERROR 1054 (42S22): Unknown column 'CSE' in 'field list'
mysql> insert into rgukt values('B201330','Varun',36,'CSE','P');
Query OK, 1 row affected (0.01 sec)

mysql> select * from rgukt;
+---------+-------+-------+--------+-------+
| ID      | Name  | Marks | Branch | Grade |
+---------+-------+-------+--------+-------+
| B201330 | Varun |    36 | CSE    | P     |
+---------+-------+-------+--------+-------+
1 row in set (0.00 sec)

mysql> insert into rgukt values('B200067','Karthik',84,'MME','A'),('B201367','Sunil',70,'B'),('B201785','Ravi',87,'A'),('B201222','Vinay',24,'CHE','R');
ERROR 1136 (21S01): Column count doesn't match value count at row 2
mysql> insert into rgukt values('B200067','Karthik',84,'MME','A'),('B201367','Sunil',70,'CSE',B'),('B201785','Ravi',87,'A'),('B201222','Vinay',24,'CHE','R');
    '> insert into rgukt values('B200067','Karthik',84,'MME','A'),('B201367','Sunil',70,'CSE','B'),('B201785','Ravi',87,'A'),('B201222','Vinay',24,'CHE','R');
    '> ;
    '> insert into rgukt values('B200067','Karthik',84,'MME','A'),('B201367','Sunil',70,'CSE','B'),('B201785','Ravi',87,'ECE','A'),('B201222','Vinay',24,'CHE','R');
    '> ;
    '> insert into rgukt values('B200067','Karthik',84,'MME','A'),('B201367','Sunil',70,'CSE','B'),('B201785','Ravi',87,'ECE','A'),('B201222','Vinay',24,'CHE','R');
    '> '
    -> insert into rgukt values('B200067','Karthik',84,'MME','A'),('B201367','Sunil',70,'CSE','B'),('B201785','Ravi',87,'ECE','A'),('B201222','Vinay',24,'CHE','R');
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'B'),('B201785','Ravi',87,'A'),('B201222','Vinay',24,'CHE','R');
insert into rguk' at line 1
mysql> ;
ERROR: 
No query specified

mysql> insert into rgukt values('B200067','Karthik',84,'MME','A'),('B201367','Sunil',70,'CSE',B'),('B201785','Ravi',87,'A'),('B201222','Vinay',24,'CHE','R');
insert into rgukt values('B200067','Karthik',84,'MME','A'),('B201367','Sunil',70,'CSE','B'),('B201785','Ravi',87,'A'),('B201222','Vinay',24,'CHE','R');
;
insert into rgukt values('B200067','Karthik',84,'MME','A'),('B201367','Sunil',70,'CSE','B'),('B201785','Ravi',87,'ECE','A'),('B201222','Vinay',24,'CHE','R');
;
insert into rgukt values('B200067','Karthik',84,'MME','A'),('B201367','Sunil',70,'CSE','B'),('B201785','Ravi',87,'ECE','A'),('B201222','Vinay',24,'CHE','R');
' insert into rgukt values('B200067','Karthik',84,'MME','A'),('B201367','Sunil',70,'CSE','B'),('B201785','Ravi',87,'ECE','A'),('B201222','Vinay',24,'CHE','R');
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'B'),('B201785','Ravi',87,'A'),('B201222','Vinay',24,'CHE','R');
insert into rguk' at line 1
mysql> insert into rgukt values('B200067','Karthik',84,'MME','A'),('B201367','Sunil',70,'CSE',B'),('B201785','Ravi',87,'A'),('B201222','Vinay',24,'CHE','R');
insert into rgukt values('B200067','Karthik',84,'MME','A'),('B201367','Sunil',70,'CSE','B'),('B201785','Ravi',87,'A'),('B201222','Vinay',24,'CHE','R');
;
insert into rgukt values('B200067','Karthik',84,'MME','A'),('B201367','Sunil',70,'CSE','B'),('B201785','Ravi',87,'ECE','A'),('B201222','Vinay',24,'CHE','R');
;
insert into rgukt values('B200067','Karthik',84,'MME','A'),('B201367','Sunil',70,'CSE','B'),('B201785','Ravi',87,'ECE','A'),('B201222','Vinay',24,'CHE','R');
' insert into rguktt values('B200067','Karthik',84,'MME','A'),('B201367','Sunil',70,'CSE','B'),('B201785','Ravi',87,'ECE','A'),('B201222','Vinay',24,'CHE','R');
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'B'),('B201785','Ravi',87,'A'),('B201222','Vinay',24,'CHE','R');
insert into rguk' at line 1
mysql> clear
mysql> select * from rgukt;
+---------+-------+-------+--------+-------+
| ID      | Name  | Marks | Branch | Grade |
+---------+-------+-------+--------+-------+
| B201330 | Varun |    36 | CSE    | P     |
+---------+-------+-------+--------+-------+
1 row in set (0.00 sec)

mysql> insert into rgukt values('B201547','Karthik',84,'MME','A'),('B201367','Sunil',70,'CSE','B'),('B201785','Ravi',87,'ECE','A'),('B201222','Vinay',24,'CHE','R');
Query OK, 4 rows affected (0.01 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> select * from rgukt;
+---------+---------+-------+--------+-------+
| ID      | Name    | Marks | Branch | Grade |
+---------+---------+-------+--------+-------+
| B201330 | Varun   |    36 | CSE    | P     |
| B201547 | Karthik |    84 | MME    | A     |
| B201367 | Sunil   |    70 | CSE    | B     |
| B201785 | Ravi    |    87 | ECE    | A     |
| B201222 | Vinay   |    24 | CHE    | R     |
+---------+---------+-------+--------+-------+
5 rows in set (0.00 sec)

mysql> select name from student;
+-----------+
| name      |
+-----------+
| Varun     |
| Bunny     |
| Ramesh    |
| Venkatesh |
+-----------+
4 rows in set (0.01 sec)

mysql> select name from rgukt;
+---------+
| name    |
+---------+
| Varun   |
| Karthik |
| Sunil   |
| Ravi    |
| Vinay   |
+---------+
5 rows in set (0.00 sec)

mysql> selct Name from rgukt where Grade='A';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'selct Name from rgukt where Grade='A'' at line 1
mysql> select Name from rgukt where Grade='A';
+---------+
| Name    |
+---------+
| Karthik |
| Ravi    |
+---------+
2 rows in set (0.00 sec)

mysql> select Name from rgukt where Grade='X';
Empty set (0.00 sec)

mysql> select ID,Name from rgukt ;
+---------+---------+
| ID      | Name    |
+---------+---------+
| B201330 | Varun   |
| B201547 | Karthik |
| B201367 | Sunil   |
| B201785 | Ravi    |
| B201222 | Vinay   |
+---------+---------+
5 rows in set (0.00 sec)

mysql> select * from rgukt where Name like '%sai%';
Empty set (0.00 sec)

mysql> select * from rgukt where Name like '%a%';
+---------+---------+-------+--------+-------+
| ID      | Name    | Marks | Branch | Grade |
+---------+---------+-------+--------+-------+
| B201330 | Varun   |    36 | CSE    | P     |
| B201547 | Karthik |    84 | MME    | A     |
| B201785 | Ravi    |    87 | ECE    | A     |
| B201222 | Vinay   |    24 | CHE    | R     |
+---------+---------+-------+--------+-------+
4 rows in set (0.00 sec)

mysql> select * from rgukt where Name like '%run%';
+---------+-------+-------+--------+-------+
| ID      | Name  | Marks | Branch | Grade |
+---------+-------+-------+--------+-------+
| B201330 | Varun |    36 | CSE    | P     |
+---------+-------+-------+--------+-------+
1 row in set (0.01 sec)

mysql> select * from rgukt where Name like 'run%';
Empty set (0.00 sec)

mysql> select * from rgukt where Name like 'run';
Empty set (0.00 sec)

mysql> select * from rgukt where Name like 's%';
+---------+-------+-------+--------+-------+
| ID      | Name  | Marks | Branch | Grade |
+---------+-------+-------+--------+-------+
| B201367 | Sunil |    70 | CSE    | B     |
+---------+-------+-------+--------+-------+
1 row in set (0.00 sec)

mysql> select * from rgukt where Name like 'v%';
+---------+-------+-------+--------+-------+
| ID      | Name  | Marks | Branch | Grade |
+---------+-------+-------+--------+-------+
| B201330 | Varun |    36 | CSE    | P     |
| B201222 | Vinay |    24 | CHE    | R     |
+---------+-------+-------+--------+-------+
2 rows in set (0.00 sec)

mysql> select Name from rgukt where Name like '_____';
+-------+
| Name  |
+-------+
| Varun |
| Sunil |
| Vinay |
+-------+
3 rows in set (0.00 sec)

mysql> select * from rgukt where Name like '_____';
+---------+-------+-------+--------+-------+
| ID      | Name  | Marks | Branch | Grade |
+---------+-------+-------+--------+-------+
| B201330 | Varun |    36 | CSE    | P     |
| B201367 | Sunil |    70 | CSE    | B     |
| B201222 | Vinay |    24 | CHE    | R     |
+---------+-------+-------+--------+-------+
3 rows in set (0.00 sec)

mysql> select Name from rgukt like '_____';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'like '_____'' at line 1
mysql> select Name from rgukt where Marks>=50 and marks<=100;
+---------+
| Name    |
+---------+
| Karthik |
| Sunil   |
| Ravi    |
+---------+
3 rows in set (0.00 sec)

mysql> select Name,Marks from rgukt where Marks>=50 and marks<=100;
+---------+-------+
| Name    | Marks |
+---------+-------+
| Karthik |    84 |
| Sunil   |    70 |
| Ravi    |    87 |
+---------+-------+
3 rows in set (0.00 sec)

mysql> select Name,Marks from rgukt where Marks between 50 and 100;
+---------+-------+
| Name    | Marks |
+---------+-------+
| Karthik |    84 |
| Sunil   |    70 |
| Ravi    |    87 |
+---------+-------+
3 rows in set (0.00 sec)

mysql> select Name,ID from rgukt order by Marks desc;
+---------+---------+
| Name    | ID      |
+---------+---------+
| Ravi    | B201785 |
| Karthik | B201547 |
| Sunil   | B201367 |
| Varun   | B201330 |
| Vinay   | B201222 |
+---------+---------+
5 rows in set (0.00 sec)

mysql> select Name,Marks from rgukt order by Marks desc;
+---------+-------+
| Name    | Marks |
+---------+-------+
| Ravi    |    87 |
| Karthik |    84 |
| Sunil   |    70 |
| Varun   |    36 |
| Vinay   |    24 |
+---------+-------+
5 rows in set (0.00 sec)

mysql> select Name,Marks from rgukt order by maRKs  desc;
+---------+-------+
| Name    | Marks |
+---------+-------+
| Ravi    |    87 |
| Karthik |    84 |
| Sunil   |    70 |
| Varun   |    36 |
| Vinay   |    24 |
+---------+-------+
5 rows in set (0.00 sec)

mysql> select Name,Marks from rgukt order by maRKs  desC;
+---------+-------+
| Name    | Marks |
+---------+-------+
| Ravi    |    87 |
| Karthik |    84 |
| Sunil   |    70 |
| Varun   |    36 |
| Vinay   |    24 |
+---------+-------+
5 rows in set (0.00 sec)

mysql> select Name from rgukt order by Name asc;
+---------+
| Name    |
+---------+
| Karthik |
| Ravi    |
| Sunil   |
| Varun   |
| Vinay   |
+---------+
5 rows in set (0.00 sec)

mysql> select Name from rgukt order by ID asc;
+---------+
| Name    |
+---------+
| Vinay   |
| Varun   |
| Sunil   |
| Karthik |
| Ravi    |
+---------+
5 rows in set (0.00 sec)

mysql> select max(marks) from student;
+------------+
| max(marks) |
+------------+
|        100 |
+------------+
1 row in set (0.01 sec)

mysql> select max(marks) from rgukt;
+------------+
| max(marks) |
+------------+
|         87 |
+------------+
1 row in set (0.00 sec)

mysql> select name,Marks from rgukt where marks =(select amx(marks) from rgukt;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '' at line 1
mysql> select name,Marks from rgukt where marks =(select max(marks) from rgukt);
+------+-------+
| name | Marks |
+------+-------+
| Ravi |    87 |
+------+-------+
1 row in set (0.00 sec)

mysql> select name,Marks from rgukt where marks =select max(marks) from rgukt;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'select max(marks) from rgukt' at line 1
mysql> select name,Marks from rgukt where marks =(select max(marks) from rgukt)^C
mysql> select name,Marks from rgukt where marks =select max(marks) from rgukt;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'select max(marks) from rgukt' at line 1
mysql> select name,Marks from rgukt where marks =(select max(marks) from rgukt);
+------+-------+
| name | Marks |
+------+-------+
| Ravi |    87 |
+------+-------+
1 row in set (0.01 sec)

mysql> select * from rgukt order by marks limit 5;
+---------+---------+-------+--------+-------+
| ID      | Name    | Marks | Branch | Grade |
+---------+---------+-------+--------+-------+
| B201222 | Vinay   |    24 | CHE    | R     |
| B201330 | Varun   |    36 | CSE    | P     |
| B201367 | Sunil   |    70 | CSE    | B     |
| B201547 | Karthik |    84 | MME    | A     |
| B201785 | Ravi    |    87 | ECE    | A     |
+---------+---------+-------+--------+-------+
5 rows in set (0.00 sec)

mysql> select * from rgukt order by marks desc  limit 5;
+---------+---------+-------+--------+-------+
| ID      | Name    | Marks | Branch | Grade |
+---------+---------+-------+--------+-------+
| B201785 | Ravi    |    87 | ECE    | A     |
| B201547 | Karthik |    84 | MME    | A     |
| B201367 | Sunil   |    70 | CSE    | B     |
| B201330 | Varun   |    36 | CSE    | P     |
| B201222 | Vinay   |    24 | CHE    | R     |
+---------+---------+-------+--------+-------+
5 rows in set (0.00 sec)

mysql> select * from rgukt order by marks desc  limit   5;
+---------+---------+-------+--------+-------+
| ID      | Name    | Marks | Branch | Grade |
+---------+---------+-------+--------+-------+
| B201785 | Ravi    |    87 | ECE    | A     |
| B201547 | Karthik |    84 | MME    | A     |
| B201367 | Sunil   |    70 | CSE    | B     |
| B201330 | Varun   |    36 | CSE    | P     |
| B201222 | Vinay   |    24 | CHE    | R     |
+---------+---------+-------+--------+-------+
5 rows in set (0.00 sec)

mysql> select count(ID),Name from rgukt where Grade='R';
ERROR 1140 (42000): In aggregated query without GROUP BY, expression #2 of SELECT list contains nonaggregated column 'week1.rgukt.Name'; this is incompatible with sql_mode=only_full_group_by
mysql> select count(ID) from rgukt where Grade='R';
+-----------+
| count(ID) |
+-----------+
|         1 |
+-----------+
1 row in set (0.00 sec)

mysql> select count(*) from rgukt where Grade='R';
+----------+
| count(*) |
+----------+
|        1 |
+----------+
1 row in set (0.00 sec)

mysql> alter table rgukt add Gender char;
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> select * form rgukt;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'form rgukt' at line 1
mysql> select * from rgukt;
+---------+---------+-------+--------+-------+--------+
| ID      | Name    | Marks | Branch | Grade | Gender |
+---------+---------+-------+--------+-------+--------+
| B201330 | Varun   |    36 | CSE    | P     | NULL   |
| B201547 | Karthik |    84 | MME    | A     | NULL   |
| B201367 | Sunil   |    70 | CSE    | B     | NULL   |
| B201785 | Ravi    |    87 | ECE    | A     | NULL   |
| B201222 | Vinay   |    24 | CHE    | R     | NULL   |
+---------+---------+-------+--------+-------+--------+
5 rows in set (0.00 sec)

mysql> update rgukt set Name ='Anvesh' where Grade='r';
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from rgukt;
+---------+---------+-------+--------+-------+--------+
| ID      | Name    | Marks | Branch | Grade | Gender |
+---------+---------+-------+--------+-------+--------+
| B201330 | Varun   |    36 | CSE    | P     | NULL   |
| B201547 | Karthik |    84 | MME    | A     | NULL   |
| B201367 | Sunil   |    70 | CSE    | B     | NULL   |
| B201785 | Ravi    |    87 | ECE    | A     | NULL   |
| B201222 | Anvesh  |    24 | CHE    | R     | NULL   |
+---------+---------+-------+--------+-------+--------+
5 rows in set (0.00 sec)

mysql> update table rgukt Name='Aravind';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'table rgukt Name='Aravind'' at line 1
mysql> update table rgukt set  Name='Aravind';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'table rgukt set  Name='Aravind'' at line 1
mysql> update  rgukt set  Name='Aravind';
Query OK, 5 rows affected (0.00 sec)
Rows matched: 5  Changed: 5  Warnings: 0

mysql> select * from rgukt;
+---------+---------+-------+--------+-------+--------+
| ID      | Name    | Marks | Branch | Grade | Gender |
+---------+---------+-------+--------+-------+--------+
| B201330 | Aravind |    36 | CSE    | P     | NULL   |
| B201547 | Aravind |    84 | MME    | A     | NULL   |
| B201367 | Aravind |    70 | CSE    | B     | NULL   |
| B201785 | Aravind |    87 | ECE    | A     | NULL   |
| B201222 | Aravind |    24 | CHE    | R     | NULL   |
+---------+---------+-------+--------+-------+--------+
5 rows in set (0.00 sec)

mysql> delete from rgukt where Id='B201367';
Query OK, 1 row affected (0.01 sec)

mysql> select * from rgukt;
+---------+---------+-------+--------+-------+--------+
| ID      | Name    | Marks | Branch | Grade | Gender |
+---------+---------+-------+--------+-------+--------+
| B201330 | Aravind |    36 | CSE    | P     | NULL   |
| B201547 | Aravind |    84 | MME    | A     | NULL   |
| B201785 | Aravind |    87 | ECE    | A     | NULL   |
| B201222 | Aravind |    24 | CHE    | R     | NULL   |
+---------+---------+-------+--------+-------+--------+
4 rows in set (0.00 sec)

mysql> drop table rgukt;
Query OK, 0 rows affected (0.01 sec)

mysql> select * from rgukt;
ERROR 1146 (42S02): Table 'week1.rgukt' 
'doesn't exist
mysql> thank you;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'thank you' at line 1
mysql> drop table rgukt;
ERROR 1051 (42S02): Unknown table 'week1.rgukt'
mysql> update table rgukt set  Name='Aravind';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'table rgukt set  Name='Aravind'' at line 1
mysql> clear
mysql> show tables;
+-----------------+
| Tables_in_week1 |
+-----------------+
| student         |
+-----------------+
1 row in set (0.01 sec)

mysql> select *from student;
+---------+-----------+-------+-------+
| ID      | Name      | Marks | Grade |
+---------+-----------+-------+-------+
| B201330 | Varun     |    90 | A     |
| B201293 | Bunny     |    50 | D     |
| B201456 | Ramesh    |    36 | P     |
| B201005 | Venkatesh |   100 | X     |
+---------+-----------+-------+-------+
4 rows in set (0.00 sec)

mysql> Query;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'Query' at line 1
mysql> alter table student add sl.no integer;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '.no integer' at line 1
mysql> alter table student add sl_no integer;
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> select * from student;
+---------+-----------+-------+-------+-------+
| ID      | Name      | Marks | Grade | sl_no |
+---------+-----------+-------+-------+-------+
| B201330 | Varun     |    90 | A     |  NULL |
| B201293 | Bunny     |    50 | D     |  NULL |
| B201456 | Ramesh    |    36 | P     |  NULL |
| B201005 | Venkatesh |   100 | X     |  NULL |
+---------+-----------+-------+-------+-------+
4 rows in set (0.00 sec)

