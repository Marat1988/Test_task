--Создаем таблицу Products
/*id - код товара
  ShowcaseCode - витринный код товара
  NameProduct - Название товара*/
CREATE TABLE Products (ProductId INT IDENTITY(1,1) NOT NULL, 
			ShowCaseCode INT NOT NULL,
			NameProduct VARCHAR(50) NOT NULL
			CONSTRAINT PK_ProductId PRIMARY KEY (ProductId),
			CONSTRAINT CK_ShowCaseCode CHECK (ShowCaseCode>=0)--Ограничение для витринного кода. Чтобы не было значений меньше либо равно нулю
)
--Создаем уникальный некластеризованный индекс для поля ShowcaseCode таблицы Products
--Витринный код должен быть уникальный у товаров. Создаю индекс для того,
--чтобы не повторялись витринные кода
CREATE UNIQUE NONCLUSTERED INDEX IX_Products ON Products --Создание уникального некластеризованного индекса
(
	ShowCaseCode ASC
)
--Чтобы не повторялись название товаров, для этого создаем индекс
CREATE UNIQUE NONCLUSTERED INDEX IX_NameProduct ON Products --Создание уникального некластеризованного индекса
(
	NameProduct ASC
)
--Создаем таблицу Категории
/*IdCategory - код категории
  NameCategories - навазение категории*/
CREATE TABLE Categories (CategoryId INT IDENTITY(1,1) NOT NULL, 
					     NameCategory VARCHAR(50) NOT NULL
					     CONSTRAINT PK_IdCategories PRIMARY KEY (CategoryId))
--Чтобы не повторялось название категории, для этого создаем индекс
CREATE UNIQUE NONCLUSTERED INDEX IX_NameCategories ON Categories --Создание уникального некластеризованного индекса
(
	NameCategory ASC
)
--Создаем таблицу Категории
CREATE TABLE ProductsCategory (ProductId INT,
							   CategoryId INT,
CONSTRAINT PK_ProductCategory PRIMARY KEY(ProductId ASC, 
										  CategoryId ASC),
CONSTRAINT FK_Products FOREIGN KEY (ProductId) REFERENCES Products(ProductId) ON DELETE CASCADE ON UPDATE NO ACTION, --Связываю с таблицей Products
CONSTRAINT FK_Categories FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId) ON DELETE CASCADE ON UPDATE NO ACTION --Связываю с таблицей Categories
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
INSERT INTO ProductsCategory (ProductId, CategoryId)
VALUES (1,1)
INSERT INTO ProductsCategory (ProductId, CategoryId)
VALUES (2,1)
INSERT INTO ProductsCategory (ProductId, CategoryId)
VALUES (3,1)
INSERT INTO ProductsCategory (ProductId, CategoryId)
VALUES (3,2)
--Проверка
SELECT *
FROM ProductsCategory
--Запрос
SELECT p.NameProduct AS [Название продукта], ISNULL(c.NameCategory,'Нет категории') AS Категория
FROM Products p
LEFT JOIN ProductsCategory pc ON p.ProductId=pc.ProductId
LEFT JOIN Categories c ON pc.CategoryId=c.CategoryId
ORDER BY p.NameProduct
