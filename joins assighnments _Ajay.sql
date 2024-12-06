create database emp;
use  emp;

create table employee(
id int primary key auto_increment,
name varchar(100),
phone_number varchar(20)
);

insert into employee(name,phone_number)
values
("Chethan","9875845687"),
("Sangamesh","8758698574"),
("Ajay","9758968574"),
("Vijay","7856985478")
;
CREATE TABLE attendance (
    employee_id INT,
    A_date DATE NOT NULL,
    check_in TIME,
    check_out TIME,
    PRIMARY KEY (employee_id, A_date),
    FOREIGN KEY (employee_id) REFERENCES employee(id)
);

INSERT INTO attendance (employee_id, A_date, check_in, check_out)
VALUES
(1, '2024-12-01', '09:00', '18:00'),
(1, '2024-12-03', '09:00', '18:00'),
(2, '2024-12-02', '09:00', '18:00'),
(2, '2024-12-04', '09:00', '18:00'),
(3, '2024-12-03', '09:00', '18:00'),
(3, '2024-12-05', '09:00', '18:00'),
(4, '2024-12-04', '09:00', '18:00'),
(4, '2024-12-01', '09:00', '18:00');

select * from attendance; 
########################################################################

# employees  present on 1st dec 2024

select e.name,e.phone_number from employee as e 
left join attendance as a 
on e.id=a.employee_id
where a.A_date ='2024-12-02';

###########################################################################

# employees  absent  on 1st dec 2024

SELECT DISTINCT e.name, e.phone_number
FROM employee AS e
left JOIN attendance AS a 
ON e.id = a.employee_id
WHERE a.A_date IS NULL or a.A_date NOT IN ('2024-12-02');

SELECT DISTINCT e.name, e.phone_number
FROM employee AS e
LEFT JOIN attendance AS a 
ON e.id = a.employee_id AND a.A_date = '2024-12-02'
WHERE a.A_date IS NULL;

#########################################################################################
# simple subquery 

select distinct employee_id from attendance where employee_id not in (
     select employee_id from attendance where A_date='2024-12-02');

# people who are absent on 2nd dec 2024  1st method 

select  DISTINCT e.name ,e.phone_number,a.employee_id from employee as e 
left join attendance as a on e.id=a.employee_id 
where a.employee_id in (select distinct employee_id from attendance where employee_id not in (
     select employee_id from attendance where A_date='2024-12-02')
);

# 2nd method withour using joins 

select id,name,phone_number from employee 
where id in (select employee_id from attendance where employee_id not in 
		(select employee_id from attendance where A_date in ('2024-12-02')));

# 3rd method to solve the query 

SELECT e.id, e.name, e.phone_number
FROM employee e
WHERE NOT EXISTS (SELECT 1 FROM attendance a   
WHERE a.employee_id = e.id AND a.A_date = '2024-12-02'
);
 
        
###############################################################################################
SHOW CREATE TABLE attendance;

ALTER TABLE attendance
DROP FOREIGN KEY attendance_ibfk_1;

ALTER TABLE attendance
ADD CONSTRAINT attendance_ibfk_1
FOREIGN KEY (employee_id) REFERENCES employee(id);

###############################################################################################






