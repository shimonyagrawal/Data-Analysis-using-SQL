USE employees; 

/* SELECT, INSERT, UPDATE, DELETE */ 

-- Select the information from the “dept_no” column of the “departments” table
SELECT dept_no
FROM departments;

-- Select all people from the “employees” table whose first name is “Elvis”.
SELECT *
FROM employees
WHERE first_name = 'Elvis';
    
-- Retrieve a list with all female employees whose first name is Kellie. 
SELECT *
FROM employees
WHERE first_name = 'Kellie' AND gender = 'F'; 

-- Retrieve a list with all employees whose first name is either Kellie or Aruna.
SELECT *
FROM employees
WHERE first_name = 'Kellie' OR first_name = 'Aruna';
        
-- Retrieve a list with all female employees whose first name is either Kellie or Aruna.
SELECT *
FROM employees
WHERE gender = 'F'
AND (first_name = 'Kellie' OR first_name = 'Aruna');

-- Use the IN operator to select all individuals from the “employees” table, whose first name is either “Denis”, or “Elvis”.
SELECT *
FROM employees
WHERE first_name IN ('Denis','Elvis');

-- Extract all records from the ‘employees’ table, aside from those with employees named John, Mark, or Jacob.
 SELECT *
FROM employees
WHERE first_name NOT IN ('John','Mark','Jacob');

 -- Working with the “employees” table, use the LIKE operator to select the data about all individuals, 
 -- whose first name starts with “Mark”; specify that the name can be succeeded by any sequence of characters 
SELECT *
FROM employees
WHERE first_name LIKE 'Mark%';

-- Retrieve a list with all employees who have been hired in the year 2000.
SELECT * 
FROM employees 
WHERE hire_date LIKE '%2000%'; 

-- Retrieve a list with all employees whose employee number is written with 5 characters, and starts with “1000”. 
SELECT *
FROM employees
WHERE emp_no LIKE '1000_';

-- Extract all individuals from the ‘employees’ table whose first name contains “Jack”.
SELECT *
FROM employees
WHERE first_name LIKE '%Jack%';

-- Once you have done that, extract another list containing the names of employees that do not contain “Jack”.
SELECT *
FROM employees
WHERE first_name NOT LIKE '%Jack%';

-- Select all the information from the “salaries” table regarding contracts from 66,000 to 70,000 dollars per year.
SELECT *
FROM salaries
WHERE salary BETWEEN 66000 AND 70000;

-- Retrieve a list with all individuals whose employee number is not between ‘10004’ and ‘10012’.
SELECT *
FROM employees 
WHERE emp_no NOT BETWEEN 10004 AND 10012;
 
-- Select the names of all departments with numbers between ‘d003’ and ‘d006’.
SELECT *
FROM departments
WHERE dept_no BETWEEN 'd003' AND 'd006';

-- Select the names of all departments whose department number value is not null.
SELECT *
FROM departments
WHERE dept_no IS NOT NULL;

-- Retrieve a list with data about all female employees who were hired in the year 2000 or after.
SELECT * 
FROM employees 
WHERE hire_date >= '2000-01-01' AND gender = 'F';

-- Extract a list with all employees’ salaries higher than $150,000 per annum.
SELECT *
FROM salaries
WHERE salary > 150000;

-- Obtain a list with all different “hire dates” from the “employees” table. 
SELECT DISTINCT hire_date
FROM employees;

-- How many annual contracts with a value higher than or equal to $100,000 have been registered in the salaries table?
SELECT COUNT(salary)
FROM salaries
WHERE salary >= 100000;

-- How many managers do we have in the “employees” database? 
SELECT COUNT(*)
FROM dept_manager;

-- Select all data from the “employees” table, ordering it by “hire date” in descending order.
SELECT *
FROM employees
ORDER BY hire_date DESC;

-- Write a query that obtains two columns. The first column must contain annual salaries higher than 80,000 dollars. 
-- The second column, renamed to “emps_with_same_salary”, must show the number of employees contracted to that salary. 
-- Lastly, sort the output by the first column.
SELECT salary, count(salary) AS 'emps_with_same_salary'
FROM salaries
WHERE salary > 80000
GROUP BY salary
ORDER BY salary;

select * from salaries where salary = (select max(salary) from salaries);

 select * from EMPLOYEE 
where salary = (select min(salary) from EMPLOYEE 
where salary > (select min(salary) from EMPLOYEE));


Select all employees whose average salary is higher than $120,000 per annum.
SELECT emp_no, AVG(salary) AS 'average_salary'
FROM salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000
ORDER BY emp_no;

-- Select the employee numbers of all individuals who have signed more than 1 contract after the 1st of January 2000.
SELECT emp_no
FROM dept_emp
WHERE from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date) > 1
ORDER BY emp_no;

-- Select the first 100 rows from the ‘dept_emp’ table. 
SELECT *
FROM dept_emp
LIMIT 10;

-- Using the insert statement to add employee details 
SELECT *
FROM titles
LIMIT 10;

INSERT INTO titles (
emp_no,
title,
from_date
)
VALUES (
999903,
'Senior Engineer',
'1997-10-01'
);

/*COMMIT AND ROLL BACK */

-- for testing purpose, disable autocommit
SET autocommit = 0;
 
SELECT *
FROM employees
WHERE emp_no = '999903';

UPDATE employees
SET first_name = 'Stella', gender = 'M'
WHERE emp_no = '999901';

ROLLBACK;

SELECT *
FROM employees
WHERE emp_no = '999901';

-- using commit 

UPDATE employees
SET first_name = 'Sally'
WHERE emp_no = '999901';

COMMIT;

SELECT *
FROM employees
WHERE emp_no = '999901';

ROLLBACK;

-- now the changes are aready commmited, it cannot be rollback
SELECT *
FROM employees
WHERE emp_no = '999901';

-- change back to auto commit
SET autocommit = 1;

-- Change the “Business Analysis” department name to “Data Analysis
INSERT INTO departments(dept_no,dept_name)
VALUES('d010','Business Analysis');

SELECT *
FROM departments;

COMMIT;

UPDATE departments
SET dept_name = 'Data Analysis'
WHERE dept_no = 'd010';
 
--  IFNULL 
SELECT dept_no,
	IFNULL(dept_name,"Department info not provided") as dept_name
FROM departments
ORDER BY dept_no;

-- COALESCE - can take multiple parameters , and work like IFNULL
SELECT dept_no,
	COALESCE(dept_name,"N/A") as dept_name
FROM departments
ORDER BY dept_no;

-- How many departments are there in the “employees” database? Use the ‘dept_emp’ table to answer the question.
SELECT COUNT(DISTINCT(dept_no)) as number_of_dept
FROM departments;

-- What is the total amount of money spent on salaries for all contracts starting after the 1st of January 1997?
SELECT SUM(salary) AS total_amount
FROM salaries
WHERE from_date >= '1997-01-01';

-- Which is the lowest employee number in the database?
SELECT MIN(emp_no)
FROM employees;

-- Which is the highest employee number in the database?
SELECT MAX(emp_no)
FROM employees;

-- What is the average annual salary paid to employees who started after the 1st of January 1997?
SELECT AVG(salary) AS total_amount
FROM salaries
WHERE from_date >= '1997-01-01';

-- Round the average amount of money spent on salaries for all contracts that started after the 1st of January 1997 to a precision of cents.
SELECT ROUND(AVG(salary),2) AS total_amount
FROM salaries
WHERE from_date >= '1997-01-01';

DROP TABLE IF EXISTS departments_dup;

CREATE TABLE departments_dup
(dept_no CHAR(4),
dept_name CHAR(40),
PRIMARY KEY (dept_no),
UNIQUE  KEY (dept_name));

INSERT INTO `departments_dup` VALUES 
('d001','Marketing'),
('d002','Finance'),
('d003','Human Resources'),
('d004','Production'),
('d005','Development'),
('d006','Quality Management'),
('d007','Sales'),
('d008','Research'),
('d009','Customer Service');

ALTER TABLE departments_dup
DROP PRIMARY KEY; 

ALTER TABLE departments_dup
DROP INDEX dept_name; 

ALTER TABLE departments_dup
MODIFY dept_no CHAR(4) NULL;

INSERT INTO departments_dup(dept_name) VALUES 
('Public Relations');

DELETE FROM departments_dup
WHERE dept_no = 'd011';

INSERT INTO departments_dup(dept_no) VALUES 
('d010'),
('d011');

/* JOINS */	 
	     
-- Extract a list containing information about all managers’ employee number, first and last name, department number, and hire date. 
SELECT e.emp_no, e.first_name, e.last_name, de.dept_no, e.hire_date
FROM employees e
JOIN dept_emp de ON de.emp_no = e.emp_no;


-- Join the 'employees' and the 'dept_manager' tables to return a subset of all the employees whose last name is Markovitch. 
SELECT e.emp_no, e.first_name, e.last_name, dm.dept_no, dm.from_date
FROM employees e
LEFT JOIN dept_manager dm ON dm.emp_no = e.emp_no
WHERE e.last_name = 'Markovitch'
ORDER BY dm.dept_no DESC, e.emp_no;

-- Extract a list containing information about all managers’ employee number, first and last name, department number, and hire date.
SELECT e.emp_no, e.first_name, e.last_name, dm.dept_no, dm.from_date
FROM employees e
JOIN dept_manager dm ON dm.emp_no = e.emp_no
ORDER BY dm.dept_no DESC, e.emp_no;

-- Select the first and last name, the hire date, and the job title of all employees whose first name is “Margareta” and have the last name “Markovitch”.
SELECT e.emp_no, e.first_name, e.last_name, e.hire_date, t.title
FROM employees e
JOIN titles t ON t.emp_no = e.emp_no
WHERE e.first_name = 'Margareta' AND e.last_name = 'Markovitch'
ORDER BY 1;

-- cross join with Department Manager and Departments to see possible combination
SELECT dm.emp_no, d.dept_name
FROM dept_manager dm
CROSS JOIN departments d
ORDER BY dm.emp_no, d.dept_no;

-- cross join with Department Manager and Departments to see possible combination but except for the department he/she already in
SELECT dm.emp_no, d.dept_name
FROM dept_manager dm
CROSS JOIN departments d
WHERE dm.dept_no <> d.dept_no
ORDER BY dm.emp_no, d.dept_no;

-- Use a CROSS JOIN to return a list with all possible combinations between managers from the dept_manager table and department number 9
SELECT dm.*, d.*
FROM dept_manager dm
CROSS JOIN departments d
WHERE d.dept_no = 'd009'
ORDER BY dm.emp_no;

-- Return a list with the first 10 employees with all the departments they can be assigned to.
SELECT e.*, d.*
FROM employees e
CROSS JOIN departments d
WHERE emp_no <= '10010'
ORDER BY e.emp_no, d.dept_name;

-- Select all managers’ first and last name, hire date, job title, start date, and department name.
SELECT e.first_name,e.last_name,e.hire_date,t.title,de.from_date, d.dept_name
FROM employees e
JOIN titles t ON t.emp_no = e.emp_no
JOIN dept_emp de ON de.emp_no = e.emp_no
JOIN departments d ON d.dept_no = de.dept_no
WHERE t.title = 'Manager'
ORDER BY e.emp_no;

-- How many male and how many female managers do we have in the ‘employees’ database?
SELECT e.gender, COUNT(e.gender) AS total_managers
FROM employees e
JOIN dept_manager dm ON e.emp_no = dm.emp_no
GROUP BY e.gender;

-- Average salary of employees by each department 
SELECT d.dept_name, AVG(s.salary) AS avg_salary
FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
JOIN salaries s ON s.emp_no = de.emp_no
GROUP BY d.dept_no
ORDER BY 2 DESC;

SELECT *
FROM
    (SELECT e.emp_no, e.first_name, e.last_name, NULL AS dept_no, NULL AS from_date
    FROM employees e
    WHERE last_name = 'Denis' 
		UNION 
	SELECT NULL AS emp_no, NULL AS first_name, NULL AS last_name, dm.dept_no, dm.from_date
    FROM dept_manager dm) AS a
ORDER BY -a.emp_no DESC;
	     
/* SUB QUERIES */

-- Extract the information about all department managers who were hired between the 1st of January 1990 and the 1st of January 1995. 

SELECT 
    *
FROM
    dept_manager
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            employees
        WHERE
            hire_date BETWEEN '1990-01-01' AND '1995');
            
-- Select the entire information for all employees whose job title is “Assistant Engineer”. 

SELECT * 
FROM employees e
WHERE EXISTS (SELECT * 
				FROM titles T
                WHERE t.emp_no = e.emp_no AND title = 'Assistant Engineer');


DROP TABLE IF EXISTS emp_manager;

CREATE TABLE emp_manager (
   emp_no INT(11) NOT NULL,
   dept_no CHAR(4) NULL,
   manager_no INT(11) NOT NULL
);

-- assign employee number 110022 as a manager to all employees from 10001 to 10020 (this must be subset A), 
-- and employee number 110039 as a manager to all employees from 10021 to 10040 (this must be subset B).
INSERT INTO emp_manager
SELECT 
    U.*
FROM
    (SELECT 
        A.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A UNION SELECT 
        B.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B UNION SELECT 
        C.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110022
    GROUP BY e.emp_no) AS C UNION SELECT 
        D.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no) AS D) AS U;
    
SELECT * 
	FROM emp_manager
ORDER BY emp_manager.emp_no; 

SELECT e1.*
	FROM emp_manager e1 
		JOIN emp_manager e2 ON e1.emp_no = e2.manager_no;

/* VIEWS */ 

CREATE VIEW v_dept_emp_latest_date AS 
	SELECT emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date 
		FROM dept_emp 
	GROUP BY emp_no; 
    
CREATE OR REPLACE VIEW v_average_salary_managers AS
    SELECT 
        ROUND(AVG(salary), 2)
    FROM
        salaries s
            JOIN
        dept_manager m ON s.emp_no = m.emp_no;
	
/* STORED PROCEDURES - Routines and Functions */ 

DROP PROCEDURE IF EXISTS select_employees;
DELIMITER $$ 
CREATE PROCEDURE select_employees()
BEGIN 
	SELECT * FROM employees 
    LIMIT 500; 
END $$
DELIMITER ;

CALL employees.select_employees();

-- Create a procedure that will provide the average salary of all employees.
 
DROP PROCEDURE IF EXISTS avg_salary;
DELIMITER $$ 
CREATE PROCEDURE avg_salary()
BEGIN 
	SELECT AVG(salary) 
		FROM salaries; 
END $$
DELIMITER ;

CALL avg_salary();

DROP PROCEDURE IF EXISTS emp_salary;
DELIMITER $$ 
CREATE PROCEDURE emp_salary(IN p_emp_no INTEGER)
BEGIN 
	SELECT e.first_name, e.last_name, s.salary, s.to_date, s.from_date
		FROM employees e
			JOIN salaries s ON e.emp_no = s.emp_no 
	WHERE e.emp_no = p_emp_no; 
END $$
DELIMITER ;

CALL emp_salary();

DROP PROCEDURE IF EXISTS avg_emp_salary;
DELIMITER $$ 
CREATE PROCEDURE avg_emp_salary(IN p_emp_no INTEGER)
BEGIN 
	SELECT e.first_name, e.last_name, AVG(s.salary)
		FROM employees e
			JOIN salaries s ON e.emp_no = s.emp_no 
	WHERE e.emp_no = p_emp_no; 
END $$
DELIMITER ;

CALL avg_emp_salary(11300);

DROP PROCEDURE IF EXISTS avg_emp_salary_out;
DELIMITER $$ 
CREATE PROCEDURE avg_emp_salary_out(IN p_emp_no INTEGER, OUT p_average_salary DECIMAL(10,2))
BEGIN 
	SELECT e.first_name, e.last_name, AVG(s.salary)
    INTO p_average_salary 
		FROM employees e
			JOIN salaries s ON e.emp_no = s.emp_no 
	WHERE e.emp_no = p_emp_no; 
END $$
DELIMITER ;

SET @v_avg_salary = 0; 
CALL employees.avg_emp_salary_out(11300, @v_avg_salary); 
SELECT @v_avg_salary; 

-- Create a procedure called ‘emp_info’ that uses as parameters the first and the last name of an individual, and 
-- returns their employee number.

DROP PROCEDURE IF EXISTS emp_info;

DELIMITER $$ 
CREATE PROCEDURE emp_info(IN p_first_name VARCHAR(255), IN p_last_name VARCHAR(255), OUT p_emp_no INTEGER)
BEGIN 
	SELECT e.emp_no
    INTO p_emp_no
		FROM employees e
	WHERE e.first_name = p_first_name AND e.last_name = p_last_name; 
END $$
DELIMITER ;

SET @v_emp_no = 0; 
CALL employees.emp_info('Aruna', 'Journel', @v_emp_no); 
SELECT @v_emp_no; 

-- User Defined Functions 

DROP FUNCTION IF EXISTS f_emp_avg_salary;

DELIMITER $$ 
CREATE FUNCTION f_emp_avg_salary(p_emp_no INTEGER) RETURNS DECIMAL(10,2)
DETERMINISTIC 
BEGIN 
DECLARE v_avg_salary DECIMAL (10,2);
SELECT 
    AVG(s.salary)
INTO v_avg_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;
RETURN v_avg_salary;
END $$
DELIMITER ;

SELECT f_emp_avg_salary(11301);

-- Functions 
-- Create a function called ‘emp_info’ that takes for parameters the first and last name of an employee, and 
-- returns the salary from the newest contract of that employee.

DROP FUNCTION IF EXISTS emp_info;

DELIMITER $$ 
CREATE FUNCTION emp_info(p_first_name VARCHAR(255), p_last_name VARCHAR(255)) RETURNS DECIMAL(10,2)
DETERMINISTIC 
BEGIN 
DECLARE v_salary DECIMAL (10,2);
DECLARE v_max_date DATE;

SELECT 
    MAX(from_date)
INTO v_max_date FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.first_name = p_first_name AND e.last_name = p_last_name;
    
SELECT 
    s.salary
INTO v_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.first_name = p_first_name AND e.last_name = p_last_name AND s.from_date = v_max_date;
RETURN v_salary;
END $$
DELIMITER ;

SELECT emp_info('Aruna', 'Journel');

/* ADVANCED SQL - Variables, Triggers, Indexes, Case */ 

-- VARIABLE 
/*
Scope = Visibility
There are 3 types of MySQL Variables:
	- Local Variable
    - Session Variable
    - Global Varaible
    
    
*** Local Variable: ***
- a variable that is only visible only in the BEGIN - END block in which it was created.
- Only user defined variable can be used as local variable.
	DECLARE v_my_local_variable;
    
    
*** Session Variable: ***
- a variable that exists only for the session in which we are operating.
- It is defined on our server and it lives there
- It is visible to the connection being used only.
- Both user defined and system defiend variables can be used as session variables. (BUT some system varialbes are limited only for global variables)
	
    SET @var_name = value;
    
    Example:
	SET @s_var1 = 3;
    SELECT @s_var1;
    
*** Global Variable: ***
- applies to all connections related to a specific server.
	SET GLOBAL var_name = value;   (OR)
    
    SET @@global.var_name = value;
    
    System variables are types of pre-defined Global Variables. (such as max_connections, max_join_size)
    Only system variables can be used as Global Variables.
    Example: SET @@global.max_connections = 1; (if set like that, only 1 connection can be connected to server)
*/

-- TRIGGER

DELIMITER $$

CREATE TRIGGER before_salaries_insert
BEFORE INSERT ON salaries
FOR EACH ROW
BEGIN 
	IF NEW.salary < 0 THEN 
		SET NEW.salary = 0; 
	END IF; 
END $$

DELIMITER ;

# Let’s check the values of the “Salaries” table for employee 10001.
SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001';
    
# Now, let’s insert a new entry for employee 10001, whose salary will be a negative number.
INSERT INTO salaries VALUES ('10001', -92891, '2010-06-22', '9999-01-01');

# Let’s run the same SELECT query to see whether the newly created record has a salary of 0 dollars per year.
SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001';
    
-- Create a trigger that checks if the hire date of an employee is higher than the current date. 
-- If true, set this date to be the current date. 
-- Format the output appropriately (YY-MM-DD). 

DELIMITER $$

CREATE TRIGGER trig_hire_date 
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN 
	IF NEW.hire_date < DATE_FORMAT(SYSDATE(), '%Y-%M-%D') THEN 
		SET NEW.hire_date = DATE_FORMAT(SYSDATE(), '%Y-%M-%D'); 
	END IF; 
END $$
DELIMITER ;

INSERT employees VALUES ('999904', '1970-01-31', 'John', 'Johnson', 'M', '2025-01-01');  

SELECT  *  FROM  employees ORDER BY emp_no DESC;

-- INDEXES

CREATE INDEX i_hire_date 
ON employees (hire_date);

CREATE INDEX i_composite 
ON employees (first_name, last_name); 

SELECT * FROM employees WHERE first_name = 'Georgi' AND last_name = 'Facello';

-- Select all records from the ‘salaries’ table of people whose salary is higher than $89,000 per annum.
-- Then, create an index on the ‘salary’ column of that table, and check if it has sped up the search of the same SELECT statement. 

SELECT * FROM salaries WHERE salary > 89000;

CREATE INDEX i_salary 
ON salaries (salary);

SELECT * FROM salaries WHERE salary > 89000;

-- CASE 

SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more than $30,000'
        WHEN MAX(s.salary) - MIN(s.salary) BETWEEN 20000 AND 30000 THEN 'Salary was raised more than $20,000 but less then $30,000'
        ELSE 'Salary was raised less than $20,000'
    END
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = e.emp_no
GROUP BY s.emp_no;

-- Obtain a result set containing the employee number, first name, and last name of all employees with a number higher than 109990. 
-- Create a fourth column in the query, indicating whether this employee is also a manager, 
-- according to the data provided in the dept_manager table, or a regular employee. 

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
    END
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
WHERE
    e.emp_no > 109990;
    
   
SELECT  dm.emp_no, e.first_name, e.last_name, MAX(s.salary) - MIN(s.salary) AS salary_difference,  
    IF(MAX(s.salary) - MIN(s.salary) > 30000, 'Salary was raised by more then $30,000', 'Salary was NOT raised by more then $30,000') 
    AS salary_increase  
FROM dept_manager dm  
	JOIN employees e ON e.emp_no = dm.emp_no  
    JOIN  salaries s ON s.emp_no = dm.emp_no  
GROUP BY s.emp_no;

-- Extract the employee number, first name, and last name of the first 100 employees, 
-- and add a fourth column, called “current_employee” saying “Is still employed” 
-- if the employee is still working in the company, or “Not an employee anymore” if they aren’t.  

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE 
		WHEN MAX(de.to_date) > SYSDATE() THEN 'Is still employed'
		ELSE'Not an employee anymore'
    END AS current_employee
FROM
    employees e
        JOIN
    dept_emp de ON e.emp_no = de.emp_no
GROUP BY de.emp_no
LIMIT 100; 	     

