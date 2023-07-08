

--SESSION -4 joins


---ürünleri kategori isimleriyle birlikte getiriniz

SELECT *
FROM product.product


SELECT *
FROM product.category


SELECT	product.product.product_name, product.product.category_id, 
		product.category.category_id, product.category.category_name
FROM	product.product 
		INNER JOIN
		product.category
		ON	product.product.category_id = product.category.category_id
ORDER BY
		product.product.category_id


----

SELECT	A.product_name, A.category_id, 
		B.category_id, B.category_name
FROM	product.product AS A
		INNER JOIN
		product.category AS B
		ON	A.category_id = B.category_id
ORDER BY
		A.category_id


----------

SELECT	A.product_name, A.category_id, 
		B.category_id, B.category_name
FROM	product.product AS A
		JOIN
		product.category AS B
		ON	A.category_id = B.category_id
ORDER BY
		A.category_id


-----------

SELECT	A.product_name, A.category_id, 
		B.category_id, B.category_name
FROM	product.product A , product.category B
WHERE	A.category_id = B.category_id
ORDER BY
		2 DESC



--list employees of stores with their store information


SELECT	A.*, B.store_name
FROM	sale.staff A, sale.store B
WHERE	A.store_id = B.store_id


--Write a query that returns streets. The third character of the streets is numerical.

--street sütununda soldan üçüncü karakterin rakam olduðu kayýtlarý getiriniz.






