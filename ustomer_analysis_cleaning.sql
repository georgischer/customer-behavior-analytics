SELECT *
FROM food_data1;

CREATE TABLE food_staging
LIKE food_data1;

INSERT INTO food_staging
SELECT * FROM food_data1;


SELECT *
FROM food_staging;

    
    SELECT `Income`,`Age`,`Customer_Days`,`MntWines`,`MNTMeatProducts`,
ROW_NUMBER() OVER(
                  PARTITION BY `Income`,`Age`,`Customer_Days`,`MntWines`,`MNTMeatProducts`) AS row_num
                  FROM food_staging;
                  

WITH duplicate_cte AS (
					SELECT *,
                    ROW_NUMBER()OVER(
                    PARTITION BY `Income`,`Age`,`Customer_Days`,`MntWines`,`MNTMeatProducts`
                    ORDER BY `Income`
                    ) AS row_num
                    FROM food_staging
                    )
 SELECT *
 FROM duplicate_cte
 WHERE row_num >1;
 
 SHOW CREATE TABLE food_staging;
 
 CREATE TABLE `food_cleaned` (
  `Income` double DEFAULT NULL,
  `Kidhome` int DEFAULT NULL,
  `Teenhome` int DEFAULT NULL,
  `Recency` int DEFAULT NULL,
  `MntWines` int DEFAULT NULL,
  `MntFruits` int DEFAULT NULL,
  `MntMeatProducts` int DEFAULT NULL,
  `MntFishProducts` int DEFAULT NULL,
  `MntSweetProducts` int DEFAULT NULL,
  `MntGoldProds` int DEFAULT NULL,
  `NumDealsPurchases` int DEFAULT NULL,
  `NumWebPurchases` int DEFAULT NULL,
  `NumCatalogPurchases` int DEFAULT NULL,
  `NumStorePurchases` int DEFAULT NULL,
  `NumWebVisitsMonth` int DEFAULT NULL,
  `AcceptedCmp3` int DEFAULT NULL,
  `AcceptedCmp4` int DEFAULT NULL,
  `AcceptedCmp5` int DEFAULT NULL,
  `AcceptedCmp1` int DEFAULT NULL,
  `AcceptedCmp2` int DEFAULT NULL,
  `Complain` int DEFAULT NULL,
  `Z_CostContact` int DEFAULT NULL,
  `Z_Revenue` int DEFAULT NULL,
  `Response` int DEFAULT NULL,
  `Age` int DEFAULT NULL,
  `Customer_Days` int DEFAULT NULL,
  `marital_Divorced` int DEFAULT NULL,
  `marital_Married` int DEFAULT NULL,
  `marital_Single` int DEFAULT NULL,
  `marital_Together` int DEFAULT NULL,
  `marital_Widow` int DEFAULT NULL,
  `education_2n Cycle` int DEFAULT NULL,
  `education_Basic` int DEFAULT NULL,
  `education_Graduation` int DEFAULT NULL,
  `education_Master` int DEFAULT NULL,
  `education_PhD` int DEFAULT NULL,
  `MntTotal` int DEFAULT NULL,
  `MntRegularProds` int DEFAULT NULL,
  `AcceptedCmpOverall` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM food_cleaned;

INSERT INTO food_cleaned
SELECT *,
ROW_NUMBER() OVER(
                  PARTITION BY `Income`,`Age`,`Customer_Days`,`MntWines`,`MNTMeatProducts`) AS row_num
                  FROM food_staging;

SELECT * 
FROM food_cleaned;

DELETE
FROM food_cleaned
WHERE row_num >1;

SELECT * 
FROM food_cleaned;

SELECT * 
FROM food_cleaned 
WHERE Income IS NULL;

UPDATE food_cleaned
SET Income = COALESCE(Income, 0)
WHERE Income IS NULL;

ALTER TABLE food_cleaned
ADD COLUMN Total_Children INT,
ADD COLUMN Total_Spending DOUBLE;

SELECT *
FROM food_cleaned;

UPDATE food_cleaned
SET Total_Children = Kidhome + Teenhome,
    Total_Spending = MntWines + MntFruits + MntMeatProducts + MntFishProducts + MntSweetProducts + MntGoldProds;
    
    SELECT *
    FROM food_cleaned;
    
    CREATE TABLE food_final AS
SELECT 
    Income, 
    Age, 
    Total_Children, 
    Total_Spending,
    Recency,
    Response,
    CASE 
        WHEN marital_Divorced = 1 THEN 'Divorced'
        WHEN marital_Married = 1 THEN 'Married'
        WHEN marital_Single = 1 THEN 'Single'
        WHEN marital_Together = 1 THEN 'Together'
        WHEN marital_Widow = 1 THEN 'Widow'
        ELSE 'Other'
    END AS Marital_Status,
    CASE 
        WHEN `education_2n Cycle` = 1 THEN '2n Cycle'
        WHEN education_Basic = 1 THEN 'Basic'
        WHEN education_Graduation = 1 THEN 'Graduation'
        WHEN education_Master = 1 THEN 'Master'
        WHEN education_PhD = 1 THEN 'PhD'
        ELSE 'Other'
    END AS Education_Level,
    NumWebPurchases, 
    NumStorePurchases, 
    NumWebVisitsMonth
FROM food_cleaned;

SELECT * FROM food_final;

ALTER TABLE food_final ADD COLUMN Age_GROUP VARCHAR(20);
SELECT * FROM food_final;

UPDATE food_final
SET Age_Group = CASE 
    WHEN Age < 35 THEN 'Young (Under 35)'
    WHEN Age BETWEEN 35 AND 55 THEN 'Middle-Aged (35-55)'
    WHEN Age > 55 THEN 'Senior (55+)'
END;

SELECT * FROM food_final;

ALTER TABLE food_final ADD COLUMN Spending_Income_Ratio DECIMAL(10,2);

UPDATE food_final
SET Spending_Income_Ratio = (Total_Spending / NULLIF(Income, 0)) * 100;

SELECT *
FROM food_final;




