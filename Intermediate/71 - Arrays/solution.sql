-- Set the current database context to 'FROSTYFRIDAY'
USE DATABASE FROSTYFRIDAY;

------------------
-- STARTUP CODE --
------------------
-- Create the Sales table
CREATE OR REPLACE TABLE Sales (
    Sale_ID INT PRIMARY KEY,
    Product_IDs VARIANT --INT
);

-- Inserting sample sales data
INSERT INTO Sales (Sale_ID, Product_IDs) SELECT 1, PARSE_JSON('[1, 3]');-- Products A and C in the same sale
INSERT INTO Sales (Sale_ID, Product_IDs) SELECT 2, PARSE_JSON('[2, 4]');-- Products B and D in the same sale


-- Create the Products table
CREATE OR REPLACE TABLE Products (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR,
    Product_Categories VARIANT --VARCHAR
);

-- Inserting sample data into Products
INSERT INTO Products (Product_ID, Product_Name, Product_Categories) SELECT 1, 'Product A', ARRAY_CONSTRUCT('Electronics', 'Gadgets');
INSERT INTO Products (Product_ID, Product_Name, Product_Categories) SELECT 2, 'Product B', ARRAY_CONSTRUCT('Clothing', 'Accessories');
INSERT INTO Products (Product_ID, Product_Name, Product_Categories) SELECT 3, 'Product C', ARRAY_CONSTRUCT('Electronics', 'Appliances');
INSERT INTO Products (Product_ID, Product_Name, Product_Categories) SELECT 4, 'Product D', ARRAY_CONSTRUCT('Clothing');

--------------
-- SOLUTION --
--------------

-- checking tables

SELECT * FROM Sales;
SELECT * FROM Products;

-- solution 

-- aggregating common categories per sale
CREATE OR REPLACE VIEW CHALLENGE_OUTPUT AS
SELECT
    SALES.SALE_ID,
    ARRAY_AGG(PRODUCTS.PRODUCT_CATEGORIES) AS COMMON_CATEGORIES
FROM SALES
INNER JOIN PRODUCTS ON ARRAY_CONTAINS(PRODUCTS.PRODUCT_ID, SALES.PRODUCT_IDS)
GROUP BY SALES.SALE_ID;

-- Check result
SELECT *
FROM CHALLENGE_OUTPUT
ORDER BY SALE_ID ASC;
