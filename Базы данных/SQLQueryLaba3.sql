--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--2. ����������� ������� ������� ���������� �� ������ �� �
--���������� ���������:
--2.1. �������� ������� �� ������ ����������� ������������ ������ �
--���������,
/*����� ������� ������� � ��������������� ��������� � �������*/
select Town.Name, Subject.Name, Country.Name from [dbo].[Town], [dbo].[Subject], [dbo].[Country] where Town.SubjectID=Subject.SubjectID and Subject.CountryID=Country.CountryID 
order by Town.Name

select Town.Name, Subject.Name, Country.Name from [dbo].[Town] cross join [dbo].[Subject] cross join [dbo].[Country] where Town.SubjectID=Subject.SubjectID and Subject.CountryID=Country.CountryID 
order by Town.Name

--2.2. ���������� ���������� ������,
/*����������� ������������ � ��������� ������� ������ � ����*/
select Product.Name, Subcategory.Name, Category.Name from [dbo].[Product] inner join [dbo].[Subcategory] on Product.SubcategoryID = Subcategory.SubcategoryID inner join [dbo].[Category] on Subcategory.CategoryID= Category.CategoryID

--2.3. ������� ���������� ������,
/*����������� ��� ������������ � ������ ������ ������������ ��� ������ ��������� � ����*/
select Category.Name, Subcategory.Name, Product.Name from [dbo].[Category] full join [dbo].[Subcategory] on Subcategory.CategoryID= Category.CategoryID full join [dbo].[Product] on Product.SubcategoryID = Subcategory.SubcategoryID

/*�������� ���� ������� � ������� ����������*/
select Suppliers.NameSuppliers, Purchase.PurchaseID, Product.Name from [dbo].[Suppliers] left join [dbo].[Purchase] on Suppliers.SuppliersID=Purchase.SuppliersID left join [dbo].[Product_Purchase]
on Purchase.PurchaseID=Product_Purchase.PurchaseID left join [dbo].[Product] on Product_Purchase.ProductID=Product.ProductID where Suppliers.SuppliersID<>''

/*�� ������ ������ ���������� ����� ������� � ��� �����������*/
select Product.Name, Warehouse_Sale.Count_products, Sale.SaleID from [dbo].[Product] right join [dbo].[Warehouse_Sale] on Product.ProductID=Warehouse_Sale.ProductID right join [dbo].[Sale]
on Sale.SaleID= Warehouse_Sale.SaleID order by Sale.SaleID

--2.4. ���������� ������ ����� ��� �� ������ ����,
/*�������� ���������� � ��������, ����� ������ � ������ ���������� ���������� � ������ �� ��� ������� �������� ������*/
select distinct Product.Name, Suppliers.SuppliersITN, Suppliers.NameSuppliers, Town.Name from [dbo].[Product] inner join [dbo].[Product_Purchase] on Product.ProductID= Product_Purchase.ProductID
inner join [dbo].[Purchase] on Product_Purchase.PurchaseID=Purchase.PurchaseID inner join [dbo].[Suppliers] on Purchase.SuppliersID=Suppliers.SuppliersID inner join [dbo].[Town] on Suppliers.TownID= Town.TownID
inner join [dbo].[Subject] on Town.SubjectID=Subject.SubjectID inner join [dbo].[Country] on Country.CountryID=Subject.CountryID and Country.Name='Russia'

select distinct Product.Name, Suppliers.SuppliersITN, Suppliers.NameSuppliers, Town.Name from [dbo].[Product] inner join [dbo].[Product_Purchase] on Product.ProductID= Product_Purchase.ProductID
inner join [dbo].[Purchase] on Product_Purchase.PurchaseID=Purchase.PurchaseID inner join [dbo].[Suppliers] on Purchase.SuppliersID=Suppliers.SuppliersID inner join [dbo].[Town] on Suppliers.TownID= Town.TownID
inner join [dbo].[Subject] on Town.SubjectID=Subject.SubjectID inner join [dbo].[Country] on Country.CountryID=Subject.CountryID where Country.Name='Russia'

--2.5. ������� ���������� �� ������� � �����������,
/*������� ��� ������ � �� ������������ �� �������� ���������� ���������*/
declare @Name varchar(128)
set @Name = 'Confectionery products'
select Product.Name, Subcategory.Name from [dbo].[Product] inner join [dbo].[Subcategory] on Product.SubcategoryID = Subcategory.SubcategoryID inner join [dbo].[Category] on Subcategory.CategoryID= Category.CategoryID
where Category.Name = @Name

--2.6. ������� ���������� �� ������������ ����������� � ���������,
/*�������� ���������� � �������� � ����������� � id 1 � 4*/
select * from [dbo].[Purchase] inner join [dbo].[Suppliers] 
on Purchase.SuppliersID=Suppliers.SuppliersID where Suppliers.SuppliersID in (select Suppliers.SuppliersID from [dbo].[Suppliers] where Suppliers.NameSuppliers in ('The Milkman','Housewife')
)

select Suppliers.SuppliersID from [dbo].[Suppliers] where Suppliers.NameSuppliers in ('The Milkman','Housewife')
/*�������� ���������� � �������� � ����������� � id �� 1 �� 4*/
select * from [dbo].[Purchase] inner join [dbo].[Suppliers] 
on Purchase.SuppliersID=Suppliers.SuppliersID where Suppliers.SuppliersID between 1 and 4

--2.7. ��������� �������������� ���������� �� ������ �������
--������������� � ����� ����� � �� ������ ����������� ���������� �����,
/*������� �����������, ������������, �������, �������� ���� ��� ������� ������*/
select Purchase.PurchaseID as PurchaseID,
		MIN(Product_Purchase.Price_purchase) as MinPrice,
		MAX(Product_Purchase.Price_purchase) as MaxPrise,
		AVG(Product_Purchase.Price_purchase) as AvgPrise,
		Count(1) as CountProduct,
		Sum(Product_Purchase.Price_purchase) as TotalPrise
from [dbo].[Product_Purchase] join [dbo].[Purchase] on Product_Purchase.PurchaseID=Purchase.PurchaseID
group by Purchase.PurchaseID order by TotalPrise desc

--2.8. ������� �� �������� ��������� ��������,
/*��������� ���������� �� ������� ��������� ������*/
select [dbo].[Warehouse].*, [dbo].[Sale].* from [dbo].[Warehouse] join [dbo].[Warehouse_Sale] on Warehouse.ProductID =Warehouse_Sale.ProductID and Warehouse.PurchaseID = Warehouse_Sale.PurchaseID
join [dbo].[Sale] on Sale.SaleID=Warehouse_Sale.SaleID

--2.9. ����������� �������,
/*����� ����������� �� ������ ������*/
select top(100) 
	t1.SuppliersID , t2.SuppliersID,
	t1.SuppliersITN, t2.SuppliersITN,
	t1.NameSuppliers, t2.NameSuppliers,
	Town.Name
from [dbo].[Suppliers] t1 join [dbo].[Suppliers] t2 
on t1.SuppliersID<t2.SuppliersID and t1.NameSuppliers<>'' 
and t2.NameSuppliers<>'' and t1.TownID=t2.TownID inner join [dbo].[Town] on t1.TownID = Town.TownID

--2.10. ������������ ������� � ������� �� �����������, ����������� �
--���������.
/*������ ������ ���� ��������*/
select Product.Name ProductName, Subcategory.Name SubcategoryName from [dbo].[Product] inner join [dbo].[Subcategory] on Product.SubcategoryID = Subcategory.SubcategoryID inner join [dbo].[Category] on Subcategory.CategoryID= Category.CategoryID
where Category.Name ='Soft drinks'
Union 
select Product.Name ProductName, Subcategory.Name SubcategoryName from [dbo].[Product] inner join [dbo].[Subcategory] on Product.SubcategoryID = Subcategory.SubcategoryID inner join [dbo].[Category] on Subcategory.CategoryID= Category.CategoryID
where Category.Name ='Coffee drinks'
Union 
select Product.Name ProductName, Subcategory.Name SubcategoryName from [dbo].[Product] inner join [dbo].[Subcategory] on Product.SubcategoryID = Subcategory.SubcategoryID inner join [dbo].[Category] on Subcategory.CategoryID= Category.CategoryID
where Category.Name ='Alcoholic beverages'

/*������ ������ ���� ����������� �� ������, ����� ������� ��������� �� 8*/
select [dbo].[Suppliers].* from [dbo].[Suppliers] join [dbo].[Town] on Suppliers.TownID=Town.TownID and Suppliers.NameSuppliers<>'' join [dbo].[Subject] on Town.SubjectID=Subject.SubjectID join [dbo].[Country]
on Country.CountryID=Subject.CountryID and Country.Name='Russia'
INTERSECT
select [dbo].[Suppliers].* from [dbo].[Suppliers] where Suppliers.Phone_number like '8%'

/*������ ������ ���� ����������� �� ������, ����� ������� ��������� �� �� 8*/
select [dbo].[Suppliers].* from [dbo].[Suppliers] join [dbo].[Town] on Suppliers.TownID=Town.TownID and Suppliers.NameSuppliers<>'' join [dbo].[Subject] on Town.SubjectID=Subject.SubjectID join [dbo].[Country]
on Country.CountryID=Subject.CountryID and Country.Name='Russia'
EXCEPT
select [dbo].[Suppliers].* from [dbo].[Suppliers] where Suppliers.Phone_number like '8%'

--3. ����������� ������� ����������� ������:
--3.1. ������� ����� ������ � �������,
insert [dbo].[Table_1] (ProductID,Name, SubcategoryID, Unit_of_measure) values (1,'Rich juice', 10, 'piece')
insert [dbo].[Table_1] (ProductID,Name, SubcategoryID, Unit_of_measure) values (2,'Good juice', 10, 'piece')
select * from [dbo].[Table_1]

--3.2. ������� ��������� ������� � �������,
insert into [dbo].[Table_2] (ProductID, Name, SubcategoryID, Unit_of_measure) select Table_1.ProductID, Table_1.Name, Table_1.SubcategoryID, Table_1.Unit_of_measure from [dbo].[Table_1]
select * from [dbo].[Table_2]

--3.3. �������� �������,
CREATE TABLE Table_1
( 
	ProductID	smallint NOT NULL,
	Name	varchar(128)	NOT NULL,
	SubcategoryID	smallint	NOT NULL,
	Unit_of_measure	varchar(50) NOT NULL
)
go
CREATE TABLE Table_2
( 
	ProductID	smallint NOT NULL,
	Name	varchar(128)	NOT NULL,
	SubcategoryID	smallint	NOT NULL,
	Unit_of_measure	varchar(50) NOT NULL
)
go
--3.4. �������� ������� �� ������ �������,
select Table_1.ProductID, Table_1.Name, Table_1.SubcategoryID, Table_1.Unit_of_measure into Table_2 from [dbo].[Table_1] where Table_1.SubcategoryID = 10
select * from [dbo].[Table_2]

--3.5. ��������� ������ � �������,
update [dbo].[Table_1] set Table_1.Unit_of_measure = 'packaging', SubcategoryID = SubcategoryID-1 
where Unit_of_measure= 'piece'
select * from [dbo].[Table_1]

--3.6. �������� ������ �� �������,
delete from [dbo].[Warehouse][Table_1] where Table_1.Name like'Rich%'
select * from [dbo].[Table_1]

delete from [dbo].[Table_2] 
select * from [dbo].[Table_2]

--3.7. �������� �������,
drop table [dbo].[Table_2]

--3.8. ��������� �������.
alter table [dbo].[Table_2]
	ADD CONSTRAINT UN_Table_2_ProductID UNIQUE (ProductID ASC)
go

--//////////////////////////////////////////////////////////////
--DELETE FROM [Product_Purchase]
--DBCC CHECKIDENT ('Product_Purchase', RESEED, 0)
--GO

