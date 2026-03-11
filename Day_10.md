# 1. Stored Procedure

A **Stored Procedure** is a saved SQL program that runs when you call it.

Think of it like a **function in programming**.

Example from your lecture:

```sql
drop procedure spemp;
```

This deletes the procedure if it already exists.


## Creating / Altering Procedure

```sql
alter procedure spemp (@dept_id int , @cnt int out)
as
select @cnt = count(1) 
from employee 
where dept_id=@dept_id
```

### What this means

Procedure name:

```
spemp
```

Parameters:

```
@dept_id → input parameter
@cnt → output parameter
```

# 2. Dummy Employee Table

Example table

| emp_id | name  | dept_id |
| ------ | ----- | ------- |
| 1      | Ali   | 10      |
| 2      | Ahmed | 10      |
| 3      | Sara  | 20      |

# 3. Logic Inside Procedure

```sql
if @cnt=0
print 'there is no employee in this dept'
else
print 'total employees ' + cast(@cnt as varchar(10))
```

Explanation:

Step 1 → count employees
Step 2 → check condition

If department has no employees → show message
Else → print total employees.

`CAST()` converts number → text.

Example:

```
3 → '3'
```

# 4. Calling the Procedure

```sql
declare @cnt1 int
exec spemp 100 , @cnt1 out
print @cnt1
```

Step by step

### Step 1

Create variable

```
@cnt1
```

### Step 2

Call procedure

```
exec spemp 100
```

Meaning:

Check employees in department **100**

### Step 3

Store output

```
@cnt1 out
```

Example result

```
there is no employee in this dept
0
```

# 5. User Defined Function (UDF)

Functions return a **value**.

Your function:

```sql
alter function fnproduct (@a int , @b int = 200)
returns decimal(5,2)
as
begin
return (select @a * @b)
end
```

## Understanding It

Function name

```
fnproduct
```

Parameters

```
@a
@b
```

Default value

```
@b = 200
```

Return type

```
decimal(5,2)
```

Meaning

```
max digits = 5
decimal places = 2
```

# 6. Using the Function

Example:

```sql
select [dbo].[fnproduct](4,default)
```

Since default value of `b` is **200**

Result

```
4 × 200 = 800
```

Output

```
800.00
```

# 7. Using Function Inside Query

Example:

```sql
select 
datepart(year,order_date),
order_date,
row_id,
quantity,
[dbo].[fnproduct](row_id,quantity)
from orders;
```

Example Orders table

| order_date | row_id | quantity |
| ---------- | ------ | -------- |
| 2020-01-01 | 2      | 10       |
| 2021-02-01 | 3      | 5        |

Result

| year | order_date | row_id | quantity | product |
| ---- | ---------- | ------ | -------- | ------- |
| 2020 | 2020-01-01 | 2      | 10       | 20      |
| 2021 | 2021-02-01 | 3      | 5        | 15      |


# 8. Pivot Concept

Pivot converts **rows → columns**.

Example table

| category | year | sales |
| -------- | ---- | ----- |
| A        | 2020 | 100   |
| A        | 2021 | 150   |
| B        | 2020 | 200   |
| B        | 2021 | 300   |

We want:

| category | sales_2020 | sales_2021 |
| -------- | ---------- | ---------- |
| A        | 100        | 150        |
| B        | 200        | 300        |


# 9. Pivot Using CASE

First method (manual pivot)

```sql
select
category,
sum(case when datepart(year,order_date)=2020 then sales end) as sales_2020,
sum(case when datepart(year,order_date)=2021 then sales end) as sales_2021
from orders
group by category;
```

Explanation

```
CASE WHEN year=2020 → take sales
ELSE → NULL
```

# 10. Pivot Using SQL PIVOT

Your lecture query:

```sql
select * from
(
select category , datepart(year,order_date) as yod , sales
from orders
) t1
pivot (
sum(sales) for yod in ([2020],[2021])
) as t2;
```

Step by step

Inner query

```
category | year | sales
```

Pivot

```
year values become columns
```

Result

| category | 2020 | 2021 |
| -------- | ---- | ---- |
| A        | 100  | 150  |
| B        | 200  | 300  |


# 11. Pivot by Region

Example query

```sql
pivot (
sum(sales) for region in (West,East,South)
)
```

Input table

| category | region | sales |
| -------- | ------ | ----- |
| A        | West   | 100   |
| A        | East   | 200   |
| A        | South  | 150   |

Output

| category | West | East | South |
| -------- | ---- | ---- | ----- |
| A        | 100  | 200  | 150   |


# 12. Creating Table From Query

Your query

```sql
select * into sales_yearwise from (...)
```

This means:

```
Create new table
+
Insert query result
```

Result

New table created

```
sales_yearwise
```

# 13. Table Backup Example

Your lecture did:

```sql
select * into orders_back from orders
```

Meaning:

Create **backup table**.

```
orders_back
```

# 14. Example Restore

Insert back data

```sql
insert into orders 
select * from orders_back;
```

Meaning

Copy all data back.

# 15. Filtering Region Table Example

Commented query

```
create table orders_east as
(select * from orders where region='East')
```

Meaning

Create table only for **East region orders**.
