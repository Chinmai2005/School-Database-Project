CREATE TABLE Students (
    student_id int PRIMARY KEY,
    name text NOT NULL,
    roll_number text UNIQUE NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT UNIQUE NOT NULL,
    address TEXT DEFAULT 'Not Provided'
);

CREATE TABLE Faculty (
    faculty_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT UNIQUE NOT NULL,
    department TEXT CHECK (department IN ('Science', 'Arts', 'Commerce', 'Engineering'))
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name TEXT NOT NULL,
    course_code TEXT UNIQUE NOT NULL,
    department TEXT CHECK (department IN ('Science', 'Arts', 'Commerce', 'Engineering')),
    credits INT CHECK (credits > 0),
    faculty_id INT NOT NULL
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE DEFAULT CURRENT_DATE,
    grade TEXT CHECK (grade IN ('A', 'B', 'C', 'D', 'F')) DEFAULT 'Note Graded'
);


INSERT INTO Students (student_id, name, roll_number, email, phone, address) VALUES
(1, 'John Doe', '101', 'john.doe@email.com', '9876543210', '123 Main St'),
(2, 'Jane Smith', '102', 'jane.smith@email.com', '9823456789', '45 Elm St'),
(3, 'Alice Brown', '103', 'alice.b@email.com', '9988776655', '78 Pine Ave'),
(4, 'Bob Johnson', '104', 'bob.j@email.com', '9765432109', '90 Oak Lane'),
(5, 'Charlie Lee', '105', 'charlie.l@email.com', '9234567890', 'Not Provided'),
(6, 'David White', '106', 'david.w@email.com', '9678991234', '12 Maple St'),
(7, 'Emily Clark', '107', 'emily.c@email.com', '9345678901', 'Not Provided'),
(8, 'Frank Harris', '108', 'frank.h@email.com', '9763214785', '56 Birch Road'),
(9, 'Grace Kelly', '109', 'grace.k@email.com', '9456123870', '32 Cedar Ave'),
(10, 'Henry Adams', '110', 'henry.a@email.com', '9312465789', '22 Walnut Lane');

-- Insert data into Faculty table
INSERT INTO Faculty (faculty_id, name, email, phone, department) VALUES
(1, 'Dr. Smith', 'smith@univ.com', '9876543211', 'Science'),
(2, 'Dr. Johnson', 'johnson@univ.com', '9823456781', 'Arts'),
(3, 'Dr. Williams', 'williams@univ.com', '9988776611', 'Commerce'),
(4, 'Dr. Brown', 'brown@univ.com', '9765432191', 'Engineering'),
(5, 'Dr. Davis', 'davis@univ.com', '9234567811', 'Science');

-- Insert data into Courses table
INSERT INTO Courses (course_id, course_name, course_code, department, credits, faculty_id) VALUES
(1, 'Mathematics', 'MATH101', 'Science', 4, 1),
(2, 'English Literature', 'ENG102', 'Arts', 3, 2),
(3, 'Economics', 'ECO103', 'Commerce', 4, 3),
(4, 'Computer Science', 'CS104', 'Engineering', 4, 4),
(5, 'Physics', 'PHY105', 'Science', 3, 5);

-- Insert data into Enrollments table
INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date, grade) VALUES
(1, 1, 1, '2024-01-15', 'A'),
(2, 2, 2, '2024-01-16', 'B'),
(3, 3, 3, '2024-01-17', 'A'),
(4, 4, 4, '2024-01-18', 'C'),
(5, 5, 5, '2024-01-19', 'B'),
(6, 6, 1, '2024-01-20', 'A'),
(7, 7, 2, '2024-01-21', 'C'),
(8, 8, 3, '2024-01-22', 'B'),
(9, 9, 4, '2024-01-23', 'A'),
(10, 10, 5, '2024-01-24', 'B');

-- Retrieve the last record from the Faculty table
SELECT * FROM Faculty
WHERE faculty_id = 5;


-- Retrieve the last record from the Courses table
SELECT * FROM Courses
WHERE course_id = 5;


-- Retrieve the last record from the Enrollments table
SELECT * FROM Enrollments
WHERE enrollment_id = 10;

--Fetch all distinct departments from the Faculty table.
SELECT DISTINCT department FROM Courses

--Get enrollments where students received grade 'C'.
SELECT * FROM Enrollments
WHERE grade = 'C'; 

--Find the 2 most recent enrollments by enrollment_date.
SELECT * FROM Enrollments
ORDER BY enrollment_date DESC LIMIT 2;

--Increase the credits of all Science courses by 1.
--Then, retrieve the course_name, department, and updated credits of the first Science course from the Courses table.
UPDATE Courses 
SET credits = credits + 1
WHERE department = 'Science';

SELECT course_name, department, credits
FROM Courses LIMIT 1;

--Add a new column "scholarship" to the Students table.
--Set its default value to "None".
--Then, retrieve the student_id, name, and scholarship of the first student from the Students table.
ALTER TABLE Students
ADD COLUMN scholarship TEXT DEFAULT 'None';

SELECT student_id, name, scholarship
FROM Students LIMIT 1;

--Update the address of all students whose address is "Not Provided" to "Unknown". Then, retrieve the student_id, name, and updated
--address of all students whose address is now "Unknown" from the Students table.
UPDATE Students
SET address = 'Unknown'
WHERE address = 'Not Provided';

SELECT student_id, name, address FROM Students
WHERE address = 'Unknown';

--Add a new column called "status" to the Enrollments table. Set its default value to "Active".Then, retrieve the enrollment_id, student_id, course_id, and status of the first enrollment from the Enrollments table.
ALTER TABLE Enrollments
ADD COLUMN status TEXT DEFAULT 'Active';

SELECT enrollment_id, student_id, course_id, status
FROM Enrollments limit 1;

--Change the department of the course "Computer Science" to "Technology".
--Then, retrieve the course_id, course_name, and updated department from the Courses table.
SELECT course_id, course_name, department
FROM Courses
WHERE department = 'Technology' LIMIT 1;

--Remove all students whose address is marked as 'Not Provided'. Then, retrieve the --student_id, name, and address of all students from the Students table.
DELETE FROM Students
WHERE address = 'Not Provided';
SELECT student_id, name, address 
FROM Students;

--Delete all enrollments where the grade is 'B'. Then, retrieve the enrollment_id, student_id, course_id, and grade from the Enrollments table.
DELETE FROM Enrollments
WHERE grade = 'B';
SELECT enrollment_id, student_id, course_id, grade
FROM Enrollments;

--Delete all courses with less than 4 credits. Then, retrieve all course details from the Courses table.
DELETE FROM Courses
WHERE credits < 4;
SELECT * FROM Courses;

--Alter Table: Add a new column named salary to the Faculty table. Use an appropriate data type (e.g., DECIMAL(10,2) or INT).
--Transaction Control: Create a SAVEPOINT named S1. This ensures we can rollback changes if the subsequent updates are incorrect.
--Update Data: Write queries to update the salary column for the existing faculty members based on the reference table below:
ALTER TABLE Faculty 
ADD COLUMN salary int; 

SAVEPOINT S1;

UPDATE Faculty SET salary = 100000 WHERE faculty_id = 1;
UPDATE Faculty SET salary = 95000 WHERE faculty_id = 2;
UPDATE Faculty SET salary = 85000 WHERE faculty_id = 3;
UPDATE Faculty SET salary = 110000 WHERE faculty_id = 4;
UPDATE Faculty SET salary = 92000 WHERE faculty_id = 5;


--Calculate and display the average salary of all faculty members.
SELECT AVG(salary) AS 'avg_salary'
FROM Faculty;

--Calculate the total credit points available across all courses (using the Courses table created in previous tasks).
SELECT SUM(credits) AS 'total_credits'
FROM Courses;

--Reduce each faculty member's salary by ₹2,000.Then, retrieve (print) the updated faculty_id, name, and salary.
ROLLBACK TO S1;

UPDATE Faculty SET salary = 98000 WHERE faculty_id = 1;
UPDATE Faculty SET salary = 93000 WHERE faculty_id = 2;
UPDATE Faculty SET salary = 83000 WHERE faculty_id = 3;
UPDATE Faculty SET salary = 108000 WHERE faculty_id = 4;
UPDATE Faculty SET salary = 90000 WHERE faculty_id = 5;

SELECT faculty_id, name, salary FROM Faculty;

--After reducing everyone's salary by ₹2,000, we will recalculate the average salary.
SELECT AVG(salary) AS 'avg_salary' 
FROM Faculty;


