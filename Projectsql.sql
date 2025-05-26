---------------------------------------
/*1. Customer Segmentation & Spending Behavior
1) Who are the highest spending customers?*/
SELECT TOP(10)
ID,
       (MntWines + MntFruits + MntMeatProducts + MntFishProducts + MntSweetProducts + MntGoldProds) AS TotalSpend
FROM [The NewData]
ORDER BY TotalSpend DESC
-- 2)  Segment customers into segments (quartiles) based on Spending
SELECT 
  ID, 
  TotalSpend,
  NTILE(3) OVER (ORDER BY TotalSpend DESC) AS SpendQuartile
FROM [The NewData]
-- 3) How does spending vary by education and marital status?
SELECT Education, Marital_Status,
       AVG(MntWines + MntFruits + MntMeatProducts + MntFishProducts + MntSweetProducts + MntGoldProds) AS AvgSpend
FROM [The NewData]
GROUP BY Education, Marital_Status 
ORDER BY AvgSpend DESC

--4)What is the average spending for each RFM engagement segment?
SELECT Customer_Activity,
       AVG(MntWines + MntFruits + MntMeatProducts + MntFishProducts + MntSweetProducts + MntGoldProds) AS AvgSpend
FROM [The NewData]
GROUP BY Customer_Activity

-- 5) How does the number of children/teenagers affect spending?
SELECT Kidhome, Teenhome,
       AVG(MntWines + MntFruits + MntMeatProducts + MntFishProducts + MntSweetProducts + MntGoldProds) AS AvgSpend
FROM [The NewData]
GROUP BY Kidhome, Teenhome

-- 6) To rank customers by spending
SELECT 
  ID, 
  TotalSpend,
  DENSE_RANK() OVER (ORDER BY TotalSpend DESC) AS SpendRank
FROM [The NewData]

-- 7) spending based on Age_Group
SELECT Age_Group , AVG(MntWines + MntFruits + MntMeatProducts + MntFishProducts + MntSweetProducts + MntGoldProds) AS AvgSpend
FROM [The NewData]
GROUP BY Age_Group 
Order BY AvgSpend DESC
--------------------------------------------------------------------------------------------
/* 2. Marketing Campaigns & Promotion Effectiveness
1) What is the response rate to each campaign?*/ 
SELECT 
  AVG(CAST(AcceptedCmp1 AS FLOAT)) AS Campaign1,
  AVG(CAST(AcceptedCmp2 AS FLOAT)) AS Campaign2,
  AVG(CAST(AcceptedCmp3 AS FLOAT)) AS Campaign3,
  AVG(CAST(AcceptedCmp4 AS FLOAT)) AS Campaign4,
  AVG(CAST(AcceptedCmp5 AS FLOAT)) AS Campaign5,
  AVG(CAST(Response AS FLOAT)) AS LastCampaign
FROM [The NewData]

-- 2) Do customers who recently purchased respond better to campaigns?
SELECT  Customer_Activity
 ,
   AVG(CAST(Response AS FLOAT)) AS ResponseRate
FROM [The NewData]
GROUP BY Customer_Activity

-------------------------------------------------------------------------------------------------
/* 3. Channel Preferences & Usage Patterns
1) Which channels (Web, Store, Catalog) are preferred?*/ 
SELECT 
  AVG(CAST(NumWebPurchases AS FLOAT)) AS AvgWeb ,
  AVG(CAST(NumCatalogPurchases AS FLOAT)) AS AvgCatalog,
  AVG(CAST(NumStorePurchases AS FLOAT)) AS AvgStore
FROM [The NewData]

-- 2) How many customers use multiple channels?
SELECT 
  COUNT(*) AS TotalCustomers,
  SUM(CASE 
        WHEN NumWebPurchases > 0 AND NumCatalogPurchases > 0 AND NumStorePurchases > 0 
        THEN 1 ELSE 0 
      END) AS MultiChannelUsers
FROM [The NewData]
------------------------------------------------------------------------------------------------------
/* 4. Complaints, Satisfaction, and Loyalty
1) Are high-spending customers also more likely to complain?*/ 
SELECT Complain,
       AVG(MntWines + MntFruits + MntMeatProducts + MntFishProducts + MntSweetProducts + MntGoldProds) AS AvgSpend
FROM [The NewData]
GROUP BY Complain

-- 2) Do customers who complain show less loyalty?
SELECT Complain,
       AVG(Recency) AS AvgRecency,
       AVG(CAST(Response AS FLOAT)) AS AvgCampaignResponse
FROM [The NewData]
GROUP BY Complain

----------------------------------------------------------------------------------------------------------
/* 5. Churn Risk & Retention Insight
1) Which customers are at risk of churning (based on Recency)?*/

SELECT ID, Recency
FROM [The NewData]
WHERE Recency > 80
ORDER BY Recency DESC

-- 2) Which customers are the most loyal based on RFM?

SELECT ID, Customer_Activity
FROM [The NewData]
WHERE Customer_Activity = 'Very Active'

------------------------------------------------------------------------------------------------------------
-- THE END






