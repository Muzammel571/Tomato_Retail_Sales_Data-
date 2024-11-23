**Tomato Retail Sales Data in Nigeria**

****Project Over View****
a)This project showcases my data analysis skills using a dataset sourced from Kaggle, focused on tomato sales and pricing trends in Nigeria.
b)Writing SQL queries to address key analytical questions and uncover actionable insights.
c)Summarizing findings through a detailed presentation to highlight trends, patterns, and data-driven conclusions.

****Dataset****
i.Source:** https://www.kaggle.com/datasets/bonifacechosen/tomato-retail-sales-data-2009-2022
ii)Description: 
a)This dataset captures 13 years of tomato sales and pricing data in Nigeria, providing valuable insights into agricultural market dynamics. 
b)It reflects regional price fluctuations, consumer demand trends, and the impact of seasonal changes (rainy and dry seasons) on produce availability.
c)The dataset is a critical resource for analyzing food security, market forecasting, and localized agricultural trends in Nigeria.

****Objectives*****
The primary objective of this project is to analyze 13 years of tomato sales and pricing data
In Nigeria to uncover retail segments . 
**Analyze Sales Trend**s: Identify annual sales growth or decline, maximum and minimum sales years, and year-on-year changes in quantity sold.
**Seasonal and Supplier** Insights: Group data by seasons to explore trends and examine each supplier’s contributions to sales and restocking patterns.
**Performance Analysis**: Highlight top-performing store locations and investigate the impact of transport costs on pricing and sales.
**Pricing and Stock Dynamics**: Study unit price fluctuations and compare opening versus closing stock levels over the years.

**Project Structure**
I). The dataset, originally downloaded from Kaggle in CSV format, has been uploaded to the database as Tomato_Retail_Data for analysis.

II)**Data Analysis And Finding**

**Annual Sales Trends**:
i.Calculated total sales per year to identify growth or decline trends.
ii.Identified the years with maximum and minimum total sales values.

**Quantity and Stock Analysis:**
i.Analyzed year-on-year changes in quantity sold (kg)
ii.Compared opening and closing stock levels to observe trends over the years.

**Supplier and Seasonal Insights**
i.Examined each supplier's annual sales, units sold, and contributions to overall performance
ii.Grouped sales and quantity data by seasons to determine seasonal effects on supply and demand.

**Price Fluctuations and Costs:****
i.Analyzed year-on-year unit price trends and calculated annual changes to highlight fluctuations
ii.Investigated how transport costs impacted product pricing and total sales value.

**Store Performance**:
i.Identified the top 10 performing store locations based on sales, quantity sold, and units sold year-on-year.

**Restocking Patterns:**
i.Examined total restocked quantities and their variations across seasons, tracking year-on-year changes.

**The following SQL queries were developed to answer specific business questions:**

--1.Calculate total sales per year and identify growth or decline trends.
SELECT 
DATEPART(YEAR, Date) AS Year_on_Year,
FORMAT(SUM(Total_Sales_Value_NGN), 'N0', 'en-US') AS Total_Sales,
SUM(Total_Sales_Value_NGN) - LAG(SUM(Total_Sales_Value_NGN)) OVER (ORDER BY DATEPART(YEAR, Date)) AS Year_on_Year_Change,
CASE 
WHEN SUM(Total_Sales_Value_NGN) - LAG(SUM(Total_Sales_Value_NGN)) OVER (ORDER BY DATEPART(YEAR, Date)) > 0 THEN 'Growth'
WHEN SUM(Total_Sales_Value_NGN) - LAG(SUM(Total_Sales_Value_NGN)) OVER (ORDER BY DATEPART(YEAR, Date)) < 0 THEN 'Decline'
ELSE 'No Change'
END AS Trend
FROM [Tomato_Retail_Data].[dbo].[Tomato_Retail_Data]
GROUP BY DATEPART(YEAR, Date)
ORDER BY Year_on_Year;

--2.Find the year with the maximum total sales value. 
Select
Top 1
DATEPART(YEAR,Date) AS Year,
FORMAT (MAX (Total_Sales_Value_NGN),'N0','en-US') As Maximum_Sales
FROM [Tomato_Retail_Data].[dbo].[Tomato_Retail_Data]
GROUP By DATEPART(YEAR,Date)
ORDER by Year Desc ;

--3.Find the quantity sold (kg) year on year and identify changes.
SELECT 
    DATEPART(YEAR, Date) AS Year,
    FORMAT(SUM(Quantity_Sold_kg), 'N0', 'en-US') AS Total_Quantity,
    SUM(Quantity_Sold_kg) - LAG(SUM(Quantity_Sold_kg)) OVER (ORDER BY DATEPART(YEAR, Date)) AS Year_On_Year_Change
FROM [Tomato_Retail_Data].[dbo].[Tomato_Retail_Data]
GROUP BY DATEPART(YEAR, Date)
ORDER BY Year;

--4. Compare opening vs closing stock levels over the years to see trends. 
SELECT 
DATEPART(YEAR, Date) AS Year_on_Year,
SUM(Opening_Stock_kg) AS Opening_Stock,
SUM(Closing_Stock_kg) AS Closing_Stock,
SUM(Opening_Stock_kg) - LAG(SUM(Closing_Stock_kg)) OVER (ORDER BY DATEPART(YEAR, Date)) AS Year_On_Year_Change
FROM [Tomato_Retail_Data].[dbo].[Tomato_Retail_Data]
GROUP BY DATEPART(YEAR, Date)
ORDER BY Year_on_Year;

--5.Find the year with the minimum total sales value.
Select
Top 1
DATEPART (YEAR,Date) AS Years,
MIN(Total_Sales_Value_NGN) As Minimum_Total_Sale
FROM [Tomato_Retail_Data].[dbo].[Tomato_Retail_Data] 
GROUP by DATEPART (YEAR,Date);

--6.Analyse how each supplier's total sales,units sold vary each year,

SELECT
Supplier_Name,
FORMAT (SUM(Total_Sales_Value_NGN),'N0','en-US') AS Total_Sales,
AVG(Unit_Price_NGN) AS Average_Unit_Price
FROM [Tomato_Retail_Data].[dbo].[Tomato_Retail_Data]
GROUP BY Supplier_Name
ORDER BY Total_Sales Desc;

--7. Group sales and quantity data by season to analyze if certain seasons 
--(e.g., rainy or dry) have significant effects on retail sales
SELECT
Season,
FORMAT (SUM(Total_Sales_Value_NGN),'N0','en-US') AS Total_Sales,
Sum(Unit_Price_NGN) AS Total_Unit_Price
FROM [Tomato_Retail_Data].[dbo].[Tomato_Retail_Data] 
GROUP by Season 
ORDER by Total_Sales,Total_Unit_Price Desc;


--8.Analyze the year-on-year trend of unit prices, calculating the annual change to highlight fluctuations over time.
SELECT 
DATEPART(YEAR, Date) AS Year,
AVG(Unit_Price_NGN) AS Average_Unit_Price,
AVG(Unit_Price_NGN) - LAG(AVG(Unit_Price_NGN)) OVER (ORDER BY DATEPART(YEAR, Date)) AS Yearly_Change
FROM [Tomato_Retail_Data].[dbo].[Tomato_Retail_Data]
GROUP BY DATEPART(YEAR, Date)
ORDER BY Year;

--9.Analyze the total restocked quantities,how they vary across different seasons and track the year-on-year changes.
Select
DATEPART (YEAR,Date) As Years,
Season,
SUM (Restocked_Quantity_kg) AS Total_Restocked
FROM [Tomato_Retail_Data].[dbo].[Tomato_Retail_Data]
Group by DATEPART (YEAR,Date),Season
ORDER by Years Asc, Total_Restocked Desc;

--10.Measure each supplier’s contribution to the overall sales value or quantity sold.
SELECT
Supplier_Name,
SUM (Total_Sales_Value_NGN) AS Total_Sales,
SUM (quantity_Sold_kg) AS Total_quantity
FROM [Tomato_Retail_Data].[dbo].[Tomato_Retail_Data]
GROUP by Supplier_Name 
ORDER by Total_Sales,Total_quantity DESC;

--11.Identify the top 10 performing store locations year-on-year based on sales, quantity sold, and units sold.
Select
Top 10
DATEPART (YEAR,Date) AS Years,
Store_Location,
SUM (Unit_Price_NGN) AS Total_units,
SUM (quantity_Sold_kg) AS Total_quantity,
SUM (Total_Sales_Value_NGN) AS Total_Sales
FROM [Tomato_Retail_Data].[dbo].[Tomato_Retail_Data]
GROUP by Store_Location,DATEPART (YEAR,Date)
ORDER by Total_Sales,Total_quantity,Total_units ASC;

--12.Investigate how changes in transport costs affect product pricing and overall sales value.
Select
Transport_Cost_NGN,
AVG (Unit_Price_NGN) AS Total_Product,
SUM (Total_Sales_Value_NGN) AS Total_Sales
FROM [Tomato_Retail_Data].[dbo].[Tomato_Retail_Data]
GROUP by  Transport_Cost_NGN
ORDER by  Transport_Cost_NGN Desc;

**Conclusion**
The analysis of tomato sales and pricing data providing insights into agricultural market dynamics in Nigeria. Here's a summary of the key findings:

****Annual Trends:**
i.Total sales and quantities sold varied year-on-year, with clear trends of growth or decline identified across the years.
ii.Specific years stood out with maximum or minimum sales, reflecting external influences like weather or economic conditions.

**Stock and Seasonal Insights:****
i.Opening and closing stock levels showed notable trends, helping track inventory dynamics.
ii.Seasonal analysis revealed how rainy and dry seasons impacted sales, quantities, and restocking patterns.

**Supplier Contributions:**
i.Analysis of supplier data highlighted variations in total sales, units sold, and their contributions to overall performance.

**Price Fluctuations and Costs:**
i.Year-on-year analysis of unit prices exposed fluctuations and potential pricing patterns over time.
ii.Transport costs were shown to influence product pricing and total sales, underscoring the importance of logistical expenses.

**Store Performance:**
i.The top 10 store locations based on sales and units sold were identified, demonstrating regional performance differences.
ii.Through SQL queries, this analysis effectively highlights key trends and patterns in the tomato market, offering valuable insights for decision-making, forecasting, and further research.




