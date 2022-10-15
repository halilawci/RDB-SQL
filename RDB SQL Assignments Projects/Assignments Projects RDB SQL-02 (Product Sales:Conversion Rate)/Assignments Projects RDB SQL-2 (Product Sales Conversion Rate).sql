/* 
Assignments/Projects RDB/SQL-2 (Product Sales/Conversion Rate)

1- Product Sales

You need to create a report on whether customers who purchased the product named '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD' buy the product below or not.
'2TB Kırmızı 5400 rpm SATA III 3.5 Dahili NAS HDD' isimli ürünü satın alan müşterilerin aşağıdaki ürünü alıp almadığına dair bir rapor oluşturmanız gerekmektedir.

a. 'Polk Audio - 50 W Woofer - Black' -- (other_product)

To generate this report, you are required to use the appropriate SQL Server Built-in functions or expressions as well as basic SQL knowledge.
Bu raporu oluşturmak için, temel SQL bilgisinin yanı sıra uygun SQL Server Yerleşik işlevlerini veya ifadelerini kullanmanız gerekir.
*/

WITH T1 AS
(
SELECT	DISTINCT A.product_name, D.customer_id, D.first_name, D.last_name
FROM	product.product A, sale.order_item B, sale.orders C, sale.customer D
WHERE	A.product_id = B.product_id
AND		B.order_id = C.order_id
AND		C.customer_id = D.customer_id
AND		A.product_name = '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD'
), T2 AS
(
SELECT	DISTINCT A.product_name, D.customer_id, D.first_name, D.last_name
FROM	product.product A, sale.order_item B, sale.orders C, sale.customer D
WHERE	A.product_id = B.product_id
AND		B.order_id = C.order_id
AND		C.customer_id = D.customer_id
AND		A.product_name = 'Polk Audio - 50 W Woofer - Black'
)
SELECT	T1.customer_id, T1.first_name, T1.last_name,
		ISNULL (NULLIF (ISNULL(T2.first_name, 'No'), T2.first_name) , 'Yes') as is_otherproduct_order
FROM	T1
		LEFT JOIN
		T2
		ON	T1.customer_id = T2.customer_id

/* 
2- Conversion Rate

Below you see a table of the actions of customers visiting the website by clicking on two different types of advertisements given by an E-Commerce company. Write a query to return the conversion rate for each Advertisement type.

Aşağıda, bir E-Ticaret şirketi tarafından verilen iki farklı reklam türüne tıklayarak web sitesini ziyaret eden müşterilerin eylemlerinin bir tablosunu görüyorsunuz. Her bir Reklam türü için dönüşüm oranını döndürecek bir sorgu yazın.

a.    Create above table (Actions) and insert values,
a. Yukarıdaki tabloyu (Eylemler) oluşturun ve değerleri ekleyin, 

b.    Retrieve count of total Actions and Orders for each Advertisement Type,
b. Her Reklam Türü için toplam İşlem ve Emir sayısını alma,

c.    Calculate Orders (Conversion) rates for each Advertisement Type by dividing by total count of actions casting as float by multiplying by 1.0.
c. Her bir Reklam Türü için Sipariş (Dönüşüm) oranlarını, 1.0 ile çarparak değişken olarak yayınlanan toplam eylem sayısına bölerek hesaplayın.
*/
SELECT * INTO #TABLE1
FROM
( VALUES 			
				(1,'A', 'Left'),
				(2,'A', 'Order'),
				(3,'B', 'Left'),
				(4,'A', 'Order'),
				(5,'A', 'Review'),
				(6,'A', 'Left'),
				(7,'B', 'Left'),
				(8,'B', 'Order'),
				(9,'B', 'Review'),
				(10,'A', 'Review')
			) A (visitor_id, adv_type, actions)
WITH T1 AS
(
SELECT	adv_type, COUNT (*) cnt_action
FROM	#TABLE1
GROUP BY
		adv_type
), T2 AS
(
SELECT	adv_type, COUNT (actions) cnt_order_actions
FROM	#TABLE1
WHERE	actions = 'Order'
GROUP BY
		adv_type
)
SELECT	T1.adv_type, CAST (ROUND (1.0*T2.cnt_order_actions / T1.cnt_action, 2) AS numeric (3,2)) AS Conversion_Rate
FROM	T1, T2
WHERE	T1.adv_type = T2.adv_type