-- Retrieve the total number of orders placed.
SELECT COUNT(order_id) as TOTAL_ORDERS from orders;

-- Calculate the total revenue generated from pizza sales.
SELECT ROUND(SUM(ORDERS_DETAILS.QUANTITY * PIZZAS.PRICE),2) AS TOTAL_REVENUE
FROM ORDERS_DETAILS JOIN PIZZAS
ON ORDERS_DETAILS.PIZZA_ID= PIZZAS.PIZZA_ID;

-- Identify the highest-priced pizza.
SELECT PIZZA_TYPES.NAME,PIZZAS.PRICE FROM PIZZA_TYPES 
JOIN PIZZAS ON PIZZA_TYPES.PIZZA_TYPE_ID=PIZZAS.PIZZA_TYPE_ID
ORDER BY PRICE DESC LIMIT 1;

-- Identify the most common pizza size ordered.
select pizzas.size, count(orders_details.order_details_id) as pizza_count
from pizzas join orders_details on orders_details.pizza_id = pizzas.pizza_id 
group by pizzas.size 
order by count(orders_details.order_details_id) desc 
limit 1;

-- List the top 5 most ordered pizza types along with their quantities.
SELECT PIZZAS.PIZZA_TYPE_ID,SUM(ORDERS_DETAILS.QUANTITY) 
FROM ORDERS_DETAILS
JOIN PIZZAS ON ORDERS_DETAILS.PIZZA_ID=PIZZAS.PIZZA_ID 
GROUP BY PIZZAS.PIZZA_TYPE_ID
ORDER BY SUM(ORDERS_DETAILS.QUANTITY) DESC
LIMIT 5;


