CREATE DATABASE [Shop_Database]
ON
(
	NAME=N'Shop_Database',
	FILENAME=N'D:\SQL\Shop_Database.mdf',
	SIZE=5MB,
	FILEGROWTH=5Mb
)
LOG ON
(
	NAME=N'Shop_Database_log',
	FILENAME=N'D:\SQL\Shop_Database.ldf',
	SIZE=5MB,
	FILEGROWTH=5Mb
);
GO

USE Shop_Database;
GO

CREATE TABLE [Customers]
(
	[ID] INT IDENTITY NOT NULL PRIMARY KEY,
	[FirstName] NVARCHAR(200) NOT NULL,
	[LastName] NVARCHAR(200) NOT NULL,
	[CreateDate] DATETIME NOT NULL DEFAULT(GETDATE())
);
GO

CREATE TABLE [Customer_Addresses]
(
	[ID] INT IDENTITY NOT NULL PRIMARY KEY,
	[Customer_ID] INT NOT NULL REFERENCES [Customers]([ID]),
	[Country] NVARCHAR(200) NOT NULL,
	[State] NVARCHAR(200) NOT NULL,
	[City] NVARCHAR(200) NOT NULL,
	[Address] NVARCHAR(1000) NOT NULL,
	[PostalCode] CHAR(10) NULL
);
GO

CREATE TABLE [Customer_Emails]
(
	[ID] INT IDENTITY NOT NULL PRIMARY KEY,
	[Customer_ID] INT NOT NULL REFERENCES [Customers]([ID]),
	[Address] NVARCHAR(360) NOT NULL UNIQUE
);
GO

CREATE TABLE [Customer_PhoneNumbers]
(
	[ID] INT IDENTITY NOT NULL PRIMARY KEY,
	[Customer_ID] INT NOT NULL REFERENCES [Customers]([ID]),
	[Number] CHAR(20) NOT NULL,
	[IsMobile] BIT NOT NULL DEFAULT(0)
);
GO

CREATE TABLE [ProductCategories]
(
	[ID] INT IDENTITY NOT NULL PRIMARY KEY,
	[ParentProductAtegory_ID] INT NOT NULL REFERENCES [ProductCategories]([ID]),
	[Title] NVARCHAR(200) NOT NULL,
	UNIQUE([ParentProductAtegory_ID],[Title])
);
GO

CREATE TABLE [Product_Units]
(
	[ID] INT IDENTITY NOT NULL PRIMARY KEY,
	[Title] NVARCHAR(200) NOT NULL
);
GO


CREATE TABLE [Products]
(
	[ID] INT IDENTITY NOT NULL PRIMARY KEY,
	[ParentProductAtegory_ID] INT NOT NULL REFERENCES [ProductCategories]([ID]),
	[ProductUnits_ID] INT NOT NULL REFERENCES [Product_Units]([ID]),
	[Code] NCHAR(10) NOT NULL,
	[Title] NVARCHAR(200) NOT NULL,
	[Description] NVARCHAR(2000) NOT NULL,
	[AddDate] DATETIME NOT NULL DEFAULT(GETDATE())
);
GO

CREATE TABLE [Product_Prices]
(
	[ID] INT IDENTITY NOT NULL PRIMARY KEY,
	[Product_ID] INT NOT NULL REFERENCES [Products]([ID]),
	[Date] DATETIME NOT NULL DEFAULT(GETDATE()),
	[Price] DECIMAL NOT NULL CHECK([Price]>0),
	[Tax] AS ([Price]/100)*12
);
GO

CREATE TABLE [Product_Ins]
(
	[ID] INT IDENTITY NOT NULL PRIMARY KEY,
	[Product_ID] INT NOT NULL REFERENCES [Products]([ID]),
	[Date] DATETIME NOT NULL DEFAULT(GETDATE()),
	[Amount] DECIMAL NOT NULL CHECK([Amount]>0)
);
GO

CREATE TABLE [Product_Outs]
(
	[ID] INT IDENTITY NOT NULL PRIMARY KEY,
	[Product_ID] INT NOT NULL REFERENCES [Products]([ID]),
	[Date] DATETIME NOT NULL DEFAULT(GETDATE()),
	[Amount] DECIMAL NOT NULL CHECK([Amount]>0)
);
GO

CREATE TABLE [ShopReceipts]
(
	[ID] INT IDENTITY(1000,1) NOT NULL PRIMARY KEY,
	[Customer_ID] INT NOT NULL REFERENCES [Customers]([ID]),
	[Date] DATETIME NOT NULL DEFAULT(GETDATE()),
	[Description] NVARCHAR(2000) NULL
);
GO

CREATE TABLE [ShopReceiptDetails]
(
	[ShopReceipt_ID] INT NOT NULL REFERENCES [ShopReceipts]([ID]),
	[Product_ID] INT NOT NULL REFERENCES [Products]([ID]),
	[ProductPrice_ID] INT NOT NULL REFERENCES [Product_Prices]([ID]),
	[Amount] DECIMAL NOT NULL
);
GO
