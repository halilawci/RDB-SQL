


--Window Functions

-- Window Frames



SELECT	category_id, product_id,
		COUNT(*) OVER() NOTHING,
		COUNT(*) OVER(PARTITION BY category_id) countofprod_by_cat,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id) countofprod_by_cat_2,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) prev_with_current,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) current_with_following,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) whole_rows,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) specified_columns_1,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN 2 PRECEDING AND 3 FOLLOWING) specified_columns_2
FROM	product.product
ORDER BY category_id, product_id

;



SELECT	DISTINCT brand_id, model_year
		, COUNT(*) OVER() NOTHING
		, COUNT(*) OVER(PARTITION BY brand_id)
		, COUNT(*) OVER(PARTITION BY brand_id ORDER BY model_year)
FROM	product.product




SELECT	brand_id, model_year
		, COUNT(*) OVER(PARTITION BY brand_id ORDER BY model_year)
		, COUNT(*) OVER(PARTITION BY brand_id ORDER BY model_year RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)--DEFAULT FRAME
		, COUNT(*) OVER(PARTITION BY brand_id ORDER BY model_year ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
		, COUNT(*) OVER(PARTITION BY brand_id ORDER BY model_year RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM	product.product


--

SELECT	brand_id, model_year
		, COUNT (*) OVER(PARTITION BY brand_id ORDER BY model_year range BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM	product.product




SELECT	brand_id, model_year
		, COUNT(*) OVER(PARTITION BY brand_id ORDER BY model_year ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM	product.product
order by brand_id, model_year



SELECT	brand_id, model_year
		, COUNT(*) OVER(PARTITION BY brand_id ORDER BY model_year ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) 
FROM	product.product
order by brand_id, model_year




---------------



-- What is the cheapest product price for each category?


SELECT	DISTINCT category_id, 
		MIN (list_price) OVER (PARTITION BY category_id)
FROM	product.product


-- How many different product in the product table?


SELECT	DISTINCT COUNT(product_id) OVER ()
FROM	product.product


-- How many different product in the order_item table?

SELECT COUNT (DISTINCT product_id)
FROM	sale.order_item



SELECT	DISTINCT COUNT (product_id) OVER()
FROM	sale.order_item




SELECT COUNT (product_id)
FROM	(
		SELECT DISTINCT product_id
		FROM	sale.order_item
		) A




-- Write a query that returns how many products are in each order?



SELECT	DISTINCT order_id, SUM(quantity) OVER (PARTITION BY order_id) NUMOFPROD
FROM	sale.order_item




------ How many different product are in each brand in each category?


SELECT	DISTINCT category_id, brand_id, COUNT (product_id) OVER (PARTITION BY category_id, brand_id)
FROM	product.product
ORDER BY category_id, brand_id




------FIRST_VALUE() - 

--Write a query that returns one of the most stocked product in each store.


SELECT *
FROM	product.stock
ORDER BY 
		store_id, quantity DESC


--result
SELECT	DISTINCT store_id,
		FIRST_VALUE(product_id) OVER (PARTITION BY store_id ORDER BY quantity DESC)
FROM	product.stock




SELECT	*,
		FIRST_VALUE(product_id) OVER (PARTITION BY store_id ORDER BY quantity DESC RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM	product.stock




--Write a query that returns customers and their most valuable order with total amount of it.


SELECT	A.customer_id, first_name, last_name, B.order_id,
		SUM(quantity*list_price* (1-discount)) total_amount
FROM	sale.customer A, sale.orders B, sale.order_item C
WHERE	A.customer_id = B.customer_id
AND		B.order_id = C.order_id
GROUP BY 
		A.customer_id, first_name, last_name, B.order_id
ORDER BY
		1,5 desc



WITH T1 AS
(
	SELECT	A.customer_id, first_name, last_name, B.order_id,
			SUM(quantity*list_price* (1-discount)) total_amount
	FROM	sale.customer A, sale.orders B, sale.order_item C
	WHERE	A.customer_id = B.customer_id
	AND		B.order_id = C.order_id
	GROUP BY 
			A.customer_id, first_name, last_name, B.order_id
)
SELECT	DISTINCT customer_id, first_name, last_name, 
		FIRST_VALUE(order_id) OVER (PARTITION BY customer_id ORDER BY total_amount DESC) most_val_order
		, FIRST_VALUE(total_amount) OVER (PARTITION BY customer_id ORDER BY total_amount DESC) total_amount
FROM	T1



---Write a query that returns first order date by month


SELECT	DISTINCT YEAR(order_date), MONTH(order_date), 
		FIRST_VALUE (order_date) OVER (PARTITION BY YEAR(order_date), MONTH(order_date) ORDER BY order_date)	
FROM	sale.orders




--LAST VALUE

--Write a query that returns most stocked product in each store. (Use Last_Value)




SELECT	DISTINCT store_id, 
		FIRST_VALUE(product_id) OVER (PARTITION BY store_id ORDER BY quantity DESC),--RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		LAST_VALUE (product_id) OVER (PARTITION BY store_id ORDER BY quantity, product_id desc RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM	product.stock





SELECT *
FROM	product.stock
ORDER BY 
		store_id, quantity asc













