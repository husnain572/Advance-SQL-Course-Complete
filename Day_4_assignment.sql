CREATE TABLE orders (
    order_id VARCHAR(20),
    order_date DATE,
    ship_mode VARCHAR(20),
    region VARCHAR(20),
    category VARCHAR(20),
    sub_category VARCHAR(20),
    city VARCHAR(50),
    sales DECIMAL(10,2),
    quantity INT,
    profit DECIMAL(10,2)
);

INSERT INTO orders VALUES
('CA-2020-161389','2020-06-12','Second Class','West','Furniture','Chairs','Los Angeles',500,5,120),
('US-2021-156909','2021-03-18','Standard Class','East','Technology','Phones','New York',900,3,200),
('CA-2020-111111','2020-01-10','First Class','West','Furniture','Tables','San Diego',300,2,40),
('CA-2020-111112','2020-02-15','Second Class','West','Furniture','Chairs','San Jose',450,4,80),
('CA-2020-111113','2020-03-20','Standard Class','Central','Office Supplies','Binders','Chicago',200,6,60),
('CA-2020-111114','2020-04-25','First Class','East','Technology','Accessories','Boston',150,3,30),
('CA-2020-111115','2020-05-30','Second Class','South','Office Supplies','Paper','Dallas',120,5,20),
('CA-2020-111116','2020-07-05','Standard Class','West','Technology','Phones','Seattle',800,2,150),
('CA-2021-111117','2021-01-11','Second Class','West','Technology','Accessories','San Francisco',220,3,70),
('CA-2021-111118','2021-02-19','First Class','East','Furniture','Bookcases','Miami',600,2,110),
('CA-2021-111119','2021-03-12','Standard Class','Central','Office Supplies','Storage','Denver',180,4,40),
('CA-2021-111120','2021-04-01','Second Class','West','Furniture','Furnishings','Los Angeles',130,5,35),
('CA-2021-111121','2021-05-14','First Class','West','Technology','Machines','San Diego',1000,1,300),
('CA-2021-111122','2021-06-22','Standard Class','South','Office Supplies','Art','Houston',90,7,25),
('CA-2021-111123','2021-07-30','Second Class','West','Furniture','Tables','San Jose',400,3,95);

-- write a update statement to update city as null for order ids :  CA-2020-161389 , US-2021-156909
update orders set city=null where order_id in ('CA-2020-161389','US-2021-156909')

-- write a query to find orders where city is null (2 rows)
select * from orders where city is null


-- write a query to get total profit, first order date and latest order date for each category
select category , sum(profit) as total_profit, min(order_date) as first_order_date
,max(order_date) as latest_order_date
from orders
group by category 


-- write a query to find sub-categories where average profit is more than the half of the max profit in that sub-category
select sub_category
from orders
group by sub_category
having avg(profit) > max(profit)/2


-- create the exams table with below script;
create table exams (student_id int, subject varchar(20), marks int);

insert into exams values (1,'Chemistry',91),(1,'Physics',91),(1,'Maths',92)
,(2,'Chemistry',80),(2,'Physics',90)
,(3,'Chemistry',80),(3,'Maths',80)
,(4,'Chemistry',71),(4,'Physics',54)
,(5,'Chemistry',79);

-- write a query to find students who have got same marks in Physics and Chemistry.
select student_id , marks
from exams
where subject in ('Physics','Chemistry')
group by student_id , marks
having count(1)=2

-- write a query to find total number of products in each category.
select category,count(distinct product_id) as no_of_products
from orders
group by category

-- write a query to find top 5 sub categories in west region by total quantity sold
select top 5  sub_category, sum(quantity) as total_quantity
from orders
where region='West'
group by sub_category
order by total_quantity desc


-- write a query to find total sales for each region and ship mode combination for orders in year 2020
select region,ship_mode ,sum(sales) as total_sales
from orders
where order_date between '2020-01-01' and '2020-12-31'
group by region,ship_mode
