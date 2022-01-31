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
	products_id  INT NOT NULL,
	category_id INT NOT NULL
);

