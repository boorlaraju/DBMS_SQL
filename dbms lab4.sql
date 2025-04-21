1.display name and rating of the youngest sailor
+-------+--------+
| sname | rating |
+-------+--------+
| Zorba |     10 |
+-------+--------+

2.display name of the sailor who have rating better than some sailor called horatio
mysql> select sname from sailors where rating >ANY(select rating from sailors where sname="Horatio");

+---------+
| sname   |
+---------+
| Lubber  |
| Andy    |
| Rusty   |
| Zorba   |
| Horatio |
+---------+

3.display names of the sailors who have rating better than all sailor named horatio
mysql> select sname from sailors where rating >all(select rating from sailors where sname="Horatio");
+-------+
| sname |
+-------+
| Rusty |
| Zorba |
+-------+

4.display name of the sailor who is older than oldest sailor with rating 10
mysql> select sname from sailors where age >any(select max(age) from sailors where rating=10);
+---------+
| sname   |
+---------+
| Dustin  |
| Lubber  |
| Horatio |
| Bolo    |
+---------+

5.display count of the boats reserved by each sailor
mysql> select sid,count(*) from reserves group by sid;
+-----+----------+
| sid | count(*) |
+-----+----------+
|  22 |        4 |
|  31 |        3 |
|  64 |        2 |
|  74 |        1 |
+-----+----------+
+-----+----------+
| bid | count(*) |
+-----+----------+
| 101 |        2 |
| 102 |        3 |
| 103 |        3 |
| 104 |        2 |
+-----+----------+


6.display count of the boats for each color
mysql> select color,count(*) from boats group by color;
+-------+----------+
| color | count(*) |
+-------+----------+
| Blue  |        1 |
| Red   |        2 |
| Green |        1 |
+-------+----------+

7.display ids of the sailors who have reserved boat number 103
mysql> select sid from reserves where bid=103;
+-----+
| sid |
+-----+
|  22 |
|  31 |
|  74 |
+-----+

8.display names of the sailors who have reserved boat number 103
mysql> select sname from sailors where sid=ANY(select sid from reserves where bid=103);
+---------+
| sname   |
+---------+
| Dustin  |
| Lubber  |
| Horatio |
+---------+
mysql> select sname from sailors where sid IN(select sid from reserves where bid=103);
+---------+
| sname   |
+---------+
| Dustin  |
| Lubber  |
| Horatio |
+---------+

9.display ids of the sailors who have reserved red boat
mysql> select sid from reserves where bid=all(select bid from boats where color="red");
Empty set (0.00 sec)
mysql> select sid from reserves where bid =any (select bid from boats where color="red");
+-----+
| sid |
+-----+
|  22 |
|  31 |
|  64 |
|  22 |
|  31 |
+-----+
mysql> select sid from reserves where bid in (select bid from boats where color="red");
+-----+
| sid |
+-----+
|  22 |
|  31 |
|  64 |
|  22 |
|  31 |
+-----+


10.display names of the sailor who have reserved red boat
mysql> select sname from sailors where sid=(select sid from reserves where bid=(select bid from boats where color="red"));
ERROR 1242 (21000): Subquery returns more than 1 row
mysql> select sname from sailors where sid in (select sid from reserves where bid=(select bid from boats where color="red"));
ERROR 1242 (21000): Subquery returns more than 1 row
mysql> select sname from sailors where sid in (select sid from reserves where bid=any(select bid from boats where color="red"));
+---------+
| sname   |
+---------+
| Dustin  |
| Lubber  |
| Horatio |
+---------+


11.display names of the sailor who have reserved atleast one boat
mysql> select sname from sailors where sid in (select sid from reserves );
//where bid in(select bid from boats));
+---------+
| sname   |
+---------+
| Dustin  |
| Lubber  |
| Horatio |
| Horatio |
+---------+

12.display names of the sailor who have not reserved any boat
mysql> select sname from sailors where sid not in (select sid from reserves );
//where bid in (select bid from boats));
+--------+
| sname  |
+--------+
| Brutus |
| Andy   |
| Rusty  |
| Zorba  |
| Art    |
| Bolo   |
+--------+

13.display names of the sailor with age below 50 and reserved green boat
mysql> select sname from sailors where age<50 and sid in (select sid from reserves where bid in(select bid from boats where color="Green"));
+---------+
| sname   |
+---------+
| Dustin  |
| Horatio |
+---------+

14.display color of the boats reserved by lubber
mysql> select color from boats where bid=any(select bid from reserves where sid=any(select sid from sailors where sname="Lubber"));
+-------+
| color |
+-------+
| Red   |
| Green |
| Red   |
+-------+

15.display ids of the boats which are not reserved by lubber
mysql> select bid from boats where bid not in (select bid from reserves where sid in (select sid from sailors where sname="Lubber"));
+-----+
| bid |
+-----+
| 101 |
+-----+

**display names of the sailors who have reserved either red or green color boats
mysql> select sname from sailors where sid in (select sid from reserves where bid in (select bid from boats where color="Red" or color="Green"));
+---------+ct sname from sailors where sid in (select sid from reserves where bif
| sname   |
+---------+
| Dustin  |
| Lubber  |
| Horatio |
| Horatio |
+---------+
4 rows in set (0.00 sec)

16.mysql> select distinct(sname) from sailors where sid in (select sid from reserves where bid in (select bid from boats where color="Red" or color="Green"));
+---------+
| sname   |
+---------+
| Dustin  |
| Lubber  |
| Horatio |
+---------+

17.**display names of the sailors who have reserved both red and green boats
mysql> select distinct(sname) from sailors where sid in (select sid from reserves where bid in (select bid from boats where color="Red" and color="Green"));
Empty set (0.00 sec)

18.display names of the sailors who havw reserved red but not green
/*mysql> select sname from sailors  where sid in (select sid from reserves where bid in(select bid from boats where color="Red"));
+---------+
| sname   |
+---------+
| Dustin  |
| Lubber  |
| Horatio |
+---------+*/
mysql> select sname from sailors where sid in ( select sid from reserves where bid in(select bid from boats where color='red') except select sid from reserves where bid in(select bid from boats where color='green'));
+---------+
| sname   |
+---------+
| Horatio |
+---------+
1 row in set (0.00 sec)

mysql> select sid,sname from sailors where sid in ( select sid from reserves where bid in(select bid from boats where color='red') except select sid from reserves where bid in(select bid from boats where color='green'));
+-----+---------+
| sid | sname   |
+-----+---------+
|  64 | Horatio |
+-----+---------+
1 row in set (0.00 sec)



mysql> select sname from sailors where sid in(select sid from reserves where bid in(select bid from boats where color="red" and color<>"green"));
+---------+
| sname   |
+---------+
| Dustin  |
| Lubber  |
| Horatio |
+---------+
3 rows in set (0.01 sec)


19.display maximum rating without using maximum function
mysql> select rating from sailors order by rating desc limit 1;
+--------+
| rating |
+--------+
|     10 |
+--------+

20.display maximum age(oldest age) without using maximum function
mysql> select age from sailors order by age desc limit 1;
+------+
| age  |
+------+
| 63.5 |
+------+
1
























mysql> select sname,min(age) from sailors group by sname;
+---------+----------+
| sname   | min(age) |
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

mysql> select rating,min(age) from sailors group by rating;
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

mysql> select rating,count(*) from sailors group by rating;
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

mysql> select sname,rating from student where age=(select min(age) from sailors);
ERROR 1146 (42S02): Table 'lab2.student' doesn't exist
mysql> select sname,rating from sailors  where age=(select min(age) from sailors);
+-------+--------+
| sname | rating |
+-------+--------+
| Zorba |     10 |
+-------+--------+
1 row in set (0.00 sec)

mysql> select sname,rating,age from sailors  where age=(select min(age) from sailors);
+-------+--------+------+
| sname | rating | age  |
+-------+--------+------+
| Zorba |     10 |   16 |
+-------+--------+------+
1 row in set (0.00 sec)

mysql> select #from reserves;
    -> select *from reserves;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'select *from reserves' at line 2
mysql> select sname,rating from sailors where age=(select min(age) from sailors| B201403 | Karthik     |    95 | X     | M      |   10 | P          |
    -> | B200105 | Balaji      |    88 | A     | M      |   11 | F          |
    -> | B200344 | Ramesh      |    67 | D     | M      |   12 | P          |
    -> +---------+-------------+-------+-------+--------+------+------------+
    -> 12 rows in set (0.01 sec)
    -> 
    -> mysql> use lab2;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '| B201403 | Karthik     |    95 | X     | M      |   10 | P          |
| B200105' at line 1
mysql> Reading table information for completion of table and column names
    -> You can turn off this feature to get a quicker startup with -A
    -> 
    -> Database changed
    -> mysql> select*from sailors;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'Reading table information for completion of table and column names
You can turn ' at line 1
mysql> +-----+---------+--------+------+
    -> | sid | sname   | rating | age  |
    -> +-----+---------+--------+------+
    -> |  22 | Dustin  |      7 |   45 |
    -> |  29 | Brutus  |      1 |   33 |
    -> |  31 | Lubber  |      8 | 55.5 |
    -> |  32 | Andy    |      8 | 25.5 |
    -> |  58 | Rusty   |     10 |   35 |
    -> select rating,min(age) from sailors group by rating;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '+-----+---------+--------+------+
| sid | sname   | rating | age  |
+-----+-----' at line 1
mysql> select sname,rating from sailors where age=(select min(age) from sailors);
+-------+--------+
| sname | rating |
+-------+--------+
| Zorba |     10 |
+-------+--------+
1 row in set (0.00 sec)

mysql> 


