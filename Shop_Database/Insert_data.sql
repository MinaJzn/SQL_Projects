USE [Shop_Database]
GO

INSERT INTO [Product_Units] ([Title])
VALUES
(N'جفت'),
(N'عدد'),
(N'کیلوگرم'),
(N'بطری')
GO

INSERT INTO [ProductCategories] ([ParentProductAtegory_ID],[Title]) VALUES (NULL,N'پوشاک')
INSERT INTO [ProductCategories] ([ParentProductAtegory_ID],[Title]) VALUES (NULL,N'حبوبات')
INSERT INTO [ProductCategories] ([ParentProductAtegory_ID],[Title]) VALUES (NULL,N'مایعات')
INSERT INTO [ProductCategories] ([ParentProductAtegory_ID],[Title]) VALUES (NULL,N'لوازم تحریر')
Go

INSERT INTO [ProductCategories] ([ParentProductAtegory_ID],[Title])
VALUES 
(1,N'جوراب'),(1,N'دستکش'),(1,N'کلاه'),
(2,N'لوبیا'),(2,N'عدس'),(2,N'ماش'),(2,N'لپه'),
(3,N'مداد'),(3,N'خودکار'),(3,N'دفتر'),
(4,N'دوغ'),(4,N'نوشابه')
GO

INSERT INTO [Products] ([ParentProductAtegory_ID],[ProductUnits_ID],[Code],[Title],[Description],[AddDate]) 
VALUES 
(1,1,N'S121',N'جوراب نایکی',N'دوازده رنگ',GETDATE()),
(4,4,N'D1001',N'دوغ عالیس',N'نعنایی و کرفسی',N'2024-12-05'),
(2,3,N'H456',N'لوبیا چیتی',N'اعلاء',N'2024-05-15 12:12')
Go

INSERT INTO [Product_Prices] ([Product_ID],[Date],[Price]) 
VALUES
(1,GETDATE(),20000),(2,GETDATE(),55000),(3,GETDATE(),150000)
GO