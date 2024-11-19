-- Join the necessary tables to find the total quantity 
-- of each pizza category ordered.
SELECT pizza_types.category,sum(orders_details.quantity) from pizza_types
join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
join orders_details on pizzas.pizza_id=orders_details.pizza_id
GROUP BY pizza_types.category
ORDER BY sum(orders_details.quantity) DESC;

-- Determine the distribution of orders by hour of the day.
SELECT HOUR(ORDER_TIME),COUNT(ORDER_ID)FROM ORDERS 
GROUP BY HOUR(order_time) ORDER BY COUNT(ORDER_ID) DESC;

-- Join relevant tables to find the category-wise distribution of pizzas.
SELECT CATEGORY,count(name)FROM pizza_types group by category;

-- Group the orders by date and 
-- calculate the average number of pizzas ordered per day.

SELECT ROUND(AVG(QUANTITY),0) FROM 
(SELECT ORDERS.ORDER_DATE,
SUM(ORDERS_DETAILS.QUANTITY) AS QUANTITY FROM orders
JOIN orders_details ON orders_details.ORDER_ID = ORDERS.ORDER_ID
GROUP BY ORDERS.ORDER_DATE) AS ORDERS_QUANTITY;

-- Determine the top 3 most ordered pizza types based on revenue.

SELECT SUM(ORDERS_DETAILS.QUANTITY * PIZZAS.PRICE) AS TOTAL_REVENUE, 
PIZZA_TYPE_ID FROM orders_details 
JOIN PIZZAS ON orders_details.pizza_id= pizzas.pizza_id
GROUP BY PIZZA_TYPE_ID ORDER BY TOTAL_REVENUE DESC LIMIT 3;	



