DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS OrderDetails;

-- Customer's table 

CREATE TABLE Customers (
     "Customer ID" INT PRIMARY KEY,
     Country VARCHAR(50)
);
INSERT INTO Customers ( "Customer ID",Country)
SELECT  "Customer ID",Country
FROM clean_retail
WHERE "Customer ID" IS NOT NULL
GROUP BY "Customer ID"
;
-- Products table 
CREATE TABLE Products (
     StockCode VARCHAR(20) PRIMARY KEY,
     Description TEXT,
     Price REAL
);

INSERT INTO Products ( StockCode,Description,Price)
SELECT StockCode,Description,Price
FROM clean_retail
GROUP BY StockCode;

-- ORDER table 
CREATE TABLE Orders (
       Invoice VARCHAR(20),
       StockCode VARCHAR(20),
       Quantity INT,
       
       PRIMARY KEY(Invoice,StockCode)
);


INSERT INTO Orders ( Invoice,StockCode,Quantity)
SELECT Invoice,StockCode,SUM(Quantity)
FROM clean_retail
GROUP BY Invoice,StockCode;


-- ORDER DETAIL
CREATE TABLE OrderDetails( 
       "Customer ID" INT,
       Invoice VARCHAR(20),
       StockCode VARCHAR(20),
       InvoiceDate DATE TIME,
       Quantity INT,

       PRIMARY KEY(Invoice,StockCode)
);

INSERT INTO OrderDetails( "Customer ID", Invoice,StockCode, InvoiceDAte,Quantity)
SELECT "Customer ID",Invoice,StockCode,InvoiceDate,SUM(Quantity) 
FROM clean_retail
GROUP BY  Invoice, StockCode
;
