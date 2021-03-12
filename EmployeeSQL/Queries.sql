
--Viewing each of the Tables

SELECT * FROM departments;

SELECT * FROM dept_emp;

SELECT * FROM dept_manager;

SELECT * FROM employees;

SELECT * FROM salaries;

SELECT * FROM titles;

--(1.)List the following details of each employee: 
--employee number, last name, first name, sex, and salary.

SELECT emps.emp_no, emps.last_name, emps.first_name, emps.sex, sals.salary 
FROM employees AS emps
LEFT JOIN 
salaries AS sals
ON emps.emp_no = sals.emp_no;

--(2.)List first name, last name, and hire date for 
--employees who were hired in 1986.

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'

--(3.)List the manager of each department with the following information:
--department number, department name, the manager's employee number, last name, first name.

SELECT dpts.dept_no, dpts.dept_name, mdpts.emp_no, emps.last_name, emps.first_name
FROM dept_manager AS mdpts
INNER JOIN 
departments AS dpts
ON dpts.dept_no = mdpts.dept_no
INNER JOIN employees AS emps
ON emps.emp_no = mdpts.emp_no;

--(4.)List the department of each employee with the following information:
--employee number, last name, first name, and department name.

SELECT edpts.emp_no, emps.last_name, emps.first_name, dpts.dept_name
FROM dept_emp AS edpts
INNER JOIN 
employees AS emps
ON emps.emp_no = edpts.emp_no
INNER JOIN 
departments AS dpts
ON dpts.dept_no = edpts.dept_no;

--(5.)List first name, last name, and sex for employees whose 
--first name is "Hercules" and last names begin with "B."

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules'
AND 
last_name LIKE 'B%';

--(6.)List all employees in the Sales department, including their:
--employee number, last name, first name, and department name.

SELECT edpts.emp_no, emps.last_name, emps.first_name, dept_name
FROM dept_emp AS edpts
INNER JOIN
employees AS emps
ON emps.emp_no = edpts.emp_no
INNER JOIN
departments AS dpts
ON dpts.dept_no = edpts.dept_no
WHERE dpts.dept_name = 'Sales';

--(7.)List all employees in the Sales and Development departments, including their:
--employee number, last name, first name, and department name.

SELECT edpts.emp_no, emps.last_name, emps.first_name, dpts.dept_name
FROM dept_emp as edpts
INNER JOIN
employees as emps
ON emps.emp_no = edpts.emp_no
INNER JOIN
departments as dpts
ON dpts.dept_no = edpts.dept_no
WHERE dpts.dept_name = 'Sales' OR dpts.dept_name = 'Development';

--(8.)In descending order, list the frequency count of employee last names, i.e.,
--how many employees share each last name.
SELECT last_name,
COUNT(last_name) AS amount
FROM employees
GROUP BY last_name
ORDER BY amount DESC;


