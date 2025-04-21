create database dbms3;
use dbms3;

create table player(pname varchar(20) primary key,country varchar(20),category varchar(20));
insert into player
values
('Ashwin', 	'India',	'Bowler'),
('Kohli',	'India',	'Batsman'),
('De villiers',	'South Africa',	'Batsman');
select * from player;

create table format(fname varchar(20) primary key,oversPerDay int,days int);
insert into format
values
('ODI',	100,	1),
('Twenty20',	40,	1),
('Test',	90,	5);
select * from format;


create table rankings(
pname varchar(20),
fname varchar(20),
ranks int,
primary key(pname,fname),
foreign key(pname) references player(pname),
foreign key(fname) references format(fname)
);

insert into rankings
values
('kohli','ODI',2),
('kohli','Twenty20',2),
('Ashwin','ODI',10),
('Ashwin','Test',2),
('Ashwin','Twenty20',5),
('De villiers','ODI',1);



select * from rankings;

-- 1.Find the player name who are listed for all formats in Rankings table

select fname from format;

select pname,count(*) as formatCount from rankings group by pname having formatCount>=(select count(fname) from format);


-- 2.Display  the name and category of player who has highest rank for each format
select p.pname,p.category,fname,r.ranks from player p,rankings r where p.pname=r.pname order by ranks desc limit 1;

select f.fname,count(*) from format f,player p,rankings r where r.pname=p.pname and r.fname=f.fname group by f.fname;
	
SELECT f.fname, COUNT(*) AS player_count
FROM format f
JOIN rankings r ON f.fname = r.fname
JOIN player p ON r.pname = p.pname
GROUP BY f.fname;



SELECT r.fname, p.pname, p.category
FROM rankings r
JOIN (
    SELECT fname, MAX(ranks) AS max_rank
    FROM rankings
    GROUP BY fname
) rm ON r.fname = rm.fname AND r.ranks = rm.max_rank
JOIN player p ON r.pname = p.pname;



SELECT r.fname, p.pname, p.category,max(r.ranks) from player p,rankings r where p.pname=r.pname group by fname ;

--  My approach would be first join the rankings and format table then attain the list of markks
select f.fname,max(r.ranks) from rankings r  join format f on r.fname=f.fname group by f.fname;

--  final

select pname,fname,ranks from rankings where ranks in(select max(r.ranks) from rankings r  join format f on r.fname=f.fname group by f.fname);


-- 3.Find the player names who are listed in rankings table only for “ODI” format but NOT for “Test” format

SELECT distinct(pname)
FROM Rankings R
WHERE pname IN (SELECT pname FROM Rankings WHERE fname = 'ODI')
AND pname NOT IN (SELECT pname FROM Rankings WHERE fname = 'Test');
  

  
-- 4.Add an attribute age to players table and put age of player named “kohli” to 27

alter table player
 add column age int;
 
 update player
 set age=27 where pname='Kohli';
 
 select * from player;
 
 -- 5.Count the no. of players in each country
 select * from rankings r, player p where r.pname=p.pname;
 
 select country,count(*) from rankings r, player p where r.pname=p.pname group by country;
 
 -- Final solution
 select country,count(*) from player group by country;