use zpace;

CREATE TABLE department (department_id INT AUTO_INCREMENT PRIMARY KEY, department_name VARCHAR(50) UNIQUE);
INSERT INTO department (department_name) VALUES('CS');
INSERT INTO department (department_name) VALUES('Math');
INSERT INTO department (department_name) VALUES('Geology'),('Geography'),('Physics'), ('Biology');
SELECT * FROM department;

UPDATE department SET department_name = 'Mathmatics' WHERE department_name = 'Math';  
UPDATE department SET department_name = 'Computer Science' WHERE department_name = 'CS'; 
DELETE FROM department WHERE department_name = 'Physics';
DELETE FROM department WHERE department_name = 'Biology';

create table course(
		course_id INT AUTO_INCREMENT PRIMARY KEY,
        course_name VARCHAR(100) UNIQUE NOT NULL,
        course_number VARCHAR(3) UNIQUE,
        department_id INT,
	FOREIGN KEY (department_id) REFERENCES department(department_id));

insert into course(course_id,course_name, course_number,department_id) VALUES (456, 'Rocks', '99', 1);
insert into course(course_id,course_name, course_number,department_id) VALUES (789, 'Dinos', '88', 2);
insert into course(course_id,course_name, course_number,department_id) VALUES (101, 'Skydiving', '44', 3);
insert into course(course_id,course_name, course_number,department_id) VALUES (123, 'Shoe Cleaning', '19', 4);

SELECT * From course;

create table section(
		section_id INT AUTO_INCREMENT primary key, 
        section_numer INT, course_id INT, 
        semester VARCHAR(100) NOT NULL, 
		year INT NOT NULL,
	UNIQUE(course_id, section_number, semester, year),
    FOREIGN KEY(course_id) REFERENCES course(course_id));

create table student(
		student_id int primary key auto_increment,
        student_number int unique,
        first_name varchar(100),
        last_name varchar(100),
        class varchar(50),
        major varchar(50));
        
insert into student(student_id, student_number, first_name,last_name, class, major) VALUES
		(1, 1234, 'Zack', 'Pace', 'CS215', 'CS'),
        (2, 2345, 'Zpac', 'Paceo', 'CS115', 'CS'),
        (3, 3456, 'Z', 'P', 'CS242', 'CS'),
        (4, 4567, 'Pack', 'Zace', 'CS210', 'CS');

select * from student;

create table grade_report(
		student_id INT,
        section_id INT,
        grade INT,
        student_id INT,
        section_id INT,
        PRIMARY KEY(student_id, section_id),
        FOREIGN KEY (student_id) references student(student_id),
        FOREIGN KEY (section_id) references section(section_id));
        
drop table if exists student;