--1.GROUP BY with WHERE - Orders by Year and Quarter
--Display, order year, quarter, order count, avg freight cost only for those orders 
--where freight cost > 100
select * from orders;
select 
   extract(YEAR from order_date) as order_year,
   extract(quarter from order_date) as order_quarter,
count(order_id),avg(freight) 
from orders
where freight > 100
group by order_year,order_quarter
order by order_year,order_quarter;

--2.GROUP BY with HAVING - High Volume Ship Regions
--Display, ship region, no of orders in each region, min and max freight cost
-- Filter regions where no of orders >= 5
select 
  ship_region,
  count(order_id) as no_of_orders,
  min(freight) as min_freigt_cost,
  max(freight) as max_freight_cost
from orders
group by ship_region
having count(order_id) >=5
order by ship_region desc;

--3.Get all title designations across employees and customers ( Try UNION & UNION ALL)
--union
select title as designations from employees
union
select contact_title from customers;
--unoin all
select title as designations from employees
union all
select contact_title from customers;

--4.Find categories that have both discontinued and in-stock products
--(Display category_id, instock means units_in_stock > 0, Intersect)

select * from products;



select category_id,units_in_stock,units_on_order
from products
where discontinued =1
intersect
select category_id,units_in_stock,units_on_order
from products
where units_in_stock > 0

select category_id,units_in_stock,units_on_order
from products
where discontinued =1
and units_in_stock > 0;

--5.Find orders that have no discounted items (Display the  order_id, EXCEPT)
select * from order_details;

select distinct order_id
from order_details
where discount = 0;

--or
select distinct order_id
from order_details
except 
select distinct order_id
from order_details
where discount > 0;

select DISTINCT order_id
from order_details
EXCEPT 
select distinct order_id
from order_details
where discount > 0;





