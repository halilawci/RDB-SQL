

---Session 11 Window Functions



--LAG() - LEAD()


--Write a query that returns the order date of the one previous sale of each staff (use the LAG function)



SELECT	A.staff_id, A.first_name, A.last_name, B.order_id, B.order_date,
		LAG(order_date) OVER (PARTITION BY A.staff_id ORDER BY order_id) prev_order_date
FROM	sale.staff A, sale.orders B
WHERE	A.staff_id = B.staff_id


--Write a query that returns the order date of the one next sale of each staff (use the lead function)

SELECT	A.staff_id, A.first_name, A.last_name, B.order_id, B.order_date,
		LEAD (order_date) OVER (PARTITION BY A.staff_id ORDER BY order_id) prev_order_date
FROM	sale.staff A, sale.orders B
WHERE	A.staff_id = B.staff_id



--Assign an ordinal number to the product prices for each category in ascending order


SELECT	category_id, list_price,
		ROW_NUMBER() OVER (PARTITION BY category_id ORDER BY list_price) ord_number
FROM	product.product



SELECT *
FROM
		(
		SELECT	category_id, list_price,
				ROW_NUMBER() OVER (PARTITION BY category_id ORDER BY list_price) ord_number
		FROM	product.product
		) A
WHERE	ord_number < 4




--------RANK vs. DENSE_RANK


SELECT	category_id, list_price,
		ROW_NUMBER() OVER (PARTITION BY category_id ORDER BY list_price) RN, 
		RANK() OVER (PARTITION BY category_id ORDER BY list_price) RNK,
		DENSE_RANK() OVER (PARTITION BY category_id ORDER BY list_price) DNS_RNK
FROM	product.product



--Write a query that returns both of the followings:
--Average product price.
--The average product price of orders.



SELECT	DISTINCT order_id, 
		AVG(list_price) OVER () avg_price_by_table,
		AVG(list_price) OVER (PARTITION BY order_id) avg_price_by_order
FROM	sale.order_item



--Which orders' average product price is lower than the overall average price?




WITH T1 AS
(
SELECT	DISTINCT order_id, 
		AVG(list_price) OVER () avg_price_by_table,
		AVG(list_price) OVER (PARTITION BY order_id) avg_price_by_order
FROM	sale.order_item
)
SELECT *
FROM	T1
WHERE	avg_price_by_order < avg_price_by_table
ORDER BY 
		3 DESC



--Calculate the stores' weekly cumulative number of orders for 2018


SELECT	DISTINCT A.store_id, A.store_name,
		DATEPART(WEEK, order_date) WEEK_OF_ORDER,
		COUNT(order_id) OVER (PARTITION BY A.store_id, DATEPART(WEEK, order_date)) CNT_ORDER,
		COUNT(order_id)	OVER (PARTITION BY A.store_id ORDER BY DATEPART(WEEK, order_date)) CUM_ORD_CNT
FROM	sale.store A, sale.orders B
WHERE	A.store_id = B.store_id
AND		YEAR(order_date) = 2018



--Calculate 7-day moving average of the number of products sold between '2018-03-12' and '2018-04-12'

WITH T1 AS
(
SELECT	DISTINCT order_date, 
		SUM(quantity) OVER (PARTITION BY order_date) daily_product_cnt
FROM	sale.orders A, sale.order_item B
WHERE	A.order_date BETWEEN  '2018-03-12' and '2018-04-12'
AND		A.order_id = B.order_id
) 
SELECT	order_date, 
		daily_product_cnt,
		AVG(daily_product_cnt) OVER (ORDER BY order_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
FROM	T1


------


WITH T1 AS
(
SELECT	DISTINCT order_date, 
		SUM(quantity) OVER (PARTITION BY order_date) daily_product_cnt
FROM	sale.orders A, sale.order_item B
WHERE	A.order_date BETWEEN  '2018-03-12' and '2018-04-12'
AND		A.order_id = B.order_id
) 
SELECT	order_date, 
		daily_product_cnt,
		AVG(daily_product_cnt) OVER (ORDER BY order_date ROWS BETWEEN CURRENT ROW AND 6 FOLLOWING)
FROM	T1


WITH T1 AS
(
SELECT	DISTINCT order_date, 
		SUM(quantity) OVER (PARTITION BY order_date) daily_product_cnt
FROM	sale.orders A, sale.order_item B
WHERE	A.order_date BETWEEN  '2018-03-12' and '2018-04-12'
AND		A.order_id = B.order_id
) 
SELECT	order_date, 
		daily_product_cnt,
		AVG(daily_product_cnt) OVER (ORDER BY order_date ROWS BETWEEN 2 PRECEDING AND 3 FOLLOWING)
FROM	T1









--Write a query that returns the highest daily turnover amount for each week on a yearly basis.





--List customers whose have at least 2 consecutive orders are not shipped.
















