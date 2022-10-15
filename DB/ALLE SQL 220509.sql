
------------------------------------------------------------SQL KADIR  DATABASE--------------------------------------------------------------------------

-- Database (Veritabanı): Verileri anlamlı saklayan programdır.

/*SQL: Veri işlemleri içindir. Veritabanına kaydetme, okuma, güncelleme, 
silme (CRUD: Create,Read,Update,Delete) gibi işlemleri yaptığımız dildir.*/

/*
Örnek:
* Elbise Dolabı										-> Database / Veritabanı
	* Gömlekler										-> Table / Tablo
		*	Tip	*	Renk	*	...	*					-> Column / Item / Sutun / Başlık / Eleman
		-	...		-	...		-	...	-
		-	Uzun	-	Mavi	-	...	-					-> Row / Satır / Data / Veri
		-	Kısa	-	Mor	-	...	-
		-	...		-	...		-	...	-
	* Pantolonlar
		-	...		-	...		-	...	-
	* Kemerler
		-	...		-	...		-	...	-
*/

-- YORUM --

-- Tek satır yorum için iki-tire (--) kullanabilirim. iki-tire kullandıktan sonrası komple yorum satırı olur.

SELECT 1 AS One; -- Bundan sonrası yorumdur. (Kod geçersizdir: SELECT 2;)

/*
	TersSlaş-Yıldız ile istediğim gibi yorum yazabilirim.
	İster satır içi, ister çoklu satıra yazabilirim.
	Kapatmak için Yıldız-TersSlaş kullanmalıyım.
*/

SELECT 1 /* Kod içi yorum */ AS One;

-- SQL --

-- SQL is case insensitive (büyük-küçük harf ayrımı gözetmez)
-- BNF kurallar: (Python PEP8 gibi.)
-- * SQL komutları BÜYÜK HARF, tablo-sütun isimleri küçük harfle yazmamız beklenir.
/** String verilerde çift-tırnak ve tek-tırnak kullanabiliyor. 
(Her program çift-tırnak desteklemez). tek-tırnak (') kullanırın.*/
/** Noktalı-virgül (;) -> SQL işlemi yaptğınızda satır sonuna eklemeniz 
gereken ayıraçtır. Tek bir işlem yaptığnızda gerek yoktur. Çoklu işlemlerde mecburidir.*/

--noktalı virgül:
--SELECT 1;
-- select AlbumId, Title, ArtistId from albums; -- Çalışır ama BNF aykırı.

-- SELECT - Seç ve Getir.
-- FROM - Hangi tablodan?
-- SELECT AlbumId, Title, ArtistId FROM albums; -- Tavsiye edilen yöntemdir.
-- SELECT * FROM albums; -- Tüm sutunları getir.

-- AS - Tablo veya Sütun isimlendirme için kullanılır. -> Lakap takma :)
-- SELECT FirstName AS isim FROM clients; -- Sütün isimlendirme
-- SELECT (1+2-3) AS lakap; -- Matematiksel işlem isimlendirme
-- SELECT c.FirstName FROM clients AS c; -- Tablo isimlendirme
-- SELECT c.FirstName isim FROM clients c; -- Kısa kullanım

-- DISTINCT - Tekrar edilen kayıtarın tekrar edilmesini engeller (tek kayıt olarak getirir)
-- SELECT DISTINCT FirstName FROM clients; -- FirstName aynı olanları 1 defa getir.
-- SELECT DISTINCT FirstName, LastName FROM clients; -- (FirstName AND LastName) aynı olanları 1 defa getir.

-- WHERE -- Filtreleme
-- SELECT * FROM customers WHERE City = 'Berlin'; -- = Eşit olanlar.
-- SELECT * FROM customers WHERE CustomerId > 3; -- Büyük olanlar.
-- SELECT * FROM customers WHERE CustomerId >= 3; -- Dahil Büyük olanlar.
-- SELECT * FROM customers WHERE CustomerId < 3; -- Küçük olanlar.
-- SELECT * FROM customers WHERE CustomerId <= 3; -- Dahil Küçük olanlar.
-- SELECT * FROM customers WHERE CustomerId <> 3; -- Eşit olmayanlar
-- SELECT * FROM customers WHERE CustomerId != 3; -- Eşit olmayanlar
-- SELECT * FROM customers WHERE CustomerId BETWEEN 3 AND 15; -- Arasında olanlar
-- SELECT CustomerId, FirstName, LastName FROM customers WHERE CustomerId BETWEEN 3 AND 5; -- Arasında olanlar
-- SELECT * FROM invoices WHERE InvoiceDate BETWEEN '2009-01-01' AND '2009-02-15'; -- İki tarih arasındaki veriler.

-- LIMIT -- Limitler -- Default: LIMIT start=0, kaçtane=?
-- SELECT * FROM invoices LIMIT 20; -- İlk 20 kayıt
-- SELECT * FROM invoices LIMIT 0, 20; -- İlk 20 kayıt
-- SELECT * FROM invoices LIMIT 20, 25; -- İlk 20 kayıt
-- SELECT * FROM invoices LIMIT 20, 25; -- İlk 20'den sonraki (20 hariç) 25 adet kayıt getir.

-- ORDER BY - Sıralama - Default: ASC
-- SELECT * FROM invoices ORDER BY InvoiceDate ASC; -- Yakın tarihten uzağa sırala.
-- SELECT * FROM invoices ORDER BY InvoiceDate DESC; -- Uzak tarihten yakın sırala.
-- SELECT * FROM invoices ORDER BY InvoiceDate; -- Default: ASC
-- SELECT * FROM invoices ORDER BY BillingAddress ASC; -- A -> Z sırala. (Önce rakamlar)
-- SELECT * FROM invoices ORDER BY BillingAddress DESC; -- Z -> A sırala. (Sonra rakamlar)
-- SELECT * FROM invoices ORDER BY BillingCity DESC, BillingAddress ASC; -- Önce BillingCity DESC, sonra BillingAddress ASC
-- SELECT * FROM invoices ORDER BY BillingCountry DESC, BillingCity ASC;
-- SELECT * FROM invoices WHERE CustomerId = 54 ORDER BY InvoiceDate ASC -- Müşteri ID'si = 54 olan faturaları getir ve tarihe göre sırala.
-- SELECT * FROM invoices WHERE CustomerId = 54 ORDER BY InvoiceDate ASC LIMIT 3 -- Müşteri ID'si = 54 olan faturaları getir ve tarihe göre sırala. ilk 3 kayıt

-- AND, OR, NOT -- WHERE içinde kullanılır. (ORDER BY için virgül kullanılır.)
-- SELECT * FROM invoices WHERE CustomerId = 54 AND InvoiceDate <= '2010-09-13'; --  54 nolu müşteri ve bu tarihte önceki kayıtlar.
-- SELECT * FROM invoices WHERE CustomerId = 54 OR CustomerId = 42; -- Hem 42 hem de 54 numaralı müşterilerin faturaları.
-- SELECT * FROM invoices WHERE (CustomerId = 54 AND InvoiceDate <= '2010-09-13') OR CustomerId = 42; -- AND ve OR kullanımı.
-- SELECT * FROM invoices WHERE NOT CustomerId = 54; -- 54 olmayan müşterilerin faturalarını getir.
-- SELECT * FROM invoices WHERE CustomerId <> 54; -- 54 eşit olmayan müşterilerin faturalarını getir.
-- SELECT * FROM invoices WHERE InvoiceDate >= '2008-09-01' AND CustomerId = 54 AND NOT Total <= 2; -- Çoklu kullanım
-- SELECT * FROM customers WHERE CustomerId NOT BETWEEN 3 AND 15; -- Arasında OLMAYAN
-- SELECT * FROM invoices ORDER BY Total ASC LIMIT 10; -- En düşük fatura tutarına ait ilk 10 kayıt.

-- IN -- İçindekilerden biri mi?
-- NOT IN -- İçindekilerinden hiçbiri ?
-- SELECT * FROM invoices WHERE CustomerId = 50 OR CustomerId = 51 OR CustomerId = 52 OR CustomerId = 53 OR CustomerId = 54; -- Daha kısa yolu var -> IN :)
-- SELECT * FROM invoices WHERE CustomerId IN (50, 51, 52, 53, 54); -- Müşteri numaralası parantez içinde yazılı OLAN getir. (OR olarak düşünülebilir.)
-- SELECT * FROM invoices WHERE CustomerId NOT IN (50, 51, 52, 53, 54); -- Müşteri numaralası parantez içinde yazılı OLMAYAN getir. (AND olarak düşünülebilir.)
-- SELECT * FROM invoices WHERE CustomerId BETWEEN 50 AND 55; -- 50 ile 55 arasını getir.

-- LIKE -- İçinde ara. (insensitive -> Küçük büyük harf ayrımı yapmaz.)
-- Yüzde (%) ve alt-tire (_) -> JOKER KARAKTERLER
-- % -> "Karakter limiti YOK ve herhangi bir karakter" 
-- _ -> "Karakter limiti VAR, her bir alt-tire bir (herhangi) karakteri temsil eder"
-- SELECT * FROM invoices WHERE BillingCountry LIKE 'G%'; -- G ile başlayan ülkelerin faturaları
-- SELECT * FROM invoices WHERE BillingCountry LIKE 'U%'; -- U ile başlayan ülkelerin faturaları
-- SELECT * FROM invoices WHERE BillingCountry LIKE '%SA%'; -- İçinde SA olan ülkelerin faturaları
-- SELECT * FROM invoices WHERE BillingCountry LIKE '%M%'; -- İçinde M olan ülkelerin faturaları
-- SELECT * FROM invoices WHERE BillingCity LIKE '%e%o%'; -- İçinde a ve b olan (yanyana olmak zorunda değil, olabilir de)
-- SELECT * FROM invoices WHERE BillingCity LIKE '%o'; -- O ile biten
-- SELECT * FROM invoices WHERE BillingCity LIKE '%e%o'; -- İçinde E geçen ve O ile biten
-- SELECT * FROM invoices WHERE BillingCity LIKE '_e%'; -- İlk karakteri önemsiz, ama ikinci karakteri E olan
-- SELECT * FROM invoices WHERE BillingCity LIKE '_e_m%'; -- 1:önemsiz, 2:E, 3. önemsiz, 4: M ... olan

-- COUNT -- Çağırdığımız verinin kayıt Sayısı.
-- SELECT COUNT(*) FROM invoices; -- Satır sayısı -> (*) kullanmasan olmaz mı?
-- SELECT COUNT(InvoiceId) FROM invoices;
-- SELECT COUNT(InvoiceId) AS fatura_adet FROM invoices WHERE BillingCountry LIKE 'G%';

-- SUM - Toplama -> İçindeki veriler sayı olmak zorunda.
-- SELECT SUM(Total) AS Toplam FROM invoices;
-- SELECT SUM(Total) AS toplam FROM invoices WHERE BillingCity LIKE '_e%';

-- AVG - Ortalama
-- SELECT AVG(Total) AS ortalama FROM invoices;
-- SELECT AVG(Total) AS ortalama FROM invoices WHERE BillingCity LIKE '_e%';

-- ROUND -> Yuvarlar. -> ROUND(sayı, noktadanSonraHaneSayisi)
-- SELECT ROUND(AVG(Total), 2) AS ortalama FROM invoices WHERE BillingCity LIKE '_e%'; 

------------------------------------------------------------------SQL KADIR 2. DERS------------------------------------------------------------------- 

  -- SUM, AVG, MIN, MAX, COUNT
-- Veriyi tek satırda getirir.
-- SELECT BillingCity, SUM(Total) AS toplam_tutar  FROM invoices;  -- SUM ->Topla
-- SELECT BillingCity, ROUND(AVG(Total), 2) AS toplam_tutar  FROM invoices;  -- AVG -> Ortalama (ROUND -> Yuvarla)
-- SELECT BillingCity, MIN(Total) AS toplam_tutar  FROM invoices;  -- MIN -> Min
-- SELECT BillingCity, MAX(Total) AS toplam_tutar  FROM invoices;  -- MAX -> Max
-- SELECT BillingCity, COUNT(Total) AS toplam_tutar  FROM invoices;  -- COUNT -> Satır Sayısı
-- SELECT BillingCity, MIN(BillingCity) AS toplam_tutar  FROM invoices;  -- MIN -> Min (STRING veride çalışıyor.)
-- SELECT BillingCity, MAX(BillingCity) AS toplam_tutar  FROM invoices;  -- MAX -> Max (STRING veride çalışıyor.)

-- GROUP BY -> GRUPLAMA YAPAR.

/*
-- Şehre göre toplam tutar getir:
SELECT BillingCity, SUM(Total) AS toplam_tutar 
FROM invoices
GROUP BY BillingCity; 
*/

-- Min Tutara göre sırala:
-- SELECT BillingCity, MIN(Total) AS min_tutar  FROM invoices GROUP BY BillingCity ORDER BY min_tutar ASC, BillingCity DESC;
-- Tutara göre sırala:
-- SELECT BillingCity, Total FROM invoices GROUP BY BillingCity ORDER BY Total ASC, BillingCity ASC;
-- Karakter uzunluğuna göre sırala:
-- SELECT LENGTH(BillingCity) AS karakter_sayisi, BillingCity, Total FROM invoices ORDER BY BillingState ASC, BillingCity ASC, Total ASC;
-- SELECT LENGTH(12113) AS number, LENGTH('sadnashds') AS string;  -- LENGTH -> HEm sayı hem de yazı -> karakter sayısı.
-- SELECT BillingCity, SUM(Total) AS toplam_tutar  FROM invoices GROUP BY BillingCity;  -- Fatura toplam tutar (şehre göre)
-- SELECT BillingCity, COUNT(Total) AS toplam_tutar  FROM invoices WHERE BillingCity LIKE 'B%' GROUP BY BillingCity;
-- SELECT BillingCity, COUNT(Total) AS toplam_tutar  FROM invoices WHERE LEFT(BillingCity, 1) IN ('B', 'C') GROUP BY BillingCity;

-- LEFT, RIGHT
-- SELECT LEFT('ABCD', 1) AS ilk_karakter;
-- SELECT RIGHT('ABCD', 1) AS son_karakter;

/*
-- DATA ÇAĞIRAN TEMEL KOMUTLAR:
SELECT 
FROM
JOIN
WHERE
-- ÇAĞRILMIŞ DATA İŞLEMLERİ:
SELECT DISTINCT  -- Aynı kayıtları 1 defa göster.
GROUP BY  -- Gruplar.
HAVING  -- Gelen data içinde filtreleme.
ORDER BY  -- Sıralar.
LIMIT  -- Sınırlı adet getir. (limitler)
-- EKSTRA
UNION (ALL)  -- Çağrılmış birden fazla datayı birleştirir. (sutun sayısı ve sutun isimleri/lakapları aynı olmak ZORUNDA)
*/

     -- -- -- -- - -  JOINS    -- -- -- - -  - -  - 

/*
INNER JOIN -> Kısa Kullanım: JOIN  -- Tercih: INNER JOIN - Kesişim kayıtlar
LEFT OUTER JOIN -> Kısa: LEFT JOIN - Ana tablo hepsi, kesişimleri de göster.
RIGHT OUTER JOIN -> Kısa: RIGHT JOIN - Join tablo hepsi, kesişimleri de göster.
FULL OUTER JOIN - Her iki tablo hepsi, kesişimleri de göster.
CROSS JOIN -> Kısa: FROM içinde - İlişkisiz tüm tabloları yanyana yaz.
*/

-- INNER JOIN:

/*
SELECT c.FirstName, c.LastName, c.Company, i.InvoiceDate, i.Total
FROM invoices AS i
INNER JOIN customers AS c ON i.CustomerId=c.CustomerId
WHERE c.FirstName LIKE 'L%';
*/

/*
SELECT c.FirstName, c.LastName, c.Company, i.InvoiceDate, SUM(i.Total) AS toplam_fatura
FROM invoices AS i
INNER JOIN customers AS c ON c.CustomerId=i.CustomerId  -- Sıra önemsiz, bu da çalışır -> c.CustomerId=i.CustomerId
GROUP BY c.Company, c.FirstName
ORDER BY i.InvoiceId ASC;
*/

/*
SELECT c.CustomerId, c.FirstName, c.LastName, c.Company, i.InvoiceDate, SUM(i.Total) AS toplam_fatura
FROM invoices AS i
INNER JOIN customers AS c ON c.CustomerId=i.CustomerId AND c.CustomerId>5
GROUP BY c.Company, c.FirstName
ORDER BY i.InvoiceId ASC;
*/

-- LEFT JOIN:
 

/*
SELECT ar.Name, al.Title
FROM artists AS ar
LEFT JOIN albums AS al ON al.ArtistId=ar.ArtistId
GROUP BY ar.ArtistId;
*/

-- RIGHT JOIN:
 

/*
SELECT *
FROM artists AS ar
RIGHT JOIN albums AS al ON al.ArtistId=ar.ArtistId;
*/

-- FULL OUTER JOIN:
 

/*
SELECT *
FROM artists AS ar
FULL OUTER JOIN albums AS al ON al.ArtistId=ar.ArtistId
*/

-- CROSS JOIN

/*
SELECT *
FROM invoices
CROSS JOIN customers;
*/

/*
-- Kısa Kullanım:
SELECT *
FROM invoices, customers;
*/

/*
SELECT i.InvoiceDate, i.BillingCity, c.FirstName, c.LastName
FROM invoices AS i, customers AS c;
*/









--write a query that return distinct Albumld,MediaTypeld pairlect 

SELECT AlbumId, MediaTypeId
FROM tracks

SELECT DISTINCT AlbumId, MediaTypeId
FROM tracks

-----WEHERE AND LIMIT KONULARI

---Jimi Hendrix'in parçalarının ismini getir

SELECT * FROM tracks   ----tracks tablosunda ne var yok şu an ona bbakıyorum


SELECT *

FROM tracks

WHERE Composer = 'Jimi Hendrix'

--tekrar eden kayıt var mı diye bakalım şimdi

SELECT DISTINCT name

FROM tracks

WHERE Composer = 'Jimi Hendrix'

--

 SELECT *
 
 FROM tracks
 
 WHERE Composer = 'Jerry Cantrell'
 
 --10 $ dan yüksek tutara sahip invoice'ları getir

SELECT *
FROM invoices
WHERE total > 10

------------LIMIT--------------
--10$ DAN DAHA BÜYÜK TUTARI OLAN İNVOİCES'İN BİLGİSİNİ BUL.SONRA AZALAN SIRAYA GÖRE ONLARI SIRALA

SELECT *

FROM invoices

WHERE total > 10

ORDER BY total DESC;

---------------------------------AND-OR-NOT-------------
---BİLLLİNGCOUNTRY'Sİ USE OLMAYANLARI İNVOİCES TABLOSUNDAN BUL.SONRA ONLARI TOTAL DA ARTAN SIRAYA GÖRE SIRLA

SELECT *

FROM invoices

WHERE NOT BillingCountry = 'USA'

---
  
SELECT *

FROM invoices

WHERE BillingCountry <> 'USA'

--

SELECT *

FROM invoices

WHERE BillingCountry != 'USA'

ORDER BY ASC

--BERLİNDE 2 $ DAN YüKSEK TUTARA SAHİP İNVOİCE'LARI GETİRİN

SELECT *

FROM invoices

WHERE BillingCity = ' Berlin' AND total >2

ORDER BY total 
 
 --berlinde veya london'da  2 dolardan yüsek tutara sahip invoice'leri getir
 
SELECT *

FROM invoices

WHERE (BillingCity = ' Berlin ' OR BillingCity = 'london') AND  total > 2

--BERLİN DE VEYA LONDON DA OLMAYAN VE 2 DOLARDAN YÜKSEK TUTARA SAHİP İNVOİCE'LARI GETİR
 
SELECT *

FROM invoices

WHERE (BillingCity != 'Berlin' OR BillingCity != 'London') AND total > 2 

--not : or parantez için de bu şekilde yazoyor conditionları unutma!!!!! sadece bu orda geçerli

------BETWEEN operatörü---------

---2009 ve 2010 yılları arasında düzenlenen en son fatura tarihi getir 

SELECT *
FROM invoices
WHERE InvoiceDate BETWEEN '2009-01-01' AND  '2010-12-31'
ORDER BY InvoiceDate

--2010 DAKİ EN SONUNCU FATURAYI YUKARIYA ÇIKARMAK İÇİN

SELECT *
FROM invoices
WHERE InvoiceDate BETWEEN '2009-01-01' AND '2010-12-31'
ORDER BY InvoiceDate DESC
LIMIT 1

--------------------IN  / IN NOT ---------------------
-----BELÇİKA,NORWEÇ,KANADA VE USA DAN SİPARİŞ VEREN MÜŞTERİLERİN İSİM VE SOY İSMİNİ BUL


SELECT FirstName,LastName
FROM customers

WHERE country IN ('BELGİUM','CANADA','USA','NORWAY')

--bach'ın parçalarını bu

SELECT *

FROM tracks

WHERE Composer LİKE '%Bach'









/*SELECT 2;*/

SELECT 1+1;

SELECT 1;

SELECT 2;

--- AS sutuna isim veriri

SELECT 2 AS VALUE;

SELECT 2 AS value;

--

SELECT 2 +2 AS value;

--

SELECT 'Hello World' AS value;
SELECT "Hello World" AS value;

--

SELECT "Hello World", 2 AS value;

--

SELECT "Hello World" AS column_1, 2 AS value;

--

SELECT "Hello World" column_1, 2 AS  value;

--

SELECT "Hello World" column_1, nobody cloumn_3, 2 AS  calumn_2;

--

SELECT "sorgu bitti";

--

SELECT name
FROM	tracks

--

SELECT name, composer
FROM	 tracks;

--

SELECT *
FROM	 tracks;

--

/* Tracks tablosundan composer,lari donduren 
bir sorgu yazin distinct ayni degerleri kaldirir 
distinc tekrak eden satirlari kaldirir.
Satir icin gcerli. distinct calssabilmesi icin
tum egerlerin ayni olmasi lazim*/

SELECT   Composer
FROM tracks

--

SELECT  DISTINCT Composer
FROM tracks

--

SELECT   MediaTypeId, GenreId
FROM tracks

--

SELECT   DISTINCT MediaTypeId, GenreId
FROM tracks

--

SELECT DISTINCT  *
FROM tracks

--

SELECT   *
FROM tracks

--

SELECT   DISTINCT MediaTypeId, GenreId
FROM tracks;

/*Aslında öğrencilerin kaydolabileceği 6 benzersiz veya farklı alan vardır. 
Sütun alanındakiCOUNT(DISTINCT field) benzersiz 
ve boş olmayan değerlerin sayısını döndürür .
Cümle ile de birleştirebiliriz COUNT(DISTINCT)veya 
COUNT()işlev görebiliriz WHERE. 
Örneğin, Virginia'dan gelen öğrencilerin sayısını görüntüleyin.*/

--DISTINCT AlbumId ve MediaTypeId biliglerini getiriniz  220512

SELECT  DISTINCT AlbumId, MediaTypeId
FROM  tracks

--Jimi Hendrix parcalarinin isimleri getir

SELECT DISTINCT name
FROM tracks	
WHERE Composer = 'Jimi Hendrix'

--v10 dolardan yuksek tutar sahip invoiceleri getiriniz

SELECT *
FROM invoices
WHERE  total>10

--v10 dolardan yuksek tutar ilk 4 tutar sahip invoiceleri getiriniz

SELECT *
FROM invoices
WHERE  total>10 LIMIT 4

/*biling country USa olmayan invoiceleri getiriniz 
ve atan sirayla tatal sutununda siralayiniz*/

SELECT *
FROM invoices
WHERE NOT BillingCountry = 'USA'
ORDER BY total ASC

---berlinde 2 $ dan yuksek tutara sahi p invoiceleri getir

SELECT *
FROM invoices
WHERE BillingCity = "Berlin" AND total>2
ORDER BY total
LIMIT 4

-- berlinde veya londonda2 $ dan yuksek tutara sahi p invoiceleri getir

SELECT *
FROM invoices
WHERE( BillingCity =  "London" OR BillingCity = "Berlin" )AND total>2
ORDER BY Total ASC

SELECT *
FROM invoices
WHERE( BillingCity =  "London" OR BillingCity = "Berlin" )AND total>2
ORDER BY Total DESC

/*berlinde veya londonda2 $ da olmayan 
yuksek tutara sahi p invoiceleri getir*/

SELECT *
FROM invoices
WHERE InvoiceDate BETWEEN "2009-12-31" AND "2010-12-31"
ORDER BY InvoiceDate DESC
LIMIT 1

--belcika kanada norvec usa den siparis verlernler

SELECT FirstName, LastName
FROM customers
WHERE  Country IN ("Belgium", "Canada", "USA", "Norway")

--like  bach

SELECT *
FROM tracks
WHERE Composer LIKE "%Bach"

--tum data bese kac tane invoince duzenlenmis

SELECT count (*) FROM invoices 

/*invoices tablosunda billingstate sutununda 
nuull olmayan larin sayiasini bul*/



----------------------------------SQL 1. Ders Not Defteri   220509---------------------------------------------

--SQL Fundamentals SQL' in temelleri

SELECT 1+1

SELECT 1+1;

--

SELECT 1;

SELECT 2

--

SELECT 2 AS VALUE;

SELECT 2 AS value;  

--

SELECT 2+2 AS value;

-----

SELECT 'Hello World' AS value;


SELECT "Hello World" AS value;

--

SELECT "Hello World", 2 AS value;

SELECT "Hello World" AS column_1, 2 AS column_2;

-- Tracks tablosundan track name sütununu getiren bir sorgu yazınız.

SELECT name
FROM	tracks;

--

SELECT 	name, composer
FROM	tracks;

--

SELECT 	*
FROM	tracks;

-- Tracks tablosundan composer' ları döndüren bir sorgu yazınız.

SELECT DISTINCT MediaTypeId, GenreId 
FROM	tracks;

--

SELECT DISTINCT MediaTypeId, GenreId 
FROM	tracks

--

SELECT DISTINCT *
FROM	tracks

--------------------------------------SQL 2. Ders Not Defteri   220512-----------------------------------------

-- DISTINCT AlbumId ve MediaTypeId bilgilerini getiriniz.

SELECT DISTINCT AlbumId, MediaTypeId
FROM	tracks

---- WHERE AND LIMIT

-- Jimi Hendrix' in parçalarının isimlerini getiriniz.

SELECT name
FROM tracks
WHERE Composer = 'Jimi Hendrix'

---10 dolardan yüksek tutara sahip invoice' ları getiriniz.

SELECT *
FROM	invoices
WHERE	total>10

--

SELECT *
FROM	invoices
WHERE	total>10
ORDER BY	total DESC

-/*BillingCountry USA olmayan invoice' leri getiriniz ve 
artan sırayla total sütununu sıralayınız.*/

SELECT *
FROM	invoices
WHERE NOT BillingCountry = 'USA'

---yanlış sonuç

SELECT *
FROM	invoices
WHERE NOT BillingCountry = 'usa'

--

SELECT *
FROM	invoices
WHERE  BillingCountry <> 'USA'

--

SELECT *
FROM	invoices
WHERE  BillingCountry != 'USA'
ORDER BY total DESC

/*Berlin' de 2 dolardan yüksek tutara sahip invoice' ları getiriniz.*/

SELECT *
FROM invoices
WHERE BillingCity = 'Berlin' AND total > 2
ORDER BY total

--

SELECT *
FROM invoices
WHERE BillingCity = 'Berlin' AND total > 2
ORDER BY total
LIMIT 3

--

SELECT *
FROM invoices
WHERE BillingCity = 'Berlin' AND total > 2
ORDER BY total DESC
LIMIT 3

/*Berlin' de veya London' da 2 dolardan 
yüksek tutara sahip invoice' ları getiriniz.*/

SELECT *
FROM invoices
WHERE (BillingCity = 'Berlin' OR BillingCity = 'London') AND total > 2

/*Berlin' de veya London' da olmayan ve 
2 dolardan yüksek tutara sahip invoice' ları getiriniz.*/

/*2009 ve 2011 yılları arasında düzenlenen 
en son faturanın tarihini getiriniz*/

SELECT 	InvoiceDate
FROM	invoices
WHERE	InvoiceDate BETWEEN '2009-01-01' AND '2010-12-31'
ORDER BY InvoiceDate DESC
LIMIT 1

/*Belçika, Norveç, Kanada ve USA' den sipariş veren 
müşterilerin isim ve soyisimlerini getiriniz.*/

SELECT FirstName, LastName
FROM	customers
WHERE	Country IN ('Belgium', 'Canada', 'USA', 'Norway')

---Bach' ın parçalarını getiriniz

SELECT *
FROM	tracks
WHERE Composer LIKE '%Bach'

----------------------------------------------Aggregate Functions---------------------------------------------------

-- Kaç adet invoice mevcut?

--ITF SQL Session 3 Aggregate Functions 220516

/*2011-05-16 tarihinden sonra USA veya Kanada' d
düzenlenen en yüksek tutara sahip InvoiceId' yi getiriniz.*/

SELECT 	InvoiceId, total
FROM	invoices
WHERE	InvoiceDate > '2011-05-16'
AND		BillingCountry IN ('USA', 'Canada')
ORDER BY 2 DESC
LIMIT 1

--Düzenlenen kaç adet invoice mevcut?

SELECT	COUNT(InvoiceId)
FROM	invoices

SELECT	COUNT(*)
FROM	invoices

--Kaç state'te fatura düzenlenmiştir?

SELECT 	COUNT (BillingState)
FROM 	invoices

SELECT 	COUNT (*)
FROM 	invoices

SELECT 	COUNT (*)
FROM 	invoices
WHERE 	BillingState IS NOT NULL

--Kaç state'te fatura düzenlenmiştir?
--Kaç farklı state'te fatura düzenlenmiştir?

SELECT 	COUNT (DISTINCT BillingCountry)
FROM 	invoices
order by BillingCountry

--Database' de kaç farklı composer mevcut?

SELECT 	COUNT (DISTINCT composer) as num_of_composer
FROM 	tracks


--minimum ve maximum süreye sahip track' leri getiriniz

SELECT MIN(Milliseconds) as Minimum_dur , MAX (Milliseconds) as Max_duration
FROM 	tracks

--MIN DURATION TRACK

SELECT	NAME, Milliseconds
FROM	tracks
WHERE	Milliseconds = 1071


--MAX DURATION TRACK

SELECT	NAME, Milliseconds
FROM	tracks
WHERE	Milliseconds = 5286953

---Mağazamız ne kadar kazanmıştır?

SELECT 	SUM(total)
FROM 	invoices

---Ortalama süreden uzun track name' leri getiriniz

SELECT 	AVG(Milliseconds)
FROM	tracks

SELECT 	name, Milliseconds ,  393599.212103911 AS AVG_DUR
FROM	tracks
WHERE	Milliseconds > 393599.212103911
ORDER BY Milliseconds ASC

---Her bir composer' ın kaç adet track' e sahip olduğunu getiriniz/raporlayınız.

SELECT	COUNT (NAME), COUNT (*), COUNT (DISTINCT NAME), COUNT (TrackId), COUNT (DISTINCT TrackId)
FROM	tracks

SELECT 	Composer, COUNT (TrackId)
FROM	tracks
GROUP BY	Composer

--Her bir country' deki müşteri sayısını getiriniz.

SELECT	Country, COUNT (CustomerId) AS CNT_CUSTOMER
FROM	customers
GROUP BY Country
ORDER BY 2 DESC

--Albümlerin minimum süreli tracklerini getiriniz

SELECT 	AlbumId, MIN (Milliseconds)
FROM	tracks
GROUP BY AlbumId


--Her bir country' den kazanılan toplam tutarı hesaplayınız.

SELECT 	SUM(total)
FROM	invoices

SELECT 	BillingCountry, SUM(total) AS total_income
FROM	invoices
GROUP BY BillingCountry
ORDER BY 2

--City kırılımını da eklersek...

SELECT 	BillingCountry, BillingCity, SUM(total) AS total_income
FROM	invoices
GROUP BY BillingCountry, BillingCity

-----------------------------------------------------3. DERS----------------------------------------------------------------

---- toplam kaç stır varsa sayar NULL değerler dahil

SELECT count (*)
FROM invoices

--- NULL değerleri saymadı

SELECT count (BillingState)
FROM invoices

----- 2011-05-16 tarihinden sonra USA veya Kanada'da düzenlenen en yüksek tutara sahip İnvoiceId nedir?

SELECT InvoiceId
FROM invoices
WHERE BillingCountry = 'USA' OR BillingCountry ='Canada'
AND InvoiceDate >'2011-05-16'
ORDER BY total DESC
LIMIT 1

----- kaç adet invoice var?

SELECT count(InvoiceId)
FROM invoices

--- (412)

SELECT count(*)
FROM invoices

SELECT count(*)
FROM invoices
WHERE BillingState IS NOT NULL

----primary key (uniq) olur sadece 1 tane vardır.

--- kaç farklı state de fatura kesilmiştir.(24)

SELECT count(DISTINCT BillingCountry)
FROM invoices
ORDER BY BillingCountry

--- database'de kaç farklı compose var? 
---(3503 composer satırı var

SELECT count(*)
FROM tracks

---2525 composer var,

SELECT count(Composer)
FROM tracks

---852 farklı composer var

SELECT count(DISTINCT composer)
FROM tracks

----en kısa ve en uzun süreli trackleri bul

SELECT min(Milliseconds) as min_dur, max(Milliseconds) as max_dur
FROM tracks

---- bulduk fakat isimleri yok bunun için

SELECT name, Milliseconds
FROM tracks
WHERE Milliseconds = 1071

----mağaza ne kadar para kazandı?(2328.6)

SELECT sum(total)
FROM invoices

----ortalama süreden uzun track isimleri nedir?
--- önce ortalam süre bulunur

SELECT avg(Milliseconds)
FROM tracks

--- sonra bu süreden büyük track isimleri çağırılır.

SELECT name
FROM tracks
WHERE Milliseconds > 393599.212103911

---- her parçanın uzunluğu ve ortalam değerde bulunsun ki kontrol edebileyim
--- 393599.212103911 bu her satırda yazar

SELECT name, Milliseconds, 393599.212103911 AS AVG_DUR
FROM tracks
WHERE Milliseconds > 393599.212103911
ORDER BY Milliseconds ASC


-- GRUP BY Clause(broken by diye sorulur)
-- broken by gender, gender kırılımında grupla demek
-- %99 Aggerate ile birlikte kullanılır.

-- ablumıd ye göre isimleri grupla

SELECT name, count(name)
FROM tracks
GROUP By AlbumId

--- herbir yazarın toplam track sayısını göster

SELECT composer, Count(name)
FROM tracks
GROUP BY Composer
----
SELECT count(*), Count(name), count(DISTINCT name), count (TrackId), count(DISTINCT TrackId)
FROM tracks

-- trackıd uniq olduğu için onu sayarız.

SELECT composer, Count(TrackId)
FROM tracks
GROUP BY Composer

---- her ülkeden kaç müşterim var?
-- çıktı conrty/number olacak

SELECT Country, count (CustomerId) AS Customer_Num
FROM customers
GROUP BY Country
ORDER BY 2 DESC

--- burada order by 2 (2nci sütunu sırala demek)

-- her albümün en kısa süreli track'ini bul

SELECT AlbumId, MIN(Milliseconds)
FROM tracks
GROUP BY AlbumId

---- toplam kaç stır varsa sayar NULL değerler dahil
SELECT count (*)
FROM invoices

--- NULL değerleri saymadı
SELECT count (BillingState)
FROM invoices

----- 2011-05-16 tarihinden sonra USA veya Kanada'da düzenlenen en yüksek tutara sahip İnvoiceId nedir?
SELECT InvoiceId
FROM invoices
WHERE BillingCountry = 'USA' OR BillingCountry ='Canada'
AND InvoiceDate >'2011-05-16'
ORDER BY total DESC
LIMIT 1

----- kaç adet invoice var?
SELECT count(InvoiceId)
FROM invoices

--- (412)
SELECT count(*)
FROM invoices

SELECT count(*)
FROM invoices
WHERE BillingState IS NOT NULL

----primary key (uniq) olur sadece 1 tane vardır.

--- kaç farklı state de fatura kesilmiştir.(24)
SELECT count(DISTINCT BillingCountry)
FROM invoices
ORDER BY BillingCountry

--- database'de kaç farklı compose var? 
---(3503 composer satırı var

SELECT count(*)
FROM tracks

---2525 composer var,

SELECT count(Composer)
FROM tracks

---852 farklı composer var

SELECT count(DISTINCT composer)
FROM tracks

----en kısa ve en uzun süreli trackleri bul

SELECT min(Milliseconds) as min_dur, max(Milliseconds) as max_dur
FROM tracks

---- bulduk fakat isimleri yok bunun için

SELECT name, Milliseconds
FROM tracks
WHERE Milliseconds = 1071

----mağaza ne kadar para kazandı?(2328.6)

SELECT sum(total)
FROM invoices

----ortalama süreden uzun track isimleri nedir?
--- önce ortalam süre bulunur

SELECT avg(Milliseconds)
FROM tracks

--- sonra bu süreden büyük track isimleri çağırılır.

SELECT name
FROM tracks
WHERE Milliseconds > 393599.212103911

---- her parçanın uzunluğu ve ortalam değerde bulunsun ki kontrol edebileyim
--- 393599.212103911 bu her satırda yazar

SELECT name, Milliseconds, 393599.212103911 AS AVG_DUR
FROM tracks
WHERE Milliseconds > 393599.212103911
ORDER BY Milliseconds ASC

-- GRUP BY Clause(broken by diye sorulur)
-- broken by gender, gender kırılımında grupla demek
-- %99 Aggerate ile birlikte kullanılır.

-- ablumıd ye göre isimleri grupla

SELECT name, count(name)
FROM tracks
GROUP By AlbumId

--herbir yazarın toplam track sayısını göster

SELECT composer, Count(name)
FROM tracks
GROUP BY Composer

---
SELECT count(*), Count(name), count(DISTINCT name), count (TrackId), count(DISTINCT TrackId)
FROM tracks

--trackıd uniq olduğu için onu sayarız.

SELECT composer, Count(TrackId)
FROM tracks
GROUP BY Composer

---- her ülkeden kaç müşterim var?
-- çıktı conrty/number olacak

SELECT Country, count (CustomerId) as Customer_Num
FROM customers
GROUP BY Country
ORDER BY 2 DESC

--- burada order by 2 (2nci sütunu sırala demek)
-- her albümün en kısa süreli track'ini bul

SELECT AlbumId, MIN(Milliseconds)
FROM tracks
GROUP BY AlbumId

-------------------------------------------C12 ITF SQL Session 4 - Joins-----------------------------------------

-- USA' den elde edilen kazancı şehirlere göre raporlayınız.

SELECT	BillingCity, SUM (total) AS Total_income
FROM	invoices
WHERE	BillingCountry = 'USA' AND InvoiceDate between '2010-12-25' and '2010-12-31'
GROUP BY BillingCity
ORDER BY 2

-- tracks tablosundaki her bir track' in genre bilgisini getiriniz.

SELECT	*
FROM	tracks 
INNER JOIN genres ON tracks.GenreId = genres.GenreId


SELECT	tracks.* , genres.Name
FROM	tracks INNER JOIN genres ON tracks.GenreId = genres.GenreId


SELECT	tracks.name AS Track_name , genres.Name AS genre_name
FROM	tracks INNER JOIN genres ON tracks.GenreId = genres.GenreId


SELECT	A.name AS Track_name , B.Name AS genre_name
FROM	tracks AS A
INNER JOIN genres AS B 
ON A.GenreId = B.GenreId

---yukarıdaki sorgu sonucunda kaç farklı genre_name vardır?

SELECT	count (distinct B.name)
FROM	tracks AS A
INNER JOIN genres AS B 
ON A.GenreId = B.GenreId

--- Her bir çalışanın 2010-12-05 tarihindeki satış bilgilerini getiriniz.

SELECT	invoices.*, employees.*
FROM	employees
		INNER JOIN customers ON employees.EmployeeId = customers.SupportRepId
		INNER JOIN invoices ON customers.CustomerId = invoices.CustomerId
WHERE	invoices.InvoiceDate > '2010-09-14'
order by invoices.InvoiceDate

--Her faturanın müşterisinin isim bilgisini getiriniz

SELECT 	A.InvoiceId, B.FirstName, B.LastName
FROM	invoices AS A
JOIN customers AS B ON A.CustomerId = B.CustomerId

----

SELECT 	count (distinct CustomerId)
FROM	invoices 

---Her bir artist' in Albüm bilgilerini yazdırınız.

--INNER JOIN

SELECT	B.name AS Artist_Name, A.Title, A.ArtistId
FROM	albums AS A
		INNER JOIN artists AS B ON A.ArtistId = B.ArtistId
ORDER BY 1

--LEFT JOIN

--Acaba db' deki tüm artistlerin Albüm bilgisi mevcut mudur?

SELECT	artists.Name AS artist_name , albums.Title, albums.ArtistId
FROM	artists 
		LEFT JOIN  albums  
		ON artists.ArtistId = albums.ArtistId
ORDER BY 2

--

SELECT	artists.Name AS artist_name , albums.Title, albums.ArtistId
FROM	albums 
		LEFT JOIN  artists  
		ON artists.ArtistId = albums.ArtistId
ORDER BY artist_name

---Her bir Artistin track' lerini getiriniz.

SELECT 	A.name AS track_name, C.name AS Artist_Name
FROM	tracks AS A
		JOIN	albums AS B ON A.AlbumId = B.AlbumId
		JOIN	artists AS C ON B.ArtistId = C.ArtistId

---Her bir Track' in bulunduğu faturaları getiriniz.

SELECT A.name AS TRACK_NAME, B.InvoiceId
FROM 	tracks AS A
		INNER JOIN invoice_items AS B ON A.TrackId = B.TrackId

------HER BİR TRACK EN AZ BİR FATURADA BULUNUYOR MU?

SELECT 	DISTINCT A.name AS TRACK_NAME, B.InvoiceId
FROM 	tracks AS A
		LEFT JOIN invoice_items AS B ON A.TrackId = B.TrackId
ORDER BY 2

--- Hangi türde kaçar adet track olduğunu getiriniz.

SELECT	GenreId, count (TrackId)
FROM	tracks 
GROUP BY GenreId


SELECT	B.Name AS genre_name,  COUNT (A.TrackId) AS CNT_TRACK
FROM	tracks AS A
INNER JOIN genres AS B 
ON A.GenreId = B.GenreId
GROUP BY B.Name

--

/*LIKEAncak operatörü büyük/küçük harfe duyarlı hale getirmek istiyorsanız 
PRAGMA deyimini aşağıdaki gibi kullanmamız gerekiyor:*/

PRAGMA case_sensitive_like = true;

PRAGMA case_sensitive_like = true;
SELECT *
FROM student_info
WHERE field LIKE '%developer';

/*Ciktinin tablosu bostur cunku developer pragma ile kucuk harfe duyarlidir.
Tablodaki Develeper lerde buyuk harfle baslar.*/

SELECT InvoiceId,CustomerId,Total
from invoices ORDER BY CustomerId ASC;

--MAX MIN--

SELECT salary AS lowest_salary
FROM employees
WHERE gender = 'Female'
ORDER BY salary
LIMIT 1;


SELECT MIN(salary) AS lowest_salary
FROM employees
WHERE gender = 'Female';

--

SELECT start_date
FROM student_info
WHERE gender = 'F'
ORDER BY start_date
LIMIT 1

SELECT MIN(start_date) AS earliest_date
FROM student_info
WHERE gender = 'F';

--

SELECT MAX(start_date) AS newest_date
FROM student_info
WHERE gender = 'M';

--SUM AVG--

SELECT SUM(grade) AS total_grade
FROM student_table

--

SELECT SUM(grade) AS total_grade
FROM student_table
WHERE lesson = 'Mathematics'

--

SELECT AVG(grade) AS average_grade
FROM student_table

--

SELECT AVG(grade) AS average_grade
FROM student_table
WHERE lesson = 'Physics'

--
8

SELECT *
FROM student_info
WHERE field IN ('Data Science', 'Data Analysis', 'DevOps')

SELECT *
FROM student_info
WHERE field IN ('Data Science', 'Data Analysis', 'DevOps') AND state = 'Virginia'

--
9

SELECT first_name, last_name, field
FROM student_info
WHERE field IN ('Data Science', 'Data Analysis')
ORDER BY first_name DESC;

SELECT last_name
FROM student_info
WHERE last_name LIKE '%er%';

SELECT first_name
FROM student_info
WHERE first_name='Eric'

/*quiz 1
Please write a query to return the departments of the employees who have a salary higher than 80000. 
Show just first name, last name, salary and department of the employees.*/
SELECT employees.first_name, employees.last_name, employees.salary, departments.dept_name
FROM employees
INNER JOIN departments ON employees.emp_id=departments.emp_id AND employees.salary >80000

/*quiz2
Please write a query to return the departments of female employees. 
Show just first name, last name, salary and department of the employees.*/
SELECT employees.first_name, employees.last_name, employees.salary, departments.dept_name
FROM employees
INNER JOIN departments ON employees.emp_id=departments.emp_id AND employees.gender = 'Female'


SELECT employees.first_name, employees.last_name, departments.dept_name, departments.dept_id
FROM employees
LEFT JOIN departments ON employees.emp_id=departments.emp_id WHERE employees.gender = ‘Male’

----------------------------------------------------------- ITF SQL Session 5 (Subqueries & DDL)--------------------------------------------------

SELECT *
FROM	albums LEFT JOIN artists ON albums.ArtistId = artists.ArtistId


SELECT 	artists.ArtistId
FROM	artists LEFT JOIN albums ON albums.ArtistId = artists.ArtistId




SELECT 	albums.ArtistId
FROM	artists LEFT JOIN albums ON albums.ArtistId = artists.ArtistId



SELECT 	albums.ArtistId
FROM	artists INNER JOIN albums ON albums.ArtistId = artists.ArtistId


SELECT 	COUNT (albums.ArtistId), 	COUNT (artists.ArtistId)
FROM	artists LEFT JOIN albums ON albums.ArtistId = artists.ArtistId


-----

---Album title' ı 'Faceless' olan track' lerin bilgilerini getiriniz.

SELECT 	TrackId, AlbumId, Name
FROM	tracks
WHERE	AlbumId = 88

----

SELECT 	TrackId, AlbumId, Name
FROM	tracks
WHERE	AlbumId = (SELECT AlbumId FROM albums WHERE Title = 'Faceless')


----JOIN

SELECT 	tracks.TrackId, tracks.AlbumId, tracks.Name
FROM	tracks INNER JOIN albums ON tracks.AlbumId = albums.AlbumId
WHERE	albums.Title = 'Faceless'

---------------

---Album title' ı 'Faceless' veya 'Let There Be Rock' olan track' lerin bilgilerini getiriniz.

SELECT 	TrackId, AlbumId, Name
FROM	tracks
WHERE	AlbumId IN (SELECT AlbumId FROM albums WHERE Title IN ('Faceless', 'Let There Be Rock'))


SELECT 	TrackId, AlbumId, Name
FROM	tracks
WHERE	AlbumId NOT IN (SELECT AlbumId FROM albums WHERE Title IN ('Faceless', 'Let There Be Rock'))


------

SELECT 	TrackId, AlbumId, Name
FROM	tracks
WHERE	AlbumId = (SELECT AlbumId FROM albums WHERE Title = 'Faceless')
OR		AlbumId = (SELECT AlbumId FROM albums WHERE Title = 'Let There Be Rock')


---

SELECT 	TrackId, AlbumId, Name
FROM	tracks
WHERE	AlbumId IN (SELECT AlbumId FROM albums WHERE Title = 'Faceless' OR Title = 'Let There Be Rock')


---DDL

CREATE TABLE vacation_table 
(
place_id int,
country text,
hotel_name text,
employee_id int,
vacation_length int,
budged REAL
);


INSERT INTO vacation_table 
VALUES
(1, 'USA', 'California', 1, 10, 20000),
(2, 'Rwanda', 'Rwanda', 2, 15, 20000),
(3, 'USA', 'Holidayinn', 3, 10.5, 20.500)
(4, 'USA', 'Holidayinn', 5, 10.5, 20.555)


INSERT INTO vacation_table 
VALUES
(4, 'USA', 'Holidayinn', 5, 10.5, 20.555)



INSERT INTO vacation_table 
VALUES
(5, 'USA', 'Holidayinn', 6, 10.5, null,'CANSAS')

SELECT * FROM vacation_table


----drop TABLE

DROP TABLE vacation_table

SELECT * FROM vacation_table


CREATE TABLE vacation_table 
(
place_id int PRIMARY KEY,
country text,
hotel_name text NOT NULL,
employee_id int,
vacation_length int,
budged REAL,
FOREIGN KEY (employee_id) REFERENCES employees (EmployeeId)
);

select * from vacation_table


ALTER TABLE vacation_table
ADD City varchar(50) not null
;


ALTER TABLE vacation_table
DROP  City ;


select * from vacation_table


---------------------////////////////////////////---------------------------


SELECT trackId, albumId, name
FROM tracks
Where AlbumId in
	(SELECT AlbumId
	FROM albums
	WHERE Title = 'Faceless' or Title = 'Let There Be Rock');
	
	
	
	
SELECT trackId, albumId, name
FROM tracks
Where AlbumId IN
	(SELECT AlbumId
	FROM albums
	WHERE Title = 'Faceless' or title = 'Let There Be Rock');

	-------
	
	
SELECT tracks.TrackId, tracks.AlbumId, tracks.Name
FROM tracks INNER JOIN albums ON tracks.AlbumId = albums.AlbumId
WHERE Title IN ('Faceless', 'Let There Be Rock')	
	
	
----


--5--Based on the previous question, find the albums whose total duration is higher than 70 minutes. 
--Your solution should include album title and total duration.	

SELECT A.AlbumId, A.total_duration, albums.Title
FROM
	(
	select 	AlbumId, SUM (Milliseconds) AS TOTAL_DURATION
	from 	tracks
	GROUP BY AlbumId
	) A INNER JOIN albums ON A.AlbumId = albums.AlbumId
WHERE 	TOTAL_DURATION > 70*60*1000
ORDER BY TOTAL_DURATION


-----Facelift isimli albümde bulunan ve 4 dakikadan az süreli kaç adet track vardır?


SELECT 	COUNT (TrackId)
FROM 	tracks
WHERE	Milliseconds < 4*60*1000
AND		AlbumId = (SELECT AlbumId
					FROM 	albums 
					WHERE 	Title = 'Facelift')

----

SELECT *
FROM invoices
WHERE total >(	SELECT avg(total) avg_total
				FROM invoices )

				
------------------------------------------------QUESTION 1--------------------------------------------------------------

1.a)
SELECT InvoiceId,CustomerId,Total
FROM invoices ORDER BY CustomerId ASC,  total DESC;

1.b)
SELECT InvoiceId,CustomerId,Total
from invoices ORDER BY total DESC;

2.a)
SELECT Total,InvoiceId,CustomerId
FROM invoices ORDER BY total DESC;

2.b)
SELECT Total,InvoiceId,CustomerId
FROM invoices ORDER BY CustomerId ASC;

3)
-- Sadece columb'lar değişiyor. Order girdiğimiz için satır yerlerinde bir değişiklik olmuyor.

4a)
SELECT *FROM invoices WHERE total >= 10 ORDER BY total DESC LIMIT 10

4b)
SELECT *FROM invoices WHERE total >= 10 ORDER BY total DESC

5a)
SELECT *FROM invoices WHERE total <= 10 ORDER BY total ASC LIMIT 5

5b)
SELECT *FROM invoices WHERE total <= 10 ORDER BY total ASC

6)
SELECT *FROM tracks WHERE Name like 'b%s';

7)
SELECT *FROM invoices WHERE InvoiceDate 
BETWEEN '2010-01-01' AND '2010-12-31' ORDER BY InvoiceDate DESC;

--

SELECT *FROM invoices WHERE BillingCountry IN ('Germany', 'Canada', 'USA', 'Norway')

AND InvoiceDate 

BETWEEN '2010-01-01' and '2010-12-31' ORDER BY InvoiceDate DESC;


SELECT 	BillingCountry, SUM(total) AS total_income
FROM	invoices
GROUP BY BillingCountry
ORDER BY 2


/*Questions:   1
1. Write a query that displays InvoiceId, CustomerId and total dollar amount for 
each invoice, sorted first by CustomerId (in ascending order), and then by total dollar 
amount  (in descending order).

1. Fatura Kimliği, Müşteri Kimliği ve toplam dolar tutarını gösteren bir sorgu yazın.
her fatura, önce Müşteri Kimliğine göre (artan düzende) ve ardından toplam dolara göre sıralanır
miktar (azalan sırada).

2. Write a query that displays InvoiceId, CustomerId and total dollar amount for 
each invoice, but this time sorted first by total dollar amount (in descending order), 
and then by CustomerId (in ascending order).

2. Fatura Kimliği, Müşteri Kimliği ve toplam dolar tutarını gösteren bir sorgu yazın.
her fatura, ancak bu sefer önce toplam dolar tutarına göre sıralanır (azalan düzende),
ve ardından CustomerId tarafından (artan sırada).

3. Compare the results of these two queries above. How are the results different 
when you switch the column you sort on first? (Explain it in your own words.)

3. Yukarıdaki iki sorgunun sonuçlarını karşılaştırın. Sonuçlar nasıl farklı
ilk sıraladığınız sütunu değiştirdiğinizde? (Kendi kelimelerinizle açıklayın.)

4. Write a query to pull the first 10 rows and all columns from the invoices table 
that have a dollar amount of total greater than or equal to 10.

4. Faturalar tablosundan ilk 10 satırı ve tüm sütunları çekmek için bir sorgu yazın
10'a eşit veya daha büyük bir toplam dolar tutarına sahip olan.

5. Write a query to pull the first 5 rows and all columns from the invoices table 
that have a dollar amount of total less than 10.

6. Find all track names that start with 'B' and end with 's'.

7. Use the invoices table to find all information regarding invoices whose
 billing address is USA or Germany or Norway or Canada and invoice date is 
 at any point in 2010, sorted from newest to oldest.
 
 Sorular:
1. Her fatura için FaturaKimliği, MüşteriKimliği ve toplam dolar tutarını önce 
MüşteriKimliği'ne göre (artan düzende) ve ardından toplam dolar tutarına göre
 (azalan düzende) sıralayan bir sorgu yazın.

2. Her fatura için FaturaKimliği, MüşteriKimliği ve toplam dolar tutarını gösteren 
bir sorgu yazın, ancak bu sefer önce toplam dolar tutarına göre (azalan düzende), 
ardından MüşteriKimliği'ne göre (artan düzende) sıralayın.

3. Yukarıdaki iki sorgunun sonuçlarını karşılaştırın. İlk sıraladığınız sütunu 
değiştirdiğinizde sonuçlar nasıl farklı oluyor? (Kendi kelimelerinizle açıklayın.)

4. Faturalar tablosundan dolar toplamı 10'a eşit veya daha büyük olan 
ilk 10 satırı ve tüm sütunları

çekmek için bir sorgu yazın. 5. Faturalar tablosundan ilk 5 satırı ve 
tüm sütunları çekmek için bir sorgu yazın. toplam tutarı 10'dan az olan.

6. 'B' ile başlayan ve 's' ile biten tüm parça adlarını bulun.

7.  Fatura adresi ABD veya Almanya veya Norveç veya Kanada olan ve 
fatura tarihi 2010 yılının herhangi bir noktasında olan faturalarla ilgili tüm bilgileri 
en yeniden en eskiye doğru sıralayarak bulmak için fatura tablosunu kullanın.
 */
 
 
 -----------------------------------------------------------SQL WORKSHOP 220524-------------------------------------------------------------
 
 
 -- -WRITE A QUERY THAT RETURNS TRACK NAME AND ITS COMPOSER FROM TRACKS TABLE

SELECT Composer,Name from tracks

---WRITE A QUERY THAT RETURNS ALL COLUMNS FROM TRACKS TABLE

SELECT * from tracks 


---WRITE A QUERY THAT RETURNS THE NAME OF COMPOSERS OF EACH TRACK
---(her parçayı beğenenlerin adını döndüren) muhtemelen yanlış.

SELECT Name from tracks

---WRITE A QUERY THAT RETURNS UNIQUE ALBUMID, MEDIATYPEID FROM TRACKS TABLE

SELECT DISTINCT AlbumId, MediaTypeId from tracks

---WRITE A QUERY THAT RETURNS TRACK NAME AND TRACKID OF ‘Jorge Ben’  

SELECT name,TrackId,Composer FROM tracks where Composer = ('Jorge Ben')

---WRITE A QUERY THAT RETURNS ALL INFO OF THE INVOICES OF WHICH TOTAL AMOUNT IS GREATER THAN $25

SELECT * from invoices where total > 25
SELECT * from invoices order by total DESC --- test

---WRITE A QUERY THAT RETURNS ALL INFO OF THE INVOICES OF WHICH TOTAL AMOUNT IS LESS THAN $15. JUST RETURN 5 ROWS  <

SELECT * from invoices where total < 15 limit 5

---WRITE A QUERY THAT RETURNS ALL INFO OF THE INVOICES OF WHICH --- birleşik

SELECT * from invoices A inner join invoice_items B on B.InvoiceId=A.InvoiceId

--- inner join ile olmayan tüm veriler getiriliyor     

---TOTAL AMOUNT IS GREATER THAN $10. THEN SORT THE TOTAL AMOUNTS IN DESCENDING ORDER, LASTLY DISPLAY TOP 2 ROWS --- birleşik

SELECT * from invoices A inner join invoice_items B on B.InvoiceId=A.InvoiceId where total > 10 order by total DESC limit 2

---WRITE A QUERY THAT RETURNS ALL INFO OF THE INVOICES OF WHICH BILLING COUNTRY IS NOT CANADA. 
---THEN SORT THE TOTAL AMOUNTS IN ASCENDING ORDER, LASTLY DISPLAY TOP 10 ROWS

SELECT * from invoices A inner join invoice_items B on B.InvoiceId=A.InvoiceId where BillingCountry is not 'Canada' order by total ASC limit 10;
SELECT * from invoices A inner join invoice_items B on B.InvoiceId=A.InvoiceId where BillingCountry != 'Canada' order by total ASC limit 10;

---WRITE A QUERY THAT RETURNS INVOICEID, CUSTOMERID AND TOTAL DOLLAR AMOUNT FOR EACH INVOICE. 
--THEN SORT THEM FIRST BY CUSTOMERID IN ASCENDING, THEN TOTAL DOLLAR AMOUNT IN DESCENDING ORDER.

SELECT A.InvoiceId,A.CustomerId,A.total from invoices A inner join invoice_items B on B.InvoiceId=A.InvoiceId order by  total DESC; -- total veri
SELECT InvoiceId,CustomerId,total from invoices order by total DESC; --- 412 veri


SELECT InvoiceId,CustomerId,total 
from invoices 
order by CustomerId ASC, total DESC---412 veri


--- WRITE A QUERY THAT RETURNS ALL TRACK NAMES THAT START WITH ‘B’AND END WITH ‘S’

SELECT * FROM tracks where name like 'B%N' ;
SELECT * FROM tracks where name like 'B%' ;

-- FOR LİKE
-- - **Percent (%):** The `%` character matches any sequence of zero or more characters.
-- *Underscore ( _ ):** The `_` character matches any single character.
-- - 'Out%' pattern matches any string beginning with "Out" such as "Outro".
-- - outla başlayanları bulmak için
-- s%' pattern matches any string that starts with "s" such as "silk", "soup", etc.
-- - S ile başlayanları bulmak için
-- %per%' pattern matches any string containing "per" such as "percentile" and "peeper".
-- - Tamamen kelimelerin arasında veya herhangi bir yerinde arama yapmak için
-- 's_n' pattern matches "son", "sun", etc.
-- - s ile başlayp n ile bitenler
--  '__te' pattern matches "mate", "Kate", "kate", etc.

---WRITE A QUERY THAT RETURNS THE NEWEST DATE AMONG THE INVOICE DATES BETWEEN 2008 AND 2011

SELECT * from invoices where InvoiceDate BETWEEN '2008-01-01' and '2011-12-30' order by InvoiceDate DESC 
SELECT * from invoices where InvoiceDate BETWEEN '2008' and '2011'

--- WRITE A QUERY THAT RETURNS THE FIRST AND LAST NAME OF THE CUSTOMERS WHO HAVE ORDERS FROM NORWAY AND BELGIUM.

SELECT FirstName,LastName FROM customers WHERE Country in ('Norway','Belgium')
SELECT FirstName,LastName FROM customers WHERE Country = ('Norway','Belgium')  --**
SELECT FirstName, LastName from customers INNER JOIN invoices ON customers.CustomerId= invoices.CustomerId
where invoices.BillingCountry IN ("Norway", "Belgium")

---WRITE A QUERY THAT RETURNS THE TRACK NAMES OF ‘ZAPPA’

SELECT * from tracks where Composer like '%ZAPPA%'

---HOW MANY TRACKS AND INVOICES ARE THERE IN THE DIGITAL MUSIC STORE, DISPLAY SEPERATELY --- Yanlış

SELECT count(TrackId) from tracks --- ilkel first.
SELECT Count(InvoiceId) from invoices --- ilkel sec.
SELECT count(TrackId) from tracks where TrackId is not NULL ---not null opt.
SELECT count(TrackId) from tracks where InvoiceId (SELECT count(InvoiceId) from invoices)---- Bu metod yanlış
SELECT count(DISTINCT TrackId) as track_count, count(DISTINCT InvoiceId) as invoice_count FROM tracks, invoices --- bu muhtemelen doğru
SELECT count(A.TrackId),count(B.InvoiceId) from tracks A 
inner join invoice_items C on C.InvoiceLineId=A.InvoiceId
inner join invoices B on B.InvoiceId+A.TrackId  --- absurd

SELECT count(A.TrackId),count(B.InvoiceId) from tracks A inner join invoices B on B.InvoiceId=A.TrackId   -- just try
SELECT count(A.TrackId),count(B.InvoiceId) from tracks A left join invoices B on B.InvoiceId and A.TrackId  --- just try


---HOW MANY COMPOSERS ARE THERE IN THE DIGITAL MUSIC STORE

SELECT count(DISTINCT(Composer)) from tracks
SELECT count(DISTINCT(Composer)) from tracks where Composer is not null
SELECT count(DISTINCT(A.Composer)),count(DISTINCT(B.Title)) from tracks A  inner join albums B on A.AlbumId=B.AlbumId

select count(DISTINCT Composer) from tracks
select count(DISTINCT Composer) from tracks where Composer is not NULL

select count(Composer) from tracks
select count(Composer) from tracks where Composer is not NULL


---HOW MANY TRACKS DOES EACH ALBUM HAVE, DISPLAY ALBUMID AND NUMBER OF TRACKS SORTED FROM HIGHEST TO LOWEST

SELECT A.Title,B.name from albums A left join tracks B on B.AlbumId=A.AlbumId 
SELECT count(DISTINCT TrackId), count(DISTINCT InvoiceId) FROM tracks, invoices

---WRITE A QUERY THAT RETURNS TRACK NAME HAVING THE MINIMUM AND MAXIMUM DURATION, DISPLAY SEPERATELY

SELECT Name,min(Milliseconds),max(Milliseconds) from tracks group by Milliseconds

---WRITE A QUERY THAT RETURNS THE TRACKS HAVING DURATION LESS THAN THE AVERAGE DURATION

SELECT avg(Milliseconds) from tracks ---
SELECT * from tracks where Milliseconds < 393599 order by Milliseconds DESC

SELECT TrackId, name, Milliseconds FROM tracks
WHERE Milliseconds <
(	SELECT avg(Milliseconds)
	FROM tracks
	) order by Milliseconds DESC

---WRITE A QUERY THAT RETURNS THE TOTAL NUMBER OF EACH COMPOSER’s TRACK.
---her bir composerin kaç şarkısı var

SELECT composer, count(TrackId) as Total_Num FROM tracks GROUP BY Composer --- Doğru cevap


SELECT composer, sum(TrackId) as Total_Num FROM tracks GROUP BY Composer 
SELECT composer, sum(TrackId) as Total_Num FROM tracks GROUP BY Composer order by Total_Num DESC

---WRITE A QUERY THAT RETURNS THE GENRE OF EACH TRACK.
--- having grup by dan sonra kullanılır; ortalama veya toplam değerlerinin gösterimi için...


SELECT tracks.name,tracks.GenreId,genres.name from tracks 
inner join genres on tracks.GenreId = genres.GenreId


SELECT tracks.AlbumId, albums.Title, sum(Milliseconds) from tracks 
INNER JOIN albums on albums.AlbumId = tracks.AlbumId  
GROUP BY albums.Title HAVING sum(Milliseconds) > 4200000  
ORDER by sum(tracks.Milliseconds) DESC



---WRITE A QUERY THAT RETURNS THE ARTIST’s ALBUM INFO.
---SANATÇININ ALBÜM BİLGİLERİNİ DÖNDÜREN BİR SORU YAZIN.
SELECT * from tracks A inner join albums B on A.AlbumId=B.AlbumId inner join artists C on c.ArtistId=B.ArtistId 
SELECT * from tracks A inner join albums B on A.AlbumId=B.AlbumId inner join artists C on c.ArtistId=B.ArtistId  
inner join playlist_track D on D.TrackId=A.TrackId

SELECT artists.name,albums.AlbumId From albums inner join artists  on albums.ArtistId=artists.ArtistId---- doğru

---WRITE A QUERY THAT RETURNS THE MINIMUM DURATION OF THE TRACKIN EACH ALBUM. 
---DISPLAY ALBUMID, ALBUM TITLE AND DURATION OF THETRACK. THEN SORT THEM FROM HIGHEST TO LOWEST
---HER ALBÜMDEKİ MİNİMUM PARÇA SÜRESİNİ DÖNDÜREN BİR SORU YAZIN. ALBÜMID'İ, ALBÜM İSMİ VE PARÇA SÜRESİ'Nİ GÖRÜNTÜLEYİN. SONRA EN YÜKSEKTEN DÜŞÜĞE DÖNÜŞTÜRÜN

SELECT tracks.AlbumId, albums.Title, min(Milliseconds) from tracks 
INNER JOIN albums on albums.AlbumId = tracks.AlbumId  
GROUP BY albums.Title HAVING min(Milliseconds) 
ORDER by min(tracks.Milliseconds) DESC


SELECT B.AlbumId ,B.Title,min(Milliseconds),A.name
from tracks A inner join albums B on A.AlbumId=B.AlbumId
GROUP by B.AlbumId order by Milliseconds DESC limit 1

---WRITE A QUERY THAT RETURNS ALBUMS WHOSE TOTAL DURATION IS HIGHER THAN 60 MIN. 
---DISPLAY ALBUM TITLE AND THEIR DURATIONS. THEN SORT THE RESULT FROM HIGHEST TO LOWEST
---TOPLAM SÜRESİ 60 DAKİKADAN UZAK OLAN ALBÜMLERİ DÖNDÜREN BİR SORU YAZIN. ALBÜM İSMİ VE SÜRELERİNİ GÖRÜNTÜLEYİN. SONRA SONUCU EN YÜKSEKTEN DÜŞÜĞE DÜZENLE
---- 60 DK = 3600000 ms.

SELECT * from tracks A
INNER JOIN albums B on B.AlbumId = A.AlbumId  
where A.Milliseconds > '3600000'
ORDER by A.Milliseconds DESC



---WRITE A QUERY THAT RETURNS TRACKID, TRACK NAME AND ALBUMIDINFO OF THE ALBUM WHOSE TITLE ARE ‘Prenda Minha’, 'Heart of the Night'AND 'Out Of Exile'.


SELECT * from tracks A inner join albums B on A.AlbumId=B.AlbumId inner join artists C on c.ArtistId=B.ArtistId 
where B.Title in ('Prenda Minha','Heart of the Night','Out Of Exile')


SELECT A.TrackId,A.name,B.AlbumId,B.Title from tracks A inner join albums B on A.AlbumId=B.AlbumId inner join artists  
where B.Title in ('Prenda Minha','Heart of the Night','Out Of Exile')---- doğru sonuç

----------------------------------------------------------------Check Yourself-2-----------------------------------------------------------------------------------

--1-Please write a query for selecting the "first_name" column with all its rows in the "employees" table.
--1-"Çalışanlar" tablosundaki "first_name" sütununu tüm satırlarıyla birlikte seçmek için lütfen bir sorgu yazınız.

SELECT first_name FROM employees;

--2-Please write a query for selecting the "first_name" and "last_name" columns in the "employees" table.
--2-"Çalışanlar" tablosunda "ad_adı" ve "soy_adı" sütunlarını seçmek için lütfen bir sorgu yazınız.

SELECT first_name, last_name FROM employees;

--3-Please write a query for selecting all columns in the "employees" table. (Note: Please use column names.)
--3-"Çalışanlar" tablosundaki tüm sütunları seçmek için lütfen bir sorgu yazın. (Not: Lütfen sütun adlarını kullanın.)

SELECT * FROM employees;

--4-Please write a query for selecting all columns in the "employees" table. (Note: Please use a special character)
--4-"Çalışanlar" tablosundaki tüm sütunları seçmek için lütfen bir sorgu yazın. (Not: Lütfen özel bir karakter kullanın)

select * FROM employees ;

----------------------------------------------------------------Check Yourself-3-----------------------------------------------------------------------------------

--1-Please write a query for selecting the unique values of "first_name" column in the "student_info" table.
--1-Lütfen "student_info" tablosundaki "first_name" sütununun benzersiz değerlerini seçmek için bir sorgu yazın.

SELECT DISTINCT first_name
FROM	student_info

--2-Please write a query for selecting the unique values of the "last_name" column in the "student_info" table.
--2-Lütfen "student_info" tablosundaki "last_name" sütununun benzersiz değerlerini seçmek için bir sorgu yazın.

SELECT DISTINCT last_name
FROM student_info

--3-Please write a query for selecting the unique values of "state_name" column in the "student_info" table.
--3-Lütfen "student_info" tablosundaki "state_name" sütununun benzersiz değerlerini seçmek için bir sorgu yazın.

SELECT DISTINCT state_name
FROM student_info

--4-Please write a query for selecting the unique values of both "state_name" and "county_name" columns in the "student_info" table.
--4-Lütfen "student_info" tablosunda hem "state_name" hem de "county_name" sütunlarının benzersiz değerlerini seçmek için bir sorgu yazın.

SELECT DISTINCT state_name, county_name
FROM student_info

--5-Please write a query for selecting the unique values of both "field" and "start_date" columns in the "student_info" table.
--5-Lütfen "student_info" tablosunda hem "field" hem de "start_date" sütunlarının benzersiz değerlerini seçmek için bir sorgu yazın.

SELECT DISTINCT field, start_date
FROM student_info

----------------------------------------------------------------Check Yourself-5-----------------------------------------------------------------------------------

--1-Please write a query to return the salary of employees from highest to lowest. Show just first name, last name and salary of the employees.
--1-Lütfen çalışanların maaşını en yüksekten en düşüğe döndürmek için bir sorgu yazınız. Çalışanların sadece adını, soyadını ve maaşını gösterin.

SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC;

/*2-Please write a query to return all records from employees table sorted by gender 
(display females first). Next, sort the result table by first names in descending order. Note: Write a single query

2-Lütfen cinsiyete göre sıralanmış çalışanlar tablosundaki tüm kayıtları döndürmek için bir sorgu yazın 
(önce kadınları göster). Ardından, sonuç tablosunu azalan düzende adlara göre sıralayın. Not: Tek bir sorgu yazın*/

SELECT *
FROM employees
ORDER BY gender ASC, first_name DESC;

--3-Which employee has been working in the company for the longest period? Note: Your query should return only one record.
--3-Hangi çalışan şirkette en uzun süredir çalışıyor? Not: Sorgunuz yalnızca bir kayıt döndürmelidir.

SELECT *
FROM employees
ORDER BY hire_date ASC 
LIMIT 1;

----------------------------------------------------------------Check Yourself-6-----------------------------------------------------------------------------------

--1-Please write a query to return female employees whose salary is higher than $70,000?
--1-Maaşı 70.000 doların üzerinde olan kadın çalışanları iade etmek için lütfen bir sorgu yazınız?

SELECT *
FROM employees
WHERE salary > 70000 AND gender = 'Female';

--2-Please write a query to return employees whose job title is web developer or data scientist.
--2-Lütfen iş unvanı web geliştiricisi veya veri bilimcisi olan çalışanları iade etmek için bir sorgu yazın.

SELECT *
FROM employees
WHERE job_title = 'Web Developer' OR job_title = 'Data Scientist';

--3-Please write a query to return all employees whose job title is not Data Scientist?
--3-Lütfen iş unvanı Data Scientist olmayan tüm çalışanları iade etmek için bir sorgu yazın?

SELECT *
FROM employees
WHERE NOT job_title = 'Data Scientist';

----------------------------------------------------------------Check Yourself-7-----------------------------------------------------------------------------------

--1-Please write a query to return employees whose salary is between $75,000 and $95,000?
--1-Maaşı 75.000 $ ile 95.000 $ arasında olan çalışanları iade etmek için lütfen bir sorgu yazın?

SELECT *
FROM employees
WHERE salary BETWEEN 75000 AND 95000;

--2-Please write a query to return employees whose salary is not between $75,000 and $95,000. Sort it by salary in descending order.
--2-Maaşı 75.000 ila 95.000 ABD Doları arasında olmayan çalışanları iade etmek için lütfen bir sorgu yazın. Azalan düzende maaşa göre sıralayın.

SELECT *
FROM employees
WHERE salary NOT BETWEEN 75000 AND 95000
ORDER BY salary DESC;

--3-Please write a query to return employees who have joined the company from January 1, 2018 to December 31, 2018. Sort it by hire date in ascending order.
--3-1 Ocak 2018 - 31 Aralık 2018 tarihleri ​​arasında şirkete katılan çalışanları iade etmek için lütfen sorgu yazınız. Kiralama tarihine göre artan düzende sıralayınız.

SELECT *
FROM employees
WHERE hire_date BETWEEN '2018-01-01' AND '2018-12-31'
ORDER BY hire_date;

----------------------------------------------------------------Check Yourself-8-----------------------------------------------------------------------------------

/* 
1- You have decided to build a project team from students. 
The project team will be composed of students from the fields of Data Analysis, 
Data Science and DevOps. You are searching for the right candidates. 
Please write a query to retrieve all possible candidates for your project team.

1-Öğrencilerden bir proje ekibi oluşturmaya karar verdiniz. Proje ekibi Veri Analizi,
 Veri Bilimi ve DevOps alanlarından öğrencilerden oluşacaktır. Doğru adayları arıyorsunuz.
Lütfen proje ekibiniz için olası tüm adayları almak için bir sorgu yazın.
*/

SELECT *
FROM student_info
WHERE field IN ('Data Science', 'Data Analysis', 'DevOps')

--2-Please modify your previous query to return all possible candidates from Virginia state. 
--2-Virginia eyaletinden tüm olası adayları döndürmek için lütfen önceki sorgunuzu değiştirin.

SELECT *
FROM student_info
WHERE field IN ('Data Science', 'Data Analysis', 'DevOps') AND state = 'Virginia'


----------------------------------------------------------------Check Yourself-9-----------------------------------------------------------------------------------
/*
1- Please write a query to return the students whose field is Data Science or Data Analysis. 
Your query should return the first name, last name and field of each student and should be 
ordered by the first name in descending order.   (Note: Use LIKE operator in your query)

1- Alanı Veri Bilimi veya Veri Analizi olan öğrencileri döndürmek için lütfen bir sorgu yazınız.
 Sorgunuz her öğrencinin adını, soyadını ve alanını döndürmeli ve azalan düzende adına göre sıralanmalıdır.
(Not: Sorgunuzda LIKE operatörünü kullanın)
*/

SELECT first_name, last_name, field
FROM student_info
WHERE field IN ('Data Science', 'Data Analysis')
ORDER BY first_name DESC;

--2-Please write a query to return the last names including'er' letters.
--2-Lütfen 'er' harfleri de dahil olmak üzere soyadlarını döndürmek için bir sorgu yazın.

SELECT last_name
FROM student_info
WHERE last_name LIKE '%er%';

--3-Please write a query to match 'r' letter in"Eric" in the first name column. Just return the first name column.
--3-Lütfen ilk ad sütununda "Eric" içindeki 'r' harfiyle eşleşen bir sorgu yazın. Sadece ilk ad sütununu döndürün.

SELECT first_name
FROM student_info
WHERE first_name='Eric'

---------------------------------------------------------------ITF-12 Assignment - 1-----------------------------------------------------------------------------------

/*
Questions:
1. Write a query that displays InvoiceId, CustomerId and total dollar amount for each invoice, sorted first by CustomerId (in ascending order), and then by total dollar amount  (in descending order).

2. Write a query that displays InvoiceId, CustomerId and total dollar amount for each invoice, but this time sorted first by total dollar amount (in descending order), and then by CustomerId (in ascending order).

3. Compare the results of these two queries above. How are the results different when you switch the column you sort on first? (Explain it in your own words.)

4. Write a query to pull the first 10 rows and all columns from the invoices table that have a dollar amount of total greater than or equal to 10.

5. Write a query to pull the first 5 rows and all columns from the invoices table that have a dollar amount of total less than 10.

6. Find all track names that start with 'B' and end with 's'.

7. Use the invoices table to find all information regarding invoices whose billing address is USA or Germany or Norway or Canada and invoice date is at any point in 2010, sorted from newest to oldest.

TR

1. Fatura Kimliği, Müşteri Kimliği ve her fatura için toplam dolar tutarını önce Müşteri Kimliğine göre (artan düzende) ve ardından toplam dolar tutarına göre  (azalan düzende) gösteren bir sorgu yazın.

2. Her fatura için FaturaKimliği, MüşteriKimliği ve toplam dolar tutarını gösteren bir sorgu yazın, ancak bu sefer önce toplam dolar tutarına göre (azalan düzende), ardından MüşteriKimliği'ne göre (artan düzende) sıralayın.

3. Yukarıdaki bu iki sorgunun sonuçlarını karşılaştırın. İlk önce sıraladığınız sütunu değiştirdiğinizde sonuçlar nasıl farklı oluyor? (Kendi kelimelerinizle açıklayın.)

4. Faturalar tablosundaki toplam dolar tutarı 10'a eşit veya daha büyük olan ilk 10 satırı ve tüm sütunları çekmek için bir sorgu yazın.

5. Dolar tutarı toplamı 10'dan az olan faturalar tablosundaki ilk 5 satırı ve tüm sütunları çekmek için bir sorgu yazın.

6. 'B' ile başlayan ve 's' ile biten tüm parça adlarını bulun.

7. Fatura adresi ABD veya Almanya veya Norveç veya Kanada olan ve fatura tarihi 2010'un herhangi bir noktasında olan faturalarla ilgili tüm bilgileri en yeniden en eskiye doğru sıralayarak bulmak için faturalar tablosunu kullanın.

*/

1. 

SELECT InvoiceId,CustomerId,Total

FROM invoices ORDER BY CustomerId ASC,  total DESC;

2-

SELECT InvoiceId,CustomerId,Total

FROM invoices ORDER BY total DESC, CustomerId ASC ;

3-

the priority in the order is different

4-

SELECT *FROM invoices WHERE total >= 10 ORDER BY total DESC LIMIT 10

5-

SELECT *FROM invoices WHERE total <= 10 ORDER BY total ASC LIMIT 5

6-

SELECT *FROM tracks WHERE Name Like 'b%s';

7-

SELECT *FROM invoices WHERE BillingCountry IN ('Germany', 'Canada', 'USA', 'Norway')

AND InvoiceDate 

BETWEEN '2010-01-01' and '2010-12-31' ORDER BY InvoiceDate DESC;



----------------------------------------------------------------ITF-12 Assignment - 2 (SQL | Aggregate Functions & JOINs)---------------------------------------------------------------------------------

/*
Instructions:  
There are multiple questions.
Use chinook database to answer the questions.
Please paste your answers (statements) as a plain text using the related question number.
Good Luck!

Questions:

1-How many tracks does each album have? Your solution should include Album id and its number of tracks sorted from highest to lowest.

2- Find the album title of the tracks. Your solution should include track name and its album title.

3- Find the minimum duration of the track in each album. Your solution should include album id, album title and duration of the track sorted from highest to lowest.

4- Find the total duration of each album. Your solution should include album id, album title and its total duration sorted from highest to lowest.

5- Based on the previous question, find the albums whose total duration is higher than 70 minutes. Your solution should include album title and total duration.

TR

Talimatlar:
Birden fazla soru var.
Soruları yanıtlamak için chinook veritabanını kullanın.
Lütfen cevaplarınızı (ifadelerinizi) ilgili soru numarasını kullanarak düz metin olarak yapıştırınız.
İyi şanslar!

Sorular:

1-Her albümde kaç parça var? Çözümünüz, Albüm kimliğini ve en yüksekten en düşüğe sıralanmış parça sayısını içermelidir.

2- Parçaların albüm başlığını bulun. Çözümünüz parça adını ve albüm başlığını içermelidir.

3- Her albümdeki parçanın minimum süresini bulun. Çözümünüz albüm kimliğini, albüm adını ve parçanın süresini en yüksekten en düşüğe sıralanmış şekilde içermelidir.

4- Her albümün toplam süresini bulun. Çözümünüz albüm kimliğini, albüm başlığını ve en yüksekten en düşüğe sıralanmış toplam süresini içermelidir.

5- Bir önceki soruya göre toplam süresi 70 dakikadan fazla olan albümleri bulun. Çözümünüz albüm başlığını ve toplam süreyi içermelidir.
*/
