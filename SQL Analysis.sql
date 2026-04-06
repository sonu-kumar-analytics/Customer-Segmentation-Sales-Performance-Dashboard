select * 
from online_retail
limit 10;

select * 
from customer_segmentation
limit 10;

-- Total Revenue 
select sum(unitprice*quantity)
from online_retail;

-- Total Customer
select count(distinct customerid) as total_customer
from online_retail;

-- Total Orders
select count(distinct invoiceno) as sales
from online_retail;

-- Revenue per Customer
select customerid, 
	   round(sum(totalprice),2) as revenue
from online_retail
group by customerid;

-- Order per Customer
select customerid,
	   count(distinct invoiceno) as order_count
from online_retail
group by customerid;

-- Average Order values
select invoiceno,
       round(sum(totalprice),2) as order_value
from online_retail
group by invoiceno;

select customerid, 
       max(invoiceno) as last_purchase
from online_retail
group by customerid;

-- Customer Segmentation
select customerid, 
	   round(sum(unitprice * quantity),2) as Total_Spent, 
	   count(distinct invoiceno) as frequency,
	   case
		   when sum(unitprice * quantity) > 1000 and count(distinct invoiceno) >5 then 'High Value'
		   when sum(unitprice * quantity) > 500 then 'Medium Value'
           else 'Low Value'
       end as segment
from online_retail
group by customerid;

-- Revenue by Country
select country,
	round(sum(totalprice),2)
from online_retail
group by country;

-- Coustomer by Country
Select country,
       count(distinct customerid) as customers
from online_retail
group by country;

-- Average Revenue per Customer by Customer
select country,
       round(sum(totalprice)/count(distinct customerid),2) as avg_rev_per_customer
from online_retail
group by country;

-- Top Customers with Country
select country, customerid,
       round(sum(totalprice),2) as spent
from online_retail
group by country, customerid
order by sum(totalprice) desc
limit 10;

-- Repeat vs One Time Customers
select Country,
       case
           when order_count = 1 then 'One-time'
           else 'Repeat'
       end as customer_type,
       count(*) as customers
from (
    select CustomerID,
           Country,
           COUNT(distinct InvoiceNo) as order_count
    from online_retail
    group by CustomerID, Country
) t
group by Country, customer_type
order by country;

-- Monthly Revenue by Country
select country,
       date_format(str_to_date(invoicedate, '%Y-%m-%d'), '%Y-%m') as month,
       round(sum(totalprice),2) as revenue
from online_retail
group by country, month;






