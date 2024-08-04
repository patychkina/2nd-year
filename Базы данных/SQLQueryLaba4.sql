--Триггер на удаление из таблицы Country. При удалении из таблицы также стираются записи регионов и городов этой страны.
create trigger Delite_Country on Country
after delete not for replication
as

	update [dbo].[Suppliers]
	set TownID = DEFAULT where TownID in 
	(select TownID from  [dbo].[Town] join [dbo].[Subject] on Town.SubjectID = Subject.SubjectID join deleted on deleted.CountryID = Subject.CountryID)

	update [dbo].[Buyer]
	set TownID = DEFAULT where TownID in 
	(select TownID from  [dbo].[Town] join [dbo].[Subject] on Town.SubjectID = Subject.SubjectID join deleted on deleted.CountryID = Subject.CountryID)

    DELETE FROM [dbo].[Town] where SubjectID in (select SubjectID from [dbo].[Subject] join deleted on Subject.CountryID = deleted.CountryID)
    
	delete from [dbo].[Subject]  where CountryID in ( select CountryID from deleted)
    PRINT 'Trigger Delite Country'
go

--delete from [dbo].[Country] where Country.Name = 'Belarus'

--Триггер на удаление поставщика из базы данных
create trigger Delite_Supplier on Suppliers
instead of delete not for replication
as
	update [dbo].[Suppliers]
	set SuppliersITN = '', NameSuppliers = '', Phone_number = 0, Street = '', TownID = 1
	from [dbo].[Suppliers] join deleted on deleted.SuppliersID = Suppliers.SuppliersID

    PRINT 'Trigger Delite Supplier'
go

--delete from [dbo].[Suppliers] where TownID = 1

--Тригер на удаление покупателя из базы данных
create trigger Delite_Buyer on Buyer
instead of delete not for replication
as
	update [dbo].[Buyer]
	set BuyerITN = '', NameBuyer = '', Phone_number = 0, Street = '', TownID = 1
	from [dbo].[Buyer] join deleted on deleted.BuyerID = Buyer.BuyerID

    PRINT 'Trigger Delite Buyer'
go

 --delete from [dbo].[Buyer] where TownID = 1

--delete from [dbo].[Country] where [dbo].[Country].Name = 'Kazakhstan'
--rollback
--select * from [dbo].[Town]
--select * from [dbo].[Subject]
--select * from [dbo].[Country]

--Таблица отслеживания работы тригеров
create table Logger
(
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
Command NCHAR(6) NOT NULL,
RowNumber INT NOT NULL,
ChangeDate DATETIME NOT NULL,
UserName NCHAR(100) NOT NULL
)

go

--Триггер на добавление в таблицу заказов
create trigger LodInsert on Purchase after insert
as
DECLARE @operation CHAR(6)
SET @operation = 'Insert'
INSERT INTO Logger (Command,RowNumber, ChangeDate, UserName)
SELECT @operation, inserted.PurchaseID , GETDATE(), USER_Name()
FROM inserted
print 'Trigger Insert'
go

--Триггер на изменение в таблице заказов
create trigger LodUpdate on Purchase after update
as DECLARE @operation CHAR(6)
SET @operation = 'Update'
INSERT INTO Logger (Command, RowNumber,ChangeDate, UserName)
SELECT @operation,inserted.PurchaseID, GETDATE(), USER_Name()
FROM inserted
print 'Trigger Update'
go

--Триггер на удаление из таблицы заказов
create trigger LodDelete on Purchase after delete
as DECLARE @operation CHAR(6)
SET @operation = 'Delete'
INSERT INTO Logger (Command, RowNumber,ChangeDate, UserName)
SELECT @operation, deleted.PurchaseID, GETDATE(), USER_Name()
FROM deleted
print 'Trigger Delete'
go

INSERT [dbo].[Purchase] ([SuppliersID], [Purchase_date], [Price_total], [Payment_status], [TypeID]) VALUES (2, CAST(N'2024-04-10T15:00:00.000' AS DateTime), 12500.0000, 1, 0)
update [dbo].[Purchase]
set [Payment_status] = 1 where TypeID = 0
delete from [dbo].[Purchase] where [dbo].[Purchase].SuppliersID = 2

 --exec PayPurchase 1,1

  --Вывод всех заказов по названию поставщика
 create procedure OrdersFromSupplier (@NameSupplier varchar(50))
 as
	select Product_Purchase.PurchaseID,  Product_Purchase.ProductID, Product.Name, Product_Purchase.Purchase_date, Product_Purchase.Price_purchase,
	Product_Purchase.Count_products
	from [dbo].[Product_Purchase] join [dbo].[Purchase] on Product_Purchase.PurchaseID = Purchase.PurchaseID 
	join [dbo].[Suppliers] on Purchase.SuppliersID = Suppliers.SuppliersID join [dbo].[Product] on Product_Purchase.ProductID = Product.ProductID
	where Suppliers.NameSuppliers = @NameSupplier
	if @@rowcount = 0
	begin
	raiserror ('Такого поставщика нет', 10, 1)
end

 go

 --exec OrdersFromSupplier 'The Milkman'

 --Вывод всех продаж по названию покупателя
 create procedure SalesToBuyers (@NameBuyer varchar(50))
 as
	select Warehouse_Sale.SaleID, Warehouse_Sale.ProductID, Product.Name, Sale_date, Warehouse.Sale_price, Warehouse_Sale.Count_products
	from [dbo].[Warehouse_Sale] join [dbo].[Sale] on Warehouse_Sale.SaleID = Sale.SaleID 
	join [dbo].[Warehouse] on Warehouse.ProductID = Warehouse_Sale.ProductID and Warehouse.PurchaseID = Warehouse_Sale.PurchaseID
	join [dbo].[Buyer] on Buyer.BuyerID = Sale.SaleID join [dbo].[Product] on Warehouse_Sale.ProductID = Product.ProductID
	where Buyer.NameBuyer = @NameBuyer
 go

 --exec SalesToBuyers 'VkusVill'

 --Вывод информации о товаре на складе по названию
 create procedure ProductInformation (@NameProduct varchar(128))
 as
	select Warehouse.ProductID, Product.Name, Warehouse.PurchaseID, Warehouse.Purchase_date, Warehouse.Price_purchase, Warehouse.Price_sale, Warehouse.Count_products 
	from [dbo].[Warehouse] join [dbo].[Product] on Warehouse.ProductID = Product.ProductID 
	where Product.Name = @NameProduct
 go

 --exec ProductInformation 'Prostokvashino milk'

 
 --Вывод всех товаров по номеру заказа
 create procedure ProductsPurchased (@PurchaseID int)
 as
	select Product.ProductID, Product.Name, Purchase.Purchase_date, Product_Purchase.Price_purchase, Product_Purchase.Count_products, Suppliers.NameSuppliers
	from  [dbo].[Product_Purchase] join [dbo].[Purchase] on Purchase.PurchaseID = Product_Purchase.PurchaseID 
	join [dbo].[Product] on Product_Purchase.ProductID = Product.ProductID
	join [dbo].[Suppliers] on Purchase.SuppliersID = Suppliers.SuppliersID
	where Purchase.PurchaseID = @PurchaseID
 go

 --exec ProductsPurchased 7

 --Вывод всех товаров по номеру продажи
 create procedure ProductsSale (@SaleID int)
 as
	select Product.ProductID, Product.Name, Sale.Sale_date, Warehouse.Price_sale, Warehouse_Sale.Count_products, Buyer.NameBuyer
	from [dbo].[Warehouse_Sale] join [dbo].[Sale] on Warehouse_Sale.SaleID = Sale.SaleID
	join [dbo].[Warehouse] on Warehouse.ProductID = Warehouse_Sale.ProductID and Warehouse.PurchaseID = Warehouse_Sale.PurchaseID
	join [dbo].[Product] on Warehouse_Sale.ProductID = Product.ProductID
	join [dbo].[Buyer] on Sale.BuyerID = Buyer.BuyerID
	where Sale.SaleID = @SaleID
 go

 --exec ProductsSale 7
 

 --Атомарная функция

 --Табличная функция возвращает таблицу покупателей по названию города
 create function GetBuyerByTown(@TownName varchar(170)) returns table
 as
 return(
	select BuyerID, Buyer.NameBuyer, Buyer.BuyerITN, Buyer.Phone_number, Buyer.Street 
	from [dbo].[Buyer] join [dbo].[Town] on Buyer.TownID = Town.TownID 
	where Town.Name = @TownName and Buyer.Phone_number<>0
 )
 go

 --select *  from [dbo].[GetBuyerByTown] ('Moscow')


 --Табличная функция возвращает таблицу покупателей по названию города
 create function GetSupplierByTown(@TownName varchar(170)) returns table
 as
 return(
	select Suppliers.SuppliersID, Suppliers.NameSuppliers, Suppliers.SuppliersITN, Suppliers.Phone_number, Suppliers.Street
	from [dbo].[Suppliers] join [dbo].[Town] on Suppliers.TownID = Town.TownID 
	where Town.Name = @TownName and Suppliers.Phone_number<>0
 )
 go

 --select *  from [dbo].[GetSupplierByTown] ('Moscow')

 --Табличная функция возвращает таблицу продуктов по категории
 create function GetProductByCategory (@CategoryName varchar(128)) returns table
 as
 return
 (
	select Product.ProductID, Product.Name as Product_Name, Product.Unit_of_measure, Subcategory.SubcategoryID, Subcategory.Name as Subcategory_Name
	from [dbo].[Product] join [dbo].[Subcategory] on Product.SubcategoryID = Subcategory.SubcategoryID
	join [dbo].[Category] on Subcategory.CategoryID = Category.CategoryID where Category.Name = @CategoryName
 )
 go

 --select * from [dbo].[GetProductByCategory] ('Confectionery products')


 --Скалярная функция подсчета итоговой суммы по id закупки
 create function GetTotalPricePurchase (@PurchaseID int) returns money
 as
 begin
	declare @TotalPrice money
	select @TotalPrice = sum(Product_Purchase.Price_purchase * Product_Purchase.Count_products)
	from [dbo].[Product_Purchase] where Product_Purchase.PurchaseID = @PurchaseID
	return @TotalPrice
end
go

--declare @TotalPrice money
--set @TotalPrice = [dbo].[GetTotalPricePurchase] (1)
--select @TotalPrice


--Скалярная функция подсчета итоговой суммы по id продажи
 create function GetTotalPriceSale (@SaleID int) returns money
 as
 begin
	declare @TotalPrice money
	select @TotalPrice = sum(Warehouse_Sale.Sale_price * Warehouse_Sale.Count_products)
	from  [dbo].[Warehouse_Sale] where Warehouse_Sale.SaleID = @SaleID
	return @TotalPrice
end
go

--declare @TotalPrice money
--set @TotalPrice = [dbo].[GetTotalPriceSale] (2)
--select @TotalPrice


--Представление модифицируемое
create view ProductView
as
select ProductID, Name, SubcategoryID, Unit_of_measure from [dbo].[Product]
go

insert ProductView ( Name, SubcategoryID, Unit_of_measure) values ('New product', 9, 'piece')
select * from ProductView

update ProductView
set Name = 'Holy Spring' 
where Name = 'New product'
go
select * from ProductView

delete from ProductView where Name = 'Holy Spring' 
select * from ProductView

DROP VIEW IF EXISTS ProductView