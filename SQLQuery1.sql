Create database Movie

CREATE TABLE actor (
  act_id INT PRIMARY KEY,
  act_fname VARCHAR(20),
  act_lname VARCHAR(20),
  act_gender CHAR(1)
);
CREATE TABLE director (
  dir_id INT PRIMARY KEY,
  dir_fname VARCHAR(20),
  dir_lname VARCHAR(20)
);
CREATE TABLE movie (
  mov_id INT PRIMARY KEY,
  mov_title VARCHAR(50),
  mov_year INT,
  mov_time INT,
  mov_lang VARCHAR(50),
  mov_dt_rel DATE,
  mov_rel_country VARCHAR(5)
);

CREATE TABLE movie_cast (
  act_id INT,
  mov_id INT,
  role VARCHAR(30),
  FOREIGN KEY (act_id) REFERENCES actor(act_id),
  FOREIGN KEY (mov_id) REFERENCES movie(mov_id)
);

CREATE TABLE movie_direction (
  dir_id INT,
  mov_id INT,
  FOREIGN KEY (dir_id) REFERENCES director(dir_id),
  FOREIGN KEY (mov_id) REFERENCES movie(mov_id)
);

CREATE TABLE genres (
  gen_id INT PRIMARY KEY,
  gen_title VARCHAR(20)
);

CREATE TABLE movie_genres (
  mov_id INT,
  gen_id INT,
  FOREIGN KEY (mov_id) REFERENCES movie(mov_id),
  FOREIGN KEY (gen_id) REFERENCES genres(gen_id)
);

CREATE TABLE reviewer (
  rev_id INT PRIMARY KEY,
  rev_name VARCHAR(30)
);

CREATE TABLE rating (
  mov_id INT,
  rev_id INT,
  rev_stars INT,
  num_o_ratings INT,
  FOREIGN KEY (mov_id) REFERENCES movie(mov_id),
  FOREIGN KEY (rev_id) REFERENCES reviewer(rev_id)
);
===========================================================================================
===========================================================================================
CREATE DATABASE Task

-- 1. Create a table named "Employees" with columns for ID (integer), Name (varchar), and Salary (decimal).
CREATE TABLE Employees (
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary DECIMAL
);

-- 2. Add a new column named "Department" to the "Employees" table with data type varchar(50).
ALTER TABLE Employees
ADD Department VARCHAR(50);

-- 3. Remove the "Salary" column from the "Employees" table.
ALTER TABLE Employees
DROP COLUMN Salary;

-- 4. Rename the "Department" column in the "Employees" table to "DeptName".
EXEC sp_rename 'Employees.Department', 'DeptName', 'COLUMN';

-- 5. Create a new table called "Projects" with columns for ProjectID (integer) and ProjectName (varchar).
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(50)
);

-- 6. Add a primary key constraint to the "Employees" table for the "ID" column.
-- (Already done in step 1)

-- 7. Create a foreign key relationship between the "Employees" table (referencing "ID") and the "Projects" table (referencing "ProjectID").
ALTER TABLE Employees
ADD CONSTRAINT FK_Employees_Projects FOREIGN KEY (ID) REFERENCES Projects(ProjectID);

-- 8. Remove the foreign key relationship between "Employees" and "Projects."
ALTER TABLE Employees
DROP CONSTRAINT FK_Employees_Projects;

-- 9. Add a unique constraint to the "Name" column in the "Employees" table.
ALTER TABLE Employees
ADD CONSTRAINT UQ_Employees_Name UNIQUE (Name);

-- 10. Create a table named "Customers" with columns for CustomerID (integer), FirstName (varchar), LastName (varchar), and Email (varchar), and Status (varchar).
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(50),
    Status_ VARCHAR(50) DEFAULT 'Active'
);


-- 11. Add a unique constraint to the combination of "FirstName" and "LastName" columns in the "Customers" table.
ALTER TABLE Customers
ADD CONSTRAINT UQ_Customers_FirstName_LastName UNIQUE (FirstName, LastName);

-- 12. Add a default value of 'Active' for the "Status" column in the "Customers" table, where the default value should be applied when a new record is inserted.
--already did it with creating table (Kept on saying syntax error so i deleted the table and made it active with the creating process)

-- 13. Create a table named "Orders" with columns for OrderID (integer), CustomerID (integer), OrderDate (datetime), and TotalAmount (decimal).
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATETIME,
    TotalAmount DECIMAL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- 14. Add a check constraint to the "TotalAmount" column in the "Orders" table to ensure that it is greater than zero.
ALTER TABLE Orders
ADD CONSTRAINT CK_Orders_TotalAmount CHECK (TotalAmount > 0);

-- 15. Create a schema named "Sales" and move the "Orders" table into this schema.
CREATE SCHEMA Sales;

ALTER SCHEMA Sales 
TRANSFER dbo.Orders;

-- 16. Rename the "Orders" table to "SalesOrders."
EXEC sp_rename 'Sales.Orders', 'SalesOrders';
