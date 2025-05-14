--Q1.List all customers and the products they ordered with the order date. (Inner join)
--Tables used: customers, orders, order_details, products
--Output should have below columns:
-- companyname AS customer,
--  orderid,
--  productname,
--  quantity,
--  orderdate
select * from customers;
select * from orders;
select * from order_details;
select * from products;

select c.company_name AS customer,
  o.order_id, o.order_date,
  od.quantity,
  p.product_name
  from customers c
  inner join orders o on c.customer_id = o.customer_id
  inner join order_details od on o.order_id = od.order_id
  inner join products p on od.product_id = p.product_id;

--Q:2.Show each order with customer, employee, shipper, and product info — 
--even if some parts are missing. (Left Join)
--Tables used: orders, customers, employees, shippers, order_details, products.

select * from customers;
select * from employees;
select * from shippers;
select * from order_details;
select * from products;
select * from orders;


select o.order_id, o.order_date,
  o.required_date,o.ship_via,o.freight,
  c.company_name AS customer,
  e.first_name ||' '||e.last_name as emp_fullname, e.title,
  od.quantity,
  p.product_name
  from orders o
  left join customers c on o.customer_id = c.customer_id
  left join order_details od on o.order_id = od.order_id
  left join products p on od.product_id = p.product_id
  left join employees e on o.employee_id = e.employee_id;

--Q:3.Show all order details and products (include all products even if they were never ordered). (Right Join)
--Tables used: order_details, products
--Output should have below columns:
-- orderid,
-- productid,
-- quantity,
-- productname

select * from order_details;
select * from products;

select od.order_id,od.product_id,
  od.quantity,p.product_name
from order_details od
right join products p
on od.product_id = p.product_id;

--Q4. List all product categories and their products — 
--including categories that have no products, and products that are not assigned to any category.
--(Outer Join)
--Tables used: categories, products
select * from categories cat
full outer join products p
on cat.category_id = p.category_id;

--5.Show all possible product and category combinations (Cross join).
select * from categories
cross join products;

--6. Show all employees and their manager(Self join(left join))
select e.first_name || ' '||e.last_name as employee_name,
COALESCE(m.first_name || ' ' || m.last_name, 'No Manager') AS manager_name,
e.employee_id,e.reports_to
from employees e
left join employees m
on e.employee_id = m.reports_to;

  select * from employees
  
--7.List all customers who have not selected a shipping method.
--Tables used: customers, orders
--(Left Join, WHERE o.shipvia IS NULL)
  select * from customers;
  select * from orders;


 select 
  c.*,o.ship_via
  from customers c
  left join orders o on c.customer_id = o.customer_id
  WHERE o.ship_via IS NULL;











  