USE [Shop_Database]
GO

INSERT INTO [Products] 
OUTPUT inserted.ID,inserted.AddDate 
VALUES (1,1,N'S478',N'جوراب آدیداس',N'مشکی رنگ',GETDATE())
GO 

DELETE FROM [Products] WHERE [Title] LIKE N'%آدیداس'
GO

SELECT * FROM [Product_Prices] ORDER BY [Price] DESC
GO

SELECT * FROM [Product_Prices] WHERE [Price]<>20000
GO

ALTER TABLE [Customers] ADD [FullName] AS [FirstName]+N' '+[LastName] 

/*
ALTER TABLE [Customers]
ADD [FullName] NVARCHAR(200);
UPDATE [Customers] SET [FullName]=[FirstName]+N' '+[LastName]
*/

GO

SELECT
	P.ID,
	PC.Title [Category_Title],
	P.Title [Products],
	PP.Price ,
	PP.Tax
FROM [Products] AS P
INNER JOIN [Product_Prices] PP ON PP.Product_ID=P.ID
INNER JOIN [ProductCategories] PC ON P.ParentProductAtegory_ID=PC.ID

GO

SELECT
	PC.Title,
	SUM(PP.Price) [Price of each category]
FROM Products P
INNER JOIN ProductCategories PC ON P.ParentProductAtegory_ID=PC.ID
INNER JOIN Product_Prices PP ON PP.Product_ID=P.ID
GROUP BY PC.Title

GO

CREATE VIEW [Product_Details] AS
(
	SELECT 
		P.Title,
		PP.Price,
		PP.Tax,
		Year(FORMAT(P.AddDate,'yyyy-MM-dd','FA-IR')) [Year_In_Solar_Date]
	FROM Product_Prices PP
	INNER JOIN Products P ON P.ID=PP.ID
);
GO

SELECT * FROM [Product_Details]

GO
