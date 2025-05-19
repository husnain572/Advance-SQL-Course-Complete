-- =========================================
-- Table: car_data
-- =========================================

CREATE TABLE car_data (
    price INTEGER,
    purchase_date DATE,
    car_name VARCHAR(25),
    average_per_liter DECIMAL(3,1)
);

-- Insert sample records
INSERT INTO car_data VALUES 
    (2500000, '2022-10-30', 'Suzuki Passo', 15.5),
    (2500000, '2022-10-30', 'Suzuki Passo', 17.5),
    (1500000, '2022-11-01', 'Suzuki Mehran', 14),
    (3000000, '2022-12-05', 'Suzuki WagonR', 11.0),
    (4500000, '2022-10-15', 'Suzuki Swift', 20.0),
    (9500000, '2022-10-20', 'Civic Oriel', 10);

-- Change data type of purchase_date (demonstration only)
ALTER TABLE car_data ALTER COLUMN purchase_date TYPE TIMESTAMP;
ALTER TABLE car_data ALTER COLUMN purchase_date TYPE DATE;

-- Insert with timestamp format (after changing data type back)
INSERT INTO car_data VALUES 
    (160000, '2024-10-14 12:00:00', 'Japanese Mira', 16.0);

-- Alterations
-- (this will fail if city_name doesn't exist)
ALTER TABLE car_data DROP COLUMN city_name; 
ALTER TABLE car_data ADD city_name VARCHAR(20) DEFAULT ('Lahore');

-- View table
SELECT * FROM car_data;

-- =========================================
-- Table: orders
-- =========================================

-- Drop if exists
DROP TABLE IF EXISTS orders;

-- Create table with constraints
CREATE TABLE orders (
    order_id INTEGER UNIQUE,
    order_date DATE,
    product_name VARCHAR(100),
    total_price DECIMAL(6,2),
    payment_method VARCHAR(20) 
        CHECK (payment_method IN ('Jazz cash', 'EasyPesa', 'NBP')) DEFAULT 'NBP',
    category VARCHAR(20) DEFAULT 'Adult Wear',
    discount INTEGER CHECK (discount <= 20),
    PRIMARY KEY (order_id, product_name)
);

-- Insert multiple records
INSERT INTO orders VALUES 
    (2, '2022-10-20', 'Wireless Mouse', 15.50, DEFAULT, 'accessory', 0),
    (3, '2022-10-21', 'USB Cable', 5.99, DEFAULT, 'accessory', 0),
    (4, '2022-10-22', 'Bluetooth Speaker', 25.00, DEFAULT, 'accessory', 0),
    (5, '2022-10-23', 'Smartwatch Band', 8.75, DEFAULT, 'accessory', 0),
    (6, '2022-10-24', 'Laptop Stand', 20.00, DEFAULT, 'accessory', 0),
    (7, '2022-10-25', 'Screen Protector', 4.50, DEFAULT, 'accessory', 0),
    (8, '2022-10-26', 'Phone Case', 12.00, DEFAULT, 'accessory', 0),
    (9, '2022-10-27', 'Power Bank', 30.00, DEFAULT, 'accessory', 0),
    (10, '2022-10-28', 'Headphones', 45.00, DEFAULT, 'accessory', 0);

-- View orders table
SELECT * FROM orders;

-- Update rows where total_price > 20
UPDATE orders
SET discount = 3
WHERE total_price > 20;

-- Delete record
DELETE FROM orders 
WHERE product_name = 'Smartwatch Band';

-- End of Script
