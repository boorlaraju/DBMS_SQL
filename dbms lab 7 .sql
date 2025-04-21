1. Query . Retrieve the birth date and address of the employee(s) whose name is ‘John B. Smith’.
mysql> select address from employee where fname='john' and mname='B' and Lname='smith';
mysql> select bdate,address from employee where fname='john' and mname='B' and Lname='smith';
+------------+-------------------------+
| bdate      | address                 |
+------------+-------------------------+
| 1965-01-09 | 731 Fondren, Houston,TX |
+------------+-------------------------+
1 row in set (0.00 sec)
2. Query . Retrieve the name and address of all employees who work
for the  Research department.
mysql> select fname,address from employee where dno in(select dnumber from department where dname='research');
+----------+-------------------------+
| fname    | address                 |
+----------+-------------------------+
| John     | 731 Fondren, Houston,TX |
| Franklin | 638 Voss, Houston,TX    |
| Joyce    | 5631 Rice, Houston,TX   |
| Ramesh   | 975 Fire Oak, Humble,TX |
+----------+-------------------------+
4 rows in set (0.00 sec)

mysql> select fname,mname,lname,address from employee where dno in(select dnumber from department where dname='research');
+----------+-------+---------+-------------------------+
| fname    | mname | lname   | address                 |
+----------+-------+---------+-------------------------+
| John     | B     | Smith   | 731 Fondren, Houston,TX |
| Franklin | T     | Wong    | 638 Voss, Houston,TX    |
| Joyce    | A     | English | 5631 Rice, Houston,TX   |
| Ramesh   | K     | Narayan | 975 Fire Oak, Humble,TX |
+----------+-------+---------+-------------------------+
3. Query: For every project located in ‘Stafford’, list the project
number, the controlling department number, and the department
manager’s last name, address, and birth date.
mysql> select p.pnumber,p.dnum,e.lname,e.address,e.bdate from employee e,department d,project p where plocation='stafford' and p.dnum=d.dnumber and d.mgr_ssn=e.ssn;
+---------+------+---------+------------------------+------------+
| pnumber | dnum | lname   | address                | bdate      |
+---------+------+---------+------------------------+------------+
|      10 |    4 | Wallace | 291 Berry, Bellaire,TX | 1941-06-20 |
|      30 |    4 | Wallace | 291 Berry, Bellaire,TX | 1941-06-20 |
+---------+------+---------+------------------------+------------+

4. Query: For each employee, retrieve the employee’s first and last
name and the first and last name of his or her immediate
supervisor.
mysql> select e1.fname,e1.lname,e2.fname,e2.lname from employee e1,employee e2 where e1.super_ssn=e2.ssn;
+----------+---------+----------+---------+
| fname    | lname   | fname    | lname   |
+----------+---------+----------+---------+
| John     | Smith   | Franklin | Wong    |
| Franklin | Wong    | James    | Borg    |
| Joyce    | English | Franklin | Wong    |
| Ramesh   | Narayan | Franklin | Wong    |
| Jennifer | Wallace | James    | Borg    |
| Ahmad    | Jabbar  | Jennifer | Wallace |
| Alicia   | Zelaya  | Jennifer | Wallace |
+----------+---------+----------+---------+
7 rows in set (0.00 sec)

mysql> 





5. Query: Write a query which is retrieves all the attribute values of
any EMPLOYE who works in DEPARTMENT number 5
mysql> select e.*,d.* from employee e join department d on d.dnumber=e.dnum where d.dnumber=5;
+----------+-------+---------+-----------+------------+-------------------------+------+----------+-----------+------+----------+---------+-----------+----------------+
| Fname    | Mname | Lname   | Ssn       | Bdate      | Address                 | Sex  | Salary   | Super_ssn | Dnum | Dname    | Dnumber | mgr_ssn   | Mgr_start_date |
+----------+-------+---------+-----------+------------+-------------------------+------+----------+-----------+------+----------+---------+-----------+----------------+
| John     | B     | Smith   | 123456789 | 1965-01-09 | 731 Fondren, Houston,TX | M    | 30000.00 | 333445555 |    5 | Research |       5 | 333445555 | 1988-05-22     |
| Franklin | T     | Wong    | 333445555 | 1955-12-08 | 638 Voss, Houston,TX    | F    | 40000.00 | 888665555 |    5 | Research |       5 | 333445555 | 1988-05-22     |
| Joyce    | A     | English | 453453453 | 1972-07-31 | 5631 Rice, Houston,TX   | F    | 25000.00 | 333445555 |    5 | Research |       5 | 333445555 | 1988-05-22     |
| Ramesh   | K     | Narayan | 666884444 | 1962-09-15 | 975 Fire Oak, Humble,TX | M    | 38000.00 | 333445555 |    5 | Research |       5 | 333445555 | 1988-05-22     |
+----------+-------+---------+-----------+------------+-------------------------+------+----------+-----------+------+----------+---------+-----------+----------------+



6. Query: write a query which is retrieves all the attributes of an
EMPLOYEE and attributes of the DEPARTMENT in which he or she
works for every employee of the ‘Research’ department,
mysql> select e.*,d.* from employee e join department d on d.dnumber=e.dnum where d.dname='research';
+----------+-------+---------+-----------+------------+-------------------------+------+----------+-----------+------+----------+---------+-----------+----------------+
| Fname    | Mname | Lname   | Ssn       | Bdate      | Address                 | Sex  | Salary   | Super_ssn | Dnum | Dname    | Dnumber | mgr_ssn   | Mgr_start_date |
+----------+-------+---------+-----------+------------+-------------------------+------+----------+-----------+------+----------+---------+-----------+----------------+
| John     | B     | Smith   | 123456789 | 1965-01-09 | 731 Fondren, Houston,TX | M    | 30000.00 | 333445555 |    5 | Research |       5 | 333445555 | 1988-05-22     |
| Franklin | T     | Wong    | 333445555 | 1955-12-08 | 638 Voss, Houston,TX    | F    | 40000.00 | 888665555 |    5 | Research |       5 | 333445555 | 1988-05-22     |
| Joyce    | A     | English | 453453453 | 1972-07-31 | 5631 Rice, Houston,TX   | F    | 25000.00 | 333445555 |    5 | Research |       5 | 333445555 | 1988-05-22     |
| Ramesh   | K     | Narayan | 666884444 | 1962-09-15 | 975 Fire Oak, Humble,TX | M    | 38000.00 | 333445555 |    5 | Research |       5 | 333445555 | 1988-05-22     |
+----------+-------+---------+-----------+------------+-------------------------+------+----------+-----------+------+----------+---------+-----------+----------------+
7. Query: write a query which is specifies the CROSS PRODUCT of the
EMPLOYEE and DEPARTMENT relations.
mysql> select * from employee cross join department;
+----------+-------+---------+-----------+------------+-------------------------+------+----------+-----------+------+----------------+---------+-----------+----------------+
| Fname    | Mname | Lname   | Ssn       | Bdate      | Address                 | Sex  | Salary   | Super_ssn | Dnum | Dname          | Dnumber | mgr_ssn   | Mgr_start_date |
+----------+-------+---------+-----------+------------+-------------------------+------+----------+-----------+------+----------------+---------+-----------+----------------+
| John     | B     | Smith   | 123456789 | 1965-01-09 | 731 Fondren, Houston,TX | M    | 30000.00 | 333445555 |    5 | Research       |       5 | 333445555 | 1988-05-22     |
| John     | B     | Smith   | 123456789 | 1965-01-09 | 731 Fondren, Houston,TX | M    | 30000.00 | 333445555 |    5 | Administration |       4 | 987654321 | 1995-01-01     |
| John     | B     | Smith   | 123456789 | 1965-01-09 | 731 Fondren, Houston,TX | M    | 30000.00 | 333445555 |    5 | Headquarters   |       1 | 888665555 | 1981-06-19     |
| Franklin | T     | Wong    | 333445555 | 1955-12-08 | 638 Voss, Houston,TX    | F    | 40000.00 | 888665555 |    5 | Research       |       5 | 333445555 | 1988-05-22     |
| Franklin | T     | Wong    | 333445555 | 1955-12-08 | 638 Voss, Houston,TX    | F    | 40000.00 | 888665555 |    5 | Administration |       4 | 987654321 | 1995-01-01     |
| Franklin | T     | Wong    | 333445555 | 1955-12-08 | 638 Voss, Houston,TX    | F    | 40000.00 | 888665555 |    5 | Headquarters   |       1 | 888665555 | 1981-06-19     |
| Joyce    | A     | English | 453453453 | 1972-07-31 | 5631 Rice, Houston,TX   | F    | 25000.00 | 333445555 |    5 | Research       |       5 | 333445555 | 1988-05-22     |
| Joyce    | A     | English | 453453453 | 1972-07-31 | 5631 Rice, Houston,TX   | F    | 25000.00 | 333445555 |    5 | Administration |       4 | 987654321 | 1995-01-01     |
| Joyce    | A     | English | 453453453 | 1972-07-31 | 5631 Rice, Houston,TX   | F    | 25000.00 | 333445555 |    5 | Headquarters   |       1 | 888665555 | 1981-06-19     |
| Ramesh   | K     | Narayan | 666884444 | 1962-09-15 | 975 Fire Oak, Humble,TX | M    | 38000.00 | 333445555 |    5 | Research       |       5 | 333445555 | 1988-05-22     |
| Ramesh   | K     | Narayan | 666884444 | 1962-09-15 | 975 Fire Oak, Humble,TX | M    | 38000.00 | 333445555 |    5 | Administration |       4 | 987654321 | 1995-01-01     |
| Ramesh   | K     | Narayan | 666884444 | 1962-09-15 | 975 Fire Oak, Humble,TX | M    | 38000.00 | 333445555 |    5 | Headquarters   |       1 | 888665555 | 1981-06-19     |
| James    | E     | Borg    | 888665555 | 1937-11-10 | 450 Stone, Houston,TX   | M    | 55000.00 | NULL      |    1 | Research       |       5 | 333445555 | 1988-05-22     |
| James    | E     | Borg    | 888665555 | 1937-11-10 | 450 Stone, Houston,TX   | M    | 55000.00 | NULL      |    1 | Administration |       4 | 987654321 | 1995-01-01     |
| James    | E     | Borg    | 888665555 | 1937-11-10 | 450 Stone, Houston,TX   | M    | 55000.00 | NULL      |    1 | Headquarters   |       1 | 888665555 | 1981-06-19     |
| Jennifer | S     | Wallace | 987654321 | 1941-06-20 | 291 Berry, Bellaire,TX  | F    | 43000.00 | 888665555 |    4 | Research       |       5 | 333445555 | 1988-05-22     |
| Jennifer | S     | Wallace | 987654321 | 1941-06-20 | 291 Berry, Bellaire,TX  | F    | 43000.00 | 888665555 |    4 | Administration |       4 | 987654321 | 1995-01-01     |
| Jennifer | S     | Wallace | 987654321 | 1941-06-20 | 291 Berry, Bellaire,TX  | F    | 43000.00 | 888665555 |    4 | Headquarters   |       1 | 888665555 | 1981-06-19     |
| Ahmad    | V     | Jabbar  | 987987987 | 1969-03-29 | 980 Dallas, Houston,TX  | M    | 25000.00 | 987654321 |    4 | Research       |       5 | 333445555 | 1988-05-22     |
| Ahmad    | V     | Jabbar  | 987987987 | 1969-03-29 | 980 Dallas, Houston,TX  | M    | 25000.00 | 987654321 |    4 | Administration |       4 | 987654321 | 1995-01-01     |
| Ahmad    | V     | Jabbar  | 987987987 | 1969-03-29 | 980 Dallas, Houston,TX  | M    | 25000.00 | 987654321 |    4 | Headquarters   |       1 | 888665555 | 1981-06-19     |
| Alicia   | J     | Zelaya  | 999887777 | 1968-01-19 | 3321 Castle, Spring,TX  | F    | 25000.00 | 987654321 |    4 | Research       |       5 | 333445555 | 1988-05-22     |
| Alicia   | J     | Zelaya  | 999887777 | 1968-01-19 | 3321 Castle, Spring,TX  | F    | 25000.00 | 987654321 |    4 | Administration |       4 | 987654321 | 1995-01-01     |
| Alicia   | J     | Zelaya  | 999887777 | 1968-01-19 | 3321 Castle, Spring,TX  | F    | 25000.00 | 987654321 |    4 | Headquarters   |       1 | 888665555 | 1981-06-19     |
+----------+-------+---------+-----------+------------+-------------------------+------+----------+-----------+------+----------------+---------+-----------+----------------+

8. Query: Select all EMPLOYEE Ssns in the database.
mysql> select ssn from employee;
+-----------+
| ssn       |
+-----------+
| 888665555 |
| 987654321 |
| 987987987 |
| 999887777 |
| 123456789 |
| 333445555 |
| 453453453 |
| 666884444 |
+-----------+
10.Query: Retrieve the salary of every employee.
mysql> select salary from employee;
+----------+
| salary   |
+----------+
| 30000.00 |
| 40000.00 |
| 25000.00 |
| 38000.00 |
| 55000.00 |
| 43000.00 |
| 25000.00 |
| 25000.00 |
+----------+


11.Query: Retrieve the all distinct salary value.
mysql> select distinct(salary) from employee;
+----------+
| salary   |
+----------+
| 30000.00 |
| 40000.00 |
| 25000.00 |
| 38000.00 |
| 55000.00 |
| 43000.00 |
+----------+

12. Query: Make a list of all project numbers for projects that
involve an employee whose last name is ‘Smith’, either as a worker
or as a manager of the department that controls the project.
mysql> select p.pnumber from project p join employee e on p.dnum=e.dnum where e.lname='smith';
+---------+
| pnumber |
+---------+
|       1 |
|       2 |
|       3 |
+---------+
3 rows in set (0.00 sec)
mysql> select p.pnumber from project p,employee e,department d where e.lname='smith' and p.dnum=d.dnumber and d.dnumber=e.dnum union select p.pnumber from project p,employee e,department d where e.lname='smith' and p.dnum=d.dnumber and d.mgr_ssn=e.ssn;
+---------+
| pnumber |
+---------+
|       1 |
|       2 |
|       3 |
+---------+

13.Query: Retrieve all employees whose address is in Houston,Texas.
mysql> select fname,mname,lname from employee where address='houston,tx';
mysql> select * from employee where address like '%houston,tx%';
+----------+-------+---------+-----------+------------+-------------------------+------+----------+-----------+------+
| Fname    | Mname | Lname   | Ssn       | Bdate      | Address                 | Sex  | Salary   | Super_ssn | Dnum |
+----------+-------+---------+-----------+------------+-------------------------+------+----------+-----------+------+
| John     | B     | Smith   | 123456789 | 1965-01-09 | 731 Fondren, Houston,TX | M    | 30000.00 | 333445555 |    5 |
| Franklin | T     | Wong    | 333445555 | 1955-12-08 | 638 Voss, Houston,TX    | F    | 40000.00 | 888665555 |    5 |
| Joyce    | A     | English | 453453453 | 1972-07-31 | 5631 Rice, Houston,TX   | F    | 25000.00 | 333445555 |    5 |
| James    | E     | Borg    | 888665555 | 1937-11-10 | 450 Stone, Houston,TX   | M    | 55000.00 | NULL      |    1 |
| Ahmad    | V     | Jabbar  | 987987987 | 1969-03-29 | 980 Dallas, Houston,TX  | M    | 25000.00 | 987654321 |    4 |
+----------+-------+---------+-----------+------------+-------------------------+------+----------+-----------+------+

14.Query: Find all employees who were born during the 1950s.
mysql> select fname,mname,lname from employee where bdate between '1950-01-01' and '1960-12-31';
+----------+-------+-------+
| fname    | mname | lname |
+----------+-------+-------+
| Franklin | T     | Wong  |
+----------+-------+-------+
1 row in set (0.00 sec)

15.Query: Show the resulting salaries if every employee workingon the ‘ProductX’ project is given a 10 percent raise.
mysql> select e.salary+e.salary*0.1 as incremented_salary from employee e join p
roject p on e.dnum=p.dnum where p.pname='productx';
+--------------------+
| incremented_salary |
+--------------------+
|          33000.000 |
|          44000.000 |
|          27500.000 |
|          41800.000 |
+--------------------+
4 rows in set (0.00 sec)

16.Query: Retrieve all employees in department 5 whose salary
is between $30,000 and $40,000.
mysql> select fname,mname,lname from employee where salary between 30000 and 40000 and dnum=5;
+----------+-------+---------+
| fname    | mname | lname   |
+----------+-------+---------+
| John     | B     | Smith   |
| Franklin | T     | Wong    |
| Ramesh   | K     | Narayan |
+----------+-------+---------+

17.
Query: Retrieve a list of employees and the projects they are
working on, ordered by department and within each department,
ordered alphabetically by last name, then first name.

mysql> select e.dnum,e.fname,e.mname,e.lname,p.pname from employee e join department d on e.dnum=d.dnumber join project p on d.dnumber=p.dnum order by e.dnum,e.fname,e.lname;
+------+----------+-------+---------+-----------------+
| dnum | fname    | mname | lname   | pname           |
+------+----------+-------+---------+-----------------+
|    1 | James    | E     | Borg    | Reorganization  |
|    4 | Ahmad    | V     | Jabbar  | Newbenefits     |
|    4 | Ahmad    | V     | Jabbar  | Computarization |
|    4 | Alicia   | J     | Zelaya  | Newbenefits     |
|    4 | Alicia   | J     | Zelaya  | Computarization |
|    4 | Jennifer | S     | Wallace | Newbenefits     |
|    4 | Jennifer | S     | Wallace | Computarization |
|    5 | Franklin | T     | Wong    | ProductZ        |
|    5 | Franklin | T     | Wong    | ProductY        |
|    5 | Franklin | T     | Wong    | ProductX        |
|    5 | John     | B     | Smith   | ProductZ        |
|    5 | John     | B     | Smith   | ProductX        |
|    5 | John     | B     | Smith   | ProductY        |
|    5 | Joyce    | A     | English | ProductZ        |
|    5 | Joyce    | A     | English | ProductY        |
|    5 | Joyce    | A     | English | ProductX        |
|    5 | Ramesh   | K     | Narayan | ProductZ        |
|    5 | Ramesh   | K     | Narayan | ProductY        |
|    5 | Ramesh   | K     | Narayan | ProductX        |
+------+----------+-------+---------+-----------------+
19 rows in set (0.00 sec)

18.Query: Retrieve the name of all employees who do not have supervisors.
mysql> select fname from employee where super_ssn is null or super_ssn=' ';
+-------+
| fname |
+-------+
| James |
+-------+
1 row in set (0.00 sec)


19.Query: Retrieve the name of each employee who has a dependent with the same first name and is the same sex as the
employee.
mysql> select e.fname,e.mname,e.lname from employee e join dependent d on e.ssn=d.essn where e.fname=d.dependent_name and e.sex=d.sex;
Empty set (0.00 sec)


21.Query: Retrieve the names of employee who have no dependents;
   mysql> select e.fname from employee e left join dependent d on e.ssn=d.essn where d.essn is null or d.essn='';
+--------+
| fname  |
+--------+
| Joyce  |
| Ramesh |
| James  |
| Ahmad  |
| Alicia |
+--------+


22.Query: List the name of managers who have at least one dependent.
mysql> select fname from employee where ssn in(select essn from dependent group by essn having count(*)>=1);
+----------+
| fname    |
+----------+
| John     |
| Franklin |
| Jennifer |
+----------+


23.Query: Retrieve the Social Security numbers of all employee
who work on project numbers 1, 2, or 3.
mysql> select distinct(e.ssn) from employee e join project p on e.dnum=p.dnum where p.pnumber=1 or p.pnumber=2 or p.pnumber=3;
+-----------+
| ssn       |
+-----------+
| 123456789 |
| 333445555 |
| 453453453 |
| 666884444 |
+-----------+

24.Query: Find the sum of the salaries of all employees, the
maximum salary, the minimum salary, and the average salary.
mysql> select sum(salary),avg(salary),max(salary),min(salary) from employee;
+-------------+--------------+-------------+-------------+
| sum(salary) | avg(salary)  | max(salary) | min(salary) |
+-------------+--------------+-------------+-------------+
|   281000.00 | 35125.000000 |    55000.00 |    25000.00 |
+-------------+--------------+-------------+-------------+
1 row in set (0.00 sec)


25.Query: Find the sum of the salaries of all employees of the
‘Research’ department, as well as the maximum salary, the
minimum salary, and the average salary in this department.
mysql> select avg(e.salary),sum(e.salary),max(e.salary),min(e.salary) from employee e join department d on e.dnum=d.dnumber where d.dname="research";
+---------------+---------------+---------------+---------------+
| avg(e.salary) | sum(e.salary) | max(e.salary) | min(e.salary) |
+---------------+---------------+---------------+---------------+
|  33250.000000 |     133000.00 |      40000.00 |      25000.00 |
+---------------+---------------+---------------+---------------+


26.Query: Retrieve the total number of employees in the
company.
mysql> select count(fname) from employee;
+--------------+
| count(fname) |
+--------------+
|            8 |
+--------------+
1 row in set (0.00 sec)

mysql> select count(ssn) from employee;
+------------+
| count(ssn) |
+------------+
|          8 |
+------------+
1 row in set (0.00 sec)


27.Query: Retrieve the total number of employees in the
company and the number of employees in the ‘Research’
department.
mysql> select count(fname) as total_emp from employee union select count(e.fname) as research_emp from employee e join department d on e.dnum=d.dnumber group by d.dname="research";
+-----------+
| total_emp |
+-----------+
|         8 |
|         4 |
+-----------+
2 rows in set (0.00 sec)


28.
Query: Count the number of distinct salary value in the
database.
mysql> select salary,count(salary) from employee group by salary;
+----------+---------------+
| salary   | count(salary) |
+----------+---------------+
| 30000.00 |             1 |
| 40000.00 |             1 |
| 25000.00 |             3 |
| 38000.00 |             1 |
| 55000.00 |             1 |
| 43000.00 |             1 |
+----------+---------------+
6 rows in set (0.00 sec)

29. Query: For each department, retrieve the department number,the number of employees in the department, and their average
salary.
mysql> select d.dname,d.dnumber,count(e.fname) as no_of_emp,avg(e.salary) as avg_salary from employee e join department d on e.dnum=d.dnumber group by d.dnumber;
+----------------+---------+-----------+--------------+
| dname          | dnumber | no_of_emp | avg_salary   |
+----------------+---------+-----------+--------------+
| Headquarters   |       1 |         1 | 55000.000000 |
| Administration |       4 |         3 | 31000.000000 |
| Research       |       5 |         4 | 33250.000000 |
+----------------+---------+-----------+--------------+
3 rows in set (0.00 sec)


30. Query: For each project, retrieve the project number, the project
name, and
the number of employees who work on that project.
mysql> select p.pnumber,p.pname,count(e.fname) as no_of_emp from project p join department d on p.dnum=d.dnumber join employee e on e.dnum=d.dnumber group by p.pnumber;
+---------+-----------------+-----------+
| pnumber | pname           | no_of_emp |
+---------+-----------------+-----------+
|       1 | ProductX        |         4 |
|       2 | ProductY        |         4 |
|       3 | ProductZ        |         4 |
|      10 | Computarization |         3 |
|      20 | Reorganization  |         1 |
|      30 | Newbenefits     |         3 |
+---------+-----------------+-----------+
6 rows in set (0.00 sec)

31. Query: For each project on which more than two employees
work, retrieve the project number, the project name, and the
number of employees who work on the project.
mysql> select p.pnumber,p.pname,count(w.essn) as 'no of employees' from project p join works_on w on p.pnumber=w.pno group by pnumber having count(w.essn)>2;
+---------+-----------------+-----------------+
| pnumber | pname           | no of employees |
+---------+-----------------+-----------------+
|       2 | ProductY        |               3 |
|      10 | Computarization |               3 |
|      20 | Reorganization  |               3 |
|      30 | Newbenefits     |               3 |
+---------+-----------------+-----------------+
4 rows in set (0.00 sec)


32. Query: For each project, retrieve the project number, the
project name, and
the number of employees from department 5 who work on the
project.
mysql> select p.pnumber,p.pname,count(w.essn) as 'no of employees' from project p,works_on w where p.pnumber=w.pno and p.dnum=5 group by pnumber;
+---------+----------+-----------------+
| pnumber | pname    | no of employees |
+---------+----------+-----------------+
|       1 | ProductX |               2 |
|       2 | ProductY |               3 |
|       3 | ProductZ |               2 |
+---------+----------+-----------------+
3 rows in set (0.00 sec)

33. Query: For each department that has more than five employees,
retrieve the department number and the number of its employees
who are making more than $40,000.mysql> select e.dnum,count(e.ssn) from employee e,department d where e.salary>40000 and e.dnum=d.dnumber group by dnum having count(e.ssn )>5;
Empty set (0.00 sec)









