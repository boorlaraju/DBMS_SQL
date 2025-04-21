
--sales,salesperson and products table queries--
--ERROR 1140 (42000): In aggregated query without GROUP BY, expression #1 of SELECT list contains nonaggregated column 'lab3.p.pname'; this is incompatible with sql_mode=only_full_group_by--
mysql> 
mysql> select p.pname,s.pid,count(s.pid) as 'no of sales' from sales s,salesperson sp, products p where sp.sname='ramana' and sp.sid=s.sid and s.pid=p.pid group by s.pid;
+----------+------+-------------+
| pname    | pid  | no of sales |
+----------+------+-------------+
| good day |  121 |           1 |
| maggie   |  111 |           2 |
+----------+------+-------------+
2 rows in set (0.00 sec)

1. Count the no. of each product sales by salesperson with name “ramana”
mysql> select s.pid,count(s.pid) as no_of_sales from sales s,salesperson sp where sp.sname='ramana' and s.sid=sp.sid group by s.pid;
+------+-------------+
| pid  | no_of_sales |
+------+-------------+
|  121 |           1 |
|  111 |           2 |
+------+-------------+elect p.pname,s.pid,count(s.pid) as 'no of sales' from sales s,salesperson sp, products p where sp.sname='ramana' and sp.sid=s.sid and s.pid=p.pid group by s.pid;
2 rows in set (0.01 sec)
mysql> select p.pname,s.pid,count(s.pid) as 'no of sales' from sales s,salesperson sp, products p where sp.sname='ramana' and sp.sid=s.sid and s.pid=p.pid group by s.pid;
+----------+------+-------------+
| pname    | pid  | no of sales |
+----------+------+-------------+
| good day |  121 |           1 |
| maggie   |  111 |           2 |
+----------+------+-------------+
2 rows in set (0.00 sec)



2. Find the no. of products which are not listed in sales relation
mysql> select count(p.pid) as product_not_sold from products p left join sales s on p.pid=s.pid where s.pid is null or s.pid=' ';
+------------------+
| product_not_sold |
+------------------+
|                1 |
+------------------+
1 row in set (0.00 sec)


3. Find the name and age of the salespersons who have done sales of all different  products
mysql> select sp.sname,sp.age from salesperson sp join sales s on sp.sid=s.sid join products p on s.pid=p.pid where p.pname;
Empty set, 3 warnings (0.00 sec)


4. Display the product details which are better in rating than product named “yippie”
in category “noodles”.
mysql> select * from products where rating > (select rating from products where pname="yippie" and category="noodles");
+-----+----------+--------+----------+
| pid | pname    | rating | category |
+-----+----------+--------+----------+
| 111 | maggie   |      8 | noodles  |
| 121 | good day |      8 | biscuits |
+-----+----------+--------+----------+
2 rows in set (0.00 sec)



5. Find the name of salesperson who have done sales of both products “Maggie” and "Good day".
 mysql> select sp.sname from salesperson sp,sales s,products p where p.pname="maggie" and p.pname="good day" and sp.sid=s.sid and s.pid=p.pid;
Empty set (0.00 sec)

mysql> select sp.sname from salesperson sp join sales s on sp.sid=s.sid join products p on s.pid=p.pid where p.pname="maggie" and p.pname="good day";
Empty set (0.00 sec)

mysql> select distinct(sp.sname) from salesperson sp join sales s on sp.sid=s.sid join products p on s.pid=p.pid where p.pname="maggie" or p.pname="good day";
+--------+
| sname  |
+--------+
| ramana |
| raju   |
| vimala |
+--------+
mysql> select sp.sname from salesperson sp inner join sales s on sp.sid=s.sid inner join products p on p.pid=s.pid where p.pname="maggie" and p.pname="good day";
Empty set (0.00 sec)



2.--players,rankings.format--

1. Find the player name who are listed for all formats in Rankings table

mysql> select pname from rankings where fname='ODI' and fname='Test' and fname='Twenty20';
Empty set (0.00 sec)

mysql> select r.pname from rankings r join format f on r.fname=f.fname where f.fname='ODI' and f.fname='Test' and f.fname='Twenty20';
Empty set (0.00 sec)

2. Display the name and category of player who has highest rank for each format
mysql> select pname,category from players where pname in (select pname from rankings where(fname,ranks) in (select fname,max(ranks) from rankings group by fname));
+--------+----------+
| pname  | category |
+--------+----------+
| Ashwin | Bowler   |
+--------+----------+
1 row in set (0.00 sec)


3. Find the player names who are listed in rankings table only for “ODI” format but
NOT for “Test” format

mysql> select pname from rankings where fname='ODI' and fname<>'Test';
+------------+
| pname      |
+------------+
| kohli      |
| Ashwin     |
| Devilliers |
+------------+
3 rows in set (0.00 sec)

4. Add an attribute age to players table and put age of player named “kohli” to 27

mysql> alter table players add age int;
Query OK, 0 rows affected (0.03 sec)

mysql> update players set age=27 where pname='kohli';
Query OK, 1 row affected (0.01 sec)

mysql> select * from players;
+------------+--------------+----------+------+
| pname      | country      | category | age  |
+------------+--------------+----------+------+
| Ashwin     | India        | Bowler   | NULL |
| Devilliers | south africa | Batsman  | NULL |
| Kohli      | India        | Batsman  |   27 |
+------------+--------------+----------+------+
3 rows in set (0.00 sec)


5. Count the no. of players in each country
mysql> select country,count(pname) as 'no of players' from players group by country;
+--------------+---------------+
| country      | no of players |
+--------------+---------------+
| India        |             2 |
| south africa |             1 |
+--------------+---------------+
2 rows in set (0.00 sec)

--Faculty,Teaches,Course--
1. Find faculty names whose qualification is “M.Tech” and teaches at least two
different courses
mysql> select fname as 'faculty name' from Faculty where qualification='M.Tech' and fid = any(select fid from Teaches group by fid having count(cid)>=2);
+--------------+
| faculty name |
+--------------+
| kavitha      |
+--------------+
1 row in set (0.00 sec)


2. Find faculty names whose age is below 30 and teaches all the courses

mysql> select f.fname from Faculty f join Teaches t on f.fid=t.fid join Course c on t.cid=c.cid where f.age<30 and c.cname='DBMS' and c.cname='COA' and c.cname='JAVA' and c.cname='FLAT';
Empty set (0.00 sec)

mysql> select f.fname from Faculty f join Teaches t on f.fid=t.fid join Course c on t.cid=c.cid where f.age<30 and c.cname in (select c.cname from Course);
+---------+
| fname   |
+---------+
| vanitha |
| vanitha |
+---------+
2 rows in set (0.00 sec)

3. Find course name and textbooks of the courses taught by either “kavitha” or “venu”.

mysql> select c.cname,c.textbook from Course c join Teaches t on c.cid=t.cid join Faculty f on t.fid=f.fid where f.fname='kavitha' or f.fname='venu';
+-------+-------------------------+
| cname | textbook                |
+-------+-------------------------+
| DBMS  | Database concepts       |
| COA   | Computer architecture   |
| JAVA  | Computer reference JAVA |
+-------+-------------------------+
3 rows in set (0.00 sec)

4. Count the no. of courses for each “year-sem”

mysql> select year_sem,count(cid) as 'no of courses' from Teaches group by year_sem;
+----------+---------------+
| year_sem | no of courses |
+----------+---------------+
| 2-1      |             1 |
| 3-1      |             3 |
| 4-1      |             1 |
+----------+---------------+
3 rows in set (0.00 sec)

5. Alter the table courses to add a new attribute “credits” and update the credits to 4
for the courses taught by faculty with fid 10

mysql> alter table Course add credits int;
Query OK, 0 rows affected (0.03 sec)

mysql> select * from Course;
+-------+-------+-------------------------+---------+
| cid   | cname | textbook                | credits |
+-------+-------+-------------------------+---------+
| CS201 | DBMS  | Database concepts       |    NULL |
| CS301 | COA   | Computer architecture   |    NULL |
| CS302 | FLAT  | Formal languages        |    NULL |
| CS401 | JAVA  | Computer reference JAVA |    NULL |
+-------+-------+-------------------------+---------+

mysql> update Course set credits=4 where cid in (select cid from Teaches where fid=10);
Query OK, 2 rows affected (0.02 sec)

mysql> select * from Course;
+-------+-------+-------------------------+---------+
| cid   | cname | textbook                | credits |
+-------+-------+-------------------------+---------+
| CS201 | DBMS  | Database concepts       |       4 |
| CS301 | COA   | Computer architecture   |       4 |
| CS302 | FLAT  | Formal languages        |    NULL |
| CS401 | JAVA  | Computer reference JAVA |    NULL |
+-------+-------+-------------------------+---------+
4 rows in set (0.01 sec)







