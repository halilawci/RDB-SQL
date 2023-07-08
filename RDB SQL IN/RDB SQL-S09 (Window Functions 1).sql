

----SET OPERATORS 

--Write a query that returns all customers whose  first or last name is Thomas.  (don't use 'OR')



SELECT first_name, last_name
FROM sale.customer
WHERE first_name='Thomas'

UNION

SELECT first_name, last_name
FROM sale.customer
WHERE last_name='Thomas'



SELECT first_name, last_name
FROM sale.customer
WHERE first_name='Thomas'

UNION ALL

SELECT first_name, last_name
FROM sale.customer
WHERE last_name='Thomas'

---------- INTERSECT

--Write a query that returns all brands with products for both 2018 and 2020 model year.


SELECT	DISTINCT B.brand_id, B.brand_name
FROM	product.product A, product.brand B
WHERE	model_year = 2018
AND		A.brand_id = B.brand_id

INTERSECT

SELECT	DISTINCT B.brand_id, B.brand_name
FROM	product.product A, product.brand B
WHERE	model_year = 2020
AND		A.brand_id = B.brand_id


----

--SELECT	DISTINCT B.brand_id, B.brand_name, model_year
--FROM	product.product A, product.brand B
--WHERE	model_year = 2018
--AND		A.brand_id = B.brand_id

--INTERSECT

--SELECT	DISTINCT B.brand_id, B.brand_name, model_year
--FROM	product.product A, product.brand B
--WHERE	model_year = 2020
--AND		A.brand_id = B.brand_id



-- Write a query that returns the first and the last names of the customers who placed orders in all of 2018, 2019, and 2020.


SELECT	customer_id, first_name, last_name
FROM	sale.customer 
WHERE	customer_id IN (
						SELECT	DISTINCT customer_id
						FROM	sale.orders
						WHERE	order_date BETWEEN '2018-01-01' AND '2018-12-31'

						INTERSECT

						SELECT	DISTINCT customer_id
						FROM	sale.orders
						WHERE	order_date BETWEEN '2019-01-01' AND '2019-12-31'

						INTERSECT
						SELECT	DISTINCT customer_id
						FROM	sale.orders
						WHERE	order_date BETWEEN '2020-01-01' AND '2020-12-31'
						) 




SELECT	customer_id, first_name, last_name
FROM	sale.customer 
WHERE	customer_id IN (
						SELECT	DISTINCT customer_id
						FROM	sale.orders
						WHERE	order_date BETWEEN '2018-01-01' AND '2018-12-31'

						INTERSECT

						SELECT	DISTINCT customer_id
						FROM	sale.orders
						WHERE	order_date BETWEEN '2019-01-01' AND '2019-12-31'

						INTERSECT
						SELECT	DISTINCT customer_id
						FROM	sale.orders
						WHERE	order_date BETWEEN '2020-01-01' AND '2020-12-31'
						) 



------ EXCEPT


-- Write a query that returns the brands have  2018 model products but not 2019 model products.


SELECT	 B.brand_id, B.brand_name
FROM	product.product A, product.brand B
WHERE	A.brand_id = B.brand_id
AND		A.model_year = 2018

Except

SELECT	 B.brand_id, B.brand_name
FROM	product.product A, product.brand B
WHERE	A.brand_id = B.brand_id
AND		A.model_year = 2019




-- Write a query that contains only products ordered in 2019 (Result not include products ordered in other years)

WITH T1 AS
(
SELECT	DISTINCT A.product_id
FROM	sale.order_item A, sale.orders B
WHERE	A.order_id = B.order_id
AND		YEAR(B.order_date) = 2019

EXCEPT

SELECT	DISTINCT A.product_id
FROM	sale.order_item A, sale.orders B
WHERE	A.order_id = B.order_id
AND		YEAR(B.order_date) <> 2019
)
SELECT	A.product_id, A.product_name
FROM	T1, product.product A
WHERE	T1.product_id = A.product_id


-------
--(
--SELECT	DISTINCT A.product_id
--FROM	sale.order_item A, sale.orders B
--WHERE	A.order_id = B.order_id
--AND		YEAR(B.order_date) = 2019

--EXCEPT

--SELECT	DISTINCT A.product_id
--FROM	sale.order_item A, sale.orders B
--WHERE	A.order_id = B.order_id
--AND		YEAR(B.order_date) <> 2019
--)

--UNION ALL
--(
--SELECT	DISTINCT A.product_id
--FROM	sale.order_item A, sale.orders B
--WHERE	A.order_id = B.order_id
--AND		YEAR(B.order_date) = 2019

--EXCEPT

--SELECT	DISTINCT A.product_id
--FROM	sale.order_item A, sale.orders B
--WHERE	A.order_id = B.order_id
--AND		YEAR(B.order_date) <> 2019
--)

-----


--CASE EXPRESSIONS

--SIMPLE CASE EXP.


---- Create  a new column with the meaning of the  values in the Order_Status column. 
-- 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed



SELECT	order_id, order_status,
		CASE order_status
			WHEN 1 THEN 'Pending'
			WHEN 2 THEN 'Processing'
			WHEN 3 THEN 'Rejected'
			ELSE 'Completed'
		END AS ord_status_mean
FROM	sale.orders



--SEARCH CASE EXP


---- Create  a new column with the meaning of the  values in the Order_Status column. 
-- 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed


SELECT	order_id, order_status,
		CASE 
			WHEN order_status = 1 THEN 'Pending'
			WHEN order_status = 2 THEN 'Processing'
			WHEN order_status = 3 THEN 'Rejected'
			ELSE 'Completed'
		END AS ord_status_mean
FROM	sale.orders



-- Create a new column that shows which email service provider ("Gmail", "Hotmail", "Yahoo" or "Other" ).



SELECT	customer_id, first_name, last_name, email,
		CASE WHEN email LIKE '%gmail.com%' THEN 'Gmail'
				WHEN email LIKE '%hotmail.com%' THEN 'Hotmail'
				WHEN email LIKE '%yahoo.com%' THEN 'Yahoo'
				ELSE 'Other'
		END email_service_provider
FROM	sale.customer



--Write a query that returns the count of the orders day by day in a pivot table format that has been shipped two days later.


SELECT	 
		SUM(CASE WHEN DATENAME(DW, order_date) = 'Sunday' THEN 1 ELSE 0 END ) AS Sunday,
		SUM(CASE WHEN DATENAME(DW, order_date) = 'Monday' THEN 1 ELSE 0 END )AS Monday,
		SUM(CASE WHEN DATENAME(DW, order_date) = 'Tuesday' THEN 1 ELSE 0 END )AS Tuesday,
		SUM(CASE WHEN DATENAME(DW, order_date) = 'Wednesday' THEN 1 ELSE 0 END) AS Wednesday,
		SUM(CASE WHEN DATENAME(DW, order_date) = 'Thursday' THEN 1 ELSE 0 END )AS Thursday,
		SUM(CASE WHEN DATENAME(DW, order_date) = 'Friday' THEN 1 ELSE 0 END) AS Friday,
		SUM(CASE WHEN DATENAME(DW, order_date) = 'Saturday' THEN 1 ELSE 0 END )AS Saturday
FROM	sale.orders
WHERE	DATEDIFF (DAY, order_date, shipped_date) >2



----WINDOW FUNCTIONS


-----Write a query that returns the total stock amount of each product in the stock table.



SELECT	product_id, SUM(quantity) TOTAL_QUANTITY
FROM	product.stock
GROUP BY	
		product_id
ORDER BY 1


SELECT	*, 
		SUM(quantity) OVER (PARTITION BY product_id) TOTAL_QUANTITY
FROM	product.stock



SELECT	DISTINCT product_id, 
		SUM(quantity) OVER (PARTITION BY product_id) TOTAL_QUANTITY
FROM	product.stock


-- Write a query that returns average product prices of brands. 

SELECT	*,
		AVG(list_price) OVER (PARTITION BY brand_id)
FROM	product.product





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
