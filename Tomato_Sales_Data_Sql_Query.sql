
---Analysis of Tomato Retail Sales Data in Nigeria (2009-2022)----

--Checking All Table in Database
Select
*
FROM [Tomato_Retail_Data].[dbo].[Tomato_Retail_Data];

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









