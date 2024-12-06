create database school_management;
use school_management;

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('Student', 'Teacher', 'Admin') NOT NULL,
    date_of_birth DATE NOT NULL,
    contact_number VARCHAR(15) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO Users (full_name, email, password, role, date_of_birth, contact_number)
VALUES
('Aarav Sharma', 'aarav.sharma@example.com', 'password123', 'Student', '2010-05-15', '9876543210'),
('Ananya Iyer', 'ananya.iyer@example.com', 'password123', 'Teacher', '1985-03-22', '9876543211'),
('Rohit Kumar', 'rohit.kumar@example.com', 'adminpass', 'Admin', '1980-12-10', '9876543212');

CREATE TABLE Classes (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(50) NOT NULL,
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Users(user_id)
);

INSERT INTO Classes (class_name, teacher_id)
VALUES
('Mathematics', 2),
('Science', 2);


CREATE TABLE Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    class_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    FOREIGN KEY (student_id) REFERENCES Users(user_id),
    FOREIGN KEY (class_id) REFERENCES Classes(class_id),
    UNIQUE (student_id, class_id)
);

INSERT INTO Enrollments (student_id, class_id)
VALUES
(1, 1),
(1, 2);


CREATE TABLE Attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    class_id INT NOT NULL,
    date DATE NOT NULL,
    status ENUM('Present', 'Absent', 'Late') NOT NULL,
    FOREIGN KEY (student_id) REFERENCES Users(user_id),
    FOREIGN KEY (class_id) REFERENCES Classes(class_id)
);

INSERT INTO Attendance (student_id, class_id, date, status)
VALUES
(1, 1, '2024-12-01', 'Present'),
(1, 2, '2024-12-01', 'Absent');

CREATE TABLE Exams (
    exam_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(50) NOT NULL,
    class_id INT NOT NULL,
    exam_date DATE NOT NULL,
    total_marks INT NOT NULL,
    FOREIGN KEY (class_id) REFERENCES Classes(class_id)
);

INSERT INTO Exams (subject_name, class_id, exam_date, total_marks)
VALUES
('Mathematics', 1, '2024-12-10', 100),
('Science', 2, '2024-12-11', 100);

CREATE TABLE Results (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    exam_id INT NOT NULL,
    marks_obtained INT NOT NULL,
    grade CHAR(1),
    FOREIGN KEY (student_id) REFERENCES Users(user_id),
    FOREIGN KEY (exam_id) REFERENCES Exams(exam_id)
);

INSERT INTO Results (student_id, exam_id, marks_obtained, grade)
VALUES
(1, 1, 85, 'A'),
(1, 2, 75, 'B');

###############################################################################
#Joins 
SELECT u.full_name, c.class_name
FROM Users u
JOIN Enrollments e ON u.user_id = e.student_id
JOIN Classes c ON e.class_id = c.class_id
WHERE u.role = 'Student';

##############################################################################
# Aggregate function
SELECT c.class_name, AVG(r.marks_obtained) AS average_marks
FROM Results r
JOIN Exams e ON r.exam_id = e.exam_id
JOIN Classes c ON e.class_id = c.class_id
GROUP BY c.class_name;
##############################################################################
#window functions

SELECT student_id, exam_id, marks_obtained,
RANK() OVER (PARTITION BY exam_id ORDER BY marks_obtained DESC) AS rn
FROM Results;
################################################################################
#CASE
SELECT marks_obtained,
       CASE 
           WHEN marks_obtained >= 90 THEN 'A+'
           WHEN marks_obtained >= 75 THEN 'A'
           WHEN marks_obtained >= 50 THEN 'B'
           ELSE 'F'
       END AS grade
FROM Results;

#################################################################################
#group by andhaving clause

SELECT class_id, COUNT(*) AS total_classes,
       SUM(status = 'Present') / COUNT(*) * 100 AS attendance_percentage
FROM Attendance
GROUP BY class_id
HAVING attendance_percentage > 75;

#################################################################################
#Password 

SELECT user_id, full_name, role
FROM Users
WHERE email = 'aarav.sharma@example.com' AND password = 'password123';





