-- =========================================
-- SQL COMMANDS
-- =========================================
--
-- SQL commands are commonly divided into 5 main types:
--
-- 1. DDL — Data Definition Language
--    Used to create or modify database structure.
--    Examples: CREATE, ALTER, DROP, TRUNCATE
--
-- 2. DML — Data Manipulation Language
--    Used to add, change, or delete data.
--    Examples: INSERT, UPDATE, DELETE
--
-- 3. DQL — Data Query Language
--    Used to retrieve data from the database.
--    Example: SELECT
--
-- 4. DCL — Data Control Language
--    Used to manage user permissions and access.
--    Examples: GRANT, REVOKE
--
-- 5. TCL — Transaction Control Language
--    Used to manage database transactions.
--    Examples: COMMIT, ROLLBACK, SAVEPOINT
--
-- Remember:
-- DDL → Structure
-- DML → Modify Data
-- DQL → Query Data
-- DCL → Permissions
-- TCL → Transactions
--
-- =========================================
-- DDL — DATA DEFINITION LANGUAGE
-- =========================================
--
-- CREATE TABLE is used to create a new table
-- and define its columns and data types.
--
-- price              → INTEGER
-- purchase_date      → DATE
-- car_name           → VARCHAR(25)
-- average_per_liter  → DECIMAL(3,1)
--

CREATE TABLE car_data (
    price INTEGER,
    purchase_date DATE,
    car_name VARCHAR(25),
    average_per_liter DECIMAL(3,1)
);


-- =========================================
-- DML — DATA MANIPULATION LANGUAGE
-- =========================================
--
-- INSERT is used to add records/rows
-- into an existing table.
--

INSERT INTO car_data VALUES
(2500000, '2022-10-30', 'Suzuki Passo', 15.5),
(2500000, '2022-10-30', 'Suzuki Passo', 17.5),
(1500000, '2022-11-01', 'Suzuki Mehran', 14),
(3000000, '2022-12-05', 'Suzuki WagonR', 11.0),
(4500000, '2022-10-15', 'Suzuki Swift', 20.0),
(9500000, '2022-10-20', 'Civic Oriel', 10);


-- =========================================
-- DQL — DATA QUERY LANGUAGE
-- =========================================
--
-- SELECT is used to retrieve data from a table.
--
-- SELECT * means:
-- Return all columns.
--

SELECT *
FROM car_data;


-- =========================================
-- LIMIT
-- =========================================
--
-- LIMIT restricts the number of rows returned
-- by the SELECT query.
--
-- The following query returns only the first
-- 3 rows from the table.
--

SELECT *
FROM car_data
LIMIT 3;


-- =========================================
-- DATA SORTING
-- =========================================
--
-- ORDER BY is used to sort the result.
--
-- ASC  → Ascending order (A-Z, smallest-largest)
-- DESC → Descending order (Z-A, largest-smallest)
--
-- This query:
-- 1. Sorts car names alphabetically (ASC).
-- 2. If two records have the same car name,
--    their prices are sorted from highest to lowest (DESC).
--

SELECT car_name, price
FROM car_data
ORDER BY car_name ASC, price DESC;


-- =========================================
-- DELETE — DELETE DATA
-- =========================================
--
-- DELETE is a DML command.
-- It is used to remove rows/data from a table.
--
-- The following command deletes ALL rows
-- from car_data but keeps the table itself.
--

DELETE FROM car_data;


-- =========================================
-- DROP — DELETE TABLE
-- =========================================
--
-- DROP is a DDL command.
-- It permanently removes the table itself,
-- including its structure and data.
--
-- After executing this command, car_data
-- will no longer exist.
--

DROP TABLE car_data;
