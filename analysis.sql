
## total revenue share of unknown category id

SELECT
   ROUND(SUM(CASE
        WHEN "Customer ID"  IS NULL
         THEN total_price
        ELSE 0
      END) * 1.0 / SUM(total_price),2) AS unknown_share
FROM clean_retail;
   
## TOP 10 product by revenue 
SELECT Description,ROUND(SUM(total_price)) AS revenue
FROM clean_retail
WHERE Description NOT IN ('Manual','POSTAGE','DOTCOM POSTAGE')
GROUP BY Description
ORDER BY  revenue DESC
LIMIT 10;


## Revenue by Country 
SELECT Country,ROUND(SUM(total_price)) AS revenue
FROM clean_retail
GROUP BY Country
ORDER BY revenue DESC
;

## Top Revenue per customer
SELECT "Customer ID", ROUND(SUM(total_price)) AS revenue
FROM clean_retail
WHERE "Customer ID" IS NOT NULL
GROUP BY "Customer ID"
ORDER BY revenue DESC
LIMIT 10;
