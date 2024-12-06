create database joins;

use joins;

create table employees (
employee_id int primary key ,
employee_name varchar(100),
dept_id int 
);

insert into employees(employee_id,employee_name,dept_id)
values
(1,'A1',101),
(2,'A2',102),
(3,'A3',null),
(4,'A4',104);

create table department(
dept_id int primary key,
dept_name varchar(100)
);

insert into department (dept_id,dept_name)
values
(101,'HR'),
(102,'Finance'),
(103,'IT'),
(104,'Marketing');

#################################################################################
#Inner Join

select e.employee_id,e.employee_name,d.dept_name from employees as e
inner join department as d on e.dept_id=d.dept_id;

#################################################################################
#left Join

select e.employee_id,e.employee_name,d.dept_name from employees as e
left join department as d on e.dept_id=d.dept_id;

#####################################################################################
# right join

select e.employee_id,e.employee_name,d.dept_name from employees as e
right join department as d on e.dept_id=d.dept_id;

###################################################################################
#outer join (if full join is not working on the system ,better do union of left & the right join will get the same output)

select e.employee_id,e.employee_name,d.dept_name from employees as e
full outer join department as d on e.dept_id=d.dept_id;
########################################################
SELECT e.employee_id, e.employee_name, d.dept_name
FROM employees AS e
LEFT JOIN department AS d ON e.dept_id = d.dept_id

UNION

SELECT e.employee_id, e.employee_name, d.dept_name
FROM employees AS e
RIGHT JOIN department AS d ON e.dept_id = d.dept_id;
########################################################
# cross join  (Cartisian format matrix m*n matrix)

SELECT e.employee_id, e.employee_name, d.dept_name
FROM employees AS e
cross JOIN department AS d 
order by e.employee_id;


###################################################################################
#self join 
SELECT e1.employee_id, e1.employee_name, e1.dept_id, e2.employee_id AS Matched_EmployeeID
FROM employees AS e1
INNER JOIN employees AS e2 ON e1.dept_id = e2.dept_id
WHERE e1.employee_id = e2.employee_id;

# to find the duplicates self join is helpfull

SELECT e1.*
FROM employees AS e1
INNER JOIN employees AS e2 
ON e1.employee_name = e2.employee_name AND e1.employee_id != e2.employee_id;

######################################################################################
