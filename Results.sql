/* OBJECTIVE1: 
View the menu items and count the number of items */
USE restaurant_db;
SELECT * FROM menu_items;
SELECT COUNT(*) FROM menu_items;

/*Least and most expensive items */
SELECT * FROM menu_items
ORDER BY price;

SELECT * FROM menu_items
ORDER BY price DESC;

/*How many Italian dishes are on the menu? */
SELECT COUNT(*) FROM menu_items
WHERE category='Italian';

/*Least and more expensive Italian dishes on the menu? */
SELECT * FROM menu_items
WHERE category='Italian' ORDER BY price;

SELECT * FROM menu_items
WHERE category='Italian' ORDER BY price DESC;

/*count and Average dish price within each category */
SELECT category, COUNT(menu_item_id) AS num_dishes
FROM menu_items
GROUP BY category;

SELECT category, AVG(price) AS avg_price
FROM menu_items
GROUP BY category;

/* OBJECTIVE2: 
View the order_details and determine date range */
SELECT * FROM order_details;

SELECT MIN(order_date), MAX(order_date) FROM order_details;

/*How many orders were made within this date range */
SELECT COUNT(DISTINCT order_id) FROM order_details;

/*How many items were ordered within this date range */
SELECT COUNT(*) FROM order_details;

/*Order with most number of items */
SELECT order_id, COUNT(item_id) AS num_items
FROM order_details
GROUP BY order_id
ORDER BY num_items DESC;

/*Wich Orders had more than 12 items */
SELECT order_id, COUNT(item_id) AS num_items
FROM order_details
GROUP BY order_id
HAVING num_items >12;

/*How many Orders had more than 12 items */
SELECT COUNT(*) FROM
(SELECT order_id, COUNT(item_id) AS num_items
FROM order_details
GROUP BY order_id
HAVING num_items >12) AS num_orders;

/* OBJECTIVE3: ANALYZE CUSTOMER BEHAVIOR
Combine menu_items and order_details tables into a single table */
SELECT * FROM menu_items;
SELECT * FROM order_details;

SELECT *
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id; /*here I use left join because I wanna retrieve all raws from order_details and complete columns with menu_items table */

/*Least and more ordered items and what categories were they in */
SELECT item_name, category, COUNT(order_details_id) AS num_purchases
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
GROUP BY item_name, category /*all we include here, also has to be include in our select function*/
ORDER BY num_purchases DESC;

/*Top 5 orders that spent the most money */
SELECT order_id, SUM(price) AS total_spend
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
GROUP BY order_id
ORDER BY total_spend DESC
LIMIT 5;
    
/*Details of the highest spend order */
SELECT category, COUNT(item_id) AS num_items
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
WHERE order_id=440
GROUP BY category;

/*Details of the top 5 spend order */
SELECT category, COUNT(item_id) AS num_items /*Retrieve the count of the 5 order*/
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
WHERE order_id IN (440,2075,1957,330,2675)
GROUP BY category;

SELECT order_id, category, COUNT(item_id) AS num_items /*Retrieve the count of each order, separately*/
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
WHERE order_id IN (440,2075,1957,330,2675)
GROUP BY order_id, category;