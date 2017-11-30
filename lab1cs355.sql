USE zpace;

CREATE TABLE student(student_nummber INT PRIMARY KEY,
					first_name VARCHAR(100),
                    last_name VARCHAR(100), 
                    class VARCHAR(50), 
                    major VARCHAR(50));
                    
INSERT INTO student(student_number,
					first_name, last_name, class, major)
VALUES (1, 'Zack','Pace','Junior','Comp Sci');

SELECT * FROM student;

SELECT first_name, last_name, student_number FROM student;

UPDATE student SET first_name='Nut', student_number=2
WHERE student_number=1;

DROP TABLE IF EXISTS student;

CREATE TABLE course(course_number INT PRIMARY KEY, 
					course_name VARCHAR (100) UNIQUE,
                    units INT);
INSERT INTO course(course_number, course_name, units)
VALUES (123,'CS315', 17);

INSERT INTO course(course_number, course_name, units)
VALUES (456,'CS415', 20);

SELECT * FROM course;

SELECT course_number, course_name, units FROM course;

SELECT course_number, course_name, units FROM course
WHERE course_number=456;

UPDATE course SET course_name='CS252'
WHERE course_name='CS415';

UPDATE course SET course_name='CS355'
WHERE course_name='CS315';

DELETE FROM course WHERE course_number=123;

DROP TABLE IF EXISTS course;




