SQL commands are commonly divided into 5 main types:

- **DDL — Data Definition Language:** Used to **create or modify database structure**.
  **Examples:** `CREATE`, `ALTER`, `DROP`, `TRUNCATE`

- **DML — Data Manipulation Language:** Used to **add, change, or delete data**.
  **Examples:** `INSERT`, `UPDATE`, `DELETE`

- **DQL — Data Query Language:** Used to **retrieve data from the database**.
  **Example:** `SELECT`

- **DCL — Data Control Language:** Used to **manage user permissions and access**.
  **Examples:** `GRANT`, `REVOKE`

- **TCL — Transaction Control Language:** Used to **manage database transactions**.
  **Examples:** `COMMIT`, `ROLLBACK`, `SAVEPOINT`

### Remember:

**DDL → Structure | DML → Modify Data | DQL → Query Data | DCL → Permissions | TCL → Transactions**

-- Data Definition language
create table car_data(
  price integer,
  purchase_date date,
  car_name varchar(25),
average_per_liter decimal(3,1)
);

-- Data Manipulation Language
insert into car_data values(2500000, '2022-10-30','Suzuki Passo', 15.5),
(2500000, '2022-10-30','Suzuki Passo', 17.5),
(1500000, '2022-11-01','Suzuki Mehran', 14),
(3000000, '2022-12-05','Suzuki WagonR', 11.0),
(4500000, '2022-10-15','Suzuki Swift', 20.0),
(9500000, '2022-10-20','Civic Oriel', 10);

-- SQL - Structured query language
select * from car_data;
-- we can limit data
select * from car_data limit 3;

-- data sorting
select car_name, price from car_data
order by car_name asc, price desc;

delete from car_data;
drop table car_data;
