-- ? Start a postgres server
-- ! docker run -d --name sql_cc -e POSTGRES_PASSWORD=postgres -p 5432:5432 postgres:18
-- ? Enter psql terminal
-- ! docker exec -it sql_cc psql -U postgres
-- ? Create a database
-- CREATE DATABASE chaicode_ecom_db;

-- ! DDL (Data Definition language)
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY, -- value cannot be NULL and it must be unique
    department_name VARCHAR(50) NOT NULL
);

INSERT INTO
    departments (department_name)
VALUES ('Sales'),
    ('Support'),
    ('Warehouse');

INSERT INTO
    departments (
        department_id,
        department_name
    )
VALUES (4, 'Tech');

SELECT * FROM departments;

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY, -- cannot be null it is unique
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20),
    bio TEXT,
    job_title VARCHAR(50) NOT NULL,
    salary INT NOT NULL CHECK (salary > 0),
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    hire_date DATE NOT NULL,
    last_login TIMESTAMP,
    employee_status VARCHAR(20) NOT NULL DEFAULT 'active' CHECK (
        employee_status IN (
            'active',
            'on_leave',
            'terminated'
        )
    ), -- active, on_leave, terminated
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    department_id INT REFERENCES departments (department_id),
    manager_id INT REFERENCES employees (employee_id)
);

INSERT INTO
    employees (
        first_name,
        last_name,
        email,
        department_id,
        job_title,
        salary,
        manager_id,
        hire_date
    )
VALUES (
        'James',
        'Okafor',
        'james.okafor@techbazaar.com',
        2,
        'Support Lead',
        72000.00,
        NULL,
        '2018-05-10'
    ),
    (
        'Sara',
        'Osei',
        'sara.osei@techbazaar.com',
        3,
        'Warehouse Lead',
        55000.00,
        NULL,
        '2020-08-23'
    );

INSERT INTO
    employees (
        first_name,
        last_name,
        email,
        department_id,
        job_title,
        salary,
        manager_id,
        hire_date
    )
VALUES (
        'Priya',
        'Nair',
        'priya.nair@techbazaar.com',
        1,
        'Sales Representative',
        62000.00,
        1,
        '2020-06-15'
    ),
    (
        'Fake',
        'Robert',
        'robert.chen@techbazaar.com',
        1,
        'Rep',
        50000.00,
        1,
        '2024-01-01'
    ),
    (
        'Marcus',
        'Webb',
        'marcus.webb@techbazaar.com',
        1,
        'Sales Representative',
        58000.00,
        1,
        '2021-09-01'
    ),
    (
        'Elena',
        'Garcia',
        'elena.garcia@techbazaar.com',
        1,
        'Senior Sales Rep',
        68000.00,
        1,
        '2019-11-20'
    ),
    (
        'Lily',
        'Zhang',
        'lily.zhang@techbazaar.com',
        2,
        'Support Agent',
        48000.00,
        2,
        '2022-02-14'
    ),
    (
        'Diego',
        'Fernandez',
        'diego.fernandez@techbazaar.com',
        2,
        'Support Agent',
        46000.00,
        2,
        '2023-01-09'
    );

SELECT * FROM employees;

SELECT * from departments;

INSERT INTO
    employees (
        first_name,
        last_name,
        email,
        department_id,
        job_title,
        salary,
        hire_date
    )
VALUES (
        NULL,
        'NoFirstName',
        'nofirstname.demo@example.com',
        1,
        'Rep',
        50000.00,
        '2024-01-01'
    );

INSERT INTO
    employees (
        first_name,
        last_name,
        email,
        department_id,
        job_title,
        salary,
        hire_date
    )
VALUES (
        'Fake',
        'Robert',
        'robert.chen@techbazaar.com',
        1,
        'Rep',
        50000.00,
        '2024-01-01'
    );

INSERT INTO
    employees (
        first_name,
        last_name,
        email,
        department_id,
        job_title,
        salary,
        hire_date
    )
VALUES (
        'Unpaid',
        'Intern',
        'unpaid.demo@example.com',
        1,
        'Intern',
        0,
        '2024-01-01'
    );

INSERT INTO
    employees (
        first_name,
        last_name,
        email,
        department_id,
        job_title,
        salary,
        hire_date,
        employee_status
    )
VALUES (
        'Bad',
        'Status',
        'badstatus.demo@example.com',
        1,
        'Rep',
        50000.00,
        '2024-01-01',
        'retired'
    );

ALTER TABLE employees
ADD COLUMN internal_note VARCHAR(100) NOT NULL DEFAULT 'N/A';

SELECT * FROM employees;

ALTER TABLE employees RENAME COLUMN internal_note TO hr_note;

ALTER TABLE employees DROP COLUMN hr_note;

--! ======== DDL End ========
-- ! INSERT< UPDATE < DELETE are called as DML - Data Manipulation language

INSERT INTO
    customers (
        first_name,
        last_name,
        email,
        phone,
        city,
        country
    )
VALUES (
        'John',
        'Doe',
        'john.doe@gmail.com',
        '0123456789',
        'Mumbai',
        'India'
    );

SELECT * FROM customers;

SELECT * FROM categories;

INSERT INTO
    categories (category_name, description)
VALUES ('Dairy', 'Dairy products'),
    ('Gym', 'Gym products'),
    (
        'Cold drinks',
        'Cold drinks description'
    );

SELECT * FROM products;

UPDATE products SET stock_quantity = 50 WHERE product_id = 1;

UPDATE products SET is_active = FALSE;

UPDATE products SET price = price + 100;

UPDATE products SET price = price + 200 WHERE product_id = 3;

SELECT * FROM departments;

DELETE FROM departments WHERE department_id = 4;

SELECT * FROM orders;

-- order_item_id: 1, 2
SELECT * FROM order_items WHERE order_id = 1;

DELETE FROM orders WHERE order_id = 1;

--! ======== DML End ========
-- ! DQL - Data Query Language

SELECT * FROM products;

SELECT
    product_id,
    product_name AS "Product Name",
    stock_quantity
FROM products;

SELECT * FROM customers;

SELECT DISTINCT country FROM customers;

SELECT * FROM products WHERE price > 200;

-- Give me products having stock qty > 0 and price < 150
SELECT *
FROM products
WHERE
    price > 150
    AND stock_quantity > 0;

-- Give me products having 0 as stock qty 1 or price < 150
SELECT *
FROM products
WHERE
    stock_quantity = 0
    OR price < 150;

-- Give me products which are not active
SELECT * FROM products WHERE NOT is_active;

-- Give me product having price > 120 and price < 200.
SELECT * FROM products WHERE price BETWEEN 120 AND 200;

-- BETWEEN lowerbound and upperbound

SELECT * FROM products WHERE price >= 120 AND price <= 200;

SELECT * FROM products WHERE price BETWEEN 120 AND 200;

SELECT * FROM categories;

-- Give me product from Electronics as well as books
SELECT *
FROM products
WHERE
    category_id = 1
    OR category_id = 3
    OR category_id = 4;

SELECT * FROM products WHERE category_id IN (1, 2, 3, 5);

SELECT * FROM products WHERE category_id = 9;

-- give me product having product name
-- starting with "Wireless"
-- Wireless headphones
-- Wireless mouse

INSERT INTO
    products (
        product_name,
        price,
        stock_quantity,
        category_id
    )
VALUES (
        'Wireless keyboard',
        100,
        20,
        1
    ),
    ('Wireless light', 200, 0, 1),
    (
        'Wireless headphones',
        150,
        20,
        1
    );

SELECT * FROM products WHERE product_name LIKE 'Wireless%';

SELECT * FROM products WHERE product_name LIKE 'Wireless M%';

SELECT * FROM products WHERE product_name LIKE '%less%';

-- Give me customers who does not have phone numbers

SELECT * FROM customers;

SELECT * FROM customers WHERE phone IS NULL;

SELECT * FROM customers WHERE phone IS NOT NULL;

SELECT
    first_name,
    last_name,
    COALESCE(
        phone,
        'Phone number unavailable'
    ) AS phone,
    COALESCE(city, 'No city') AS city
FROM customers;

-- Sorting
-- Give me products from cheapest to expensive order

SELECT * FROM products ORDER BY price DESC;
-- ASC: ascending, DESC: descending

-- Give me product form cheap to exp price for each category
SELECT * FROM products ORDER BY category_id DESC, price ASC;

-- Give me top 5 most expensive products

SELECT * FROM products ORDER BY price DESC LIMIT 10;

SELECT * FROM products ORDER BY price DESC;

-- Pagination
SELECT *
FROM products
ORDER BY product_id
LIMIT 10 -- page limit 
OFFSET
    20;
-- skip row

-- FE: page: 1, 2, 3
-- p: 1: OFFSET: 0
-- p: 2: OFFSET: 10
-- p: 3: OFFSET: 10 + 10: 20

-- formula in backend
-- offset = (page - 1) * limit

-- Joins Start

-- Give me all orders including employee details of the employee who processed
-- that order
-- only include orders punched by employees

SELECT * FROM orders;

-- INNER JOIN
-- Combines rows from two tables based on a specified ON condition.
-- INNER JOIN is strict for both the table

SELECT o.status, o.order_id, e.email, e.first_name
FROM orders AS o
    INNER JOIN employees AS e ON e.employee_id = o.employee_id;

-- give me all orders and include employee details of employee who processed
-- that order and if it is directly coming from customer keep employee
-- details empty

-- LEFT JOIN
-- Returns all rows from the left table, regardless of whether the ON condition is TRUE or FALSE.
-- Matching rows from the right table are included; if no match exists, NULL values are returned.
-- LEFT JOIN is strict for RIGHT SIDE table

-- left table is orders
-- right table is employees

SELECT o.status, o.order_id, e.email, e.first_name
FROM orders AS o
    LEFT JOIN employees AS e ON e.employee_id = o.employee_id;

-- RIGHT JOIN
-- Returns all rows from the right table, regardless of whether the ON condition matches.
-- Matching rows from the left table are included; if no match exists, NULL values are returned.
-- RIGHT JOIN is strict for LEFT SIDE table

SELECT o.status, o.order_id, e.email, e.first_name
FROM orders AS o
    RIGHT JOIN employees AS e ON e.employee_id = o.employee_id;

-- FULL OUTER JOIN
-- Returns all rows from both tables, whether the ON condition matches or not.
-- If no match exists, NULL values are returned for the columns of the unmatched table.
-- FULL OUTER JOIN is not strict for the any of the table

SELECT o.status, o.order_id, e.email, e.first_name
FROM orders AS o
    FULL OUTER JOIN employees AS e ON e.employee_id = o.employee_id;

-- CROSS JOIN
-- Returns the Cartesian product of both tables, combining every row from the left table
-- with every row from the right table.

SELECT * FROM departments CROSS JOIN categories;

-- Joins examples

-- Give me all customers who did not place any order

SELECT c.first_name, c.email, o.status, o.order_id
FROM customers as c
    LEFT JOIN orders as o ON o.customer_id = c.customer_id
WHERE
    o.status IS NULL;

-- Give me orders which have not been paid
SELECT *
FROM orders as o
    LEFT JOIN payments as p ON o.order_id = p.order_id
WHERE
    p.payment_id IS NULL;

-- Give information about all orders thata are there in the DB
-- Include info about order_items, product, customer and
-- category the product belongs to

SELECT o.order_id, o.status, oi.product_id, oi.unit_price, p.product_name, p.price, c.category_name, cu.first_name, cu.last_name
FROM
    orders AS o
    LEFT JOIN order_items AS oi ON oi.order_id = o.order_id
    LEFT JOIN products AS p ON p.product_id = oi.product_id
    LEFT JOIN categories AS c ON c.category_id = p.category_id
    LEFT JOIN customers AS cu ON cu.customer_id = o.customer_id;

-- Give me info about employees including their manager's info;

SELECT
    emp.first_name as "Employee First Name",
    emp.last_name as "Employee Last Name",
    manager_tbl.first_name as "Manager First Name",
    manager_tbl.last_name as "Manager Last Name"
FROM
    employees as emp
    LEFT JOIN employees as manager_tbl on emp.manager_id = manager_tbl.employee_id;

-- ! Aggregation start
-- ! Give me total count customers on our platform

-- College: 5 students
-- 5LPA, 10, 5, 10, 15
-- what is an average CTC of the college:
-- Total CTC across students / numbers of students
-- 5 + 10 + 5 + 10 + 15 / 5
-- 9 LPA -> Average CTA of my college
-- total CTC awarded: 5 + 10 + 5 + 10 + 15 = 45LPA

--  I had 5 entries on student level
-- I reduced those 5 entries in a single college level entry

-- Give me total count customers on our platform

SELECT * FROM customers;

SELECT
    COUNT(*) as cust_count,
    COUNT(phone) as cust_with_phone_number
FROM customers;

SELECT COUNT(DISTINCT country) FROM customers;

-- Give me total revenue across all orders till now

SELECT
    order_item_id,
    quantity,
    unit_price,
    quantity * unit_price as total_selling_val
FROM order_items;

SELECT SUM(quantity * unit_price) as total_revenue FROM order_items;

-- give average price of product across all products

SELECT * FROM products;

SELECT ROUND(AVG(price)) as avg_price FROM products;

-- give me min price and max price across all prducts
SELECT min(price) as min_price, max(price) as max_price
FROM products;

SELECT
    count(*) as total_product,
    round(avg(price), 2) as avg_price,
    min(price) as min_price,
    max(price) as max_price,
    sum(stock_quantity) as total_stock
FROM products;

SELECT * FROM products;

SELECT count(*) as product_count FROM products;

-- Give me total number of proucts in each category

SELECT category_id, count(*) FROM products GROUP BY category_id;

-- Give me total number of active and inactive
-- products in each categroy

SELECT category_id, is_active, count(*)
FROM products
GROUP BY
    category_id,
    is_active;

-- Give me total number of proucts in each category
-- Include category name in the result

SELECT p.category_id, c.category_name, count(*)
FROM products as p
    LEFT JOIN categories as c on c.category_id = p.category_id
GROUP BY
    p.category_id,
    c.category_name;

-- Give me total number of products in each category

-- Use the HAVING clause to apply conditions to aggregated results.
SELECT category_id, count(*)
FROM products
GROUP BY
    category_id
HAVING
    count(*) > 5;

-- Find departments having more than one managed employee,
-- where their combined salary of whole department exceeds 200000 reupees.

-- HAVING comes after GROUP BY
-- WHERE comes before GROUP BY

SELECT
    department_id,
    count(*) as dep_epm,
    sum(salary) as total_dep_salary
FROM employees
WHERE
    manager_id IS NOT NULL
GROUP BY
    department_id
HAVING
    count(*) > 1;

SELECT
    department_id,
    count(*) as dep_epm,
    sum(salary) as total_dep_salary
FROM employees
WHERE
    manager_id IS NOT NULL
GROUP BY
    department_id
HAVING
    count(*) > 1
    AND sum(salary) > 200000;

SELECT * FROM employees;

-- ========= Aggregation End ========

-- Subquery start

-- Give me all the customer having at least one cancelled order

SELECT customer_id FROM orders WHERE status = 'cancelled';

SELECT *
FROM customers
WHERE
    customer_id IN (
        SELECT customer_id
        FROM orders
        WHERE
            status = 'cancelled'
    );

SELECT * FROM customers;

SELECT * FROM orders;

SELECT *
FROM customers as cus
    LEFT JOIN orders as o on o.customer_id = cus.customer_id
WHERE
    o.status = 'cancelled';

-- Give me all the products which are having
-- price > average price across all products

SELECT * FROM products;

SELECT avg(price) FROM products;

SELECT product_id, product_name
FROM products
WHERE
    price > (
        SELECT avg(price)
        FROM products
    );

-- give me sales on category level
-- electronics - 3000
-- clothing - 4000
-- give me categories having sales > 500
-- return category name in the result

SELECT * FROM orders;

SELECT * FROM order_items;

SELECT * FROM products;

SELECT * FROM categories;

-- derived table
SELECT c.category_id, c.category_name, category_stats.category_sales
FROM (
        SELECT p.category_id as stat_id, sum(oi.quantity * oi.unit_price) as category_sales
        FROM order_items as oi
            LEFT JOIN products as p on p.product_id = oi.product_id
        GROUP BY
            p.category_id
    ) as category_stats
LEFT JOIN categories as c ON c.category_id = category_stats.stat_id
WHERE
    category_sales > 500;



SELECT p.category_id, sum(oi.quantity * oi.unit_price) as category_sales
FROM order_items as oi
    LEFT JOIN products as p on p.product_id = oi.product_id
GROUP BY
    p.category_id
HAVING
    sum(oi.quantity * oi.unit_price) > 500;