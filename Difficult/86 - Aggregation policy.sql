-- Create the Sales_Records table
CREATE TABLE Sales_Records (
    Order_ID INT,
    Product_Name VARCHAR(50),
    Product_Category VARCHAR(50),
    Quantity INT,
    Unit_Price DECIMAL(10,2),
    Customer_ID INT
);

-- Insert sample data into the Sales_Records table
INSERT INTO Sales_Records (Order_ID, Product_Name, Product_Category, Quantity, Unit_Price, Customer_ID) VALUES
(1, 'Laptop', 'Electronics', 2, 1200.00, 101),
(2, 'Smartphone', 'Electronics', 1, 800.00, 102),
(3, 'Headphones', 'Electronics', 5, 50.00, 103),
(4, 'T-shirt', 'Apparel', 3, 20.00, 104),
(5, 'Jeans', 'Apparel', 2, 30.00, 105),
(6, 'Sneakers', 'Footwear', 1, 80.00, 106),
(7, 'Backpack', 'Accessories', 4, 40.00, 107),
(8, 'Sunglasses', 'Accessories', 2, 50.00, 108),
(9, 'Watch', 'Accessories', 1, 150.00, 109),
(10, 'Tablet', 'Electronics', 3, 500.00, 110),
(11, 'Jacket', 'Apparel', 2, 70.00, 111),
(12, 'Dress', 'Apparel', 1, 60.00, 112),
(13, 'Sandals', 'Footwear', 4, 25.00, 113),
(14, 'Belt', 'Accessories', 2, 30.00, 114),
(15, 'Speaker', 'Electronics', 1, 150.00, 115),
(16, 'Wallet', 'Accessories', 3, 20.00, 116),
(17, 'Hoodie', 'Apparel', 2, 40.00, 117),
(18, 'Running Shoes', 'Footwear', 1, 90.00, 118),
(19, 'Earrings', 'Accessories', 4, 15.00, 119),
(20, 'Ring', 'Accessories', 2, 50.00, 120);

--------------
-- SOLUTION --
--------------

-- creating agg policy and assigning it to the sales_records table -- 

CREATE OR REPLACE AGGREGATION POLICY ff86_aggp
  AS () RETURNS AGGREGATION_CONSTRAINT -> AGGREGATION_CONSTRAINT(MIN_GROUP_SIZE => 3);

ALTER TABLE Sales_Records SET AGGREGATION POLICY ff86_aggp;

---------------------
-- TESTING QUERIES -- 
---------------------

SELECT customer_id, product_category, SUM(Quantity * unit_price) as total_spent 
FROM sales_records
GROUP BY CUSTOMER_ID, product_category;
-- agg policy violated --

SELECT SUM(Quantity * unit_price) as total_revenue 
FROM sales_records;
-- agg policy violated --

SELECT Product_Category, COUNT(*) AS Number_of_Orders, SUM(Quantity) AS Total_Quantity_Sold
FROM Sales_Records
GROUP BY Product_Category
HAVING COUNT(*) >= 2;
-- this query is allowed -- 

SELECT Product_Category, COUNT(DISTINCT PRODUCT_NAME) AS number_of_products
FROM Sales_Records
GROUP BY Product_Category;
-- this query is allowed -- 

