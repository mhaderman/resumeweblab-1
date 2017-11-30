use zpace;

drop table if exists resume_school;
drop table if exists resume_skill;
drop table if exists resume_company;
drop table if exists company_address;
drop table if exists account_skill;
drop table if exists account_company;
drop table if exists account_school;
drop table if exists skill;
drop table if exists resume;
drop table if exists school;
drop table if exists address;
drop table if exists company;
drop table if exists account;

create table account(
		account_id int auto_increment primary key,
		email varchar(50) unique,
		first_name varchar(50),
		last_name varchar(50));

insert into account (account_id, email, first_name, last_name) values
		(1, 'wacksack@gmail.com', 'Axel', 'Rose'),
        (2, 'vedereddie@gmail.com', 'Eddie', 'Vedder'),
        (3, 'adtr@gmail.com', 'Jeremy', 'McKinnon'),
        (4, 'frenchpress@gmail.com', 'Black', 'Grounds'),
        (5, 'stuffedpepper@yahoo.com', 'Seasoned', 'Meat');
		
create table company(
		company_id int auto_increment primary key,
        company_name varchar(100) unique);
        
insert into company (company_id, company_name) values
		(1, 'Guitar Center'),
        (2, 'Peets'),
        (3, 'Phils');
        
        
create table address(
		address_id int auto_increment primary key,
        street varchar(50),
        zip_code int);

insert into address (address_id, street, zip_code) values
		(1, '6 Go Beers', 84070),
        (2, '100 Stanford', 94070),
        (3, '400 Santa Cruz', 94068);


create table school(
		school_id int auto_increment primary key,
        school_name varchar(50) unique,
        address_id int,
        foreign key(address_id) references address(address_id));

insert into school (school_id, school_name, address_id) values
		(1, 'UC Berkely', 1),
        (2, 'Stanford', 2),
        (3, 'UC Santa Cruz', 3);
        
select * from school;


create table resume(
		resume_id int auto_increment primary key,
        account_id int,
        resume_name varchar(50),
        unique(account_id, resume_name),
        foreign key (account_id) references account(account_id));

insert into resume (resume_id, account_id, resume_name) values
		(1, 1, 'Keys to Rockin'),
        (2, 2, 'Wonderful Human-being'),
        (3, 3, 'Right Back At It'),
        (4, 4, 'Caramel Latte'),
        (5, 5, 'Put Me In The Oven'),
        (6, 5, 'Dont forget me!');

        
create table skill(
		skill_id int auto_increment primary key,
        skill_name varchar(50) unique,
        description varchar(100));

insert into skill (skill_id, skill_name, description) values
		(1, 'Finger Picking', 'I have impressed many, around the world, with my shredding ablilities. Let me play for you and sell some guitars!'),
        (2, 'Turning Your World To Black', 'I know some day youll have a beautiful life, I know youll be a star, in somebody elses skies'),
        (3, 'Downfall Of Us All', 'DA DA DA DA DA DA DADADADADA DADADDADADADA DADA LETS GO!'),
        (4, 'Frenchest Of Presses', 'Day to day struggles will be a little easier with a tad bit of caffine for you and all the coffee'),
        (5, 'Add A Pinch of Cheese', 'When in doubt, eat a bell pepper');

		
create table account_school(
		account_id int,
        school_id int,
        start_date varchar(50),
        end_date varchar(50),
        gpa float,
        foreign key (account_id) references account(account_id),
        foreign key (school_id) references school(school_id));

insert into account_school (account_id, school_id, start_date, end_date, gpa) value
		(1, 1, 'Febuary 6, 1962', 'July 21, 1987', 3.60),
        (2, 2, 'December 23, 1964', 'August 27, 1991', 3.33),
        (3, 3, 'December 17, 1985', 'May 10, 2005', 3.12),
        (4, 1, 'January 1, 1929', 'October 28, 2017', 3.0),
        (5, 2, 'March 22, 1997', 'March 22, 2018', 2.67);
select * from account_school;
select school_id, gpa from account_school;

        
create table account_company(
		account_id int,
        company_id int,
        foreign key (account_id) references account(account_id),
        foreign key (company_id) references company(company_id));

insert into account_company (account_id, company_id) values
		(1, 1),
        (2, 1),
        (3, 1),
        (4, 2),
        (5, 3);
        
        
create table account_skill(
		account_id int,
        skill_id int,
        foreign key (account_id) references account(account_id),
        foreign key (skill_id) references skill(skill_id));

insert into account_skill (account_id, skill_id) values
		(1, 1),
        (2, 2),
        (3, 3),
        (4, 4),
        (5, 5);
        
        
create table company_address(
		company_id int,
        address_id int,
        foreign key (company_id) references company(company_id),
        foreign key (address_id) references address(address_id));
        
insert into company_address (company_id, address_id) values
		(1, 1),
        (2, 2),
        (3, 3),
        (3, 3),
        (1, 1);

create table resume_company(
		resume_id int,
        company_id int,
        date_shared timestamp,
        was_hired boolean,
        foreign key (resume_id) references resume(resume_id),
        foreign key (company_id) references company(company_id));


insert into resume_company (resume_id, company_id, date_shared, was_hired) values
		(1, 1, '2017-01-01 12:00', true),
        (2, 2, '2017-01-15 14:00', true),
        (3, 3, '2017-5-10 16:00', false),
        (4, 2, '2017-01-04 12:00', true),
        (5, 1, '2017-03-01 12:00', false);
        
select * from resume_company;

create table resume_skill(
		skill_id int,
        resume_id int,
        foreign key (skill_id) references skill(skill_id),
        foreign key (resume_id) references resume(resume_id));
        
insert into resume_skill (skill_id, resume_id) values
		(1, 1),
        (2, 2),
        (3, 3),
        (4, 4),
        (5, 5);
        
        
create table resume_school(
		resume_id int,
        school_id int,
        foreign key (resume_id) references resume(resume_id),
        foreign key (school_id) references school(school_id));

insert into resume_school (resume_id, school_id) values
		(1, 1),
        (2, 2),
        (3, 3),
        (4, 1),
        (5, 2);
		
        
# Query #1 – Average GPA for each company

SELECT company_name, AVG(GPA) AS average_gpa  #select comp_name and avg(gpa) from c and rename to avg_gpa 
FROM company c
LEFT JOIN resume_company rc ON c.company_id = rc.company_id
LEFT JOIN resume r ON r.resume_id = rc.resume_id
LEFT JOIN resume_school rs ON rs.resume_id = r.resume_id
LEFT JOIN account_school as1 ON as1.account_id = r.account_id
WHERE rc.was_hired = 1 #only the companies who have hires
GROUP BY company_name;

# Query #2 – Names of users who were hired.

SELECT first_name, last_name
FROM account a
JOIN resume r ON r.account_id = a.account_id
JOIN resume_company rc ON rc.resume_id = r.resume_id
WHERE rc.was_hired = 1; 

# VIEWS ~ view is a virtual table based on the result-set of an SQL statement.
# CREATE VIEW view_name AS
# SELECT column1, column2, ...
# FROM table_name
# WHERE condition;

#returns only schools that have above 2.0 gpa
# have to select school_name, and average gpa of that specific school
# You can add SQL functions, WHERE, and JOIN statements to a view and
# present the data as if the data were coming from one single table.

create view school_gpa_view as 
select school_name, AVG(GPA) as average_gpa
from account_school as1  						#selecting from as1 bc it has school_id 
join school s ON s.school_id = as1.school_id	#lets you join as1 w/ s which has school name
where GPA > 2									#where clause of determining parameter (gpa >2)
Group by school_name;							#orders 

select * from school_gpa_view;

# 1)
# PROCEDURES ~  You can pass zero or more input parameters to a procedure 
# that can be used in the WHERE clause of a SQL statement.

drop procedure if exists school_get_gpa;
DELIMITER //
 create procedure school_get_gpa (_school_name varchar(50))
  BEGIN
  select * from school_gpa_view where school_name = _school_name;
  END //
DELIMITER ;

CALL school_get_gpa('UC Santa Cruz');


# 2)
# Create a stored procedure that when given a GPA value (i.e. 3.0) it returns all Schools 
# that have an average GPA greater than or equal to that given GPA.  This is similar to the example above.
drop procedure if exists school_get_above;
DELIMITER //
 create procedure school_get_above (_average_gpa float)
  BEGIN
  select * from school_gpa_view where average_gpa >= _average_gpa;
  END //
DELIMITER ;

CALL school_get_above(3.0);


# 3)
# Create a stored procedure that returns all the information (columns) 
# for an Account for all accounts who have an average GPA greater than a value provided.
create view account_view as 
select first_name, last_name, email, AVG(GPA) as average_gpa
from account a	  						
join account_school as1 ON a.account_id = as1.account_id
Group by last_name;
# Created a new view that selects the information from accounts, selects those from account, then joins with as1 
# to get the GPA column, grouped it by lastname bc professionalism;)
select * from account_view;

drop procedure if exists account_get_info;
DELIMITER //
 create procedure account_get_info (_average_gpa float)
  BEGIN
  select * from account_view where average_gpa > _average_gpa;
  END //
DELIMITER ;

CALL account_get_info(3.2);

# 4)
# FUNCTIONS ~ similar to procedures; however these only return single values, not a table of data
# Create a function that returns a user’s average gpa when given an account_id.  Pay close attention to how 
# the function example is used in a query. It is passing the school_name attribute from the school table to the function.
create OR REPLACE VIEW account_view as 
select first_name, last_name, email, AVG(GPA) as average_gpa
from account a	  						
join account_school as1 ON a.account_id = as1.account_id
Group by last_name;
# Created a new view that selects the information from accounts, selects those from account, then joins with as1 
# to get the GPA column, grouped it by lastname bc professionalism;)
select * from account_view;

drop function if exists fn_user_avg_gpa;
DELIMITER //
 create FUNCTION fn_user_avg_gpa(_account_id INT) returns double
 BEGIN
 DECLARE _gpa double;
 select avg(gpa) INTO _gpa from account_school where account_id = _account_id;
 return _gpa;
 END //
 DELIMITER ;
select account_id, fn_user_avg_gpa(account_id) from account
group by account_id asc;

# 5)
#  Create a function that returns the number of resumes a user has created when given an account_id.
drop function fn_account_get_resume;
DELIMITER //
create function fn_account_get_resume(_account_id int) returns int
begin
declare _num_resumes int;
select count(account_id) into _num_resumes from resume where account_id = _account_id;
return _num_resumes;
END//
DELIMITER ;
select account_id, fn_account_get_resume(account_id) from account;