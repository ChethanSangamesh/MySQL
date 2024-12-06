
-- This file contains detailed SQL examples with explanations for each query.

-- 16. What are Views?
-- A view is a virtual table based on the result of an SQL SELECT query.
-- It can be used to simplify complex queries and improve data security by exposing only selected data.
CREATE VIEW ActiveEmployees AS
SELECT EmployeeID, Name, Department, Salary
FROM Employees
WHERE Status = 'Active';

-- 17. What are Different Types of Constraints?
-- Constraints maintain the integrity of the database. Types include:
-- PRIMARY KEY: Ensures a column has unique and non-null values.
-- FOREIGN KEY: Ensures the value in a column matches a value in another table.
-- NOT NULL: Prevents NULL values in a column.
-- UNIQUE: Ensures all values in a column are different.
-- CHECK: Ensures a condition is true for all values in a column.
-- DEFAULT: Provides a default value if none is specified.

CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each employee
    Name VARCHAR(100) NOT NULL,                -- Name cannot be NULL
    Department VARCHAR(50), 
    Salary DECIMAL(10, 2) CHECK (Salary > 0),  -- Salary must be greater than 0
    Status ENUM('Active', 'Inactive') DEFAULT 'Active' -- Default value for Status is 'Active'
);

-- 18. What is the Difference Between VARCHAR and NVARCHAR?
-- VARCHAR: Stores non-Unicode data and uses 1 byte per character.
-- NVARCHAR: Stores Unicode data (multi-language support) and uses 2 bytes per character.
CREATE TABLE NonUnicodeTable ( Name VARCHAR(50) );
CREATE TABLE UnicodeTable ( Name NVARCHAR(50) CHARACTER SET utf8mb4 );

-- 19. Similar for CHAR and NCHAR?
-- CHAR: Fixed-length non-Unicode string.
-- NCHAR: Fixed-length Unicode string.
CREATE TABLE NonUnicodeFixed ( Code CHAR(10) );
CREATE TABLE UnicodeFixed ( Code NCHAR(10) CHARACTER SET utf8mb4 );

-- 20. What are Index and Their Types?
-- An index speeds up the retrieval of data from a table.
-- Single-column index: Index on one column.
-- Composite index: Index on multiple columns.
-- Unique index: Ensures all values in the index are unique.

CREATE INDEX idx_department ON Employees(Department); -- Single-column index
CREATE INDEX idx_dept_salary ON Employees(Department, Salary); -- Composite index

-- 22. Relationships in SQL
-- Relationships connect tables logically.
-- One-to-Many: One record in Table A links to multiple records in Table B.
-- Many-to-Many: Multiple records in Table A link to multiple records in Table B.

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) -- One-to-Many relationship
);

-- More detailed examples and comments added here.


-- 16. What are Views?
CREATE VIEW ActiveEmployees AS
SELECT EmployeeID, Name, Department, Salary
FROM Employees
WHERE Status = 'Active';

-- 17. What are Different Types of Constraints?
CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Department VARCHAR(50),
    Salary DECIMAL(10, 2) CHECK (Salary > 0),
    Status ENUM('Active', 'Inactive') DEFAULT 'Active'
);

-- 18. VARCHAR vs NVARCHAR
CREATE TABLE NonUnicodeTable ( Name VARCHAR(50) );
CREATE TABLE UnicodeTable ( Name NVARCHAR(50) CHARACTER SET utf8mb4 );

-- 19. CHAR vs NCHAR
CREATE TABLE NonUnicodeFixed ( Code CHAR(10) );
CREATE TABLE UnicodeFixed ( Code NCHAR(10) CHARACTER SET utf8mb4 );

-- 20 & 21. Indexes
CREATE INDEX idx_department ON Employees(Department);
CREATE INDEX idx_dept_salary ON Employees(Department, Salary);

-- 22. Relationships in SQL
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);
CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- 23 & 25. UNION vs UNION ALL
SELECT Name FROM Employees WHERE Department = 'Sales'
UNION
SELECT Name FROM Employees WHERE Status = 'Active';
SELECT Name FROM Employees WHERE Department = 'Sales'
UNION ALL
SELECT Name FROM Employees WHERE Status = 'Active';

-- 28. WHERE vs HAVING
SELECT * FROM Employees WHERE Salary > 5000;
SELECT Department, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY Department
HAVING AvgSalary > 5000;

-- 29. Second Highest Salary
SELECT MAX(Salary) AS SecondHighestSalary
FROM Employees
WHERE Salary < (SELECT MAX(Salary) FROM Employees);

-- 30. Retention Query
SELECT 
    Department, 
    COUNT(EmployeeID) AS TotalEmployees,
    SUM(CASE WHEN Status = 'Active' THEN 1 ELSE 0 END) AS RetainedEmployees
FROM Employees
GROUP BY Department;

-- 31. Year-on-Year Growth
SELECT 
    YEAR(HireDate) AS Year,
    COUNT(EmployeeID) AS TotalHires,
    (COUNT(EmployeeID) - LAG(COUNT(EmployeeID)) OVER (ORDER BY YEAR(HireDate))) AS Growth
FROM Employees
GROUP BY YEAR(HireDate);

-- 32. Cumulative Sum
SELECT 
    EmployeeID,
    Department,
    Salary,
    SUM(Salary) OVER (PARTITION BY Department ORDER BY EmployeeID) AS CumulativeSalary
FROM Employees;
