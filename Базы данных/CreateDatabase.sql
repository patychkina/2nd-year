USE [master]
GO
/****** Object:  Database [Warehouse]    Script Date: 11.04.2024 10:15:59 ******/
CREATE DATABASE [Warehouse]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Warehouse', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Warehouse.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Warehouse_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Warehouse_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Warehouse] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Warehouse].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Warehouse] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Warehouse] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Warehouse] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Warehouse] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Warehouse] SET ARITHABORT OFF 
GO
ALTER DATABASE [Warehouse] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Warehouse] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Warehouse] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Warehouse] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Warehouse] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Warehouse] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Warehouse] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Warehouse] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Warehouse] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Warehouse] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Warehouse] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Warehouse] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Warehouse] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Warehouse] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Warehouse] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Warehouse] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Warehouse] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Warehouse] SET RECOVERY FULL 
GO
ALTER DATABASE [Warehouse] SET  MULTI_USER 
GO
ALTER DATABASE [Warehouse] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Warehouse] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Warehouse] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Warehouse] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Warehouse] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Warehouse] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Warehouse', N'ON'
GO
ALTER DATABASE [Warehouse] SET QUERY_STORE = ON
GO
ALTER DATABASE [Warehouse] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Warehouse]
GO
/****** Object:  Table [dbo].[Buyer]    Script Date: 11.04.2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Buyer](
	[BuyerID] [smallint] IDENTITY(0,1) NOT NULL,
	[BuyerITN] [varchar](10) NOT NULL,
	[NameBuyer] [varchar](50) NOT NULL,
	[Phone_number] [varchar](12) NOT NULL,
	[TownID] [smallint] NOT NULL,
	[Street] [varchar](50) NOT NULL,
 CONSTRAINT [IX_Buyer_BuyerID] PRIMARY KEY CLUSTERED 
(
	[BuyerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 11.04.2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [smallint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](128) NOT NULL,
 CONSTRAINT [IX_Category_CategoryID] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Country]    Script Date: 11.04.2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[CountryID] [tinyint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](45) NOT NULL,
 CONSTRAINT [IX_Country_CountryID] PRIMARY KEY CLUSTERED 
(
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment_type]    Script Date: 11.04.2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment_type](
	[TypeID] [bit] NOT NULL,
	[Name] [varchar](20) NOT NULL,
 CONSTRAINT [XPKPayment_type] PRIMARY KEY CLUSTERED 
(
	[TypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 11.04.2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [smallint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](128) NOT NULL,
	[SubcategoryID] [smallint] NOT NULL,
	[Unit_of_measure] [varchar](50) NOT NULL,
 CONSTRAINT [IX_Product_ProductID] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product_Purchase]    Script Date: 11.04.2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_Purchase](
	[PurchaseID] [int] NOT NULL,
	[ProductID] [smallint] NOT NULL,
	[Purchase_date] [datetime] NOT NULL,
	[Price_purchase] [money] NOT NULL,
	[Count_products] [int] NOT NULL,
 CONSTRAINT [IX_Product_Purchase_ProductID_PurchaseID] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[PurchaseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Purchase]    Script Date: 11.04.2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Purchase](
	[PurchaseID] [int] IDENTITY(1,1) NOT NULL,
	[SuppliersID] [smallint] NOT NULL,
	[Purchase_date] [datetime] NOT NULL,
	[Price_total] [money] NOT NULL,
	[Payment_status] [bit] NOT NULL,
	[TypeID] [bit] NOT NULL,
 CONSTRAINT [IX_Purchase_PurchaseID] PRIMARY KEY CLUSTERED 
(
	[PurchaseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sale]    Script Date: 11.04.2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sale](
	[SaleID] [int] IDENTITY(1,1) NOT NULL,
	[BuyerID] [smallint] NOT NULL,
	[Sale_date] [datetime] NOT NULL,
	[Price_total] [money] NOT NULL,
	[Payment_status] [bit] NOT NULL,
	[TypeID] [bit] NOT NULL,
 CONSTRAINT [IX_Sale_SaleID] PRIMARY KEY CLUSTERED 
(
	[SaleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subcategory]    Script Date: 11.04.2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subcategory](
	[SubcategoryID] [smallint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](128) NOT NULL,
	[CategoryID] [smallint] NOT NULL,
 CONSTRAINT [IX_Subcategory_SubcategoryID] PRIMARY KEY CLUSTERED 
(
	[SubcategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subject]    Script Date: 11.04.2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subject](
	[SubjectID] [tinyint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[CountryID] [tinyint] NOT NULL,
 CONSTRAINT [IX_Subject_SubjectID] PRIMARY KEY CLUSTERED 
(
	[SubjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Suppliers]    Script Date: 11.04.2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suppliers](
	[SuppliersID] [smallint] IDENTITY(0,1) NOT NULL,
	[SuppliersITN] [varchar](10) NOT NULL,
	[NameSuppliers] [varchar](50) NOT NULL,
	[Phone_number] [varchar](12) NOT NULL,
	[Street] [varchar](50) NOT NULL,
	[TownID] [smallint] NOT NULL,
 CONSTRAINT [IX_Suppliers_SuppliersID] PRIMARY KEY CLUSTERED 
(
	[SuppliersID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Town]    Script Date: 11.04.2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Town](
	[TownID] [smallint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](170) NOT NULL,
	[SubjectID] [tinyint] NULL,
 CONSTRAINT [IX_Town_TownID] PRIMARY KEY CLUSTERED 
(
	[TownID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Warehouse]    Script Date: 11.04.2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Warehouse](
	[PurchaseID] [int] NOT NULL,
	[ProductID] [smallint] NOT NULL,
	[Purchase_date] [datetime] NOT NULL,
	[Price_purchase] [money] NOT NULL,
	[Count_products] [int] NOT NULL,
 CONSTRAINT [IX_Warehouse_ProductID_PurchaseID] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[PurchaseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Warehouse_Sale]    Script Date: 11.04.2024 10:15:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Warehouse_Sale](
	[SaleID] [int] NOT NULL,
	[PurchaseID] [int] NOT NULL,
	[ProductID] [smallint] NOT NULL,
	[Sale_price] [money] NOT NULL,
	[Count_products] [int] NOT NULL,
 CONSTRAINT [IX_Warehouse_Sale_SaleID_ProductID_PurchaseID] PRIMARY KEY CLUSTERED 
(
	[SaleID] ASC,
	[ProductID] ASC,
	[PurchaseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Buyer] ON 

INSERT [dbo].[Buyer] ([BuyerID], [BuyerITN], [NameBuyer], [Phone_number], [TownID], [Street]) VALUES (0, N'', N'', N'', 1, N'')
INSERT [dbo].[Buyer] ([BuyerID], [BuyerITN], [NameBuyer], [Phone_number], [TownID], [Street]) VALUES (1, N'1234567890', N'Magnit', N'8934567', 2, N'Sadovaya 22')
INSERT [dbo].[Buyer] ([BuyerID], [BuyerITN], [NameBuyer], [Phone_number], [TownID], [Street]) VALUES (2, N'1234567891', N'Pyaterochka', N'23448228', 1, N'Tverskaya 3 ')
INSERT [dbo].[Buyer] ([BuyerID], [BuyerITN], [NameBuyer], [Phone_number], [TownID], [Street]) VALUES (3, N'1234567892', N'Fixprice', N'83920204', 2, N'Boulevard 10')
INSERT [dbo].[Buyer] ([BuyerID], [BuyerITN], [NameBuyer], [Phone_number], [TownID], [Street]) VALUES (4, N'1234567893', N'Perekrestok', N'2198730', 5, N'Chekhov 22')
INSERT [dbo].[Buyer] ([BuyerID], [BuyerITN], [NameBuyer], [Phone_number], [TownID], [Street]) VALUES (5, N'1234567894', N'Fixprice', N'17294038', 6, N'Kalinina 9')
INSERT [dbo].[Buyer] ([BuyerID], [BuyerITN], [NameBuyer], [Phone_number], [TownID], [Street]) VALUES (6, N'1234567895', N'Dixy', N'12894038', 4, N'Lenina 44')
INSERT [dbo].[Buyer] ([BuyerID], [BuyerITN], [NameBuyer], [Phone_number], [TownID], [Street]) VALUES (7, N'1234567896', N'VkusVill', N'1213457', 5, N'Frunze 8')
INSERT [dbo].[Buyer] ([BuyerID], [BuyerITN], [NameBuyer], [Phone_number], [TownID], [Street]) VALUES (8, N'1234567897', N'VkusVill', N'36890543', 10, N'Sadovaya 5')
INSERT [dbo].[Buyer] ([BuyerID], [BuyerITN], [NameBuyer], [Phone_number], [TownID], [Street]) VALUES (9, N'1234567898', N'VkusVill', N'968643214', 1, N'Lenina 156')
INSERT [dbo].[Buyer] ([BuyerID], [BuyerITN], [NameBuyer], [Phone_number], [TownID], [Street]) VALUES (10, N'1234567899', N'Magnit', N'864297531', 2, N'Taganrogskaya 11')
SET IDENTITY_INSERT [dbo].[Buyer] OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryID], [Name]) VALUES (6, N'Alcoholic beverages')
INSERT [dbo].[Category] ([CategoryID], [Name]) VALUES (4, N'Bakery products')
INSERT [dbo].[Category] ([CategoryID], [Name]) VALUES (7, N'Coffee drinks')
INSERT [dbo].[Category] ([CategoryID], [Name]) VALUES (1, N'Confectionery products')
INSERT [dbo].[Category] ([CategoryID], [Name]) VALUES (3, N'Dairy products')
INSERT [dbo].[Category] ([CategoryID], [Name]) VALUES (10, N'Fish products')
INSERT [dbo].[Category] ([CategoryID], [Name]) VALUES (8, N'Groceries')
INSERT [dbo].[Category] ([CategoryID], [Name]) VALUES (9, N'Household chemicals')
INSERT [dbo].[Category] ([CategoryID], [Name]) VALUES (2, N'Sausage products')
INSERT [dbo].[Category] ([CategoryID], [Name]) VALUES (5, N'Soft drinks')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Country] ON 

INSERT [dbo].[Country] ([CountryID], [Name]) VALUES (4, N'Armenia')
INSERT [dbo].[Country] ([CountryID], [Name]) VALUES (7, N'Azerbaijan')
INSERT [dbo].[Country] ([CountryID], [Name]) VALUES (2, N'Belarus')
INSERT [dbo].[Country] ([CountryID], [Name]) VALUES (9, N'China')
INSERT [dbo].[Country] ([CountryID], [Name]) VALUES (3, N'Kazakhstan')
INSERT [dbo].[Country] ([CountryID], [Name]) VALUES (1, N'Russia')
INSERT [dbo].[Country] ([CountryID], [Name]) VALUES (8, N'Serbia')
INSERT [dbo].[Country] ([CountryID], [Name]) VALUES (6, N'Tajikistan')
INSERT [dbo].[Country] ([CountryID], [Name]) VALUES (5, N'Turkey')
INSERT [dbo].[Country] ([CountryID], [Name]) VALUES (10, N'Uzbekistan')
SET IDENTITY_INSERT [dbo].[Country] OFF
GO
INSERT [dbo].[Payment_type] ([TypeID], [Name]) VALUES (0, N'Cash')
INSERT [dbo].[Payment_type] ([TypeID], [Name]) VALUES (1, N'Сard')
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ProductID], [Name], [SubcategoryID], [Unit_of_measure]) VALUES (1, N'Raffaello', 1, N'kilogram')
INSERT [dbo].[Product] ([ProductID], [Name], [SubcategoryID], [Unit_of_measure]) VALUES (2, N'Snickers', 1, N'kilogram')
INSERT [dbo].[Product] ([ProductID], [Name], [SubcategoryID], [Unit_of_measure]) VALUES (3, N'AlpenGolt nutty', 2, N'piece')
INSERT [dbo].[Product] ([ProductID], [Name], [SubcategoryID], [Unit_of_measure]) VALUES (4, N'Good juice', 10, N'piece')
INSERT [dbo].[Product] ([ProductID], [Name], [SubcategoryID], [Unit_of_measure]) VALUES (5, N'Narzan', 9, N'piece')
INSERT [dbo].[Product] ([ProductID], [Name], [SubcategoryID], [Unit_of_measure]) VALUES (6, N'Dad can', 6, N'piece')
INSERT [dbo].[Product] ([ProductID], [Name], [SubcategoryID], [Unit_of_measure]) VALUES (7, N'Prostokvashino milk', 7, N'piece')
INSERT [dbo].[Product] ([ProductID], [Name], [SubcategoryID], [Unit_of_measure]) VALUES (8, N'Prostokvashino sour cream', 8, N'piece')
INSERT [dbo].[Product] ([ProductID], [Name], [SubcategoryID], [Unit_of_measure]) VALUES (9, N'AlpenGolt milky', 2, N'piece')
INSERT [dbo].[Product] ([ProductID], [Name], [SubcategoryID], [Unit_of_measure]) VALUES (10, N'Czech beer', 12, N'piece')
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
INSERT [dbo].[Product_Purchase] ([PurchaseID], [ProductID], [Purchase_date], [Price_purchase], [Count_products]) VALUES (2, 1, CAST(N'2024-03-10T15:00:00.000' AS DateTime), 100.0000, 10000)
INSERT [dbo].[Product_Purchase] ([PurchaseID], [ProductID], [Purchase_date], [Price_purchase], [Count_products]) VALUES (2, 2, CAST(N'2024-03-10T15:00:00.000' AS DateTime), 120.0000, 20000)
INSERT [dbo].[Product_Purchase] ([PurchaseID], [ProductID], [Purchase_date], [Price_purchase], [Count_products]) VALUES (8, 3, CAST(N'2024-03-10T15:00:00.000' AS DateTime), 80.0000, 80)
INSERT [dbo].[Product_Purchase] ([PurchaseID], [ProductID], [Purchase_date], [Price_purchase], [Count_products]) VALUES (10, 4, CAST(N'2024-03-10T15:00:00.000' AS DateTime), 120.0000, 20)
INSERT [dbo].[Product_Purchase] ([PurchaseID], [ProductID], [Purchase_date], [Price_purchase], [Count_products]) VALUES (3, 6, CAST(N'2024-03-09T15:00:00.000' AS DateTime), 130.0000, 20)
INSERT [dbo].[Product_Purchase] ([PurchaseID], [ProductID], [Purchase_date], [Price_purchase], [Count_products]) VALUES (4, 6, CAST(N'2024-03-10T15:00:00.000' AS DateTime), 130.0000, 30)
INSERT [dbo].[Product_Purchase] ([PurchaseID], [ProductID], [Purchase_date], [Price_purchase], [Count_products]) VALUES (1, 7, CAST(N'2024-03-10T15:00:00.000' AS DateTime), 80.0000, 200)
INSERT [dbo].[Product_Purchase] ([PurchaseID], [ProductID], [Purchase_date], [Price_purchase], [Count_products]) VALUES (6, 7, CAST(N'2024-03-09T15:00:00.000' AS DateTime), 90.0000, 200)
INSERT [dbo].[Product_Purchase] ([PurchaseID], [ProductID], [Purchase_date], [Price_purchase], [Count_products]) VALUES (1, 8, CAST(N'2024-03-10T15:00:00.000' AS DateTime), 50.0000, 100)
INSERT [dbo].[Product_Purchase] ([PurchaseID], [ProductID], [Purchase_date], [Price_purchase], [Count_products]) VALUES (9, 9, CAST(N'2024-03-08T15:00:00.000' AS DateTime), 70.0000, 70)
INSERT [dbo].[Product_Purchase] ([PurchaseID], [ProductID], [Purchase_date], [Price_purchase], [Count_products]) VALUES (5, 10, CAST(N'2024-03-10T15:00:00.000' AS DateTime), 50.0000, 20)
INSERT [dbo].[Product_Purchase] ([PurchaseID], [ProductID], [Purchase_date], [Price_purchase], [Count_products]) VALUES (7, 10, CAST(N'2024-03-09T15:00:00.000' AS DateTime), 60.0000, 50)
GO
SET IDENTITY_INSERT [dbo].[Purchase] ON 

INSERT [dbo].[Purchase] ([PurchaseID], [SuppliersID], [Purchase_date], [Price_total], [Payment_status], [TypeID]) VALUES (1, 1, CAST(N'2024-03-10T15:00:00.000' AS DateTime), 0.0000, 0, 0)
INSERT [dbo].[Purchase] ([PurchaseID], [SuppliersID], [Purchase_date], [Price_total], [Payment_status], [TypeID]) VALUES (2, 2, CAST(N'2024-03-10T15:00:00.000' AS DateTime), 0.0000, 1, 0)
INSERT [dbo].[Purchase] ([PurchaseID], [SuppliersID], [Purchase_date], [Price_total], [Payment_status], [TypeID]) VALUES (3, 4, CAST(N'2024-03-09T15:00:00.000' AS DateTime), 0.0000, 1, 1)
INSERT [dbo].[Purchase] ([PurchaseID], [SuppliersID], [Purchase_date], [Price_total], [Payment_status], [TypeID]) VALUES (4, 4, CAST(N'2024-03-10T15:00:00.000' AS DateTime), 0.0000, 0, 1)
INSERT [dbo].[Purchase] ([PurchaseID], [SuppliersID], [Purchase_date], [Price_total], [Payment_status], [TypeID]) VALUES (5, 5, CAST(N'2024-03-10T15:00:00.000' AS DateTime), 0.0000, 0, 0)
INSERT [dbo].[Purchase] ([PurchaseID], [SuppliersID], [Purchase_date], [Price_total], [Payment_status], [TypeID]) VALUES (6, 1, CAST(N'2024-03-09T15:00:00.000' AS DateTime), 0.0000, 1, 1)
INSERT [dbo].[Purchase] ([PurchaseID], [SuppliersID], [Purchase_date], [Price_total], [Payment_status], [TypeID]) VALUES (7, 5, CAST(N'2024-03-09T15:00:00.000' AS DateTime), 0.0000, 1, 0)
INSERT [dbo].[Purchase] ([PurchaseID], [SuppliersID], [Purchase_date], [Price_total], [Payment_status], [TypeID]) VALUES (8, 7, CAST(N'2024-03-10T15:00:00.000' AS DateTime), 0.0000, 0, 0)
INSERT [dbo].[Purchase] ([PurchaseID], [SuppliersID], [Purchase_date], [Price_total], [Payment_status], [TypeID]) VALUES (9, 7, CAST(N'2024-03-08T15:00:00.000' AS DateTime), 0.0000, 1, 1)
INSERT [dbo].[Purchase] ([PurchaseID], [SuppliersID], [Purchase_date], [Price_total], [Payment_status], [TypeID]) VALUES (10, 8, CAST(N'2024-03-10T15:00:00.000' AS DateTime), 0.0000, 1, 0)
SET IDENTITY_INSERT [dbo].[Purchase] OFF
GO
SET IDENTITY_INSERT [dbo].[Sale] ON 

INSERT [dbo].[Sale] ([SaleID], [BuyerID], [Sale_date], [Price_total], [Payment_status], [TypeID]) VALUES (1, 1, CAST(N'2024-04-10T15:00:00.000' AS DateTime), 0.0000, 0, 0)
INSERT [dbo].[Sale] ([SaleID], [BuyerID], [Sale_date], [Price_total], [Payment_status], [TypeID]) VALUES (2, 2, CAST(N'2024-04-10T15:00:00.000' AS DateTime), 0.0000, 1, 0)
INSERT [dbo].[Sale] ([SaleID], [BuyerID], [Sale_date], [Price_total], [Payment_status], [TypeID]) VALUES (3, 4, CAST(N'2024-04-09T15:00:00.000' AS DateTime), 0.0000, 1, 1)
INSERT [dbo].[Sale] ([SaleID], [BuyerID], [Sale_date], [Price_total], [Payment_status], [TypeID]) VALUES (4, 4, CAST(N'2024-04-10T15:00:00.000' AS DateTime), 0.0000, 0, 1)
INSERT [dbo].[Sale] ([SaleID], [BuyerID], [Sale_date], [Price_total], [Payment_status], [TypeID]) VALUES (5, 5, CAST(N'2024-04-10T15:00:00.000' AS DateTime), 0.0000, 0, 0)
INSERT [dbo].[Sale] ([SaleID], [BuyerID], [Sale_date], [Price_total], [Payment_status], [TypeID]) VALUES (6, 1, CAST(N'2024-04-09T15:00:00.000' AS DateTime), 0.0000, 1, 1)
INSERT [dbo].[Sale] ([SaleID], [BuyerID], [Sale_date], [Price_total], [Payment_status], [TypeID]) VALUES (7, 5, CAST(N'2024-04-09T15:00:00.000' AS DateTime), 0.0000, 1, 0)
INSERT [dbo].[Sale] ([SaleID], [BuyerID], [Sale_date], [Price_total], [Payment_status], [TypeID]) VALUES (8, 7, CAST(N'2024-04-10T15:00:00.000' AS DateTime), 0.0000, 0, 0)
INSERT [dbo].[Sale] ([SaleID], [BuyerID], [Sale_date], [Price_total], [Payment_status], [TypeID]) VALUES (9, 7, CAST(N'2024-04-08T15:00:00.000' AS DateTime), 0.0000, 1, 1)
INSERT [dbo].[Sale] ([SaleID], [BuyerID], [Sale_date], [Price_total], [Payment_status], [TypeID]) VALUES (10, 8, CAST(N'2024-04-10T15:00:00.000' AS DateTime), 0.0000, 1, 0)
SET IDENTITY_INSERT [dbo].[Sale] OFF
GO
SET IDENTITY_INSERT [dbo].[Subcategory] ON 

INSERT [dbo].[Subcategory] ([SubcategoryID], [Name], [CategoryID]) VALUES (1, N'Candies', 1)
INSERT [dbo].[Subcategory] ([SubcategoryID], [Name], [CategoryID]) VALUES (2, N'Chocolate', 1)
INSERT [dbo].[Subcategory] ([SubcategoryID], [Name], [CategoryID]) VALUES (3, N'Cookie', 1)
INSERT [dbo].[Subcategory] ([SubcategoryID], [Name], [CategoryID]) VALUES (4, N'Boiled sausage', 2)
INSERT [dbo].[Subcategory] ([SubcategoryID], [Name], [CategoryID]) VALUES (5, N'Smoked sausage', 2)
INSERT [dbo].[Subcategory] ([SubcategoryID], [Name], [CategoryID]) VALUES (6, N'Sausages', 2)
INSERT [dbo].[Subcategory] ([SubcategoryID], [Name], [CategoryID]) VALUES (7, N'Milk', 3)
INSERT [dbo].[Subcategory] ([SubcategoryID], [Name], [CategoryID]) VALUES (8, N'Sour cream', 3)
INSERT [dbo].[Subcategory] ([SubcategoryID], [Name], [CategoryID]) VALUES (9, N'Water', 5)
INSERT [dbo].[Subcategory] ([SubcategoryID], [Name], [CategoryID]) VALUES (10, N'Juice', 5)
INSERT [dbo].[Subcategory] ([SubcategoryID], [Name], [CategoryID]) VALUES (11, N'Wine', 6)
INSERT [dbo].[Subcategory] ([SubcategoryID], [Name], [CategoryID]) VALUES (12, N'Beer', 6)
SET IDENTITY_INSERT [dbo].[Subcategory] OFF
GO
SET IDENTITY_INSERT [dbo].[Subject] ON 

INSERT [dbo].[Subject] ([SubjectID], [Name], [CountryID]) VALUES (1, N'Moscow region', 1)
INSERT [dbo].[Subject] ([SubjectID], [Name], [CountryID]) VALUES (2, N'Rostov region', 1)
INSERT [dbo].[Subject] ([SubjectID], [Name], [CountryID]) VALUES (3, N'Kaluga region', 1)
INSERT [dbo].[Subject] ([SubjectID], [Name], [CountryID]) VALUES (4, N'Leningrad region', 1)
INSERT [dbo].[Subject] ([SubjectID], [Name], [CountryID]) VALUES (5, N'Minsk region', 2)
INSERT [dbo].[Subject] ([SubjectID], [Name], [CountryID]) VALUES (6, N'Gomel region', 2)
INSERT [dbo].[Subject] ([SubjectID], [Name], [CountryID]) VALUES (7, N'Karaganda region', 3)
INSERT [dbo].[Subject] ([SubjectID], [Name], [CountryID]) VALUES (8, N'Armavir region', 4)
INSERT [dbo].[Subject] ([SubjectID], [Name], [CountryID]) VALUES (9, N'Vitebsk region', 2)
INSERT [dbo].[Subject] ([SubjectID], [Name], [CountryID]) VALUES (10, N'Krasnodarskiy kray', 1)
SET IDENTITY_INSERT [dbo].[Subject] OFF
GO
SET IDENTITY_INSERT [dbo].[Suppliers] ON 

INSERT [dbo].[Suppliers] ([SuppliersID], [SuppliersITN], [NameSuppliers], [Phone_number], [Street], [TownID]) VALUES (0, N'', N'', N'', N'', 1)
INSERT [dbo].[Suppliers] ([SuppliersID], [SuppliersITN], [NameSuppliers], [Phone_number], [Street], [TownID]) VALUES (1, N'2234567890', N'The Milkman', N'8934567', N'Sadovaya 22', 2)
INSERT [dbo].[Suppliers] ([SuppliersID], [SuppliersITN], [NameSuppliers], [Phone_number], [Street], [TownID]) VALUES (2, N'2234567891', N'Confectioner', N'23448228', N'Tverskaya 3 ', 1)
INSERT [dbo].[Suppliers] ([SuppliersID], [SuppliersITN], [NameSuppliers], [Phone_number], [Street], [TownID]) VALUES (3, N'2234567892', N'Housewife', N'83920204', N'Boulevard 10', 2)
INSERT [dbo].[Suppliers] ([SuppliersID], [SuppliersITN], [NameSuppliers], [Phone_number], [Street], [TownID]) VALUES (4, N'2234567893', N'Sausage Maker', N'2198730', N'Chekhov 22', 5)
INSERT [dbo].[Suppliers] ([SuppliersID], [SuppliersITN], [NameSuppliers], [Phone_number], [Street], [TownID]) VALUES (5, N'2234567894', N'Beer Hall', N'17294038', N'Kalinina 9', 6)
INSERT [dbo].[Suppliers] ([SuppliersID], [SuppliersITN], [NameSuppliers], [Phone_number], [Street], [TownID]) VALUES (6, N'2234567895', N'Wine cellar', N'12894038', N'Lenina 44', 4)
INSERT [dbo].[Suppliers] ([SuppliersID], [SuppliersITN], [NameSuppliers], [Phone_number], [Street], [TownID]) VALUES (7, N'2234567896', N'The Chocolate Factory', N'1213457', N'Frunze 8', 5)
INSERT [dbo].[Suppliers] ([SuppliersID], [SuppliersITN], [NameSuppliers], [Phone_number], [Street], [TownID]) VALUES (8, N'2234567897', N'Natural juice', N'36890543', N'Sadovaya 5', 10)
INSERT [dbo].[Suppliers] ([SuppliersID], [SuppliersITN], [NameSuppliers], [Phone_number], [Street], [TownID]) VALUES (9, N'2234567898', N'Fishman', N'968643214', N'Lenina 156', 1)
INSERT [dbo].[Suppliers] ([SuppliersID], [SuppliersITN], [NameSuppliers], [Phone_number], [Street], [TownID]) VALUES (10, N'2234567899', N'Groceriesman', N'864297531', N'Taganrogskaya 11', 2)
SET IDENTITY_INSERT [dbo].[Suppliers] OFF
GO
SET IDENTITY_INSERT [dbo].[Town] ON 

INSERT [dbo].[Town] ([TownID], [Name], [SubjectID]) VALUES (1, N'Moscow', 1)
INSERT [dbo].[Town] ([TownID], [Name], [SubjectID]) VALUES (2, N'Rostov-on-Don', 2)
INSERT [dbo].[Town] ([TownID], [Name], [SubjectID]) VALUES (3, N'Kaluga', 3)
INSERT [dbo].[Town] ([TownID], [Name], [SubjectID]) VALUES (4, N'Saint-Petersburg', 4)
INSERT [dbo].[Town] ([TownID], [Name], [SubjectID]) VALUES (5, N'Taganrog', 2)
INSERT [dbo].[Town] ([TownID], [Name], [SubjectID]) VALUES (6, N'Minsk', 5)
INSERT [dbo].[Town] ([TownID], [Name], [SubjectID]) VALUES (7, N'Bragin', 6)
INSERT [dbo].[Town] ([TownID], [Name], [SubjectID]) VALUES (8, N'Karaganda', 7)
INSERT [dbo].[Town] ([TownID], [Name], [SubjectID]) VALUES (9, N'Armavir', 8)
INSERT [dbo].[Town] ([TownID], [Name], [SubjectID]) VALUES (10, N'Krasnodar', 10)
SET IDENTITY_INSERT [dbo].[Town] OFF
GO
INSERT [dbo].[Warehouse] ([PurchaseID], [ProductID], [Purchase_date], [Price_purchase], [Count_products]) VALUES (2, 1, CAST(N'2024-04-10T15:00:00.000' AS DateTime), 100.0000, 10000)
INSERT [dbo].[Warehouse] ([PurchaseID], [ProductID], [Purchase_date], [Price_purchase], [Count_products]) VALUES (2, 2, CAST(N'2024-04-10T15:00:00.000' AS DateTime), 120.0000, 20000)
INSERT [dbo].[Warehouse] ([PurchaseID], [ProductID], [Purchase_date], [Price_purchase], [Count_products]) VALUES (8, 3, CAST(N'2024-04-10T15:00:00.000' AS DateTime), 80.0000, 80)
INSERT [dbo].[Warehouse] ([PurchaseID], [ProductID], [Purchase_date], [Price_purchase], [Count_products]) VALUES (10, 4, CAST(N'2024-04-10T15:00:00.000' AS DateTime), 120.0000, 20)
INSERT [dbo].[Warehouse] ([PurchaseID], [ProductID], [Purchase_date], [Price_purchase], [Count_products]) VALUES (3, 6, CAST(N'2024-04-09T15:00:00.000' AS DateTime), 130.0000, 20)
INSERT [dbo].[Warehouse] ([PurchaseID], [ProductID], [Purchase_date], [Price_purchase], [Count_products]) VALUES (4, 6, CAST(N'2024-04-10T15:00:00.000' AS DateTime), 130.0000, 30)
INSERT [dbo].[Warehouse] ([PurchaseID], [ProductID], [Purchase_date], [Price_purchase], [Count_products]) VALUES (1, 7, CAST(N'2024-04-10T15:00:00.000' AS DateTime), 80.0000, 200)
INSERT [dbo].[Warehouse] ([PurchaseID], [ProductID], [Purchase_date], [Price_purchase], [Count_products]) VALUES (6, 7, CAST(N'2024-04-09T15:00:00.000' AS DateTime), 90.0000, 200)
INSERT [dbo].[Warehouse] ([PurchaseID], [ProductID], [Purchase_date], [Price_purchase], [Count_products]) VALUES (1, 8, CAST(N'2024-04-10T15:00:00.000' AS DateTime), 50.0000, 100)
INSERT [dbo].[Warehouse] ([PurchaseID], [ProductID], [Purchase_date], [Price_purchase], [Count_products]) VALUES (9, 9, CAST(N'2024-04-08T15:00:00.000' AS DateTime), 70.0000, 70)
INSERT [dbo].[Warehouse] ([PurchaseID], [ProductID], [Purchase_date], [Price_purchase], [Count_products]) VALUES (5, 10, CAST(N'2024-04-10T15:00:00.000' AS DateTime), 50.0000, 20)
INSERT [dbo].[Warehouse] ([PurchaseID], [ProductID], [Purchase_date], [Price_purchase], [Count_products]) VALUES (7, 10, CAST(N'2024-04-09T15:00:00.000' AS DateTime), 60.0000, 50)
GO
INSERT [dbo].[Warehouse_Sale] ([SaleID], [PurchaseID], [ProductID], [Sale_price], [Count_products]) VALUES (1, 1, 7, 80.0000, 200)
INSERT [dbo].[Warehouse_Sale] ([SaleID], [PurchaseID], [ProductID], [Sale_price], [Count_products]) VALUES (1, 1, 8, 50.0000, 100)
INSERT [dbo].[Warehouse_Sale] ([SaleID], [PurchaseID], [ProductID], [Sale_price], [Count_products]) VALUES (2, 2, 1, 100.0000, 10000)
INSERT [dbo].[Warehouse_Sale] ([SaleID], [PurchaseID], [ProductID], [Sale_price], [Count_products]) VALUES (2, 2, 2, 120.0000, 20000)
INSERT [dbo].[Warehouse_Sale] ([SaleID], [PurchaseID], [ProductID], [Sale_price], [Count_products]) VALUES (3, 3, 6, 130.0000, 20)
INSERT [dbo].[Warehouse_Sale] ([SaleID], [PurchaseID], [ProductID], [Sale_price], [Count_products]) VALUES (4, 4, 6, 130.0000, 30)
INSERT [dbo].[Warehouse_Sale] ([SaleID], [PurchaseID], [ProductID], [Sale_price], [Count_products]) VALUES (5, 5, 10, 50.0000, 20)
INSERT [dbo].[Warehouse_Sale] ([SaleID], [PurchaseID], [ProductID], [Sale_price], [Count_products]) VALUES (6, 6, 7, 90.0000, 200)
INSERT [dbo].[Warehouse_Sale] ([SaleID], [PurchaseID], [ProductID], [Sale_price], [Count_products]) VALUES (7, 7, 10, 60.0000, 50)
INSERT [dbo].[Warehouse_Sale] ([SaleID], [PurchaseID], [ProductID], [Sale_price], [Count_products]) VALUES (8, 8, 3, 80.0000, 80)
INSERT [dbo].[Warehouse_Sale] ([SaleID], [PurchaseID], [ProductID], [Sale_price], [Count_products]) VALUES (9, 9, 9, 70.0000, 70)
INSERT [dbo].[Warehouse_Sale] ([SaleID], [PurchaseID], [ProductID], [Sale_price], [Count_products]) VALUES (10, 10, 4, 120.0000, 20)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Buyer_Buyer_ITN]    Script Date: 11.04.2024 10:15:59 ******/
ALTER TABLE [dbo].[Buyer] ADD  CONSTRAINT [IX_Buyer_Buyer_ITN] UNIQUE NONCLUSTERED 
(
	[BuyerITN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Buyer_TowdID]    Script Date: 11.04.2024 10:15:59 ******/
CREATE NONCLUSTERED INDEX [IX_Buyer_TowdID] ON [dbo].[Buyer]
(
	[TownID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Category_Name]    Script Date: 11.04.2024 10:15:59 ******/
ALTER TABLE [dbo].[Category] ADD  CONSTRAINT [IX_Category_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Country_Name]    Script Date: 11.04.2024 10:15:59 ******/
ALTER TABLE [dbo].[Country] ADD  CONSTRAINT [IX_Country_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [XAK1Payment_type_Name]    Script Date: 11.04.2024 10:15:59 ******/
ALTER TABLE [dbo].[Payment_type] ADD  CONSTRAINT [XAK1Payment_type_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Product_Name]    Script Date: 11.04.2024 10:15:59 ******/
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [IX_Product_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_SubcategoryID]    Script Date: 11.04.2024 10:15:59 ******/
CREATE NONCLUSTERED INDEX [IX_Product_SubcategoryID] ON [dbo].[Product]
(
	[SubcategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_Purchase_Purchase_date_PurchaseID_ProductID]    Script Date: 11.04.2024 10:15:59 ******/
ALTER TABLE [dbo].[Product_Purchase] ADD  CONSTRAINT [IX_Product_Purchase_Purchase_date_PurchaseID_ProductID] UNIQUE NONCLUSTERED 
(
	[Purchase_date] ASC,
	[PurchaseID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_Purchase_ProductID]    Script Date: 11.04.2024 10:15:59 ******/
CREATE NONCLUSTERED INDEX [IX_Product_Purchase_ProductID] ON [dbo].[Product_Purchase]
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_Purchase_PurchaseID]    Script Date: 11.04.2024 10:15:59 ******/
CREATE NONCLUSTERED INDEX [IX_Product_Purchase_PurchaseID] ON [dbo].[Product_Purchase]
(
	[PurchaseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Purchase_SippliersID_Purchase_date]    Script Date: 11.04.2024 10:15:59 ******/
ALTER TABLE [dbo].[Purchase] ADD  CONSTRAINT [IX_Purchase_SippliersID_Purchase_date] UNIQUE NONCLUSTERED 
(
	[SuppliersID] ASC,
	[Purchase_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Purchase_SuppliersID]    Script Date: 11.04.2024 10:15:59 ******/
CREATE NONCLUSTERED INDEX [IX_Purchase_SuppliersID] ON [dbo].[Purchase]
(
	[SuppliersID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Purchase_TypeID]    Script Date: 11.04.2024 10:15:59 ******/
CREATE NONCLUSTERED INDEX [IX_Purchase_TypeID] ON [dbo].[Purchase]
(
	[TypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Sale_BuyerID_Sale_date]    Script Date: 11.04.2024 10:15:59 ******/
ALTER TABLE [dbo].[Sale] ADD  CONSTRAINT [IX_Sale_BuyerID_Sale_date] UNIQUE NONCLUSTERED 
(
	[BuyerID] ASC,
	[Sale_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Sale_BuyerID]    Script Date: 11.04.2024 10:15:59 ******/
CREATE NONCLUSTERED INDEX [IX_Sale_BuyerID] ON [dbo].[Sale]
(
	[BuyerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Sale_TypeID]    Script Date: 11.04.2024 10:15:59 ******/
CREATE NONCLUSTERED INDEX [IX_Sale_TypeID] ON [dbo].[Sale]
(
	[TypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Subcategory_Name]    Script Date: 11.04.2024 10:15:59 ******/
ALTER TABLE [dbo].[Subcategory] ADD  CONSTRAINT [IX_Subcategory_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Subcategory_CategotyID]    Script Date: 11.04.2024 10:15:59 ******/
CREATE NONCLUSTERED INDEX [IX_Subcategory_CategotyID] ON [dbo].[Subcategory]
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Subject_Name]    Script Date: 11.04.2024 10:15:59 ******/
ALTER TABLE [dbo].[Subject] ADD  CONSTRAINT [IX_Subject_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Subject_CountryID]    Script Date: 11.04.2024 10:15:59 ******/
CREATE NONCLUSTERED INDEX [IX_Subject_CountryID] ON [dbo].[Subject]
(
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Suppliers_Suppliers_ITN]    Script Date: 11.04.2024 10:15:59 ******/
ALTER TABLE [dbo].[Suppliers] ADD  CONSTRAINT [IX_Suppliers_Suppliers_ITN] UNIQUE NONCLUSTERED 
(
	[SuppliersITN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Suppliers_TownID]    Script Date: 11.04.2024 10:15:59 ******/
CREATE NONCLUSTERED INDEX [IX_Suppliers_TownID] ON [dbo].[Suppliers]
(
	[TownID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Town_Name]    Script Date: 11.04.2024 10:15:59 ******/
ALTER TABLE [dbo].[Town] ADD  CONSTRAINT [IX_Town_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Town_SubjectID]    Script Date: 11.04.2024 10:15:59 ******/
CREATE NONCLUSTERED INDEX [IX_Town_SubjectID] ON [dbo].[Town]
(
	[SubjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Warehouse_Sale_ProductID_PurchaseID]    Script Date: 11.04.2024 10:15:59 ******/
CREATE NONCLUSTERED INDEX [IX_Warehouse_Sale_ProductID_PurchaseID] ON [dbo].[Warehouse_Sale]
(
	[ProductID] ASC,
	[PurchaseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Warehouse_Sale_SaleID]    Script Date: 11.04.2024 10:15:59 ******/
CREATE NONCLUSTERED INDEX [IX_Warehouse_Sale_SaleID] ON [dbo].[Warehouse_Sale]
(
	[SaleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Purchase] ADD  CONSTRAINT [DF_Del_SuppliersID]  DEFAULT ((0)) FOR [SuppliersID]
GO
ALTER TABLE [dbo].[Sale] ADD  CONSTRAINT [DF_Del_BuyerID]  DEFAULT ((0)) FOR [BuyerID]
GO
ALTER TABLE [dbo].[Buyer]  WITH CHECK ADD  CONSTRAINT [FK_TownID] FOREIGN KEY([TownID])
REFERENCES [dbo].[Town] ([TownID])
GO
ALTER TABLE [dbo].[Buyer] CHECK CONSTRAINT [FK_TownID]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_SubcategoryID] FOREIGN KEY([SubcategoryID])
REFERENCES [dbo].[Subcategory] ([SubcategoryID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_SubcategoryID]
GO
ALTER TABLE [dbo].[Product_Purchase]  WITH CHECK ADD  CONSTRAINT [PK_ProductID] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Product_Purchase] CHECK CONSTRAINT [PK_ProductID]
GO
ALTER TABLE [dbo].[Product_Purchase]  WITH CHECK ADD  CONSTRAINT [PK_PrushaseID] FOREIGN KEY([PurchaseID])
REFERENCES [dbo].[Purchase] ([PurchaseID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product_Purchase] CHECK CONSTRAINT [PK_PrushaseID]
GO
ALTER TABLE [dbo].[Purchase]  WITH CHECK ADD  CONSTRAINT [FK_SuppliersID] FOREIGN KEY([SuppliersID])
REFERENCES [dbo].[Suppliers] ([SuppliersID])
ON DELETE SET DEFAULT
GO
ALTER TABLE [dbo].[Purchase] CHECK CONSTRAINT [FK_SuppliersID]
GO
ALTER TABLE [dbo].[Purchase]  WITH CHECK ADD  CONSTRAINT [FK_TypeID_Purchase] FOREIGN KEY([TypeID])
REFERENCES [dbo].[Payment_type] ([TypeID])
GO
ALTER TABLE [dbo].[Purchase] CHECK CONSTRAINT [FK_TypeID_Purchase]
GO
ALTER TABLE [dbo].[Sale]  WITH CHECK ADD  CONSTRAINT [FK_BuyerID] FOREIGN KEY([BuyerID])
REFERENCES [dbo].[Buyer] ([BuyerID])
ON DELETE SET DEFAULT
GO
ALTER TABLE [dbo].[Sale] CHECK CONSTRAINT [FK_BuyerID]
GO
ALTER TABLE [dbo].[Sale]  WITH CHECK ADD  CONSTRAINT [FK_TypeID_2] FOREIGN KEY([TypeID])
REFERENCES [dbo].[Payment_type] ([TypeID])
GO
ALTER TABLE [dbo].[Sale] CHECK CONSTRAINT [FK_TypeID_2]
GO
ALTER TABLE [dbo].[Subcategory]  WITH CHECK ADD  CONSTRAINT [FK_CategoryID] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[Subcategory] CHECK CONSTRAINT [FK_CategoryID]
GO
ALTER TABLE [dbo].[Subject]  WITH CHECK ADD  CONSTRAINT [FK_CountryID] FOREIGN KEY([CountryID])
REFERENCES [dbo].[Country] ([CountryID])
GO
ALTER TABLE [dbo].[Subject] CHECK CONSTRAINT [FK_CountryID]
GO
ALTER TABLE [dbo].[Suppliers]  WITH CHECK ADD  CONSTRAINT [FK_TownID_1] FOREIGN KEY([TownID])
REFERENCES [dbo].[Town] ([TownID])
GO
ALTER TABLE [dbo].[Suppliers] CHECK CONSTRAINT [FK_TownID_1]
GO
ALTER TABLE [dbo].[Town]  WITH CHECK ADD  CONSTRAINT [FK_SubjectID] FOREIGN KEY([SubjectID])
REFERENCES [dbo].[Subject] ([SubjectID])
GO
ALTER TABLE [dbo].[Town] CHECK CONSTRAINT [FK_SubjectID]
GO
ALTER TABLE [dbo].[Warehouse]  WITH CHECK ADD  CONSTRAINT [Go_To_Warehouse] FOREIGN KEY([ProductID], [PurchaseID])
REFERENCES [dbo].[Product_Purchase] ([ProductID], [PurchaseID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Warehouse] CHECK CONSTRAINT [Go_To_Warehouse]
GO
ALTER TABLE [dbo].[Warehouse_Sale]  WITH CHECK ADD  CONSTRAINT [PK_ProductID_PurchaseID] FOREIGN KEY([ProductID], [PurchaseID])
REFERENCES [dbo].[Warehouse] ([ProductID], [PurchaseID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Warehouse_Sale] CHECK CONSTRAINT [PK_ProductID_PurchaseID]
GO
ALTER TABLE [dbo].[Warehouse_Sale]  WITH CHECK ADD  CONSTRAINT [PK_SaleID] FOREIGN KEY([SaleID])
REFERENCES [dbo].[Sale] ([SaleID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Warehouse_Sale] CHECK CONSTRAINT [PK_SaleID]
GO
ALTER TABLE [dbo].[Purchase]  WITH CHECK ADD  CONSTRAINT [Valid_Zero_Price_total_purchase] CHECK  (([Price_total]>=(0)))
GO
ALTER TABLE [dbo].[Purchase] CHECK CONSTRAINT [Valid_Zero_Price_total_purchase]
GO
ALTER TABLE [dbo].[Sale]  WITH CHECK ADD  CONSTRAINT [Valid_Zero_Price_total_sale] CHECK  (([Price_total]>=(0)))
GO
ALTER TABLE [dbo].[Sale] CHECK CONSTRAINT [Valid_Zero_Price_total_sale]
GO
ALTER TABLE [dbo].[Warehouse]  WITH CHECK ADD  CONSTRAINT [Valid_Zero_Count_product_warehouse] CHECK  (([Count_products]>=(0)))
GO
ALTER TABLE [dbo].[Warehouse] CHECK CONSTRAINT [Valid_Zero_Count_product_warehouse]
GO
ALTER TABLE [dbo].[Warehouse]  WITH CHECK ADD  CONSTRAINT [Valid_Zero_Price_purchase_warehouse] CHECK  (([Price_purchase]>=(0)))
GO
ALTER TABLE [dbo].[Warehouse] CHECK CONSTRAINT [Valid_Zero_Price_purchase_warehouse]
GO
USE [master]
GO
ALTER DATABASE [Warehouse] SET  READ_WRITE 
GO
