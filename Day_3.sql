-- SQL Practice - Day 3
-- Topics Covered:
-- 1. ORDER BY with LIMIT
-- 2. DISTINCT keyword
-- 3. Filtering with WHERE, IN, NOT IN, BETWEEN
-- 4. Pattern matching (LIKE and Regex)
-- 5. Basic expressions and constraints

-- Get top 5 products ordered by product_name in descending order
SELECT * 
FROM orders 
ORDER BY product_name DESC 
LIMIT 5;

-- Get distinct payment methods
SELECT DISTINCT payment_method 
FROM orders;

-- Remove a check constraint on payment_method column
ALTER TABLE orders 
DROP CONSTRAINT orders_payment_method_check;

-- Get distinct combinations of product_name and category
SELECT DISTINCT product_name, category 
FROM orders;

-- Get all distinct rows from orders
SELECT DISTINCT * 
FROM orders;

-- Get distinct rows where payment method is 'NBP'
SELECT DISTINCT * 
FROM orders
WHERE payment_method = 'NBP';

-- Get all orders where category is not 'accessory', ordered by category ascending
SELECT * 
FROM orders 
WHERE category != 'accessory'
ORDER BY category ASC;

-- Get orders before a specific date, ordered by category
SELECT * 
FROM orders 
WHERE order_date < '2025-05-07'
ORDER BY category ASC;

-- Get orders between two dates (inclusive), ordered by category
SELECT * 
FROM orders 
WHERE order_date BETWEEN '2025-05-01' AND '2025-05-05'
ORDER BY category ASC;

-- Get orders where category is either 'accessory' or 'Electronics'
SELECT * 
FROM orders 
WHERE category IN ('accessory', 'Electronics');

-- Get orders where category is neither 'accessory' nor 'Electronics'
SELECT * 
FROM orders 
WHERE category NOT IN ('accessory', 'Electronics');

-- Get payment methods that are lexicographically <= 'Easy pesa'
SELECT DISTINCT payment_method 
FROM orders 
WHERE payment_method <= 'Easy pesa';

-- Get payment methods that are lexicographically >= 'Easy pesa'
SELECT DISTINCT payment_method 
FROM orders 
WHERE payment_method >= 'Easy pesa';

-- Orders with specific payment method and category
SELECT * 
FROM orders 
WHERE payment_method = 'Easy pesa' 
  AND category = 'Electronics';

-- Orders with either a specific payment method or category
SELECT * 
FROM orders 
WHERE payment_method = 'Easy pesa' 
   OR category = 'Electronics';

-- Calculate actual amount after discount
SELECT *, total_price - discount AS actual_amount 
FROM orders;

-- Pattern Matching using LIKE

-- Products starting with 'W'
SELECT * 
FROM orders 
WHERE product_name LIKE 'W%';

-- Products ending with 'r'
SELECT * 
FROM orders 
WHERE product_name LIKE '%r';

-- Products containing 'er'
SELECT * 
FROM orders 
WHERE product_name LIKE '%er%';

-- Products containing 'n P' somewhere
SELECT * 
FROM orders 
WHERE product_name LIKE '%n P%';

-- Products with 'n' as the 3rd character
SELECT * 
FROM orders 
WHERE product_name LIKE '__n%';

-- Pattern Matching using PostgreSQL regex

-- 't C' followed by a lowercase letter
SELECT * 
FROM orders 
WHERE product_name ~ 't C[a-z]';

-- 't C' followed by a character NOT 'b' or 'v'
SELECT * 
FROM orders 
WHERE product_name ~ 't C[^bv]';
