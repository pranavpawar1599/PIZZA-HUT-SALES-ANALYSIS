-- Calculate the percentage contribution of each pizza type to total revenue.
select pizza_types.category, 
round(sum(orders_details.quantity * pizzas.price) / 
(SELECT ROUND (SUM(orders_details.quantity * pizzas.price),2)
AS total_sales from
orders_details
JOIN pizzas ON pizzas.pizza_id = orders_details.pizza_id)*100,2)
from pizza_types join pizzas
on pizza_types.pizza_type_id= pizzas.pizza_type_id
join orders_details
on orders_details.pizza_id = pizzas.pizza_id 
group by pizza_types.category;

-- Analyze the cumulative revenue generated over time


SELECT ORDER_DATE,SUM(REVENUE) OVER (ORDER BY ORDER_DATE) AS CUM_REVENUE
FROM
(SELECT ORDERS.ORDER_DATE,
SUM(ORDERS_DETAILS.QUANTITY * PIZZAS.PRICE) AS REVENUE
FROM ORDERS_DETAILS JOIN PIZZAS	
ON ORDERS_DETAILS.PIZZA_ID = PIZZAS.PIZZA_ID
JOIN ORDERS
ON ORDERS.ORDER_ID = ORDERS_DETAILS.ORDER_ID
GROUP BY ORDERS.ORDER_DATE) AS SALES;

-- Determine the top 3 most ordered pizza types 
-- based on revenue for each pizza category

SELECT CATEGORY,NAME,REVENUE,RANKS FROM
(SELECT CATEGORY,name,REVENUE,
RANK() OVER (partition by CATEGORY ORDER BY REVENUE DESC) AS RANKS FROM
(SELECT PIZZA_TYPES.CATEGORY,PIZZA_TYPES.NAME,
SUM(ORDERS_DETAILS.QUANTITY * PIZZAS.PRICE) AS REVENUE FROM
PIZZAS JOIN PIZZA_TYPES ON PIZZA_TYPES.PIZZA_TYPE_ID = PIZZAS.PIZZA_TYPE_ID
JOIN ORDERS_DETAILS ON ORDERS_DETAILS.PIZZA_ID = PIZZAS.PIZZA_ID
GROUP BY PIZZA_TYPES.CATEGORY,PIZZA_TYPES.NAME) AS A) AS B
WHERE RANKS <= 3 ;













