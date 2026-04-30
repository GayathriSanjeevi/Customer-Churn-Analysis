CREATE DATABASE CHURN_ANALYSIS

USE CHURN_ANALYSIS

/* Display top 10 rows */

SELECT TOP 10* FROM [Customer-Churn]

/*Checking total rows */

SELECT COUNT(*) AS TOTAL_ROWS FROM [Customer-Churn]

/* Checking Column names and Datatype*/ 

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='Customer-Churn'

/* Checking Total CHurned Customers */

SELECT COUNT(*) AS TOTAL_CHURNED_CUSTOMERS
FROM [Customer-Churn]
WHERE CHURN=1

/* 1869 CUSTOMERS CHURNED*/

/*CHURN RATE */
SELECT 
    ROUND(100.0 * SUM(CAST(Churn AS INT)) / COUNT(*),2) AS churn_rate
FROM [Customer-Churn];

/*Churn Rate is 26.54*/

/* Checking for Missing Values */

SELECT COUNT(*) AS NULL_TOTALCHARGES
FROM [Customer-Churn]
WHERE TotalCharges IS NULL

SELECT COUNT(*) AS BLANK_TOTALCHARGES
FROM [Customer-Churn]
WHERE TotalCharges = ''

/* Churn Distribution */

SELECT Churn, COUNT (*) AS Count FROM [Customer-Churn]
GROUP BY Churn 

/* Understanding each Column */

SELECT DISTINCT Churn, Contract,Count(*) as Total_Count
from [Customer-Churn]
/*where churn=1 */
GROUP BY Churn, Contract

/* CHURN RATE BY CONTRACT */

SELECT 
    Contract,
    COUNT(*) AS Churn_count
FROM [Customer-Churn]
where churn=1
GROUP BY Contract
ORDER BY CHURN_COUNT DESC

SELECT Contract,
Count(*) as total, 
SUM(CAST(churn AS INT)) AS churned,
ROUND(100*SUM(CAST(CHURN AS INT))/COUNT(*),2) AS CHURN_RATE
from [Customer-Churn]
GROUP BY Contract
ORDER BY CHURNED DESC

/* Customers in month-month contract had higher churn rate of 42% */

/*CHURN RATE BY PAYMENT METHOD */

SELECT PaymentMethod,
Count(*) as total, 
SUM(CAST(churn AS INT)) AS churned,
ROUND(100*SUM(CAST(CHURN AS INT))/COUNT(*),2) AS CHURN_RATE
from [Customer-Churn]
GROUP BY PaymentMethod
ORDER BY CHURNED DESC

/* CHURN RATE BY INTERNET SERVICE */

SELECT InternetService,	
COUNT(*) AS TOTAL,
SUM(CAST(CHURN AS INT)) AS CHURNED,
ROUND(100*(SUM(CAST(CHURN AS INT)))/COUNT(*), 2) AS CHURN_RATE
from [Customer-Churn]
GROUP BY InternetService
ORDER BY CHURN_RATE DESC

/* customers with fiber optic internet service had higher chances of leaving */ 

/* CHURN BY TENURE */

SELECT AVG(TENURE) AS AVERAGE_TENURE, MAX(TENURE) AS MAXIMUM_TENURE,MIN(TENURE) AS MINIMUM_TENURE  
FROM [Customer-Churn]

/* TENURE GROUP */

ALTER TABLE [Customer-Churn]
ADD TENURE_GROUP VARCHAR(20)

UPDATE [Customer-Churn]
SET TENURE_GROUP =
    CASE 
        WHEN tenure <= 12 THEN '0-12'
        WHEN tenure <= 24 THEN '12-24'
        ELSE '24+'
    END 

SELECT * FROM [Customer-Churn]

/*CHURN RATE BY TENURE GROUP */

SELECT TENURE_GROUP,
COUNT(*) AS TOTAL,
SUM(CAST(CHURN AS INT)) AS CHURNED,
ROUND(100* SUM(CAST(CHURN AS INT))/COUNT(*),2) AS CHURN_RATE
FROM [Customer-Churn]
GROUP BY TENURE_GROUP
ORDER BY CHURN_RATE DESC

SELECT TOP 5
    Contract,
    PaymentMethod,
    COUNT(*) AS total,
    SUM(CAST(churn AS INT)) AS churned,
    ROUND(100.0 * SUM(CAST(churn AS INT)) / COUNT(*), 2) AS churn_rate
FROM [Customer-Churn]
GROUP BY Contract, PaymentMethod
ORDER BY churn_rate DESC;

/* INSIGHTS */

/* Customers involved in month to month contract with fiber optic internet service and Electronic payment method had higher chances of churn*/






//