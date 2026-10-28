-- =====================================================
-- MySQL Assignment 1 - DDL Commands & Constraints
-- (Requires MySQL 8.0.16+ for CHECK, 8.0.13+ for expression DEFAULT)
-- =====================================================

-- =====================================================
-- PART A: DDL COMMANDS
-- =====================================================

-- 1. CREATE
   DROP DATABASE IF EXISTS employee;
CREATE DATABASE employee;
USE employee;

CREATE TABLE departments (
    department_id   INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE location (
    location_id INT PRIMARY KEY,
    location    VARCHAR(30)
);

CREATE TABLE employees (
    employee_id   INT PRIMARY KEY,
    employee_name VARCHAR(50),
    gender        ENUM('M','F'),
    age           INT,
    hire_date     DATE,
    designation   VARCHAR(100),
    department_id INT,
    location_id   INT,
    salary        DECIMAL(10,2)
);

-- 2. ALTER
-- 2a. Add email column
ALTER TABLE employees ADD COLUMN email VARCHAR(100);

-- 2b. Widen designation
ALTER TABLE employees MODIFY COLUMN designation VARCHAR(255);

-- 2c. Drop age column
ALTER TABLE employees DROP COLUMN age;

-- 2d. Rename hire_date -> date_of_joining
ALTER TABLE employees RENAME COLUMN hire_date TO date_of_joining;
-- (older MySQL: ALTER TABLE employees CHANGE hire_date date_of_joining DATE;)

-- 3. RENAME
RENAME TABLE departments TO departments_info;
RENAME TABLE location TO locations;

-- 4. TRUNCATE
TRUNCATE TABLE employees;

-- 5. DROP
DROP TABLE employees;
DROP DATABASE employee;


-- =====================================================
-- PART B: CONSTRAINTS
-- =====================================================

-- 1. Database recreation
DROP DATABASE IF EXISTS employee;
CREATE DATABASE employee;
USE employee;

-- 2. Departments
CREATE TABLE departments (
    department_id   INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

-- 3. Location
CREATE TABLE location (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    location    VARCHAR(30) NOT NULL UNIQUE
);

-- 4. Employees
CREATE TABLE employees (
    employee_id   INT PRIMARY KEY,
    employee_name VARCHAR(50) NOT NULL,
    gender        ENUM('M','F'),
    age           INT,
    hire_date     DATE DEFAULT (CURRENT_DATE),
    designation   VARCHAR(100),
    department_id INT,
    location_id   INT,
    salary        DECIMAL(10,2),
    CONSTRAINT chk_gender CHECK (gender IN ('M','F')),
    CONSTRAINT chk_age    CHECK (age >= 18),
    CONSTRAINT fk_dept FOREIGN KEY (department_id)
        REFERENCES departments(department_id),
    CONSTRAINT fk_loc  FOREIGN KEY (location_id)
        REFERENCES location(location_id)
);

-- Optional: verify
DESCRIBE departments;
DESCRIBE location;
DESCRIBE employees;
