-- Create sales_data table
CREATE TABLE sales_data (
  product_id INT,
  quantity_sold INT,
  price DECIMAL(10,2),
  transaction_date DATE
);

-- Insert sample values
INSERT INTO sales_data (product_id, quantity_sold, price, transaction_date)
VALUES
  (1, 10, 15.99, '2024-02-01'),
  (1, 8, 15.99, '2024-02-05'),
  (2, 15, 22.50, '2024-02-02'),
  (2, 20, 22.50, '2024-02-07'),
  (3, 12, 10.75, '2024-02-03'),
  (3, 18, 10.75, '2024-02-08'),
  (4, 5, 30.25, '2024-02-04'),
  (4, 10, 30.25, '2024-02-09'),
  (5, 25, 18.50, '2024-02-06'),
  (5, 30, 18.50, '2024-02-10');

--Your goal? Retrieving the top 10 products with the highest total revenue, where the total revenue is calculated as the sum of the product of quantity_sold and price for each transaction.

SELECT product_id, SUM(quantity_sold*price) as total_revenue
FROM sales_data
GROUP BY product_id
qualify row_number() over 
  (partition by total_revenue
   order by total_revenue desc) <= 10
order by total_revenue desc;
