# 1. Dummy Tables

### Employee Table

| emp_id | name  | dept_id | salary |
| ------ | ----- | ------- | ------ |
| 1      | Ali   | 10      | 50000  |
| 2      | Ahmed | 20      | 60000  |
| 3      | Sara  | 30      | 55000  |
| 4      | Hina  | 20      | 70000  |

### Department Table

| dep_id | dep_name  |
| ------ | --------- |
| 10     | HR        |
| 20     | Analytics |
| 30     | IT        |


# 2. UPDATE using Subquery

Query:

```sql
update employee 
set salary=salary * 1.1
where dept_id in 
(select dep_id from dept where dep_name='HR');
```

### What happens

Step 1 → Subquery finds HR department

```sql
select dep_id from dept where dep_name='HR'
```

Result

```
10
```

Step 2 → Update employees with dept_id = 10

Salary increases **10%**

Before

| emp | salary |
| --- | ------ |
| Ali | 50000  |

After

| emp | salary |
| --- | ------ |
| Ali | 55000  |

✔ HR employees get salary increment.

# 3. ALTER TABLE

Query

```sql
alter table employee add dep_name varchar(20)
```

Meaning:

Add new column.

New table structure:

| emp_id | name | dept_id | salary | dep_name |
| ------ | ---- | ------- | ------ | -------- |


# 4. UPDATE using JOIN

Query:

```sql
update employee 
set dep_name=d.dep_name
from employee e
inner join dept d 
on e.dept_id=d.dep_id
where d.dep_name='Analytics'
```

Explanation:

Join tables:

```
employee.dept_id = dept.dep_id
```

Then update column.

Result:

| emp   | dept_id | dep_name  |
| ----- | ------- | --------- |
| Ahmed | 20      | Analytics |
| Hina  | 20      | Analytics |

# 5. Another UPDATE using Backup Table

```sql
update employee 
set dep_name=d.dep_name
from employee e
inner join dept_back d 
on e.dept_id=d.dep_id
```

Now department name is copied from **backup table**.

# 6. Creating Backup Table

Example in lecture:

```sql
select * into dept_back from dept
```

Meaning:

```
Copy dept table → dept_back
```

# 7. Insert New Department

```sql
insert into dept_back values (100,'Marketing')
```

New department added.

| dep_id | dep_name  |
| ------ | --------- |
| 100    | Marketing |

# 8. Checking Join Result

```sql
select * from employee e
inner join dept_back d 
on e.dept_id=d.dep_id;
```

This shows **employee + department info** together.

# 9. DELETE using JOIN

Query:

```sql
delete employee 
from employee e
inner join dept d 
on e.dept_id=d.dep_id
where d.dep_name='HR';
```

Meaning:

Delete employees in **HR department**.

Before

| emp | dept |
| --- | ---- |
| Ali | HR   |

After delete

Ali removed.

# 10. EXISTS vs IN

Query

```sql
select * from employee_back e
where dept_id in (select dep_id from dept)
```

Meaning:

Select employees whose department exists in dept table.


## EXISTS Version

```sql
select * 
from employee_back e
where exists (
select 1 
from dept_back d 
where e.dept_id=d.dep_id
)
```

Meaning:

Check if matching row exists.

## Difference

`IN`

```
compares values
```

`EXISTS`

```
checks row existence
```

`EXISTS` is usually **faster for large tables**.

# 11. SQL Language Categories

## DDL (Data Definition Language)

Used to **define structure**

Examples

```sql
CREATE
ALTER
DROP
```

Example

```sql
CREATE TABLE employee
```

## DML (Data Manipulation Language)

Used to **change data**

Examples

```
INSERT
UPDATE
DELETE
```

Example

```sql
UPDATE employee SET salary=60000
```

## DQL (Data Query Language)

Used to **retrieve data**

Example

```
SELECT
```

## DCL (Data Control Language)

Used to **control permissions**

Examples

```
GRANT
REVOKE
```

## TCL (Transaction Control Language)

Used to **control transactions**

Examples

```
COMMIT
ROLLBACK
SAVEPOINT
```

# 12. GRANT Permission

Query:

```sql
grant select,insert,update,create table 
on employees 
to guest
```

Meaning:

User **guest** can

* read
* insert
* update
* create table

Another example

```sql
grant select on schema::dbo to guest
```

Meaning:

Guest can **select from all tables in dbo schema**.

# 13. REVOKE Permission

```sql
revoke select,insert,delete 
on employees 
from guest;
```

Meaning:

Remove permissions from guest.

# 14. Roles

Roles group users.

Create role

```sql
create role role_sales
```

Grant permission to role

```sql
grant select on employees to role_sales
```

Add user to role

```sql
alter role role_sales add member guest;
```

Now guest inherits role permissions.

# 15. GRANT WITH GRANT OPTION

```sql
grant select on employees 
to guest 
with grant option;
```

Meaning:

Guest can **also give permission to other users**.

# 16. Transactions

Transactions ensure **data consistency**.

Example

```sql
begin tran d
update employee set salary = 35000 where emp_id=1
commit tran d;
```

Steps

1. Start transaction
2. Update data
3. Commit changes permanently

# 17. ROLLBACK

Rollback cancels transaction.

Example

```sql
update employee set salary = 50000 where emp_id=1
rollback
```

Result

Salary change undone.


# 18. SAVEPOINT

Savepoints allow partial rollback.

Example concept

```
Start transaction
Update row
Savepoint A
Insert row
Rollback to A
```

Only **insert is undone**, update remains.
