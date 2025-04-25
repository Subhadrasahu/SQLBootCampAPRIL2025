--1)Update the categoryName From “Beverages” to "Drinks" in the categories table.

select * from categories;
update categories
set categoryname ='Drinks'
where categoryname ='Beverages';

--2)Insert into shipper new record (give any values) Delete that new record from shippers table.
select * from shippers;
insert into shippers
(shipperid,companyname)
values(4,'Indian Shipping through post');

delete from shippers
where shipperid = 4;

--3)Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. Display the both category and products table to show the cascade.
-- Delete the categoryID= “3”  from categories. Verify that the corresponding records are deleted automatically from products.
-- (HINT: Alter the foreign key on products(categoryID) to add ON UPDATE CASCADE, ON DELETE CASCADE)

select * from categories;
select * from products;
Alter table products
drop constraint if exists products_categoryid_fkey


Alter table products 
Add constraint products_categoryid_fkey
foreign key(categoryid) references categories(categoryid)
on update cascade
on delete cascade


select * from categories
where categoryid =1001;

select * from products 
where categoryid =1001;

update categories
set categoryid = 1001
where categoryid =1;


select * from products 
where categoryid =3;
select * from  order_details
where productid =16;

delete from categories
where categoryid =3;
--ERROR:  Key (productid)=(16) is still referenced from table "order_details".
--update or delete on table "products" violates foreign key constraint "order_details_productid_fkey" on table "order_details" 
--order_details_productid_fkey
Alter table order_details
drop constraint if exists order_details_productid_fkey

Alter table order_details 
Add constraint order_details_productid_fkey
foreign key(productid) references products(productid)
on update set null
on delete set null;

--4)      Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to null
--(HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL)
select * from orders
where customerid ='VINET';
select * from customers
where customerid ='VINET';


Alter table orders
drop constraint if exists orders_customerid_fkey

Alter table orders 
Add constraint orders_customerid_fkey
foreign key(customerid) references customers(customerid)
on update set null
on delete set null;

delete from customers 
where customerid ='VINET';

--Q5)Insert the following data to Products using UPSERT:
--product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=3
--product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=3
--product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=3
--(this should update the quantityperunit for product_id = 100)

select * from products;

select * from categories;
 
 
 
 
 insert into products(
 productid,
 productname,
 quantityperunit,
 unitprice,
 discontinued,
 categoryid)
values
      (100, 'Wheat bread', '1', 13, 0, 1001),
      (101, 'White bread', '5 boxes', 13, 0, 1001)     
on conflict(productid)
do update set
   productname = excluded.productname,
   quantityperunit = EXCLUDED.quantityperunit,
    unitprice = EXCLUDED.unitprice,
    discontinued = EXCLUDED.discontinued,
    categoryID = EXCLUDED.categoryid;

select * from products;


insert into products(
 productid,
 productname,
 quantityperunit,
 unitprice,
 discontinued,
 categoryid)
values
      
      (100, 'Wheat bread', '10 boxes', 13, 0, 1001)
on conflict(productid)
do update set
   quantityperunit = EXCLUDED.quantityperunit;
    

--6)      Write a MERGE query:
--Create temp table with name:  ‘updated_products’ and insert values as below:
 --productID	productName	quantityPerUnit	unitPrice	discontinued	categoryID
 -- 100	Wheat bread	10	20	1	3
--101	White bread	5 boxes	19.99	0	3
--102	Midnight Mango Fizz	24 - 12 oz bottles	19	0	1
--103	Savory Fire Sauce	12 - 550 ml bottles	10	0	2
--●	 Update the price and discontinued status for from below table ‘updated_products’ only if there are matching products and updated_products .discontinued =0 
--●	If there are matching products and updated_products .discontinued =1 then delete 
 --●Insert any new products from updated_products that don’t exist in products only if updated_products .discontinued =0.

 select * from products;
 select * from categories;
MERGE into products p
using (
 VALUES
    (100, 'Wheat bread', '10', 20, 1, 1001),
    (101, 'White bread', '5 boxes', 19.99, 0, 1001),
	(102, 'Midnight Mango Fizz', '24-12 oz bottles', 19, 0, 4),
     (103, 'Savory Fire Sauce', '12-550 ml bottles', 10, 0, 2)  
) AS updated_products(productid, productname,quantityperunit,unitprice,discontinued,categoryid)
 on p.productid =updated_products.productid
when matched and updated_products .discontinued =0 then
  update set 
     unitprice = updated_products.unitprice,
	 discontinued = updated_products.discontinued
when matched and updated_products .discontinued =1 then
   delete
when not matched and updated_products .discontinued =0 then
insert(productid,productname,quantityperunit,unitprice,discontinued,categoryid)
values(updated_products.productid,
updated_products.productname,updated_products.quantityperunit,
updated_products.unitprice,
updated_products.discontinued,updated_products.categoryid)


select * from products;




























































































































































 








   





















