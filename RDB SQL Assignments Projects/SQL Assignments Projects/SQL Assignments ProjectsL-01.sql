/* Questions:
1. Write a query that displays InvoiceId, CustomerId and total dollar amount for each invoice, sorted first by CustomerId (in ascending order), and then by total dollar amount  (in descending order).

1. Her fatura için FaturaKimliği, MüşteriKimliği ve toplam dolar tutarını önce MüşteriKimliğine göre (artan düzende) ve ardından toplam TL tutarına göre (azalan düzende) sıralayan bir sorgu yazın.

2. Write a query that displays InvoiceId, CustomerId and total dollar amount for each invoice, but this time sorted first by total dollar amount (in descending order), and then by CustomerId (in ascending order).

2. Her fatura için Fatura Kimliği, Müşteri Kimliği ve toplam dolar tutarını gösteren bir sorgu yazın, ancak bu sefer önce toplam dolar tutarına göre (azalan düzende), ardından Müşteri Kimliğine göre (artan düzende) sıralayın.

3. Compare the results of these two queries above. How are the results different when you switch the column you sort on first? (Explain it in your own words.)

3. Yukarıdaki iki sorgunun sonuçlarını karşılaştırın. İlk sıraladığınız sütunu değiştirdiğinizde sonuçlar nasıl farklı oluyor? (Kendi kelimelerinizle açıklayın.)

4. Write a query to pull the first 10 rows and all columns from the invoices table that have a dollar amount of total greater than or equal to 10.

4. Faturalar tablosundaki toplam dolar tutarı 10'a eşit veya daha büyük olan ilk 10 satırı ve tüm sütunları çekmek için bir sorgu yazın.

5. Write a query to pull the first 5 rows and all columns from the invoices table that have a dollar amount of total less than 10.

5. Faturalar tablosundan dolar tutarı toplamı 10'dan az olan ilk 5 satırı ve tüm sütunları çekmek için bir sorgu yazın.

6. Find all track names that start with 'B' and end with 's'.

6. 'B' ile başlayan ve 's' ile biten tüm parça adlarını bulun.

7. Use the invoices table to find all information regarding invoices whose billing address is USA or Germany or Norway or Canada and invoice date is at any point in 2010, sorted from newest to oldest. 

7. Fatura adresi ABD veya Almanya veya Norveç veya Kanada olan ve fatura tarihi 2010 yılının herhangi bir noktasında olan faturalarla ilgili tüm bilgileri en yeniden en eskiye doğru sıralayarak bulmak için fatura tablosunu kullanın.*/

1) SELECT InvoiceId, CustomerId, total FROM invoices ORDER BY CustomerId ASC, total DESC;

2) SELECT InvoiceId, CustomerId, total FROM invoices ORDER BY total DESC, CustomerId ASC;

3) Firstly, it sorts the first command, then it sorts the other command in accordance with the first command. So if the command order changes, our table will be changed,

4) SELECT * FROM invoices WHERE total >= 10 LIMIT 10;

5) SELECT * FROM invoices WHERE total < 10 LIMIT 5;

6) SELECT * FROM tracks WHERE name like 'B%s';

7) SELECT * FROM invoices WHERE BillingCountry IN('USA', 'Germany', 'Norway', 'Canada') AND InvoiceDate BETWEEN '2010-01-01' AND '2010-12-31' ORDER BY InvoiceDate DESC;