

---Session 8


--Write a query that returns a list of States where 'Apple - Pre-Owned iPad 3 - 32GB - White' 
--product is not ordered


SELECT  DISTINCT state
FROM	sale.customer X
WHERE	NOT EXISTS (

					SELECT	DISTINCT state
					FROM	product.product A, sale.order_item B, sale.orders C, sale.customer D
					WHERE	product_name = 'Apple - Pre-Owned iPad 3 - 32GB - White'
					AND		A.product_id = B.product_id
					AND		B.order_id = C.order_id
					AND		C.customer_id = D.customer_id
					AND		D.state = X.state
					)




SELECT  DISTINCT state
FROM	sale.customer X
WHERE	EXISTS (
					SELECT	3
					FROM	product.product A, sale.order_item B, sale.orders C, sale.customer D
					WHERE	product_name = 'Apple - Pre-Owned iPad 3 - 32GB - White'
					AND		A.product_id = B.product_id
					AND		B.order_id = C.order_id
					AND		C.customer_id = D.customer_id
					AND		D.state = X.state
					)




SELECT  DISTINCT state
FROM	sale.customer X
WHERE	X.state NOT IN  (
							SELECT	State
							FROM	product.product A, sale.order_item B, sale.orders C, sale.customer D
							WHERE	product_name = 'Apple - Pre-Owned iPad 3 - 32GB - White'
							AND		A.product_id = B.product_id
							AND		B.order_id = C.order_id
							AND		C.customer_id = D.customer_id
							)



--Write a query that returns stock information of the products in Davi techno Retail store. 
--The BFLO Store hasn't  got any stock of that products.


--SELECT Y.*
--FROM	sale.store X, product.stock Y
--WHERE	X.store_id = Y.store_id
--AND		x.store_name = 'Davi techno Retail'
--AND		EXISTS
--			(
--			SELECT	A.*
--			FROM	product.stock A, sale.store B
--			WHERE	A.store_id= B.store_id
--			AND		B.store_name = 'The BFLO Store'
--			AND		A.quantity = 0
--			AND		Y.product_id = A.product_id
--			)
			

--not exists


SELECT	DISTINCT Y.product_id
FROM	sale.store X, product.stock Y
WHERE	X.store_id = Y.store_id
AND		x.store_name = 'Davi techno Retail'
AND		NOT EXISTS
			(
			SELECT	DISTINCT A.product_id
			FROM	product.stock A, sale.store B
			WHERE	A.store_id= B.store_id
			AND		B.store_name = 'The BFLO Store'
			AND		A.quantity > 0
			AND		Y.product_id = A.product_id
			)
			


SELECT * 
FROM	product.stock
WHERE	product_id  = 320



----------////////////////////------------

------ CTE's ------

--ORDINARY CTE's

-- Query Time


--List customers who have an order prior to the last order date of a customer named Jerald Berray and are residents of the city of Austin. 

-- Jerald Berray isimli müþterinin son sipariþinden önce sipariþ vermiþ 
--ve Austin þehrinde ikamet eden müþterileri listeleyin.


WITH T1 AS
(
SELECT	MAX(order_date) last_order_date
FROM	sale.customer A, sale.orders B
WHERE	A.customer_id = B.customer_id
AND		A.first_name= 'Jerald'
AND		A.last_name = 'Berray'
)
SELECT	DISTINCT A.customer_id, A.first_name, A.last_name
FROM	sale.customer A, sale.orders B, T1
WHERE	A.customer_id = B.customer_id
AND		T1.last_order_date > B.order_date
AND		A.city = 'Austin'




WITH T1 AS
(
SELECT B.order_date laurels_order_dates
FROM sale.customer A, sale.orders B
WHERE A.first_name = 'Laurel' AND A.last_name = 'Goldammer'
AND A.customer_id = B.customer_id
), T2 AS
(
SELECT DISTINCT A.customer_id, A.first_name, A.last_name, B.order_date
FROM sale.customer A, sale.orders B
WHERE A.customer_id = B.customer_id
)
SELECT *
FROM	T1, T2
WHERE	T1.laurels_order_dates = T2.order_date

----RECURSIVE CTE's



-- Create a table with a number in each row in ascending order from 0 to 9.



WITH T1 AS
(
	SELECT 0 AS NUMBER
	UNION ALL
	SELECT NUMBER +1
	FROM T1
	WHERE	NUMBER < 9
)
SELECT *
FROM T1



----------///////////////


--Write a query that returns all staff with their manager_ids. (Use Recursive CTE)






------//////////////////


--List the stores whose turnovers are under the average store turnovers in 2018.

WITH T1 AS
(
SELECT	C.store_name, SUM (quantity*list_price*(1-discount)) turnover_of_stores
FROM	sale.order_item A, sale.orders B, sale.store C
WHERE	A.order_id = B.order_id
AND		B.store_id = C.store_id
AND		YEAR (B.order_date) = 2018
GROUP BY 
		C.store_id, C.store_name
) , T2 AS 
(
SELECT	 AVG(turnover_of_stores) avg_turnover_2018
FROM	 T1
)
SELECT *
FROM	T1, T2
WHERE	T1.turnover_of_stores > T2.avg_turnover_2018


--Subquery in SELECT Statement

--Write a query that creates a new column named "total_price" calculating the total prices of the products on each order.


SELECT order_id, 
		(
			SELECT SUM(list_price)
			FROM	sale.order_item A
			WHERE	A.order_id = B.order_id
		)
FROM	sale.orders B




SELECT DISTINCT  order_id, 
		(
			SELECT SUM(list_price)
			FROM	sale.order_item A
			WHERE	A.order_id = B.order_id
		)
FROM	sale.orders B


--------SET OPERATORS 


-- UNION / UNION ALL

--List the products sold in the cities of Charlotte and Aurora

--103
SELECT	DISTINCT D.product_name
FROM	sale.customer A, sale.orders B, sale.order_item C, product.product D
WHERE	A.customer_id = B.customer_id 
AND		B.order_id = C.order_id
AND		C.product_id = D.product_id
AND		A.city = 'Aurora'

UNION
--75
SELECT	DISTINCT D.product_name
FROM	sale.customer A, sale.orders B, sale.order_item C, product.product D
WHERE	A.customer_id = B.customer_id 
AND		B.order_id = C.order_id
AND		C.product_id = D.product_id
AND		A.city = 'Charlotte'














