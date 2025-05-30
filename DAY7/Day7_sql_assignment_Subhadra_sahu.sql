--Q1)Rank employees by their total sales
--(Total sales = Total no of orders handled, JOIN employees and orders table)

SELECT * FROM employees;
SELECT * FROM orders;

SELECT 
   e.employee_id,COUNT(o.order_id) AS total_sales,
   RANK() OVER(ORDER BY COUNT(o.order_id) DESC) AS sales_rank
FROM employees e
INNER JOIN orders o
ON e.employee_id = o.employee_id
GROUP BY e.employee_id
ORDER BY total_sales DESC

--Q2)Compare current order's freight with previous and next order for each customer.
--(Display order_id,  customer_id,  order_date,  freight,
--Use lead(freight) and lag(freight).
SELECT 
   order_id,customer_id,order_date,freight,
   LEAD(freight) OVER(PARTITION BY customer_id ORDER BY order_date) AS next_freight,
   LAG(freight) OVER(PARTITION BY customer_id ORDER BY order_date) AS previous_freight
 FROM orders;
--Q3).Show products and their price categories, product count in each category, avg price:
--(HINT: Create a CTE which should have price_category definition:
-- WHEN unit_price < 20 THEN 'Low Price'
 --WHEN unit_price < 50 THEN 'Medium Price'
 --ELSE 'High Price'
--In the main query display: price_category,  product_count in each price_category,  ROUND(AVG(unit_price)::numeric, 2) as avg_price)
SELECT * from products;

WITH CTE1 AS(
   SELECT 
   product_id,
   product_name,
   unit_price,
   CASE 
   WHEN unit_price < 20 THEN 'Low Price'
   WHEN unit_price < 50 THEN 'Medium Price'
   ELSE 'High Price' 
   END AS price_category
   FROM products 
   )
  
   SELECT price_category,
    ROUND(AVG(unit_price)::numeric, 2) AS avg_price,
   Count(product_id) AS product_count
   from CTE1
   GROUP BY price_category
   ORDER BY avg_price;
   