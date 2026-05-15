create database mainproject;
use mainproject;
show tables;

select * from custdata;
rename table customer_data to custdata;

select round(sum(Purchase_Amount_USD),2) as Total_Revenue from custdata;
select count(Customer_id) as No_of_Customers from custdata;

## 1. Which category generates highest revenue? 
## ----------------Category Analysis $$ Highest Revenue Category-----------------------------------------------------------------.
select Category, round(sum(Purchase_Amount_USD)) as Highest_Revenue from custdata group by Category order by Highest_Revenue desc;

## 2. Which age group purchases more? ##
## --------------------------------------Age Group Analysis --------------------------------------------------------------- ##
select
case
	when Age between 18 and 25 then '18 - 25'
	when Age between 26 and 35 then '26 - 35'
	when Age between 36 and 45 then '36 - 45'
	when Age between 46 and 55 then '46 - 55'
	when Age between 56 and 65 then '56 - 65'
	else'65+'
end as Age_Group,
round(sum(Purchase_Amount_USD)) as Total_Sales from custdata group by
case
	when Age between 18 and 25 then '18 - 25'
	when Age between 26 and 35 then '26 - 35'
	when Age between 36 and 45 then '36 - 45'
	when Age between 46 and 55 then '46 - 55'
	when Age between 56 and 65 then '56 - 65'
	else'65+'
end
order by Total_Sales Desc;

## 3. Does discount increase sales? ------- Discount Analysis Does Discount Affect Sales? -------------------------------
select Discount_Applied, round(sum(Purchase_Amount_USD)) as sales from custdata group by Discount_Applied order by Sales desc;

## 4. Which payment method is mostly used?-------------- Payment Method Analysis Most Used Payment Method -----------------
select Payment_Method, count(Payment_Method) Most_Payment from custdata  group by Payment_Method order by Most_Payment desc;

## 5. Which season has highest sales?----- Seasonal Analysis Which Season Has Highest Sales? --------------------------------------
select Season, Round(sum(Purchase_Amount_USD))as Highest_Sales from custdata group by Season order by Highest_Sales desc;

## 6.Which shipping type is preferred? ## ----------- Shipping Analysis Most Preferred Shipping Type-----------------------------
select Shipping_Type, count(Customer_id)as Most_of_Shipping from custdata group by Shipping_Type order by Most_of_Shipping desc;

## 7. Are subscribed customers spending more? ##
select Subscription_Status, round(sum(Purchase_Amount_USD))as Total_Spending from custdata group by Subscription_Status order by Total_Spending desc;

## 8. Which locations generate more revenue?----------Location Analysis = Top Revenue Generating States --------------------------
select Location, round(sum(Purchase_Amount_USD))as Revenue from custdata group by Location order by Revenue desc limit 7;

## 9------------------------- Rank Customers by Spending--------------------------------------------------------------------------
SELECT Customer_id,SUM(Purchase_Amount_USD) AS Total_Spending,
dense_rank() OVER(ORDER BY SUM(Purchase_Amount_USD)DESC) AS Customer_Rank FROM custdata 
GROUP BY Customer_id;

## 10 ---------------- Rating Analysis Average Review Rating by Category -----------------------------------
SELECT Category,round(AVG(Review_Rating),2)AS Avg_Rating FROM custdata GROUP BY Category ORDER BY Avg_Rating DESC;

## Discount Analysis ---------- Does Discount Affect Sales? ------------------------------------------------
SELECT Discount_Applied, round(AVG(Purchase_Amount_USD),2) AS Avg_Sales FROM custdata GROUP BY Discount_Applied;

select s.Category,s.total_sold from (select Category, sum(Purchase_Amount_USD) as total_sold,
row_number() over(order by sum(Purchase_Amount_USD)DESC) as most_solds from custdata 
group by Category)s where s.most_solds = 2;

