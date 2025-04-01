# A Restaurant's Customer Behaviour Analysis

![Picture16](https://github.com/user-attachments/assets/16002cc4-65a7-46aa-93bd-e4c0be86f1ad)

## Table Of Contents
1. [Project Overview](#project-overview)
2. [Data Source](#data-source)
3. [Data Loading Process](#data-loading-process)
4. [Exploratory Data Analysis](#exploratory-data-analysis)
5. [Data Analysis](#data-analysis)
6. [Results And Insights](#results-and-insights)
7. [Recommendations](#recommendations)

### Project Overview
The goal of this project is to provide insights on the customer behavior for a restaurant over the period of a quarter. By analysing the menu items and different order details, we seek to uncover trends, identify the customer behavior that influences revenue, make data-driven recommendations, and help the restaurant better understand which of their menu items perform the best, and which customers are their biggest spenders.

### Data Source
Restaurant Orders: The dataset used for this project is create_restaurant_db.sql, the dataset contains information on the restaurant’s different menu items and the order details of those menu items. This dataset was found at ‘Maven Analytics Data Playground’: [Click here]( https://mavenanalytics.io/data-playground?order=date_added%2Cdesc&search=restaurant%20orders)

### Data Loading Process
I first downloaded the sql file from the Maven Analytics website, then I created a new connection in MySQL Workbench, uploaded the file, ran the code to create our database with the two tables: menu_items and order_id. The last step was then to open a new query tab and use our database.

### Exploratory Data Analysis
EDA involved exploring our dataset to answer these questions:
1.	What was the total number of orders and total revenue generated over the past quarter, and what were the main contributing factors?
2.	On which days of the week do we have most of our orders?
3.	What are our top selling items, and what are our lowest selling items?
4.	Which customers were our biggest spenders?

### Data Analysis
#### Analysis Of Highest Revenue By Item
To figure this out, I first had to join our menu items and order details tables, then make use of the order_id and aggregate the price column, using the sum() function to get the total revenue by item, I then ordered the table by the aggregated price column in descending order, so that our top selling items appeared at the top.

```sql
-- What are the top 10 items that made the most money?
Select mi.item_name, sum(mi.price ) as total_spend from order_details od
Left Join menu_items mi on od.item_id =mi.menu_item_id
where mi.item_name is not null
group by mi.item_name
order by total_spend desc
limit 10;
```
#### Analysis Of Number Of Orders And Revenue By Day Of Week
In order to carry out this analysis, I made use of three columns: order_date, price and order_id. Aggregate functions sum() and count() were used on the price and order_id columns respectively in order to get our totals, and the set() function was used on the order_date column to display the days of the week as their names.

```sql
-- On which days was the most money made?
Select
 case 
	when dayofweek(od.order_date) = 1 then "Sunday"
	when dayofweek(od.order_date) = 2 then "Monday"
	when dayofweek(od.order_date) = 3 then "Tuesday"
	when dayofweek(od.order_date) = 4 then "Wednesday"
	when dayofweek(od.order_date) = 5 then "Thursday"
	when dayofweek(od.order_date) = 6 then "Friday"
	when dayofweek(od.order_date) = 7 then "Saturday"
end as day_of_week, sum(mi.price) as total_spend, count(distinct order_id) as num_of_orders
 from order_details od
Left Join menu_items mi on od.item_id =mi.menu_item_id
group by  day_of_week
order by total_spend desc;
```
#### Analysis Of Biggest Orders By Order Id
To carry this analysis out, I made use of the order_id and price columns, the order_id values were used as they were and the aggregate function sum() was used on the price column in order to get our total for each order, this analysis was carried out to show us who our biggest spenders were during that quarter. The query was ordered by the total spend in descending order to make the biggest numbers appear first.

```sql
-- What are the top 10 orders that made the most money?
Select od.order_id, sum(mi.price) as total_spend from order_details od
Left Join menu_items mi on od.item_id =mi.menu_item_id
group by od.order_id
order by total_spend desc
limit 10;
```
### Results And Insights
#### Total Revenue And Number Of Orders 
- Total quarterly revenue was $159 220 and the total number of orders for that period was 5370.
- One contributing factor to the restaurant’s revenue is the fact that the restaurant sells a wide variety of items, with our highest selling item, the Korean beef bowl, having generated $10,6K in revenue.
- Another contributing factor was that the restaurant didn’t have bad business days. Some days were higher than others, but the average revenue by total weekday was $22 745,41 and the average number of orders by total weekdays was 767.

![Picture12](https://github.com/user-attachments/assets/57ad2740-7eae-4534-a3fa-139cf4c3393b)
![Picture13](https://github.com/user-attachments/assets/7f00e96f-7b7b-423c-9bea-b1048db46d5d)

#### Highest And Lowest Selling Menu Items
- Our top 10 selling items were the Korean beef bowl, spaghetti and meatballs, tofu pad thai, cheeseburger, hamburger, orange chicken, eggplant, parmesan, steak torta and chicken parmesan.
- The Korean beef bowl, our number one top seller contributed close to 7% to the total quarterly revenue on its own, and the top 10 items together contributed $77 788, which is 48% of the total revenue.
- Our lowest selling menu item was the’ potstickers’, this menu item only generated $1.8k during the quarter, which translates to 1% of total revenue.

![Picture10](https://github.com/user-attachments/assets/1639f0ba-f649-4dc3-a0b1-deaae5fb3559)

#### Total Revenue And Number Of Orders By Weekday
- Our biggest days were Mondays, with total revenue made on Mondays being $26 007, and total number of orders sold being 885.
- Our lowest revenue days, which wasn’t low revenue at all, were Wednesdays. All Wednesdays combined, the restaurant made $19 902 in revenue and sold 682 orders.
- On average, the restaurant made $22 745 and sold 767 orders per total weekdays.

![Picture11](https://github.com/user-attachments/assets/213422ea-d356-4005-90ea-7c6d594bb4b9)

#### Identifying Our Biggest Spenders
- We had 10 big orders in the same price range, the order average for these orders was $186,09.
- We can use these order ID’s to identify our biggest spending customers.

![Picture9](https://github.com/user-attachments/assets/5f9bd944-1c08-4cf2-b98f-c1a8a3bb2811)

#### Full Dashboard

![Picture7](https://github.com/user-attachments/assets/28950cf3-48c4-43d4-a545-3a93b2e8c3f0)

### Recommendations
- Ensure that the restaurant always has a consistent supply of the ingredients that make up the top 10 highest selling menu items, as they’re in high demand and their sales generated 48% of the restaurant’s quarterly revenue.
- I would advise for the marketing team to advertise the Korean beef bowl strategically on all the restaurant’s channels of advertising. E.g. Calling it the “customer favourite’ or “bestseller”.
- Concerning the lowest selling item, the potstickers, I recommend the restaurant starts by reducing the quantity of stock required to make the item, then try bundling the item with a popular item to see if that will increase the product revenue.
-	 Should the above mention item perform well after those adjustments, the restaurant can then increase inventory, if the item continues to perform poorly however, the restaurant should consider discontinuing the item in order to avoid spending on items that don’t perform well.
-	Develop a customer loyalty program in order to retain our highest spending customers and in order to give the rest of our customers an incentive, so that they can keep coming back. E.g. The restaurant can take a page out of McDonald’s book and create a program where customers earn points for every $1 spent, encouraging customers to choose our restaurant more often, because the points earned will eventually lead to a reward.




