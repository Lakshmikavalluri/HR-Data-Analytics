CREATE DATABASE HR_Analytics;
USE HR_Analytics;

USE hr_analytics;

SELECT *
FROM `hr merged sheet`
LIMIT 10;

SELECT COUNT(*) AS Total_Employees
FROM `hr merged sheet`;

DESCRIBE `hr merged sheet`;

-- 1) Average Attrition Rate for all Departments
SELECT
    AVG(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) * 100 AS Average_Attrition_Rate
FROM `hr merged sheet`;


-- 2) Average Hourly Rate of Male Research Scientist
SELECT 
    AVG(HourlyRate) AS Average_Hourly_Rate
FROM `hr merged sheet`
WHERE Gender = 'Male'
  AND JobRole = 'Research Scientist';
  
-- 3) Attrition Rate vs Monthly Income Status

SELECT
    CASE
        WHEN MonthlyIncome BETWEEN 0 AND 10000 THEN '0-10,000'
        WHEN MonthlyIncome BETWEEN 10001 AND 20000 THEN '10,001-20,000'
        WHEN MonthlyIncome BETWEEN 20001 AND 30000 THEN '20,001-30,000'
        WHEN MonthlyIncome BETWEEN 30001 AND 40000 THEN '30,001-40,000'
        WHEN MonthlyIncome >= 40001 THEN '40,001+'
    END AS Income_Range,

    AVG(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) * 100 AS Attrition_Rate

FROM `hr merged sheet`

GROUP BY
    CASE
        WHEN MonthlyIncome BETWEEN 0 AND 10000 THEN '0-10,000'
        WHEN MonthlyIncome BETWEEN 10001 AND 20000 THEN '10,001-20,000'
        WHEN MonthlyIncome BETWEEN 20001 AND 30000 THEN '20,001-30,000'
        WHEN MonthlyIncome BETWEEN 30001 AND 40000 THEN '30,001-40,000'
        WHEN MonthlyIncome >= 40001 THEN '40,001+'
    END;
 -- 4) Average Working Years for Each Department
 SELECT
    Department,
    AVG(TotalWorkingYears) AS Avg_Working_Years
FROM `hr merged sheet`
GROUP BY Department
ORDER BY Avg_Working_Years DESC;

-- 5) Job Role vs Work-Life Balance 
SELECT
    JobRole,
    AVG(WorkLifeBalance) AS Avg_WorkLife_Balance
FROM `hr merged sheet`
GROUP BY JobRole
ORDER BY Avg_WorkLife_Balance DESC;

-- 6) Attrition Rate vs Years Since Last Promotion
SELECT
    YearsSinceLastPromotion,
    AVG(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) * 100 AS Attrition_Rate
FROM `hr merged sheet`
GROUP BY YearsSinceLastPromotion
ORDER BY YearsSinceLastPromotion;

