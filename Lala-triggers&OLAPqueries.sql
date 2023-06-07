USE lalakidukaan;

-- TRIGGERS

-- to calculate price of product in cart based on discount

CREATE TRIGGER calcPrice_Product_in_Cart
BEFORE INSERT
ON Product_in_Cart
FOR EACH ROW
SET NEW.Price = (SELECT Price FROM Product WHERE Product_ID = NEW.Product_ID) * (1 - (SELECT Discount FROM Product WHERE Product_ID = NEW.Product_ID)/100);

-- to allocate a free agent or an agent with least workload right now

DELIMITER //
CREATE TRIGGER allocAgent
BEFORE INSERT
ON Order_Delivery
FOR EACH ROW
BEGIN
  IF NOT EXISTS(SELECT d.Agent_ID FROM Delivery_Agent d LEFT JOIN Order_Delivery o USING(Agent_ID) WHERE o.Order_ID IS NULL) THEN
    SET NEW.Agent_ID = (SELECT Agent_ID FROM Order_Delivery GROUP BY Agent_ID HAVING MIN(COUNT(Agent_ID)));
  ELSE
	SET NEW.Agent_ID = (SELECT d.Agent_ID FROM Delivery_Agent d LEFT JOIN Order_Delivery o USING(Agent_ID) WHERE o.Order_ID IS NULL
						ORDER BY RAND() LIMIT 1);
  END IF;
END//
DELIMITER ;


-- OLAP QUERIES

-- Purchase from all vendors and total purchase across all vendors last year

SELECT 
IF(GROUPING(Vendor_ID), 'All Vendors', Vendor_ID) AS Vendor_ID,
SUM(Quantity) AS Quantity
FROM
(SELECT Vendor_ID, Quantity, `Date` FROM Purchase_From_Vendor WHERE YEAR(`Date`) = YEAR(DATE_SUB(CURDATE(), INTERVAL 1 YEAR))) AS T
GROUP BY Vendor_ID WITH ROLLUP;

-- Sum of quantity of purchase from all vendors in last year's months and total purchase across all 12 months

SELECT
IF(GROUPING(`Month`), 'All Months', `Month`) AS `Month`,
SUM(Quantity) AS Quantity
FROM
(SELECT Vendor_ID, Quantity, MONTHNAME(`Date`) as `Month` FROM Purchase_From_Vendor WHERE YEAR(`Date`) = YEAR(DATE_SUB(CURDATE(), INTERVAL 1 YEAR))) AS T
GROUP BY `Month` WITH ROLLUP;

-- Purchase from all vendors in last years and total purchase throughout history

SELECT
IF(GROUPING(Vendor_ID), 'All Vendors', Vendor_ID) AS Vendor_ID,
IF(GROUPING(`Year`), 'All Years', `Year`) AS `Year`,
SUM(Quantity) AS Quantity
FROM
(SELECT Vendor_ID, Quantity, YEAR(`Date`) as `Year` FROM Purchase_From_Vendor) AS T
GROUP BY Vendor_ID, `Year` WITH ROLLUP;

-- All customer's purchases in past years in months to see monthly trend

SELECT
IF(GROUPING(Customer_ID), 'All Customers', Customer_ID) AS Customer_ID,
IF(GROUPING(`Month`), 'All Months', `Month`) AS `Month`,
SUM(Price) AS Price
FROM
(SELECT Customer_ID, MONTHNAME(`Date_of_Purchase`) as `Month`, Price FROM History_of_Purchases) AS T
GROUP BY Customer_ID, `Month` WITH ROLLUP;

-- Sales of all products across years and net sales throughout history

SELECT
IF(GROUPING(Product_ID), 'All Products', Product_ID) AS Product_ID,
IF(GROUPING(`Year`), 'All Years', `Year`) AS `Year`,
COUNT(Product_ID) AS Number_of_Sales
FROM
(SELECT Product_ID, YEAR(`Date_of_Purchase`) as `Year` FROM History_of_Purchases) AS T
GROUP BY Product_ID, `Year` WITH ROLLUP;