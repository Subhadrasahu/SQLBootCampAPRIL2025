Create Database "Sample"
Alter Database "Sample" rename to sample

CREATE TABLE accounts(
user_id serial Primary key,
user_name VARCHAR(50) UNIQUE NOT NULL,
password VARCHAR(50) NOT NULL,
email VARCHAR(225) unique not null,
created_at TIMESTAMP not null,
last_login TIMESTAMP

);
select * from accounts;



insert into accounts(user_name,password,email,created_at,last_login)
values
('john due','john@123', 'john@gmail.com','04-12-2025 10:20:29','04-12-2025 10:20:29'),
('alicejohn','alice@123', 'alicen@gmail.com','03-10-2025 10:20:29','04-10-2025 10:20:29');


create table categories
     (
	  categoryID int primary key,
	 categoryName Varchar,
	 description Varchar)


CREATE TABLE order_details(
orderID integer,	
productID integer,
unitPrice numeric(10,2),
quantity integer NOT NULL,
discount numeric(5,2),
foreign key(orderID) references orders(orderID),
foreign key(productID) references products(productID)
);

select * from order_details;

create table customers
(
customerID character varying(10),
companyName character varying(100),
contactName character varying(100),
contactTitle character varying(100),
city character varying(100),
country character varying(100));

select * from customers;

CREATE TABLE customers (
    customerID VARCHAR(10) PRIMARY KEY,
    companyName VARCHAR(100),
    contactName VARCHAR(100),
    contactTitle VARCHAR(100),
    city VARCHAR(100),
    country VARCHAR(100)
);


create table orders
(
orderID integer PRIMARY KEY,
customerID VARCHAR(10),
employeeID integer,
orderDate date,
requiredDate date,
shippedDate date,
shipperID integer,
freight numeric(10,2),
FOREIGN KEY(customerID) references customers(customerID),
FOREIGN KEY (employeeID) REFERENCES employees(employeeID),
FOREIGN KEY (shipperID) REFERENCES shippers(shipperID)
);

select * from orders;
create table shippers
(
shipperID serial PRIMARY KEY,
companyName VARCHAR(100)
);

select * from shippers;


create table employees
(
employeeID serial PRIMARY KEY,
employeeName VARCHAR(100),
title VARCHAR(100),
city VARCHAR(100),
country VARCHAR(10),
reportsTo integer
);

select * from employees;

create table products
(
productID serial PRIMARY KEY,
productName VARCHAR(200),
quantityPerUnit VARCHAR(200),
unitPrice numeric(10,2),
discontinued integer,
categoryID integer,
Foreign key(categoryID) references categories(categoryID)
);


select * from products;