1.display name of the sailors and day on which sailor has reserved the boat for all the sailors
mysql> select sname,day from sailors,reserves where sailors.sid=reserves.sid;
+---------+------------+
| sname   | day        |
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
2.display names of the sailors and day on which he reserved the boat no=103;
mysql> select sname,day from sailors,reserves where sailors.sid=reserves.sid and bid=103;
+---------+------------+
| sname   | day        |
+---------+------------+
| Dustin  | 1998-10-08 |
| Lubber  | 1998-11-06 |
| Horatio | 1998-09-08 |
+---------+------------+
3.display names of the sailors who reservesd at least two boats
mysql> select sname from sailors where sid in(select sid from reserves group by sid  having count(*)>=2);
+---------+
| sname   |
+---------+
| Dustin  |
| Lubber  |
| Horatio |
+---------+
3 rows in set (0.00 sec)

mysql> select sname,sid from sailors where sid in(select sid from reserves group by sid  having count(*)>=2);
+---------+-----+
| sname   | sid |
+---------+-----+
| Dustin  |  22 |
| Lubber  |  31 |
| Horatio |  64 |
+---------+-----+
3 rows in set (0.00 sec)


4.display names of the sailors who have reserves exactly two boats;
mysql> select sname from sailors where sid in(select sid from reserves group by sid  having count(*)=2);
+---------+
| sname   |
+---------+
| Horatio |
+---------+
mysql> select sid, sname from sailors where sid in(select sid from reserves group by sid  having count(*)=2);
+-----+---------+
| sid | sname   |
+-----+---------+
|  64 | Horatio |
+-----+---------+
1 row in set (0.00 sec)


5.display names of the sailors who reserved all the boats;
mysql> select sid,sname from sailors where sid in(select sid from reserves group by sid having count(*)=(select count(*) from boats));
+-----+--------+
| sid | sname  |
+-----+--------+
|  22 | Dustin |
+-----+--------+
1 row in set (0.00 sec)



