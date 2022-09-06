--Создаем таблицу Products
/*id - код товара
  ShowcaseCode - витринный код товара
  NameProduct - Название товара*/
CREATE TABLE Products (IdProduct INT IDENTITY(1,1) NOT NULL, 
			ShowCaseCode INT NOT NULL,
			NameProduct VARCHAR(50) NOT NULL
			CONSTRAINT PK_IdProduct PRIMARY KEY (IdProduct))
--Создаем уникальный некластеризованный индекс для поля ShowcaseCode таблицы Products
--Витринный код должен быть уникальный у товаров. Создаю индекс для того,
--чтобы не повторялись витринные кода
CREATE UNIQUE NONCLUSTERED INDEX IX_Products ON Products --Новое для меня. Создание некластеризованного индекса
(
	ShowCaseCode ASC
)
--Чтобы не повторялись название товаров, для этого создаем индекс
CREATE UNIQUE NONCLUSTERED INDEX IX_NameProduct ON Products --Новое для меня. Создание уникального некластеризованного индекса
(
	NameProduct ASC
)
--Создаем таблицу Категории
/*IdCategory - код категории
  NameCategories - навазение категории*/
CREATE TABLE Categories (IdCategory INT IDENTITY(1,1) NOT NULL, 
					     NameCategory VARCHAR(50) NOT NULL
					     CONSTRAINT PK_IdCategories PRIMARY KEY (IdCategory))
--Чтобы не повторялось название категории, для этого создаем индекс
CREATE UNIQUE NONCLUSTERED INDEX IX_NameCategories ON Categories --Новое для меня. Создание уникального некластеризованного индекса
(
	NameCategory ASC
)
--Создаем таблицу Категории
CREATE TABLE ProductsCategory (IdProduct INT,
			       IdCategory INT,
			       CONSTRAINT PK_ProductCategory PRIMARY KEY(IdProduct ASC,
									 IdCategory ASC),
CONSTRAINT FK_Products FOREIGN KEY (IdProduct) REFERENCES Products(IdProduct) ON DELETE CASCADE ON UPDATE NO ACTION, --Связываю с таблицей Products
CONSTRAINT FK_Categories FOREIGN KEY (IdCategory) REFERENCES Categories(IdCategory) ON DELETE CASCADE ON UPDATE NO ACTION --Связываю с таблицей Categories
)
--Заполняею таблицу Products тестовыми данными
INSERT Products (ShowCaseCode, NameProduct)
VALUES (12,'Процессор INTEL')
INSERT Products (ShowCaseCode, NameProduct)
VALUES (34,'Оперативная память')
INSERT Products (ShowCaseCode, NameProduct)
VALUES (65,'Клавиатура Defender')
INSERT Products (ShowCaseCode, NameProduct)
VALUES (78,'Футболка ФК Спартак (Москва)')
--Заполняем таблицу Categories тестовыми данными
INSERT INTO Categories (NameCategory)
VALUES ('Комплектующие компьютера')
INSERT INTO Categories (NameCategory)
VALUES ('Клавиатуры')
--Проверка
SELECT *
FROM Categories
SELECT *
FROM Products
--Заполняем таблицу ProductsCategory
INSERT INTO ProductsCategory (IdProduct, IdCategory)
VALUES (1,1)
INSERT INTO ProductsCategory (IdProduct, IdCategory)
VALUES (2,1)
INSERT INTO ProductsCategory (IdProduct, IdCategory)
VALUES (3,1)
INSERT INTO ProductsCategory (IdProduct, IdCategory)
VALUES (3,2)
--Проверка
SELECT *
FROM ProductsCategory
--Запрос
SELECT p.NameProduct AS [Название продукта], ISNULL(c.NameCategory,'Нет категории') AS Категория
FROM Products p
LEFT JOIN ProductsCategory pc ON p.IdProduct=pc.IdProduct
LEFT JOIN Categories c ON pc.IdCategory=c.IdCategory
ORDER BY p.NameProduct
