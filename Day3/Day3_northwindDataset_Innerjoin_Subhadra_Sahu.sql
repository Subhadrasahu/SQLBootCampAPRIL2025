select * from employees;
select * from orders;

select e.employee_id,e.first_name || ' '||e.last_name as Full_Name,
e.title, o.order_id,o.customer_id,o.order_date,o.required_date,o.shipped_date
from employees e
inner join orders o
on e.employee_id = o.employee_id;