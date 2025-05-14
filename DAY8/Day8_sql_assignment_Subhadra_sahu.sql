--1.Create view vw_updatable_products (use same query whatever I used in the training)
--Try updating view with below query and see if the product table also gets updated.
--Update query:
--UPDATE updatable_products SET unit_price = unit_price * 1.1 WHERE units_in_stock < 10;
SELECT * FROM products;
CREATE VIEW vw_updatable_products AS
SELECT 
    product_id,
	product_name, 
    unit_price,
    units_in_stock,
    discontinued
FROM products
WHERE discontinued = 0
WITH CHECK OPTION;

UPDATE vw_updatable_products 
     SET unit_price = unit_price * 1.1

UPDATE vw_updatable_products 
     SET discontinued =1;

--Q2.Transaction:
--Update the product price for products by 10% in category id=1
--Try COMMIT and ROLLBACK and observe what happens.
SELECT * FROM products WHERE category_id =1;
BEGIN TRANSACTION
UPDATE products
 SET unit_price =  unit_price*1.10
 WHERE category_id =1;

 SELECT * FROM products WHERE category_id =1;

COMMIT;

ROLLBACK;

--Q3)Create a regular view which will have below details (Need to do joins):
--Employee_id,
--Employee_full_name,
--Title,
--Territory_id,
--territory_description,
--region_description
SELECT * FROM employees;
SELECT * FROM employee_territories;
SELECT * FROM territories;
SELECT * FROM region;

CREATE VIEW vw_employee_territories_region AS
SELECT e.employee_id,
       e.first_name ||' '||e.last_name AS Employee_full_name,
	   e.title,
	   et.territory_id,
	   t.territory_description,
	   r.region_description
FROM employees e 
INNER JOIN employee_territories et ON e.employee_id = et.employee_id
INNER JOIN territories t ON et.territory_id = t.territory_id
INNER JOIN region r ON t.region_id = r.region_id;

SELECT * from vw_employee_territories_region;


--Q4)Create a recursive CTE based on Employee Hierarchy

SELECT * FROM employees;

WITH RECURSIVE cte_employee_hierarchy as (
SELECT employee_id, 
first_name,
last_name,
reports_to,
0 AS level
FROM employees e
WHERE reports_to IS NULL

UNION ALL
SELECT e.employee_id,
e.first_name,
e.last_name, 
e.reports_to, 
eh.level+1
FROM employees e
JOIN
cte_employee_hierarchy eh
ON
eh.employee_id = e.reports_to
)

SELECT * FROM cte_employee_hierarchy 
ORDER BY level;



