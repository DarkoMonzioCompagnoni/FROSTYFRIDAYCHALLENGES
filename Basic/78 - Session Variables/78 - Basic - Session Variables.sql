------------------
-- STARTUP CODE --
------------------

-- Creating a table 'w78' with simulated sales data
CREATE TABLE w78 AS
SELECT
  SEQ4() AS sales_id, -- Generating a sequential sales_id
  CASE -- Assigning product names based on the modulo of SEQ4()
    WHEN MOD(SEQ4(), 4) = 0 THEN 'Product A'
    WHEN MOD(SEQ4(), 4) = 1 THEN 'Product B'
    WHEN MOD(SEQ4(), 4) = 2 THEN 'Product C'
    ELSE 'Product D'
  END AS product_name,
  UNIFORM(1, 10, RANDOM())::INTEGER AS quantity_sold, 
  DATEADD('day', -UNIFORM(1, 365, RANDOM())::INTEGER, CURRENT_DATE()) AS sales_date, 
  UNIFORM(20, 100, RANDOM())::FLOAT * UNIFORM(1, 10, RANDOM())::INTEGER AS sales_amount 
FROM TABLE(GENERATOR(ROWCOUNT => 1000)); -- Generating 1000 rows of data

--------------
-- SOLUTION --
--------------

-- Create a variable named 'sales_avg' to store the average sales amount from 'w78'
SET sales_avg = (SELECT AVG(sales_amount) FROM W78);

-- Final script to select rows where sales_amount is within $50 range of the average sales amount
SELECT *
FROM w78
WHERE sales_amount BETWEEN $sales_avg - 50 AND $sales_avg + 50;
