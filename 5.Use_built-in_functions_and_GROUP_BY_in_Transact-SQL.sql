/*Challenge 1: Retrieve order shipping information
The operations manager wants reports about order shipping based on data 
in the SalesLT.SalesOrderHeader table.*/
/*1.Retrieve the order ID and freight cost of each order.
Write a query to return the order ID for each order, together with the the Freight 
value rounded to two decimal places in a column named FreightCost.*/
SELECT SalesOrderID, 
	   ROUND(Freight,2) as FreigthCost
FROM SalesLT.SalesOrderHeader;

/*2.Add the shipping method.
Extend your query to include a column named ShippingMethod that contains the ShipMethod field, 
formatted in lower case.*/
SELECT SalesOrderID, 
	   ROUND(Freight,2) as FreigthCost,
	   LOWER(ShipMethod) as ShippingMethod
FROM SalesLT.SalesOrderHeader;

/*3.Add shipping date details.
Extend your query to include columns named ShipYear, ShipMonth, and ShipDay that contain 
the year, month, and day of the ShipDate. The ShipMonth value should be displayed as the 
month name (for example, June)*/
SELECT SalesOrderID, 
	   ROUND(Freight,2) AS FreigthCost,
	   LOWER(ShipMethod) AS ShippingMethod,
	   DAY(ShipDate) AS ShipDay,
	   DATENAME(mm,ShipDate) AS ShipMonth,
	   YEAR(ShipDate) AS ShipYear
FROM SalesLT.SalesOrderHeader;

/*Challenge 2: Aggregate product sales
The sales manager would like reports that include aggregated information about product sales.*/

/*1.Retrieve total sales by product
Write a query to retrieve a list of the product names from the SalesLT.Product table and 
the total revenue for each product calculated as the sum of LineTotal from the 
SalesLT.SalesOrderDetail table, with the results sorted in descending order of total revenue.*/
SELECT p.Name,
	   SUM(s.LineTotal) AS TotalRevenue
FROM SalesLT.Product AS p
JOIN SalesLT.SalesOrderDetail AS s ON
p.ProductID = s.ProductID
GROUP BY p.Name
ORDER BY TotalRevenue DESC;
‌‌‌‌‌
/*2.Filter the product sales list to include only products that cost over 1,000
Modify the previous query to include sales totals for products that have a list price of more 
than 1000.*/
SELECT p.Name,
	   SUM(s.LineTotal) AS TotalRevenue
FROM SalesLT.Product AS p
JOIN SalesLT.SalesOrderDetail AS s ON
p.ProductID = s.ProductID
WHERE p.ListPrice > 1000
GROUP BY p.Name
ORDER BY TotalRevenue DESC;

/*3.Filter the product sales groups to include only total sales over 20,000
Modify the previous query to only include only product groups with a total sales value 
greater than 20,000.*/
SELECT p.Name,
	   SUM(s.LineTotal) AS TotalRevenue
FROM SalesLT.Product AS p
JOIN SalesLT.SalesOrderDetail AS s ON
p.ProductID = s.ProductID
WHERE p.ListPrice > 1000
GROUP BY p.Name
HAVING SUM(s.LineTotal) > 20000
ORDER BY TotalRevenue DESC;
