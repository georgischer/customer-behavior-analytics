# customer-behavior-analytics
End-to-end data analytics project using SQL for data cleaning/transformation and Power BI for interactive visualization.

Customer Behavior & Marketing Campaign Analytics
Data Preparation (SQL): Established a staging environment, removed duplicates using ROW_NUMBER(), and handled NULL values in the Income column to ensure data integrity.
Data Transformation: Unified categorical data (Education, Marital Status) from one-hot encoded columns into readable formats using CASE statements.
Feature Engineering: Calculated key performance indicators such as Total_Spending and Total_Children directly in SQL.
Visualization (Power BI): Developed an interactive dashboard featuring DAX measures (Response Rate, Total Customers). Performed correlation analysis via Scatter Charts to visualize the relationship between Income and Spending.
