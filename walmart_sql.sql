use walmart_sales;
-- how many unique cities does the data have ?
select distinct city from walmartsalesdata;

-- which city is each branch ?
select city, branch from walmartsalesdata;

-- how many unique product line does the data have ?
select distinct 'product line' from walmartsalesdata;

-- what is the most common paymnet mode?
select  payment from walmartsalesdata
order by payment desc 
limit 1;

-- what is the most selling product line?
select 'product line' , sum(cogs) total_sales
from walmartsalesdata
order by total_sales desc;

-- what is the total revenue by month 
select format(SUM(total), 'FM999,999,999') sales  , monthname(date) as month_name 
from walmartsalesdata
group by monthname(date)
order by sales desc;

-- WHAT MONTH HAS THE LARGEST COGS?
select format(SUM(COGS), 'FM999,999,999') sales  , monthname(date) as month_name 
from walmartsalesdata
group by monthname(date)
order by sales desc
limit 1;

-- WHAT PRODUCT LINE HAS THE LARGEST REVENUE ?
select 'product line', sum(total) total_sales
from walmartsalesdata
order by total_sales desc;

-- what city is the largest revenue 
select city, format(sum(total),'fm999,999,999') as Revenue
from walmartsalesdata
group by city
order by revenue desc
limit 1;

-- what product line has the largest vatS?
select 'product line' , sum('Tax 5%') as Total_VATS
FROM walmartsalesdata
group by 'product line'
order by total_vats desc;

-- fetch each product line and add column to those product line showing "good","bad". good sales



-- what branch sold morthan average product sold



-- what is the common product line by gender 

select 'product line' , gender
from walmartsalesdata;

-- what is the averge rating of each product line
select 'product line' , avg(Rating) as Average_rating
from walmartsalesdata;

-- sales 
-- number of sales made in each time of the day per weekday
select count(total) num_sales, weekday(date) week_name
from walmartsalesdata
group by week_name
order by count(total);

-- WHUCH OF THE CUSTOMER TYPE BRINGS MOST  REVENUE 
select 'Customer type' , sum(TOTAL) AS Total_revenue
from walmartsalesdata
group by 'Customer type'
order by Total_revenue desc;

-- which city has the largest tax percent /vat(value added tax)
select city , sum('Tax 5%') total_vat
from walmartsalesdata
group by city 
order by total_vat desc;

-- which customer type pays the most vat
select 'Customer type', sum('Tax 5%') as total_vat
from walmartsalesdata;

-- customer
-- how many unique customer types does the data have 
select distinct 'Customer type'
from walmartsalesdata;

-- how mnay uniqu payment method does the data have 
select distinct payment
from walmartsalesdata;

-- what is the common customer types
select "Customer type"
from walmartsalesdata;

-- which customer type buys the most
select 'customer  type', sum(cogs)
from walmartsalesdata;

-- what is gender of most customers
select gender , count('Invoice ID') customers
from walmartsalesdata
group by gender 
order by customers;

-- what is the gender distribution per branch 
select gender, branch 
from walmartsalesdata;

-- what time of the day do customers give more rating 