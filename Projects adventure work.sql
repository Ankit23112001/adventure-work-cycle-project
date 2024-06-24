create database Adventure_works;

# union fact_internet_sales_new and Fact_internet_sales
create View Sales as(select * from fact
union all
select * from fact2);

select * from sales;

select * from dimproduct;
select * from dimcustomer;

# lookup the product name from product to sales sheet
select sales.*,dp.EnglishProductName from sales
inner join dimproduct dp
on sales.productkey=dp.productkey;

# Lookup the customername
select sales.*,concat(dc.Firstname," ",Lastname)as CutomerName from sales
inner join dimcustomer dc
on sales.customerkey=dc.customerkey;


# Year, month, monthname, Quarter, Weekday, weekdayname
select month(OrderDate)"Month" from sales; 
select Year(OrderDate) "Year" from sales;
select monthname(OrderDate) "Month_Name" from sales;
select concat("Q",quarter(orderDate)) "Quarter" from sales; 
select week(OrderDate)"Weekno" from sales;
select weekday(OrderDate) "WeekdayName" from sales;


#Financial Month
select  *, if (month(orderdate)>=4,
concat(year(orderdate),'-',month(orderdate)-3),
concat(year(orderdate)-1,'-',month(orderdate)+9))as Financial_month from sales;


# Financial Quarter
select  *, if (month(orderdate)>=4,
concat("Q",ceiling(month(orderdate)/3)),
concat("Q",ceiling((month(orderdate)+9)/3))) as  Financial_Quarter from sales;

# Year-Month
select Date_format(orderdate,'%Y-%m') as YearMonth from sales;

#Calculate Profit
select * from sales;
select sum(salesamount-totalproductcost) as Profit from Sales;

 # sales Table
select sales.*,dp.EnglishProductName,concat(dc.Firstname," ",Lastname)as CutomerName,year(sales.orderdate) as Year,
month(sales.orderdate)as Monthno,monthname(sales.orderdate)as "MonthName",quarter(sales.orderdate)as Quarter,week(sales.orderdate)as Weekno
,weekday(sales.orderdate)as weekday,
Date_format(orderdate,'%Y-%m')as YearMonth, 
if (month(orderdate)>=4,
concat(year(orderdate),'-',month(orderdate)-3),
concat(year(orderdate)-1,'-',month(orderdate)+9))as Financial_month,
if (month(orderdate)>=4,
concat("Q",ceiling(month(orderdate)/3)),
concat("Q",ceiling((month(orderdate)+9)/3))) as  Financial_Quarter from sales
 inner join
dimproduct dp
on sales.Productkey=dp.ProductKey
inner join 
dimcustomer dc
on sales.customerkey=dc.customerkey;

# year wise salesamount
select year(orderdate),salesamount from sales;

# Month wise saleamount
select monthname(orderdate),salesamount from sales;

#Quarter wise sales amount
select concat("Q",quarter(orderDate)) "Quarter",salesamount from sales;

#Sales Amount and Total productioncost together
select salesamount, totalproductcost from sales;

