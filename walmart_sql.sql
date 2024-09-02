SELECT * FROM walmart_sales.walmartsalesdata;
use walmart_sales;
-- how many unique cities does the data have ?
select distinct city from walmartsalesdata;

-- which city is each branch ?
select city, branch from walmartsalesdata
group by city, branch;

-- how many unique product line does the data have ?
alter table walmartsalesdata
change column `product line`   `product_line` varchar (100);

select count(distinct product_line) num_of_product_lines from walmartsalesdata;

-- what is the most common paymnet mode?
select * from ( select  payment, 
count(payment) num_times, 
dense_rank() over (order by count(payment) desc) Ranking
from walmartsalesdata
group by payment) subqurry
where ranking <= 1;
 


-- what is the most selling product line?
select * from (select product_line , count(product_line) total_sales,
 dense_rank() over (order by count(product_line) desc) ranking
from walmartsalesdata
group by product_line) subqurry
where ranking <= 1;
 

-- what is the total revenue by month 
alter table walmartsalesdata
add column month varchar(20);

set sql_safe_updates = 0;

update  walmartsalesdata
set month = monthname(date);
set sql_safe_updates = 0;

select Month, Revenue from (select month ,  format(SUM(total), 'FM999,999,999') Revenue, 
dense_rank() over (order by SUM(total) desc) ranking 
from walmartsalesdata
group by month) subquery
where ranking <= 1;


-- WHAT MONTH HAS THE LARGEST COGS?
select * from (select month , format(sum(cogs), 'fm999.999,999') total_sales,
 dense_rank() over (order by sum(cogs) desc) ranking
from walmartsalesdata
group by month) subqurry
where ranking <= 1;

-- WHAT PRODUCT LINE HAS THE LARGEST REVENUE ?
select product_line, Revenue from (select product_line ,  format(SUM(total), 'FM999,999,999') Revenue, 
dense_rank() over (order by SUM(total) desc) ranking 
from walmartsalesdata
group by product_line) subquery
where ranking <= 1;

-- what city is the largest revenue 
select city, Revenue from (select city ,  format(SUM(total), 'FM999,999,999') Revenue, 
dense_rank() over (order by SUM(total) desc) ranking 
from walmartsalesdata
group by city) subquery
where ranking <= 1;

-- what product line has the largest vatS?

alter table walmartsalesdata
change column `Tax_5%` `tax_vat` float;

select * from  (select  product_line , round(sum(Tax_vat),2) as Total_VATS , 
dense_rank () over (order by sum(Tax_vat) desc) ranking 
FROM walmartsalesdata
group by product_line) subquery
where ranking <= 1;

select sum(Tax_vat) from walmartsalesdata;
 

-- fetch each product line and add column to those product line showing "good","bad". good sales
select product_line, total, 
case when total >=(select avg(total) from walmartsalesdata) then "Good" else "Bad" end Remark
from walmartsalesdata;

select avg(total) from walmartsalesdata;


-- what branch sold morthan average product sold
select branch , round(avg(total),2) Avg_branch_sales
from walmartsalesdata
group by branch
having avg(total) > (select avg(total) avg_productsales from walmartsalesdata);


-- what is the common product line by gender 

select * from (select product_line , gender,count(gender) num_gender, 
dense_rank() over (order by count(gender)   desc ) as ranking
from walmartsalesdata
group by 1,2)subquery
where ranking  <= 1;


-- what is the averge rating of each product line
select product_line , round(avg(Rating),2) as Average_rating
from walmartsalesdata
group by product_line;

-- sales 
-- number of sales made in each time of the day per weekday
alter table walmartsalesdata 
add column weekday varchar (15);

set sql_safe_updates = 0;

update  walmartsalesdata 
 set weekday = dayname(Date);
 
alter table walmartsalesdata 
add column daytime varchar (15);
set sql_safe_updates = 0;

update walmartsalesdata 
set daytime = case 
when time between "00:00:00" and "12:00:00" then "morning"
when time between "12:00:01" and "16:00:00" then "Afternoon"
when time between "16:00:01" and "23:59:59" then "Evening" end;

select* from (select weekday , daytime , count(total) num_sales,
dense_rank () over (order by count(total) desc) ranking
from walmartsalesdata
group by weekday, daytime) subquery
where ranking = 1;


-- WHICH OF THE CUSTOMER TYPE BRINGS MOST  REVENUE 
select * from (select customer_type , round(sum(TOTAL),2) Total_Revenue,
dense_rank() OVER (order by sum(TOTAL) desc) ranking
from walmartsalesdata
group by customer_type) subquery
where ranking = 1;


alter table walmartsalesdata
change column `Customer type`   `customer_type` varchar (100); 

-- which city has the largest tax percent /vat(value added tax)
select * from (select city ,sum(tax_vat) ,
dense_rank() over (order by sum(tax_vat) desc)  ranking 
from walmartsalesdata
group by city) subquery
where ranking = 3;



-- which customer type pays the most vat
select customer_type , sum(tax_vat) as total_vat ,
dense_rank() over(order by format(sum(tax_vat),'fm999,999,999') desc) ranking
from walmartsalesdata
group by customer_type;

-- customer
-- how many unique customer types does the data have 
select distinct customer_type
from walmartsalesdata;

-- how mnay uniqu payment method does the data have 
select distinct payment
from walmartsalesdata;

-- what is the common customer types
select Customer_type
from walmartsalesdata;

-- which customer type buys the most
SELECT * FROM (select customer_type, sum(cogs),
dense_rank () over (order by sum(cogs) desc) RANKING
from walmartsalesdata
group by customer_type) SUBQUERY;

-- what is gender of most customers
select gender , count('Invoice ID') customers,
dense_rank() OVER (order by count('Invoice ID') desc) Ranking
from walmartsalesdata
group by gender;
 

-- what is the gender distribution per branch 
select gender, branch, 
dense_rank() over (order by gender) ranking
from walmartsalesdata
group by gender,branch;
use walmart_sales;
-- what time of the day do customers give more rating 
  select daytime, round(sum(Rating),2) Total_Rating,
  dense_rank() over (order by round(sum(Rating),2)desc) ranking
  from walmartsalesdata
  group by daytime;