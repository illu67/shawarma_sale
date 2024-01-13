SELECT * FROM shawarma.shawarma_sale;
DESC shawarma_sale;
use shawarma;

-- Total Revenue of Shawarma Sales
SELECT SUM(total_price) AS 'Total Revenue'From shawarma_sale;

-- To find the Average Value on Shawarma Sales
SELECT SUM(total_price) / COUNT(distinct order_id) AS 'Average value'From shawarma_sale;

-- To find the overall quantities Shawarma sold
SELECT SUM(quantity) AS 'Quantity Sold' FROM shawarma_sale;

-- To find the total number of orders placed
SELECT COUNT(DISTINCT order_id) AS 'Total Orders' FROM shawarma_sale;

-- To find the Average Shawarma per order
SELECT SUM(quantity) / COUNT(distinct order_id) AS 'Average value'From shawarma_sale;

-- To find daily Trends for total orders
SELECT Dayname(order_date) AS 'Order Day',
COUNT(distinct order_id) AS 'Total Orders'
FROM shawarma_sale GROUP BY Dayname(order_date);

--  To find Monthly Trends for total orders
SELECT MONTHNAME(order_date) AS 'Order Day',
COUNT(distinct order_id) AS 'Total Orders'
FROM shawarma_sale GROUP BY MONTHNAME(order_date) ORDER BY 'Order Day'DESC;

-- TO find the percentage of sale by shawarma category;
SELECT shawarma_category,sum(total_price) AS 'Total Revenue',
ROUND(sum(total_price) * 100 / (SELECT SUM(total_price) from shawarma_sale),2)
AS 'Percentage of total sale' FROM shawarma_sale
GROUP BY shawarma_category;

-- TO find the percentage of sale by shawarma Size;
SELECT
  shawarma_size,
  ROUND(SUM(total_price)) AS 'Total Revenue',
  ROUND(SUM(total_price) * 100 / NULLIF((SELECT SUM(total_price) FROM shawarma_sale),0), 2) 
  AS 'Percentage of total sale'
FROM
  shawarma_sale
GROUP BY
  shawarma_size;
  
  
 --  To find the percentage of sale by shawarma size quarter 1
 SELECT
  shawarma_size,
  ROUND(SUM(total_price)) AS 'Total Revenue',
  ROUND(SUM(total_price) * 100 / NULLIF((SELECT SUM(total_price) FROM shawarma_sale),0), 2) 
  AS 'Percentage of total sale'
FROM
  shawarma_sale
WHERE
quarter(order_date)=1
GROUP BY
  shawarma_size;  -- do the same thing for balance 3 quaters total you should have 4 quarters


-- To find the top 5 best sellings depending upon revenue,total quantity and total orders
SELECT shawarma_name, sum(total_price) AS 'Revenue' FROM shawarma_sale
GROUP BY shawarma_name 
order by Revenue DESC
LIMIT 5;

-- To find the top 5 worst sellings depending upon revenue,total quantity and total orders
SELECT shawarma_name, sum(total_price) AS 'Revenue' FROM shawarma_sale
GROUP BY shawarma_name 
order by Revenue ASC
LIMIT 5;
-- top 5 total quantity
SELECT shawarma_name, sum(quantity) AS 'Total Quantity' FROM shawarma_sale
GROUP BY shawarma_name 
order by 'Total Quantity' ASC -- use DESC to find BEST 5 and use ASC to WORST 5 i used here ASC
LIMIT 5;
-- Top total orders
-- top 5 total quantity
SELECT shawarma_name, COUNT(distinct order_id) AS Total FROM shawarma_sale
GROUP BY shawarma_name 
order by total DESC  -- use DESC to find BEST 5 and use ASC to WORST 5 i used here ASC
LIMIT 5;