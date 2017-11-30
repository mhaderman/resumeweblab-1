use zpace; 

drop table if exists grades;
drop table if exists student;
drop table if exists prerequisite;
drop table if exists section;
drop table if exists course;
drop table if exists department;

CREATE TABLE department (
		department_id INT PRIMARY KEY, 
        department_name VARCHAR(50) UNIQUE,
        department_code VARCHAR(10));

insert into department (department_id, department_name, department_code) VALUES
			(1,'Computer Science','CS'),
            (2,'Mathematics','MATH'),
            (3,'Art History','ARTH'),
            (4,'English','ENG');
select * from department;

create table course(
		course_id INT AUTO_INCREMENT PRIMARY KEY,
        course_name VARCHAR(100) UNIQUE NOT NULL,
        course_number VARCHAR(3) UNIQUE,
        department_id INT,
        UNIQUE(course_id, department_id),
	FOREIGN KEY (department_id) REFERENCES department(department_id));
    
insert into course (course_id, course_name, course_number, department_id) VALUES
			(1, 'Intro to Computers and Computing', 101, 1),
            (2, 'DBMS Design', 355, 1),
            (3, 'Intro to Modern Mathematics', 104, 2),
            (4, 'Intro to Art History', 210, 3);
select * from course;

create table section(
		section_id INT AUTO_INCREMENT PRIMARY KEY, 
        section_number INT, 
        course_id INT, 
        semester VARCHAR(100) NOT NULL, 
		year INT NOT NULL,
	UNIQUE(course_id, section_number, semester, year),
    FOREIGN KEY(course_id) REFERENCES course(course_id));
    
insert into section (section_id, section_number, course_id, semester, year) VALUES
			(1, 1, 1, 'Spring', 2017),
            (2, 2, 1, 'Spring', 2017),
            (3, 1, 1, 'Fall', 2017),
            (4, 1, 3, 'Spring', 2017),
            (5, 1, 4, 'Summer', 2017);
select * from section;

create table student(
		student_id INT AUTO_INCREMENT PRIMARY KEY,
        student_number INT UNIQUE,
        first_name varchar(100),
        last_name varchar(100),
        class varchar(50),
        major varchar(50));
        
insert into student(student_id, student_number, first_name, last_name, class, major) VALUES
		(1, 1000, 'Alan', 'Turing', 'Freshman', 'Computer Science'),
        (2, 2000, 'Grace', 'Hooper', 'Sophmore', 'Computer Science'),
        (3, 3000, 'Ada', 'Lovelace', 'Junior', 'Mathematics'),
        (4, 4000, 'Frida', 'Kahlo', 'Freshman', 'Art'),
        (5, 5000, 'George', 'Orwell', 'Senior', 'English'),
        (6, 6000, 'Banksy', null, 'Freshman', 'Art');
        
select * from student;

create table grade_report(
		student_id INT,
        section_id INT,
        grade INT,
        PRIMARY KEY (student_id, section_id),
        FOREIGN KEY (student_id) references student(student_id),
        FOREIGN KEY (section_id) references section(section_id));

insert into grade_report(student_id, section_id, grade) VALUES
		(1, 1, 4),
        (1, 4, 4),
        (1, 5, 2),
        (2, 2, 4),
        (2, 4, 4),
        (4, 3, 1),
        (4, 5, 4);

select * from grade_report;

#EXERCISES
# 1) Using the > than operator that returns all the students that have a student number greater than 2000
SELECT first_name, last_name FROM student WHERE student_number > 2000;

# 2) Using the BETWEEN operator returns all the students whose student number is between 2000 and 4000.
SELECT first_name, last_name FROM student WHERE student_number BETWEEN 2000 and 4000;
# spits out only first and last name of student

# 3) Using LIKE return all the students who have an O anywhere in their last name.
SELECT first_name, last_name FROM student WHERE last_name LIKE '%O%';

# 4) Using NOT LIKE return all the students who DO NOT have a last name that ends in R.
SELECT first_name, last_name FROM student WHERE last_name NOT LIKE '%R';
# Leave off the last % to indicate nothing else can follow it. "END OF THE NAME"

# 5) Using IN, return all the sections that are in the Fall or the Spring. I.e. 
SELECT * FROM section WHERE semester IN ('Fall', 'Spring');

# 6) Using NOT IN, return all the sections that are in the Summer.
SELECT * FROM section WHERE semester NOT IN ('Summer');

# 7) Using the AND operator, return all students who first name contains an A and last name contains an R.
SELECT first_name, last_name FROM student WHERE first_name LIKE '%A%' AND last_name LIKE '%R%';

# 8) Using only the OR and AND operators, return all students whose (first AND last name contains an R) OR whose major is Mathematics.
SELECT * FROM student WHERE first_name LIKE '%R%' AND last_name LIKE '%R%' OR major = 'Mathematics';

# 9) Using the >= AND <= operators return all the students whose student number is between 2000 and 4000.
SELECT * FROM student WHERE student_number >=2000 AND student_number <= 4000;


# JOIN EXERCISES
# 1) Write a query that returns the first name, last name, and each of their grades. 
# Students who don’t have grades should not be returned.  
# Order the results by first name in ascending order [a-z], last name in ascending order [a-z], 
# and then grade in descending order [9-0]
select first_name as FirstName, last_name as LastName, grade as Grade
from student s
join grade_report on s.student_id = grade_report.student_id
order by first_name asc, last_name asc, grade desc;

# 2) Write a query that returns the first name, last name, and each of their grades.
# But this time it should return the first and last names of all students, 
#even if they haven’t received a grade. Order the results by first name 
#in ascending order [a-z], last name in ascending order [a-z], and then grade in descending order [9-0]
select first_name as FirstName, last_name as LastName, grade as Grade
from student s
left join grade_report g on s.student_id = g.student_id
order by first_name asc, last_name asc, grade desc;

# 3) Copy the query above and modify it, so that it returns the section_number,
# year, and semester along with the first_name, last_name, and grade.   
# All students should still be returned and the sort order should be the same.
select first_name as FirstName, last_name as LastName, grade as Grade, section_number, year, semester
from student s
left join grade_report g on s.student_id = g.student_id
left join section sec on sec.section_id = g.section_id
order by first_name asc, last_name asc, grade desc;

# 4) Modify the query above so that it also returns the Course Number.  Everything else should remain the same.select first_name as FirstName, last_name as LastName, grade as Grade, section_number, year, semester, course_number, department_code
select first_name as FirstName, last_name as LastName, grade as Grade, section_number, year, semester, course_number
from student s
left join grade_report g on s.student_id = g.student_id
left join section sec on sec.section_id = g.section_id
left join course c on c.course_id = sec.course_id
order by first_name asc, last_name asc, grade desc;

# 5) Modify the query above so the department code is also returned.
# Everything else should rename the same.
select first_name as FirstName, last_name as LastName, grade as Grade, section_number, year, semester, course_number, department_code
from student s
left join grade_report g on s.student_id = g.student_id
left join section sec on sec.section_id = g.section_id
left join course c on c.course_id = sec.course_id
left join department d on d.department_id = c.department_id
order by first_name asc, last_name asc, grade desc;

# 6) At this point you would either have needed to write the query using all LEFT JOINs
# or all RIGHT JOINs.  Rewrite the query so it uses the opposite of whatever you currently have.
# The results should be exactly the same.
select first_name as FirstName, last_name as LastName, grade as Grade, section_number, year, semester, course_number, department_code
from department d 
right join course c on d.department_id = c.course_id
right join section sec on sec.course_id = c.course_id
right join grade_report g on g.section_id = sec.section_id
right join student s on s.student_id = g.student_id
order by first_name asc, last_name asc, grade desc;

# 7) Rewrite the LEFT JOIN version of the query, so that it uses the following columns
# in the field list all other information can stay the same.  
# You’ll notice that items are still sorted the same way even though
# you do not return the columns themselves in the field list.
SELECT CONCAT(last_name, ', ', first_name) AS FullName, 
	department_name AS DepartmentName, 
CONCAT(department_code, course_number) AS Course, 
CASE WHEN grade >= 4 THEN 'A' 
WHEN grade = 3 THEN 'B'
WHEN grade = 2 THEN 'C'
WHEN grade = 1 THEN 'D' 
WHEN grade IS NULL THEN NULL ELSE 'F'
END AS LetterGrade
FROM student s
left join grade_report g on s.student_id = g.student_id
left join section sec on sec.section_id = g.section_id
left join course c on c.course_id = sec.course_id
left join department d on d.department_id = c.department_id
order by first_name asc, last_name asc, grade desc;

# 8) Now change your order so that it is order by FullName, CourseNumber, Grade.
SELECT CONCAT(last_name, ', ', first_name) AS FullName, 
CONCAT(department_code, course_number) AS Course, 
CASE WHEN grade >= 4 THEN 'A' 
WHEN grade = 3 THEN 'B'
WHEN grade = 2 THEN 'C'
WHEN grade = 1 THEN 'D' 
WHEN grade IS NULL THEN NULL ELSE 'F'
END AS LetterGrade
FROM student s
left join grade_report g on s.student_id = g.student_id
left join section sec on sec.section_id = g.section_id
left join course c on c.course_id = sec.course_id
left join department d on d.department_id = c.department_id
Order by FullName asc, Course asc, grade asc;

#  9)  Now using the WHERE clause only return students that have received a (4 OR a 2)
# in a course offered by the Art Department. You will need to use parenthesis.
SELECT CONCAT(last_name, ', ', first_name) AS FullName, 
CONCAT(department_code, course_number) AS Course, 
CASE WHEN grade >= 4 THEN 'A' 
WHEN grade = 3 THEN 'B'
WHEN grade = 2 THEN 'C'
WHEN grade = 1 THEN 'D' 
WHEN grade IS NULL THEN NULL ELSE 'F'
END AS LetterGrade
FROM student s
left join grade_report g on s.student_id = g.student_id
left join section sec on sec.section_id = g.section_id
left join course c on c.course_id = sec.course_id
left join department d on d.department_id = c.department_id
where (grade = 4 or grade =2) and department_name = 'Art History'
Order by FullName asc, Course asc, grade asc;

# NULL EXERCISES
# 1) Modify your JOIN sql statement #8 to use IS NOT NULL so that it only returns students who have a grade.
SELECT CONCAT(last_name, ', ', first_name) AS FullName, 
CONCAT(department_code, course_number) AS Course, 
CASE WHEN grade >= 4 THEN 'A' 
WHEN grade = 3 THEN 'B'
WHEN grade = 2 THEN 'C'
WHEN grade = 1 THEN 'D' 
WHEN grade IS NOT NULL THEN NULL ELSE 'F' #Add IS NOT NULL here to remove Grades w/ null value students
END AS LetterGrade
FROM student s
left join grade_report g on s.student_id = g.student_id
left join section sec on sec.section_id = g.section_id
left join course c on c.course_id = sec.course_id
left join department d on d.department_id = c.department_id
Order by FullName asc, Course asc, grade asc;

# 2) Now modify it using IS NULL, so it only returns students who do not have grades.
SELECT CONCAT(last_name, ', ', first_name) AS FullName, 
CONCAT(department_code, course_number) AS Course, 
CASE WHEN grade >= 4 THEN 'A' 
WHEN grade = 3 THEN 'B'
WHEN grade = 2 THEN 'C'
WHEN grade = 1 THEN 'D' 
WHEN grade IS NULL THEN NULL ELSE 'F' #Add IS NOT NULL here to remove Grades w/ null value students
END AS LetterGrade
FROM student s
left join grade_report g on s.student_id = g.student_id
left join section sec on sec.section_id = g.section_id
left join course c on c.course_id = sec.course_id
left join department d on d.department_id = c.department_id
where grade is null #select only null values
Order by FullName asc, Course asc, grade asc;

