DROP INDEX IF EXISTS idx_customer;

 -- cleaning the source data
SELECT
   ROUND(SUM(CASE
        WHEN "Customer ID"  IS NULL
        THEN total_price
        ELSE 0
      END) * 1.0 / SUM(total_price),2) AS unknown_share
FROM clean_retail;

.mode csv
-- TOP 10 product by revenue 

.output top_product.csv

SELECT Description,ROUND(SUM(total_price)) AS revenue
FROM clean_retail
WHERE Description NOT IN ('Manual','POSTAGE','DOTCOM POSTAGE')
GROUP BY Description
ORDER BY  revenue DESC
LIMIT 10;



-- Revenue by Country

.output revenue_country.csv
 
SELECT Country, ROUND(SUM(total_price)) AS revenue
FROM clean_retail
GROUP BY Country
ORDER BY revenue DESC
limit 5 ;

--Which product sells the most ?
.output most_sold_product.csv
 
SELECT
    Products.Description,
    SUM(OrderDetails.Quantity) AS total_sold
FROM OrderDetails
JOIN Products
ON OrderDetails.StockCode = Products.StockCode
GROUP BY Products.Description
ORDER BY total_sold DESC
LIMIT 10;

--Which Customer Bought most items
.output customer_report_quantity.csv
SELECT
     Customers."Customer ID",
     SUM(OrderDetails.Quantity) AS total_sold
FROM OrderDetails
JOIN Customers
ON OrderDetails."Customer ID" =  Customers."Customer ID"
GROUP BY Customers."Customer ID"
ORDER BY total_sold DESC
LIMIT 10;



-- which  customer gnererated the highest revenue
.output customer_report_revenue.csv
SELECT
      OrderDetails."Customer ID",
      ROUND(SUM(Products.Price * OrderDetails.Quantity)) AS total_revenue
FROM OrderDetails
JOIN Products
ON OrderDetails.StockCode = Products.StockCode
WHERE OrderDetails."Customer ID" IS NOT NULL
GROUP BY  OrderDetails."Customer ID"
ORDER BY total_revenue DESC
LIMIT 10;



--Which products generate highest revenue?
.output product_revenue.csv 
SELECT
     Products.Description,
     ROUND(SUM(Products.Price * Orders.Quantity)) AS total_revenue,
     SUM(Orders.Quantity) AS total_quantity,
     Products.Price
FROM Products
JOIN Orders
ON   Products.StockCode = Orders.StockCode
WHERE Description NOT IN ('Manual','POSTAGE','DOTCOM POSTAGE')
GROUP BY Products.Description
ORDER BY  total_revenue DESC
LIMIT 5;

-- Monthly revenue chart
.output monthly_revenue.csv
SELECT 
   strftime('%Y-%m',OrderDetails.InvoiceDate) AS month,
   ROUND(SUM(Products.price * OrderDetails.Quantity)) AS total_revenue
FROM OrderDetails
JOIN Products
ON  OrderDetails.StockCode = Products.Stockcode
GROUP BY month
ORDER BY month;



.output stdout
.mode column
.headers on 
-- Indexing 
CREATE INDEX IF NOT EXISTS 
idx_customer
ON OrderDetails("Customer ID");

CREATE INDEX IF NOT EXISTS
idx_customers_customer
ON  Customers("Customer ID");
