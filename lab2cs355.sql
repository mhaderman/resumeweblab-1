use zpace;

CREATE TABLE department (
		department_id INT AUTO_INCREMENT PRIMARY KEY, 
        department_name VARCHAR(50) UNIQUE);
        
INSERT INTO department (department_name) VALUES
		('CS'), 
        ('Math'), 
        ('Geology'),
        ('Geography');
INSERT INTO department (department_name) VALUES
		('Art');
INSERT INTO department (department_name) VALUES
        ('Economics');
        
UPDATE department SET department_name = 'Mathematics' WHERE department_name = 'Mathmatics';  
UPDATE department SET department_name = 'Computer Science' WHERE department_name = 'CS'; 
SELECT * FROM department;

create table course(
		course_id INT AUTO_INCREMENT PRIMARY KEY,
        course_name VARCHAR(100) UNIQUE NOT NULL,
        course_number VARCHAR(3) UNIQUE,
        department_id INT,
        UNIQUE(course_id, department_id),
	FOREIGN KEY (department_id) REFERENCES department(department_id));

insert into course (course_name, course_number, department_id) VALUES 
		('Virtual Reality', '99', 1),
		('Calculus 4', '88', 2),
		('Cliff Diving Volcanos', '44', 3),
		('Road Trip Across USA', '19', 4);

insert into course (course_name, course_number, department_id) VALUES
		('Ankle Drawing', '20', 5);
insert into course (department_id) VALUES
		(6);
        
SELECT * From course;
drop table if exists course; 

create table section(
		section_id INT AUTO_INCREMENT PRIMARY KEY, 
        section_number INT, 
        course_id INT, 
        semester VARCHAR(100) NOT NULL, 
		year INT NOT NULL,
	UNIQUE(course_id, section_number, semester, year),
    FOREIGN KEY(course_id) REFERENCES course(course_id));
    
insert into section (section_number, course_id, semester, year) VALUES
		(11111, 1, 'FALL', 1984),
        (22222, 2, 'FALL', 1900),
        (33333, 3, 'FALL', 1800),
        (44444, 4, 'FALL', 1700);
insert into section (course_id, semester, year) VALUES
		(6, 'FALL', 1600);
select * from section;
drop table if exists section;

create table student(
		student_id INT AUTO_INCREMENT PRIMARY KEY,
        student_number INT UNIQUE,
        first_name varchar(100),
        last_name varchar(100),
        class varchar(50),
        major varchar(50));
        
insert into student(student_number, first_name,last_name, class, major) VALUES
		(1234, 'Zack', 'Pace', 'CS215', 'CS'),
        (2345, 'Zpac', 'Paceo', 'CS115', 'CS'),
        (3456, 'Z', 'P', 'CS242', 'CS'),
        (4567, 'Pack', 'Zace', 'CS210', 'CS');

select * from student;
drop table if exists student;

create table grade_report(
		student_id INT,
        section_id INT,
        grade INT,
        PRIMARY KEY (student_id, section_id),
        FOREIGN KEY (student_id) references student(student_id),
        FOREIGN KEY (section_id) references section(section_id));


insert into grade_report(student_id, section_id, grade) VALUES
		(1, 1, 100),
        (2, 2, 100),
        (3, 3, 100),
        (4, 4, 10);
        
select * from grade_report;
drop table if exists grade_report;

create table prerequisite(
		course_id INT,
        prerequisite_course_id INT,
        PRIMARY KEY (course_id, prerequisite_course_id),
        FOREIGN KEY (course_id) references course(course_id),
        FOREIGN KEY (prerequisite_course_id) references course(course_id));

insert into prerequisite (course_id, prerequisite_course_id) VALUES
		(1, 1),
        (2, 2),
        (3, 3),
        (4, 4);

select * from prerequisite;
drop table if exists  prerequite;
 
select department_name, course_name from department
join course on department.department_id = course.department_id;

select department_name, course_name from department
left join course on department.department_id = course.department_id;

select department_name, course_name from department
right join course on department.department_id = course.department_id;

select department_name as DeptName, course_name as CourseName, section_number as SectionNumber
from department d
join course c on d.department_id = c.department_id
left join section s on c.course_id = s.course_id
