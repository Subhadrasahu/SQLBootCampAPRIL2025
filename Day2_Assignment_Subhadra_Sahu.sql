--DAY2 Assignment:
--Q1:Alter Table:Add a new column linkedin_profile to employees table to store LinkedIn URLs as varchar.
select * from employees;
ALTER Table employees
ADD column linkedin_profile VARCHAR(100);

--Change the linkedin_profile column data type from VARCHAR to TEXT.
ALTER Table employees 
alter column linkedin_profile TYPE text;

delete from employees where linkedin_profile is null;

--To drop column linked in profile
Alter table employees 
drop column linkedin_profile;

-- Add unique, not null constraint to linkedin_profile
ALTER TABLE employees
ADD COLUMN linkedin_profile 
UNIQUE NOT NULL;

ALTER TABLE employees
ALTER COLUMN linkedin_profile SET NOT NULL;

UPDATE employees
SET linkedin_profile = CONCAT('https://www.linkedin.com/in/subhadra_', employeeid)
WHERE linkedin_profile IS NULL;

ALTER TABLE employees
ALTER COLUMN linkedin_profile SET NOT NULL;

ALTER TABLE employees
ADD CONSTRAINT unique_linkedin_profile UNIQUE (linkedin_profile);

select * from employees

--Q2: Querying (Select)
-- Retrieve the employee name and title of all employees

select employeename,title from employees;
--•	 Find all unique unit prices of products
select * from products;

select distinct unitprice from products;

-- List all customers sorted by company name in ascending order

select * from customers 
order by companyname asc;

-- Display product name and unit price, but rename the unit_price column as price_in_usd
select productname,unitprice as price_in_usd from products;

--Q:3 Filtering
--Get all customers from Germany.
select * from customers
where country = 'Germany';
--Find all customers from France or Spain
select * from customers
where country = 'France' or country='Spain';

select * from customers
where country in('France','Spain');

--Retrieve all orders placed in 2014(based on order_date), 
--and either have freight greater than 50 or the shipped date available (i.e., non-NULL) 
--(Hint: EXTRACT(YEAR FROM order_date))

select * from orders
where EXTRACT(year FROM orderdate)=2014
AND (freight > 50 OR shippeddate is not null);

--Q:4 Filtering
--Retrieve the product_id, product_name, and unit_price of products
--where the unit_price is greater than 15.

select productid,productname,unitprice from products
where unitprice > 15;

--List all employees who are located in the USA and have the title "Sales Representative".
select * from employees
where country = 'USA'
AND title ='Sales Representative';

--Retrieve all products that are not discontinued and priced greater than 30.
select * from products
where discontinued = 0 and unitprice > 30;

--5)LIMIT/FETCH
--Retrieve the first 10 orders from the orders table.
select * from orders
limit 10

--Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20).
select * from orders
order by orderid
offset 10 rows
fetch next 10 rows only

-- Q6:Filtering (IN, BETWEEN)
--List all customers who are either Sales Representative, Owner
select * from customers
where contacttitle in('Sales Representative','Owner');

--Retrieve orders placed between January 1, 2013, and December 31, 2013.
select * from orders
where orderdate between '2013-01-01' and '2013-12-31'

--Q7:Filtering
--List all products whose category_id is not 1, 2, or 3.
select * from products
where categoryid not in(1,2,3);

--Find customers whose company name starts with "A".
select * from customers
where companyname like 'A%'

--Q8)INSERT into orders table:
--Task: Add a new order to the orders table with the following details:
--Order ID: 11078
--Customer ID: ALFKI
--Employee ID: 5
--Order Date: 2025-04-23
--Required Date: 2025-04-30
--Shipped Date: 2025-04-25
--shipperID:2
--Freight: 45.50

select * from orders
where orderid =11078;

insert into orders(orderid,customerid,employeeid,orderdate,requireddate,shippeddate,shipperid,freight)
values(11078,'ALFKI',5,'2025-04-23','2025-04-30','2025-04-25',2,45.40);


--Q9)Increase(Update)  the unit price of all products in category_id =2 by 10%.--
--(HINT: unit_price =unit_price * 1.10)

select unitprice,unitprice*1.10 as increased_unitprice from products
where categoryid = 2;
















