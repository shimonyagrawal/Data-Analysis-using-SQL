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

