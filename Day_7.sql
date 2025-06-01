DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id       VARCHAR(10)   PRIMARY KEY,
    customer_name  VARCHAR(100),
    city           VARCHAR(50),
    state          VARCHAR(50),
    region         VARCHAR(50),
    sales          NUMERIC(10,2)
);

-- Sample rows: mix of prefixes in order_id, names with spaces,
-- some NULLs in city / sales to practice null handling
INSERT INTO orders (order_id, customer_name, city, state, region, sales) VALUES
    ('CA1001', 'Ankit Bansal',   'Karachi',   'Sindh',       'South', 150.75),
    ('CA1002', 'Sara Ali',       NULL,        'Punjab',      'East',  NULL),
    ('PB1003', 'Ahmed Khan',     'Lahore',    'Punjab',      'East',  250.40),
    ('CA1004', 'Fatima Zahra',   'Islamabad', 'Islamabad',   'North',  75.00),
    ('PB1005', 'Usman Ahmed',    'Karachi',   'Sindh',       'South', 320.10),
    ('CA1006', 'Ayesha Siddiq',  'Lahore',    'Punjab',      'East',   NULL),
    ('CA1007', 'Zara  Mir',      'Quetta',    'Balochistan', 'West',  425.99),
    ('PB1008', 'Bilal   Chaudhry','Multan',   'Punjab',      'East',   58.00),
    ('CA1009', 'Sajjad  Akhtar', NULL,        'Sindh',       'South', 100.00),
    ('PB1010', 'Nadia  Karim',   'Gilgit',    'Gilgit-Baltistan','North', 210.25);


select * from orders;

-- STRING FUNCTIONS (PostgreSQL syntax)
select order_id, 
trim(' Husnain   ') as trimmed_literal,
reverse(customer_name) as revered_name,
replace(order_id,'CA','CL') as replace_ca_in_orderId,
replace(customer_name,' ','') as replace_space,
translate(customer_name,'AB','ab') as translate_letters,
length(customer_name) as length_of_name,
left(customer_name,5) as left_5,
right(customer_name,5) as right_5,
substring(order_id,3,6) as order_id_substr,
strpos(customer_name,' ') as space_pos,
strpos(lower(customer_name),'n') as first_n_pos,
concat(order_id,'-',customer_name) as concatenation
from orders
order by order_id
limit 5;


-- null handling
select order_id, city,
coalesce(city,'unknown') new_city,
coalesce(sales,1) as new_sales,
state,
coalesce(city,state,region,'unknown') as fallback_location
from orders
order by city nulls first;


SELECT 
    order_id,
    sales,
    -- CAST numeric to integer
    CAST(sales AS INTEGER)     AS sales_int,
    -- ROUND to 1 decimal place
    ROUND(sales::NUMERIC, 1)   AS sales_rounded
FROM orders
ORDER BY sales DESC
LIMIT 5;

-- ===========================
-- 📦 TABLE: orders_west / orders_east
--      (for UNION / EXCEPT / INTERSECT practice)
-- ===========================

DROP TABLE IF EXISTS orders_west;
CREATE TABLE orders_west (
    order_id   INT,
    region     VARCHAR(10),
    sales      INT
);

DROP TABLE IF EXISTS orders_east;
CREATE TABLE orders_east (
    order_id   INT,
    region     VARCHAR(10),
    sales      INT
);

-- Insert overlapping and distinct rows
INSERT INTO orders_west (order_id, region, sales) VALUES
    (1, 'west', 100),
    (2, 'west', 200),
    (3, 'west', 100),  -- overlaps with orders_east(order_id=3, region='east', sales=100)
    (1, 'west', 100);  -- duplicate row in orders_west

INSERT INTO orders_east (order_id, region, sales) VALUES
    (3, 'east', 100),
    (4, 'east', 300),
    (5, 'east', 150);

	
-- 1) UNION ALL: keeps duplicates
select * from orders_west
union all 
select * from orders_east;

-- 2) UNION: removes duplicates
select * from orders_west
union 
select * from orders_east;

-- 3) INTERSECT: rows common to both
SELECT * FROM orders_east
INTERSECT
SELECT * FROM orders_west;

-- 4) EXCEPT: rows in orders_east but not in orders_west
SELECT * FROM orders_east
EXCEPT
SELECT * FROM orders_west;


-- 5) EXCEPT + UNION ALL (to find mismatches both ways)
(
    SELECT * FROM orders_east
    EXCEPT
    SELECT * FROM orders_west
)
UNION ALL
(
    SELECT * FROM orders_west
    EXCEPT
    SELECT * FROM orders_east
);



