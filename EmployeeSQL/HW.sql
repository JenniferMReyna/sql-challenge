-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" VARCHAR(30)   NOT NULL,
    "dept_name" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(30)   NOT NULL,
    "emp_no" INT   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR(30)   NOT NULL,
    "birt_date" date   NOT NULL,
    "first_name" VARCHAR(30)   NOT NULL,
    "last_name" VARCHAR(30)   NOT NULL,
    "sex" VARCHAR(30)   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "titles" (
    "title_id" VARCHAR(30)   NOT NULL,
    "title" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

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


