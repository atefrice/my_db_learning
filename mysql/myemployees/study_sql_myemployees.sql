-- study sql
SELECT MIN(salary),COUNT(salary),ROUND(AVG(salary), 2) from employees;

SELECT COUNT(*) FROM employees;

SELECT DATEDIFF(NOW(), '1989-09-01') AS 我活多少天了;

-- GROUP BY 分组
SELECT MAX(salary)  FROM employees GROUP BY job_id;
SELECT MAX(salary),job_id  FROM employees GROUP BY job_id;

-- 表连接 sql92
SELECT employee_id,first_name,last_name,department_name 
FROM employees,departments
WHERE employees.department_id = departments.department_id
ORDER BY employee_id;


-- 表连接 sql99
SELECT employee_id,first_name,last_name,job_title,department_name
FROM employees AS e
INNER JOIN jobs AS j ON e.job_id = j.job_id
INNER JOIN departments AS d ON e.department_id = d.department_id
WHERE e.salary > 15000
ORDER BY e.employee_id;

-- 根据工作职位 统计平均工资
-- 逆序列出不同job_id并且工资大于10000的平均工资，
-- 并挑选出平均工资大于12000并列出job名称
SELECT e.job_id, j.job_title, AVG(salary) AS 平均工资
FROM employees e
INNER JOIN jobs j ON e.job_id = j.job_id
WHERE e.salary > 10000
GROUP BY job_id
HAVING 平均工资 > 12000
ORDER BY 平均工资 DESC;


-- 查询有员工的部门
SELECT DISTINCT e.department_id,department_name 
FROM departments d
INNER JOIN employees e ON e.department_id = d.department_id;

SELECT d.department_id,department_name 
FROM departments d
WHERE d.department_id IN (
	SELECT DISTINCT department_id FROM employees
);

SELECT e.department_id, d.department_name, COUNT(*) 部门员工数
FROM employees e
INNER JOIN departments d ON d.department_id = e.department_id
GROUP BY e.department_id
HAVING 部门员工数 >= 6
ORDER BY 部门员工数 DESC;


-- 子查询
SELECT * 
FROM employees 
WHERE salary >= ( 
	SELECT salary 
	FROM employees 
	WHERE last_name = "Fay" )
ORDER BY salary;	

-- 查询 与 某某 同部门的 同事
SELECT last_name,department_id,salary
FROM employees
WHERE department_id = (
	SELECT department_id FROM employees
	WHERE last_name = "Zlotkey");

-- 查询 大于平均工资的员工
SELECT last_name,department_id,salary
FROM employees
WHERE salary >= (
	SELECT AVG(salary) FROM employees)
ORDER BY salary;

-- 查询 各部门大于部门平均工资的员工
SELECT e.department_id,last_name,salary
FROM employees e
INNER JOIN (
	SELECT department_id,AVG(salary) avg_val FROM employees
	GROUP BY department_id) AS avg_dp
ON ((e.department_id = avg_dp.department_id) 
 AND (e.salary > avg_dp.avg_val))


-- 查询名字含有 u, 在相同部门
SELECT e.department_id,last_name
FROM employees e
WHERE e.department_id IN (
	SELECT DISTINCT department_id FROM employees
	WHERE last_name LIKE '%u%'
);

SELECT department_id,AVG(salary) ag
FROM employees e
GROUP BY department_id
ORDER BY ag 
LIMIT 0,1 




