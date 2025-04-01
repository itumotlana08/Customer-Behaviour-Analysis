USE restaurant_db;

-- To analyse customer behaviour, we first need to join our two tables
Select * from order_details;
Select * from menu_items;

Select * from order_details od
Left Join menu_items mi on od.item_id =mi.menu_item_id;

-- What are the least and most ordered items, and what category are they in?
Select mi.item_name, mi.category, Count(od.order_id) as num_of_orders from order_details od
Left Join menu_items mi on od.item_id =mi.menu_item_id
group by mi.item_name, mi.category
order by num_of_orders desc;

-- What are the top 10 items that made the most money?
Select mi.item_name, sum(mi.price ) as total_spend from order_details od
Left Join menu_items mi on od.item_id =mi.menu_item_id
where mi.item_name is not null
group by mi.item_name
order by total_spend 
limit 10;

-- What are the top 10 orders that made the most money?
Select od.order_id, sum(mi.price) as total_spend from order_details od
Left Join menu_items mi on od.item_id =mi.menu_item_id
group by od.order_id
order by total_spend desc
limit 10;

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

-- Calculate total revenue
Select sum(mi.price) as total_revenue from order_details od
Left Join menu_items mi on od.item_id =mi.menu_item_id;

-- Calculate total number of orders
Select count(distinct order_id) as num_of_orders  from order_details od
Left Join menu_items mi on od.item_id =mi.menu_item_id;




