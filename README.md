# Customer Behavior & Marketing Analytics 📊

## Project Overview
This project presents an end-to-end data analytics solution, focusing on customer spending patterns and marketing campaign effectiveness. By leveraging SQL for robust data processing and Power BI for advanced visualization, I transformed raw data into actionable business insights.

## Technical Workflow
- **Data Preparation (SQL):** Developed a staging environment to preserve raw data. Performed rigorous cleaning, including duplicate removal using `ROW_NUMBER()` and handling missing values (NULLs).
- **Data Transformation:** Unified categorical variables (Education, Marital Status) from one-hot encoded formats into readable attributes using complex `CASE` statements.
- **Feature Engineering:** Calculated key business metrics such as `Total_Spending` and `Total_Children` directly within the database layer to optimize report performance.
- **Data Visualization (Power BI):** Designed an interactive dashboard utilizing DAX measures for KPIs like Response Rate (15.15%) and Average Spend.

## Key Insights
- **Income Correlation:** A strong positive correlation was identified between household income and total spending, visualized through a scatter plot.
- **Demographic Analysis:** Customers with higher education levels (Graduation/PhD) represent the highest spending segment.
- **Campaign Performance:** The marketing campaign achieved a significant conversion rate of 15.15%.

## Preview
<img src="Screenshot 2026-06-28 212936.png" width="100%">
