/* INTEGRATING SQL WITH TABLEAU */ 

/* DATA PREPARATION */ 
-- For all tasks data has been exported into a csv file for visualisations in Tableau (link in README)

USE employees_mod;

-- Task 1: Number of Male and Female Employees 
SELECT YEAR(de.from_date) AS calendar_year, COUNT(e.emp_no) AS num_of_employess, e.gender
	FROM t_employees e
		JOIN t_dept_emp de ON de.emp_no = e.emp_no
	GROUP BY e.gender, calendar_year
	HAVING calendar_year >= 1990;

-- Task 2: Number of Active Employees across Departments and Gender 
SELECT 	d.dept_name,
		ee.gender,
        dm.emp_no,
        dm.from_date, 
        dm.to_date, 
		e.calendar_year, 	 
	CASE 
		WHEN YEAR(dm.to_date) >= e.calendar_year AND YEAR(dm.from_date) <= e.calendar_year THEN 1
		ELSE 0 
	END AS active
FROM 
	(SELECT YEAR(hire_date) AS calendar_year 
	FROM t_employees 
    GROUP BY calendar_year) e
		CROSS JOIN 
	t_dept_manager dm 
		JOIN 
	 ON dm.dept_no = d.dept_no 
		JOIN 
	t_employees ee ON dm.emp_no = ee.emp_no
ORDER BY dm.emp_no, calendar_year; 

-- Task 3: Average Salary across Departments 
SELECT 	d.dept_name,
		e.gender,
        ROUND(AVG(s.salary), 2) AS salary,
        YEAR(s.from_date) AS calendar_year
FROM t_employees e 
		JOIN t_salaries s ON e.emp_no = s.emp_no 
        JOIN t_dept_emp de ON e.emp_no = de.emp_no 
        JOIN t_departments d ON de.dept_no = d.dept_no 
GROUP BY e.gender, d.dept_name, calendar_year
HAVING calendar_year <= 2002
ORDER BY d.dept_no;

-- Task 4: 
DROP PROCEDURE IF EXISTS salary_filter; 

DELIMITER $$
CREATE PROCEDURE salary_filter (IN p_max_salary FLOAT, IN p_min_salary FLOAT) 
BEGIN
SELECT
	e.gender, d.dept_name, avg(s.salary) as avg_salary 
FROM t_salaries s
		JOIN t_employees e ON s.emp_no = e.emp_no 
        JOIN t_dept_emp de ON e.emp_no = de.emp_no 
        JOIN t_departments d ON de.dept_no = d.dept_no
	WHERE s.salary BETWEEN p_max_salary AND p_min_salary 
GROUP BY d.dept_no, e.gender;
END $$
DELIMITER ; 

CALL salary_filter(50000, 90000);
    
    
    
