USE master;

IF DB_ID('SQL_Cat_Prod') IS NOT NULL DROP DATABASE SQL_Cat_Prod;

IF @@ERROR = 3702 
   RAISERROR('Database cannot be dropped because there are still open connections.', 127, 127) WITH NOWAIT, LOG;

CREATE DATABASE SQL_Cat_Prod;
GO

USE SQL_Cat_Prod;
GO

CREATE TABLE Products (
	prodid INT NOT NULL IDENTITY,
	name NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_Products PRIMARY KEY(prodid)
);

CREATE TABLE Categories (
	catid INT NOT NULL IDENTITY,
	name NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_Categories PRIMARY KEY(catid)
);

CREATE TABLE RelationProd_Cat (
    id INT NOT NULL IDENTITY,
	products_id  INT NOT NULL,
	category_id INT NOT NULL
);

SET IDENTITY_INSERT Categories ON;
INSERT INTO Categories (catid, name)
VALUES  (1, 'Канцтовары'),
        (2, 'Товары для дома'),
        (3, 'Инструменты');
SET IDENTITY_INSERT Categories OFF;      

SET IDENTITY_INSERT Products ON;
INSERT INTO Products (prodid, name)
VALUES  (1, 'Молоток'),
        (2, 'Блокнот'),
        (3, 'Дрель'),
        (4, 'Швабра'),
        (5, 'Карандаш'),
        (6, 'Отвертка'),
        (7, 'Ножницы'),
        (8, 'Скатерть'),
        (9, 'Ручка'),
        (10, 'Молоко');
SET IDENTITY_INSERT Products OFF;  

INSERT INTO RelationProd_Cat (products_id, category_id)
VALUES  (1, 2),  --'Молоток' - 'Товары для дома'
        (1, 3),  --'Молоток' - 'Инструменты'
        (2, 1),  --'Блокнот' - 'Канцтовары'
        (2, 2),  --'Блокнот' - 'Товары для дома'
        (3, 3),  --'Дрель' - 'Инструменты'
        (4, 2),  --'Швабра' - 'Товары для дома'
        (5, 1),  --'Карандаш' - 'Канцтовары'
        (6, 3),  --'Отвертка' - 'Инструменты'
        (7, 1),  -- 'Ножницы' - 'Канцтовары'
        (7, 2),  -- 'Ножницы' - 'Товары для дома'
        (8, 2),  -- 'Скатерть' - 'Товары для дома'
        (9, 1)  -- 'Ручка' - 'Канцтовары'
        ;


SELECT P.name [Продукт], C.name [Категория]
FROM dbo.Products AS P
    LEFT JOIN 
        (dbo.RelationProd_Cat AS R 
            INNER JOIN dbo.Categories AS C 
            ON C.catid = R.category_id)    
        ON P.prodid = R.products_id
ORDER BY P.name  