-- Query to retrieve the column names of the 'df_orders' table
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'df_orders';

-- Query to identify the top 10 highest revenue-generating products
-- This query calculates the total sales per product and ranks the top 10 by sales.
SELECT TOP 10 product_id, SUM(sale_price) AS sales
FROM df_orders
GROUP BY product_id
ORDER BY sales DESC;

-- Query to determine the top 5 highest-selling products within each region
-- This Common Table Expression (CTE) calculates the total sales for each product in each region, 
-- and then uses the ROW_NUMBER() function to select the top 5 products per region.
WITH cte AS (
    SELECT region, product_id, SUM(sale_price) AS sales
    FROM df_orders
    GROUP BY region, product_id
)
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY region ORDER BY sales DESC) AS rn
    FROM cte
) A
WHERE rn <= 5;

-- Query to analyze month-over-month growth in sales for 2022 and 2023
-- This CTE aggregates the sales data by year and month, and then compares the sales for each month 
-- between 2022 and 2023 to analyze growth trends.
WITH cte AS (
    SELECT YEAR(order_date) AS order_year, MONTH(order_date) AS order_month,
           SUM(sale_price) AS sales
    FROM df_orders
    GROUP BY YEAR(order_date), MONTH(order_date)
)
SELECT order_month,
       SUM(CASE WHEN order_year = 2022 THEN sales ELSE 0 END) AS sales_2022,
       SUM(CASE WHEN order_year = 2023 THEN sales ELSE 0 END) AS sales_2023
FROM cte 
GROUP BY order_month
ORDER BY order_month;

-- Query to identify the month with the highest sales for each product category
-- This CTE aggregates sales by category and month, then uses ROW_NUMBER() to determine the 
-- month with the highest sales for each category.
WITH cte AS (
    SELECT category, FORMAT(order_date, 'yyyyMM') AS order_year_month,
           SUM(sale_price) AS sales 
    FROM df_orders
    GROUP BY category, FORMAT(order_date, 'yyyyMM')
)
SELECT *
FROM (
    SELECT *, ROW_NUMBER() OVER(PARTITION BY category ORDER BY sales DESC) AS rn
    FROM cte
) a
WHERE rn = 1;

-- Query to find the sub-category with the highest growth in sales from 2022 to 2023
-- This CTE aggregates sales data by sub-category and year, and then calculates the growth in 
-- sales between 2022 and 2023 to identify the sub-category with the highest growth.
WITH cte AS (
    SELECT sub_category, YEAR(order_date) AS order_year,
           SUM(sale_price) AS sales
    FROM df_orders
    GROUP BY sub_category, YEAR(order_date)
),
cte2 AS (
    SELECT sub_category,
           SUM(CASE WHEN order_year = 2022 THEN sales ELSE 0 END) AS sales_2022,
           SUM(CASE WHEN order_year = 2023 THEN sales ELSE 0 END) AS sales_2023
    FROM cte 
    GROUP BY sub_category
)
SELECT TOP 1 *, (sales_2023 - sales_2022) AS sales_growth
FROM cte2
ORDER BY sales_growth DESC;
