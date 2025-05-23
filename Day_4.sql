-- Day 4 - SQL Practice

-- 1. Check for NULL and NOT NULL order_date values
SELECT * 
FROM orders 
WHERE order_date IS NULL;

SELECT * 
FROM orders 
WHERE order_date IS NOT NULL;

-- 2. Aggregation on the entire table
SELECT  
  COUNT(*) AS cnt,
  SUM(total_price) AS total_sales,
  MAX(total_price) AS max_sales,
  MIN(total_price) AS min_profit,
  AVG(total_price) AS avg_profit
FROM orders;

-- 3. Aggregation grouped by category
SELECT 
  COUNT(*) AS cnt,
  category,
  SUM(total_price) AS total_sales,
  MAX(total_price) AS max_sales,
  MIN(total_price) AS min_profit,
  AVG(total_price) AS avg_profit
FROM orders
GROUP BY category;

-- 4. Grouping by product_name and category
SELECT category, product_name 
FROM orders 
GROUP BY product_name, category;

-- 5. View all rows
SELECT * 
FROM orders;

-- 6. Sum of total_price per category
SELECT category, SUM(total_price) 
FROM orders 
GROUP BY category;

-- 7. Filter rows with total_price > 1200 before grouping
SELECT category, SUM(total_price) AS sum
FROM orders 
WHERE total_price > 1200
GROUP BY category
ORDER BY category;

-- 8. Group all data, then filter groups with sum > 1200
SELECT category, SUM(total_price) AS sum
FROM orders 
GROUP BY category
HAVING SUM(total_price) > 1200
ORDER BY category;
