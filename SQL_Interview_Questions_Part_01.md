
# SQL Interview Questions and Explanations

## 1. Explain order of execution in SQL
In MySQL, the SQL query execution order is as follows:
1. **FROM**: Tables are selected.
2. **JOIN**: Joins between tables are resolved.
3. **WHERE**: Filters rows based on conditions.
4. **GROUP BY**: Groups rows based on columns.
5. **HAVING**: Filters grouped data.
6. **SELECT**: Columns to display are chosen.
7. **DISTINCT**: Removes duplicate rows.
8. **ORDER BY**: Sorts the result.
9. **LIMIT**: Restricts the number of rows returned.

### Example:
```sql
SELECT department, SUM(salary) 
FROM employees 
WHERE salary > 5000 
GROUP BY department 
HAVING SUM(salary) > 20000 
ORDER BY department;
```

---

## 2. What is the difference between WHERE and HAVING?
- **WHERE**: Filters rows **before** grouping.
- **HAVING**: Filters groups **after** grouping.

### Example:
```sql
-- WHERE filters individual rows
SELECT * FROM employees WHERE salary > 5000;

-- HAVING filters grouped data
SELECT department, SUM(salary) 
FROM employees 
GROUP BY department 
HAVING SUM(salary) > 20000;
```

---

## 3. What is the use of GROUP BY?
`GROUP BY` aggregates rows into groups based on one or more columns.

### Example:
```sql
SELECT department, COUNT(*) AS employee_count 
FROM employees 
GROUP BY department;
```

---

## 4. Explain all types of joins in SQL
- **INNER JOIN**: Returns rows with matching values in both tables.
- **LEFT JOIN**: Returns all rows from the left table and matching rows from the right table.
- **RIGHT JOIN**: Returns all rows from the right table and matching rows from the left table.
- **FULL OUTER JOIN**: Returns all rows when there's a match in either table (not directly supported in MySQL).
- **CROSS JOIN**: Returns the Cartesian product of both tables.

### Example:
```sql
-- INNER JOIN
SELECT employees.name, departments.department_name 
FROM employees 
INNER JOIN departments ON employees.department_id = departments.id;

-- LEFT JOIN
SELECT employees.name, departments.department_name 
FROM employees 
LEFT JOIN departments ON employees.department_id = departments.id;
```

---

## 5. What are triggers in SQL?
Triggers are database functions that execute automatically in response to certain events on a table (INSERT, UPDATE, DELETE).

### Example:
```sql
CREATE TRIGGER before_employee_insert 
BEFORE INSERT ON employees 
FOR EACH ROW 
SET NEW.created_at = NOW();
```

---

## 6. What is a stored procedure in SQL?
A stored procedure is a precompiled collection of SQL statements that can be executed as a single unit.

### Example:
```sql
DELIMITER //
CREATE PROCEDURE GetEmployeeCountByDept()
BEGIN
    SELECT department, COUNT(*) AS employee_count 
    FROM employees 
    GROUP BY department;
END //
DELIMITER ;
CALL GetEmployeeCountByDept();
```

---

## 7. Explain all types of window functions
- **ROW_NUMBER()**: Assigns a unique number to rows.
- **RANK()**: Assigns a rank, skipping ranks for duplicates.
- **DENSE_RANK()**: Assigns a rank without skipping.
- **LEAD()**: Accesses the next row's data.
- **LAG()**: Accesses the previous row's data.

### Example:
```sql
SELECT name, salary, 
       RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;
```

---

## 8. What is the difference between DELETE and TRUNCATE?
- **DELETE**: Removes specific rows; can include a WHERE clause. Logs each deleted row.
- **TRUNCATE**: Removes all rows from a table. Cannot include a WHERE clause.

### Example:
```sql
DELETE FROM employees WHERE department_id = 3;
TRUNCATE TABLE employees;
```

---

## 9. What is the difference between DML, DDL, and DCL?
- **DML (Data Manipulation Language)**: `SELECT`, `INSERT`, `UPDATE`, `DELETE`.
- **DDL (Data Definition Language)**: `CREATE`, `ALTER`, `DROP`, `TRUNCATE`.
- **DCL (Data Control Language)**: `GRANT`, `REVOKE`.

---

## 10. What are aggregate functions, and when do we use them?
Aggregate functions perform calculations on a set of values.
- **SUM()**, **AVG()**, **COUNT()**, **MIN()**, **MAX()**.

### Example:
```sql
SELECT department, SUM(salary) AS total_salary 
FROM employees 
GROUP BY department;
```

---

## 11. Which is faster between CTE and Subquery?
- CTEs (Common Table Expressions) can improve readability but aren't always faster.
- Subqueries are evaluated per usage and can be less efficient for complex queries.

### Example:
Using CTE:
```sql
WITH EmployeeCount AS (
    SELECT department, COUNT(*) AS employee_count 
    FROM employees 
    GROUP BY department
)
SELECT * FROM EmployeeCount WHERE employee_count > 10;
```

---

## 12. What are constraints and types of constraints?
Constraints enforce rules at the table level.
- **NOT NULL**: Ensures no null values.
- **UNIQUE**: Ensures unique values.
- **PRIMARY KEY**: Combines NOT NULL and UNIQUE.
- **FOREIGN KEY**: Links two tables.
- **CHECK**: Ensures a condition.
- **DEFAULT**: Sets a default value.

### Example:
```sql
CREATE TABLE employees (
    id INT PRIMARY KEY,
    salary DECIMAL(10, 2) NOT NULL,
    department_id INT,
    CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES departments(id)
);
```

---

## 13. Types of Keys
- **Primary Key**: Unique identifier.
- **Foreign Key**: Links tables.
- **Unique Key**: Ensures unique values.
- **Composite Key**: Combination of two or more columns.
- **Candidate Key**: Eligible keys for the primary key.

---

## 14. Different types of Operators
- **Arithmetic**: `+`, `-`, `*`, `/`.
- **Comparison**: `=`, `!=`, `>`, `<`, `>=`, `<=`.
- **Logical**: `AND`, `OR`, `NOT`.
- **Bitwise**: `&`, `|`, `^`.

---

## 15. Difference between GROUP BY and WHERE
- `WHERE`: Filters rows **before** grouping.
- `GROUP BY`: Groups rows after WHERE.

### Example:
```sql
SELECT department, COUNT(*) 
FROM employees 
WHERE salary > 5000 
GROUP BY department;
```

---
