--Q1).Categorize products by stock status
--(Display product_name, a new column stock_status whose values are based on below condition
-- units_in_stock = 0  is 'Out of Stock'
-- units_in_stock < 20  is 'Low Stock')

SELECT * FROM products;

SELECT 
   product_name,
   units_in_stock,
CASE
  WHEN units_in_stock = 0  THEN 'Out of Stock'
  WHEN units_in_stock < 20  THEN 'Low Stock'
END AS stock_status
 FROM products;

--Q2.Find All Products in Beverages Category
--(Subquery, Display product_name,unitprice)
select * from products;
select * from categories;

SELECT product_name,unit_price
FROM products
WHERE 
 category_id = 
 (
    SELECT 
        category_id 
		 FROM categories
		   where category_name='Beverages');

--Q3.Find Orders by Employee with Most Sales
--(Display order_id,   order_date,  freight, employee_id.
--Employee with Most Sales=Get the total no.of of orders for each employee then order by DESC and limit 1. 
--Use Subquery)
SELECT * from employees;
select * from orders;

SELECT 
    order_id, 
    order_date, 
    freight, 
    employee_id
FROM 
    orders
WHERE 
    employee_id = (
        SELECT employee_id
        FROM (
            SELECT employee_id, COUNT(order_id) AS total_orders
            FROM orders
            GROUP BY employee_id
            ORDER BY total_orders DESC
            LIMIT 1
        ) AS top_employee
    );

SELECT order_id, order_date, freight, employee_id
FROM orders
WHERE employee_id = (
    SELECT employee_id
    FROM orders
    GROUP BY employee_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

--Q4.Find orders where for country!= ‘USA’ with freight costs higher than any order from USA.
--(Subquery, Try with ANY, ALL operators)
SELECT order_id,customer_id,ship_via,freight,ship_country FROM orders
WHERE ship_country!='USA'
AND freight >
     ANY
	  (SELECT freight
           FROM orders
		where ship_country ='USA');

				 