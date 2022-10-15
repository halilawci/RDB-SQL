/*
Assignments/Projects RDB/SQL-1 (Charlies Chocolate Factory)

Charlie's Chocolate Factory company produces chocolates. The following product information is stored: product name, product ID, and quantity on hand. These chocolates are made up of many components. Each component can be supplied by one or more suppliers. The following component information is kept: component ID, name, description, quantity on hand, suppliers who supply them, when and how much they supplied, and products in which they are used. On the other hand following supplier information is stored: supplier ID, name, and activation status.

Assumptions

A supplier can exist without providing components.
A component does not have to be associated with a supplier. It may already have been in the inventory.
A component does not have to be associated with a product. Not all components are used in products.
A product cannot exist without components. 

Do the following exercises, using the data model.

     a) Create a database named "Manufacturer"

     b) Create the tables in the database.

     c) Define table constraints.

Charlie'nin Çikolata Fabrikası şirketi çikolata üretiyor. Aşağıdaki ürün bilgileri saklanır: ürün adı, ürün kimliği ve eldeki miktar. Bu çikolatalar birçok bileşenden oluşur. Her bileşen bir veya daha fazla tedarikçi tarafından tedarik edilebilir. Aşağıdaki bileşen bilgileri tutulur: bileşen kimliği, adı, tanımı, eldeki miktar, bunları tedarik eden tedarikçiler, ne zaman ve ne kadar tedarik ettikleri ve kullanıldığı ürünler. Öte yandan şu tedarikçi bilgileri saklanır: tedarikçi kimliği, adı ve etkinleştirme durumu.

varsayımlar

Bir tedarikçi, bileşenleri sağlamadan var olabilir.
Bir bileşenin bir tedarikçi ile ilişkilendirilmesi gerekmez. Zaten envanterde olabilir.
Bir bileşenin bir ürünle ilişkilendirilmesi gerekmez. Ürünlerde tüm bileşenler kullanılmaz.
Bileşenler olmadan bir ürün var olamaz.

Veri modelini kullanarak aşağıdaki alıştırmaları yapın.

     a) "Üretici" adlı bir veritabanı oluşturun

     b) Veritabanındaki tabloları oluşturun.

     c) Tablo kısıtlamalarını tanımlayın.
*/

CREATE DATABASE Manufacturer;

USE Manufacturer;

CREATE TABLE Product(
	prod_id INT PRIMARY KEY NOT NULL,
	prod_name VARCHAR(50),
	quantitiy INT
	);

CREATE TABLE Component(
	comp_id INT PRIMARY KEY NOT NULL,
	comp_name VARCHAR(50),
	[description] VARCHAR(50),
	quantity_comp INT
	);

CREATE TABLE Supplier(
	supp_id INT PRIMARY KEY NOT NULL,
	supp_name VARCHAR(50),
	supp_location VARCHAR(50),
	supp_country VARCHAR(50),
	is_active BIT
	);

CREATE TABLE Prod_Comp(
	prod_id INT,
	comp_id INT,
	PRIMARY KEY (prod_id, comp_id),
	FOREIGN Key (prod_id) REFERENCES Product (prod_id),
	FOREIGN KEY (comp_id) REFERENCES Component (comp_id)
	);

CREATE TABLE Comp_Supp(
	supp_id INT,
	comp_id INT,
	order_date DATE,
	quantity INT,
	PRIMARY KEY (supp_id, comp_id),
	FOREIGN KEY (supp_id) REFERENCES Supplier (supp_id),
	FOREIGN KEY (comp_id) REFERENCES Component (comp_id)
	);