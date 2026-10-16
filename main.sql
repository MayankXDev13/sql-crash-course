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

SELECT * FROM products
ORDER BY price DESC; -- ASC: ascending, DESC: descending


-- Give me product form cheap to exp price for each category
SELECT * FROM products
ORDER BY category_id DESC, price ASC;


-- Give me top 5 most expensive products

SELECT * FROM products
ORDER BY price DESC
LIMIT 10;

SELECT * FROM products
ORDER BY price DESC;

-- Pagination
SELECT * FROM products
ORDER BY product_id
LIMIT 10 -- page limit 
OFFSET 20; -- skip row

-- FE: page: 1, 2, 3
-- p: 1: OFFSET: 0
-- p: 2: OFFSET: 10
-- p: 3: OFFSET: 10 + 10: 20


-- formula in backend 
-- offset = (page - 1) * limit

