/* 1. Churn Percentage Calculation*/

WITH cte_exitedtotalcount AS (
    SELECT COUNT(*) AS totalcount
    FROM Churn_Modelling cm 
)   

SELECT Exited, COUNT(*) AS countt,
    ROUND(COUNT(*) * 100.0 / (SELECT totalcount FROM cte_exitedtotalcount), 2) AS Exited_Percentage
FROM Churn_Modelling cm 
GROUP BY Exited;

/*Explanation:
- This query calculates the percentage of customers who have exited (churned) versus those who have stayed.
- It first creates a CTE (`cte_exitedtotalcount`) to count the total number of customers.
- Then, it groups the data by `Exited` status and calculates the percentage of each group.



2. Active Membership Percentage*/


SELECT IsActiveMember, COUNT(*) AS countt,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Churn_Modelling cm2), 2) AS PercentageOfIsActiveMember
FROM Churn_Modelling cm
GROUP BY IsActiveMember;

/*Explanation:
- This query calculates the percentage of active vs. inactive members.
- It groups customers by `IsActiveMember` and calculates the proportion of each group relative to the total customer base.



3. Statistical Summary*/


SELECT CreditScore AS CreditScoreAvg FROM Churn_Modelling cm;
SELECT AVG(Age) AS AgeAvg FROM Churn_Modelling cm;
SELECT AVG(Balance) AS BalanceAvg FROM Churn_Modelling cm;

/*Explanation:
- These queries return basic statistical insights:
  - Credit Score values.
  - The average age of customers.
  - The average balance maintained by customers.



4. Customer Distribution by Age Group*/


SELECT
    CASE
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 55 THEN '46-55'
        WHEN Age > 55 THEN '55+'
    END AS Age_Group,
    COUNT(*) AS AgeGroupCount     
FROM Churn_Modelling cm
GROUP BY Age_Group
ORDER BY Age_Group;

/*Explanation:
- This groups customers into different age brackets and counts the number of customers in each group.
- The results help analyze the age distribution of customers.



5. Customer Distribution by Geography*/


SELECT Geography, COUNT(*) AS Geo_Customer_Count
FROM Churn_Modelling cm
GROUP BY Geography
ORDER BY Geo_Customer_Count DESC;

/*Explanation:
- This query calculates the number of customers per geographic region.
- The results show the distribution of customers across different locations.



6. Gender Distribution*/


SELECT Gender, COUNT(*) AS Gender_Count
FROM Churn_Modelling cm
GROUP BY Gender;

/*Explanation:*
- This counts the number of male and female customers.
- The results provide insights into the gender split in the dataset.



7. Average Credit Score by Tenure*/


SELECT Tenure, AVG(CreditScore) AS Avg_CreditScore
FROM Churn_Modelling cm
GROUP BY Tenure
ORDER BY Tenure;

/*Explanation:
- This query calculates the average credit score for customers based on their tenure.
- It helps analyze the relationship between customer tenure and creditworthiness.



8. Product Holding Analysis*/


SELECT NumOfProducts, COUNT(*) AS Customer_Count
FROM Churn_Modelling cm
GROUP BY NumOfProducts
ORDER BY NumOfProducts;

/*Explanation:
- This query counts the number of customers based on the number of products they hold.
- It provides insights into product engagement.



9. Active vs. Inactive Members*/


SELECT IsActiveMember, COUNT(*) AS Customer_Count
FROM Churn_Modelling cm
GROUP BY IsActiveMember;

/*Explanation:
- It counts active and inactive members to analyze customer engagement levels.

10. Churn Rate by Geography*/


SELECT Geography,
    SUM(CASE WHEN Exited = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS Churn_Rate_Percentage
FROM Churn_Modelling cm
GROUP BY Geography
ORDER BY Churn_Rate_Percentage DESC;

/*Explanation:
- This calculates the churn rate (percentage of customers who left) for each geography.
- It helps identify high-churn regions.



11. Churn Rate by Age Group*/


SELECT
    CASE
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 55 THEN '46-55'
        WHEN Age > 55 THEN '55+'
    END AS Age_Group,
    SUM(CASE WHEN Exited = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS Churn_Rate_Percentage
FROM Churn_Modelling cm
GROUP BY Age_Group
ORDER BY Age_Group;

/*Explanation:
- Groups customers by age range and calculates churn rate per group.
- Helps analyze age-related churn trends.



12. Churn Rate by Number of Products*/


SELECT NumOfProducts,
    SUM(CASE WHEN Exited = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS Churn_Rate_Percentage
FROM Churn_Modelling cm
GROUP BY NumOfProducts
ORDER BY NumOfProducts;

/*Explanation:
- This query determines how the number of products held influences churn.
- Helps understand product engagement and customer retention.



13. Average Balance by Geography*/


SELECT Geography, AVG(Balance) AS Avg_Balance
FROM Churn_Modelling cm
GROUP BY Geography
ORDER BY Avg_Balance DESC;

/*Explanation:
- Calculates the average account balance per geographic region.
- Helps understand financial behavior across locations.



14. Average Estimated Salary by Gender*/

SELECT Gender, AVG(EstimatedSalary) AS Avg_EstimatedSalary
FROM Churn_Modelling cm
GROUP BY Gender;

/*Explanation:
- Analyzes salary differences between male and female customers.



15. Credit Card Ownership Analysis*/


SELECT HasCrCard, COUNT(*) AS Customer_Count
FROM Churn_Modelling cm
GROUP BY HasCrCard;

/*Explanation:
- Counts customers based on whether they own a credit card.



16. Churn Rate Among Credit Card Holders*/


SELECT HasCrCard,
    SUM(CASE WHEN Exited = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS Churn_Rate_Percentage
FROM Churn_Modelling cm
GROUP BY HasCrCard;

/*Explanation:
- Determines the churn rate for credit card holders vs. non-holders.
- Helps understand the impact of credit card ownership on customer retention.



These queries provide analytical breakdown of customer churn patterns, demographics, and financial behaviors*/