USE [master]
GO
/****** Object:  Database [Hotel]    Script Date: 26.06.2024 13:28:54 ******/
CREATE DATABASE [Hotel]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Hotel', FILENAME = N'C:\SQLDATA\Hotel.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Hotel_log', FILENAME = N'C:\SQLDATA\Hotel_log.ldf' , SIZE = 8192KB , MAXSIZE = 1024000KB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Hotel] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Hotel].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Hotel] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Hotel] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Hotel] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Hotel] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Hotel] SET ARITHABORT OFF 
GO
ALTER DATABASE [Hotel] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Hotel] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Hotel] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Hotel] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Hotel] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Hotel] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Hotel] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Hotel] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Hotel] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Hotel] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Hotel] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Hotel] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Hotel] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Hotel] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Hotel] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Hotel] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Hotel] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Hotel] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Hotel] SET  MULTI_USER 
GO
ALTER DATABASE [Hotel] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Hotel] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Hotel] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Hotel] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Hotel] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Hotel] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Hotel] SET QUERY_STORE = OFF
GO
/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [student]    Script Date: 26.06.2024 13:28:54 ******/
CREATE LOGIN [student] WITH PASSWORD=N'j0zCsZ0+8gGUNM2RCVQjDysiYqFLHgJiWw0ZtKxGmOo=', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[русский], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
ALTER LOGIN [student] DISABLE
GO
/****** Object:  Login [NT SERVICE\Winmgmt]    Script Date: 26.06.2024 13:28:54 ******/
CREATE LOGIN [NT SERVICE\Winmgmt] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[русский]
GO
/****** Object:  Login [NT SERVICE\SQLWriter]    Script Date: 26.06.2024 13:28:54 ******/
CREATE LOGIN [NT SERVICE\SQLWriter] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[русский]
GO
/****** Object:  Login [NT SERVICE\SQLTELEMETRY$SQLEXPRESS]    Script Date: 26.06.2024 13:28:54 ******/
CREATE LOGIN [NT SERVICE\SQLTELEMETRY$SQLEXPRESS] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[русский]
GO
/****** Object:  Login [NT Service\MSSQL$SQLEXPRESS]    Script Date: 26.06.2024 13:28:54 ******/
CREATE LOGIN [NT Service\MSSQL$SQLEXPRESS] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[русский]
GO
/****** Object:  Login [NT AUTHORITY\СИСТЕМА]    Script Date: 26.06.2024 13:28:54 ******/
CREATE LOGIN [NT AUTHORITY\СИСТЕМА] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[русский]
GO
/****** Object:  Login [NEKR44-211-20\nekr44-211-25]    Script Date: 26.06.2024 13:28:54 ******/
CREATE LOGIN [NEKR44-211-20\nekr44-211-25] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[русский]
GO
/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [hoteluser]    Script Date: 26.06.2024 13:28:54 ******/
CREATE LOGIN [hoteluser] WITH PASSWORD=N'HZtCVItE6paXIrWtwzCadJK5a2QtPx7JCDPG2kQbaVY=', DEFAULT_DATABASE=[Hotel], DEFAULT_LANGUAGE=[русский], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
ALTER LOGIN [hoteluser] DISABLE
GO
/****** Object:  Login [BUILTIN\Пользователи]    Script Date: 26.06.2024 13:28:54 ******/
CREATE LOGIN [BUILTIN\Пользователи] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[русский]
GO
/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [##MS_PolicyTsqlExecutionLogin##]    Script Date: 26.06.2024 13:28:54 ******/
CREATE LOGIN [##MS_PolicyTsqlExecutionLogin##] WITH PASSWORD=N'nQmlHBlBtDCEYWO4P15zWU2zE2oZBZizLDTUTey1SIw=', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
ALTER LOGIN [##MS_PolicyTsqlExecutionLogin##] DISABLE
GO
/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [##MS_PolicyEventProcessingLogin##]    Script Date: 26.06.2024 13:28:54 ******/
CREATE LOGIN [##MS_PolicyEventProcessingLogin##] WITH PASSWORD=N'7Wpeoik3Saq+EGXI2D53k4BqDNL6h5rVVIZGK1NY1/E=', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
ALTER LOGIN [##MS_PolicyEventProcessingLogin##] DISABLE
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [student]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [NT SERVICE\Winmgmt]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [NT SERVICE\SQLWriter]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [NT Service\MSSQL$SQLEXPRESS]
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [NEKR44-211-20\nekr44-211-25]
GO
USE [Hotel]
GO
/****** Object:  User [hoteluser]    Script Date: 26.06.2024 13:28:54 ******/
CREATE USER [hoteluser] FOR LOGIN [hoteluser] WITH DEFAULT_SCHEMA=[archive]
GO
ALTER ROLE [db_datareader] ADD MEMBER [hoteluser]
GO
/****** Object:  Schema [archive]    Script Date: 26.06.2024 13:28:54 ******/
CREATE SCHEMA [archive]
GO
/****** Object:  Table [dbo].[Accomodation]    Script Date: 26.06.2024 13:28:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accomodation](
	[IDAccomodation] [int] IDENTITY(1,1) NOT NULL,
	[IDClient] [int] NOT NULL,
	[IDReserved] [int] NOT NULL,
	[IDPaymentCard] [int] NOT NULL,
	[PayDate] [date] NULL,
 CONSTRAINT [PK_Accomodation] PRIMARY KEY CLUSTERED 
(
	[IDAccomodation] ASC,
	[IDClient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clients]    Script Date: 26.06.2024 13:28:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clients](
	[IDClient] [int] IDENTITY(1,1) NOT NULL,
	[Surname] [varchar](30) NOT NULL,
	[Name] [varchar](30) NOT NULL,
	[Patronymic] [varchar](30) NOT NULL,
	[Document] [varchar](25) NOT NULL,
	[DocumentSeriesAndNumber] [varchar](40) NOT NULL,
	[Birthday] [date] NOT NULL,
	[Gender] [varchar](3) NOT NULL,
	[HomeAddress] [varchar](50) NULL,
	[PhoneNumber] [varchar](11) NOT NULL,
 CONSTRAINT [PK_Clients_IDClient] PRIMARY KEY CLUSTERED 
(
	[IDClient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Numbers]    Script Date: 26.06.2024 13:28:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Numbers](
	[IDNumber] [smallint] IDENTITY(1,1) NOT NULL,
	[Cost] [money] NOT NULL,
	[Floor] [smallint] NOT NULL,
	[PhoneNumber] [varchar](11) NOT NULL,
	[NumberName] [varchar](10) NOT NULL,
	[IsLux] [bit] NULL,
	[NumberOfRooms] [tinyint] NULL,
	[NumberOfPlaces] [tinyint] NULL,
	[NumberOfFreePlaces] [tinyint] NULL,
	[IsBusy] [bit] NULL,
	[Description] [varchar](1000) NULL,
 CONSTRAINT [PK_Numbers_IDNumber] PRIMARY KEY CLUSTERED 
(
	[IDNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentCard]    Script Date: 26.06.2024 13:28:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentCard](
	[IDPaymentCard] [int] IDENTITY(1,1) NOT NULL,
	[ArrivalDate] [datetime] NOT NULL,
	[DepartureDate] [datetime] NOT NULL,
	[Payment] [money] NOT NULL,
 CONSTRAINT [PK_PaymentCard] PRIMARY KEY CLUSTERED 
(
	[IDPaymentCard] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reservation]    Script Date: 26.06.2024 13:28:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservation](
	[IDReserved] [int] IDENTITY(1,1) NOT NULL,
	[IDClient] [int] NOT NULL,
	[EstimatedArrivalDate] [date] NOT NULL,
	[NumberDays] [tinyint] NOT NULL,
	[EstimatedDepartureDate] [datetime] NULL,
	[IsExist] [bit] NULL,
	[IsPaid] [bit] NULL,
	[Cost] [money] NULL,
	[TypeNumber] [nvarchar](11) NULL,
 CONSTRAINT [PK_Reservation] PRIMARY KEY CLUSTERED 
(
	[IDReserved] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reservation_Number]    Script Date: 26.06.2024 13:28:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservation_Number](
	[IDNumber] [smallint] NOT NULL,
	[IDClient] [int] NOT NULL,
	[ArrivalDate] [datetime] NOT NULL,
	[IDReserved] [int] NULL,
	[NumberDay] [tinyint] NOT NULL,
	[NumberPeople] [tinyint] NOT NULL,
 CONSTRAINT [PK_Reservation_Number] PRIMARY KEY CLUSTERED 
(
	[IDNumber] ASC,
	[IDClient] ASC,
	[ArrivalDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_TotalDeptors]    Script Date: 26.06.2024 13:28:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[View_TotalDeptors]
as
select
	Clients.IDClient,
	Clients.Surname + ' ' + Clients.Name + ' ' + Clients.Patronymic as 'ФИО',
	Sum (Numbers.Cost * [dbo].[Reservation_Number].NumberDay) as Cost,
	Sum(PaymentCard.Payment) as Payment
from [dbo].[Clients] left join [dbo].[Reservation_Number] on [dbo].[Clients].IDClient = [dbo].[Reservation_Number].IDClient
left join [dbo].[Reservation] on [dbo].[Clients].IDClient = [dbo].[Reservation].IDClient and [dbo].[Reservation].IDReserved = [dbo].[Reservation_Number].IDReserved
join [dbo].[Accomodation] on [dbo].[Accomodation].IDClient = [dbo].[Reservation].IDClient and [dbo].[Accomodation].IDReserved = [dbo].[Reservation].IDReserved
join [dbo].[PaymentCard] on [dbo].[Accomodation].[IDPaymentCard] = [dbo].[PaymentCard].[IDPaymentCard]
join [dbo].[Numbers] on [dbo].[Reservation_Number].IDNumber = [dbo].[Numbers].IDNumber
where [dbo].[Accomodation].PayDate = NULL
group by
Clients.IDClient,
Clients.Surname + ' ' + Clients.Name + ' ' + Clients.Patronymic
GO
/****** Object:  Table [dbo].[Reservation_Archive]    Script Date: 26.06.2024 13:28:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservation_Archive](
	[IDReserved] [int] NOT NULL,
	[IDClient] [int] NOT NULL,
	[EstimatedArrivalDate] [date] NOT NULL,
	[NumberDays] [tinyint] NOT NULL,
	[EstimatedDepartureDate] [datetime] NULL,
	[IsExist] [bit] NULL,
	[IsPaid] [bit] NULL,
	[Cost] [money] NULL,
	[TypeNumber] [nvarchar](11) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Review]    Script Date: 26.06.2024 13:28:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Review](
	[IDReview] [int] IDENTITY(1,1) NOT NULL,
	[IDClient] [int] NOT NULL,
	[Score] [varchar](1) NOT NULL,
	[Description] [varchar](500) NULL,
 CONSTRAINT [PK_Review] PRIMARY KEY CLUSTERED 
(
	[IDReview] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Accomodation] ON 

INSERT [dbo].[Accomodation] ([IDAccomodation], [IDClient], [IDReserved], [IDPaymentCard], [PayDate]) VALUES (5, 18, 2, 2, NULL)
INSERT [dbo].[Accomodation] ([IDAccomodation], [IDClient], [IDReserved], [IDPaymentCard], [PayDate]) VALUES (6, 5, 4, 4, CAST(N'2021-05-05' AS Date))
INSERT [dbo].[Accomodation] ([IDAccomodation], [IDClient], [IDReserved], [IDPaymentCard], [PayDate]) VALUES (9, 18, 5, 2, NULL)
INSERT [dbo].[Accomodation] ([IDAccomodation], [IDClient], [IDReserved], [IDPaymentCard], [PayDate]) VALUES (12, 1, 13, 14, CAST(N'2021-05-05' AS Date))
INSERT [dbo].[Accomodation] ([IDAccomodation], [IDClient], [IDReserved], [IDPaymentCard], [PayDate]) VALUES (16, 18, 8, 12, NULL)
INSERT [dbo].[Accomodation] ([IDAccomodation], [IDClient], [IDReserved], [IDPaymentCard], [PayDate]) VALUES (18, 3, 15, 11, CAST(N'2021-05-05' AS Date))
INSERT [dbo].[Accomodation] ([IDAccomodation], [IDClient], [IDReserved], [IDPaymentCard], [PayDate]) VALUES (19, 5, 2, 3, CAST(N'2021-05-05' AS Date))
INSERT [dbo].[Accomodation] ([IDAccomodation], [IDClient], [IDReserved], [IDPaymentCard], [PayDate]) VALUES (20, 18, 2, 12, CAST(N'2021-05-05' AS Date))
INSERT [dbo].[Accomodation] ([IDAccomodation], [IDClient], [IDReserved], [IDPaymentCard], [PayDate]) VALUES (21, 32, 4, 4, NULL)
INSERT [dbo].[Accomodation] ([IDAccomodation], [IDClient], [IDReserved], [IDPaymentCard], [PayDate]) VALUES (22, 34, 8, 3, NULL)
SET IDENTITY_INSERT [dbo].[Accomodation] OFF
GO
SET IDENTITY_INSERT [dbo].[Clients] ON 

INSERT [dbo].[Clients] ([IDClient], [Surname], [Name], [Patronymic], [Document], [DocumentSeriesAndNumber], [Birthday], [Gender], [HomeAddress], [PhoneNumber]) VALUES (1, N'Гордеева', N'Инна', N'Алексеевна', N'Passport', N'ffff', CAST(N'2000-12-04' AS Date), N'Ж', N'авпв', N'89323323612')
INSERT [dbo].[Clients] ([IDClient], [Surname], [Name], [Patronymic], [Document], [DocumentSeriesAndNumber], [Birthday], [Gender], [HomeAddress], [PhoneNumber]) VALUES (3, N'Гордеева', N'Валерия', N'Алексеевна', N'Passport', N'аffff', CAST(N'2000-12-04' AS Date), N'Ж', N'авпв', N'89323323612')
INSERT [dbo].[Clients] ([IDClient], [Surname], [Name], [Patronymic], [Document], [DocumentSeriesAndNumber], [Birthday], [Gender], [HomeAddress], [PhoneNumber]) VALUES (5, N'Гордеева', N'Инна', N'Алексеевна', N'Passport', N'fggbfffff', CAST(N'2000-12-04' AS Date), N'Ж', N'авпв', N'89323323612')
INSERT [dbo].[Clients] ([IDClient], [Surname], [Name], [Patronymic], [Document], [DocumentSeriesAndNumber], [Birthday], [Gender], [HomeAddress], [PhoneNumber]) VALUES (18, N'Попова', N'Валерия', N'Дмитриевна', N'Passport', N'rfee', CAST(N'2000-12-04' AS Date), N'М', NULL, N'8999999999')
INSERT [dbo].[Clients] ([IDClient], [Surname], [Name], [Patronymic], [Document], [DocumentSeriesAndNumber], [Birthday], [Gender], [HomeAddress], [PhoneNumber]) VALUES (30, N'Шевченко', N'Алексей', N'Витальевич', N'Passport', N'dgfdf', CAST(N'2000-12-04' AS Date), N'М', N'а', N'9888888888')
INSERT [dbo].[Clients] ([IDClient], [Surname], [Name], [Patronymic], [Document], [DocumentSeriesAndNumber], [Birthday], [Gender], [HomeAddress], [PhoneNumber]) VALUES (31, N'Матвеев', N'Александр', N'Александрович', N'Passport', N'dfd', CAST(N'2000-12-04' AS Date), N'М', NULL, N'9876543234')
INSERT [dbo].[Clients] ([IDClient], [Surname], [Name], [Patronymic], [Document], [DocumentSeriesAndNumber], [Birthday], [Gender], [HomeAddress], [PhoneNumber]) VALUES (32, N'Согуренко', N'Софья', N'Александровна', N'Passport', N'1', CAST(N'2000-12-04' AS Date), N'Ж', NULL, N'8765432')
INSERT [dbo].[Clients] ([IDClient], [Surname], [Name], [Patronymic], [Document], [DocumentSeriesAndNumber], [Birthday], [Gender], [HomeAddress], [PhoneNumber]) VALUES (34, N'Низаметдинов', N'Шерзодбек', N'Шавкаджонович', N'Passport', N'2', CAST(N'2000-12-04' AS Date), N'М', NULL, N'23456765')
INSERT [dbo].[Clients] ([IDClient], [Surname], [Name], [Patronymic], [Document], [DocumentSeriesAndNumber], [Birthday], [Gender], [HomeAddress], [PhoneNumber]) VALUES (35, N'Попович', N'Валерия', N'Дмитриевна', N'Passport', N'3', CAST(N'2020-04-04' AS Date), N'Ж', NULL, N'0987654432')
INSERT [dbo].[Clients] ([IDClient], [Surname], [Name], [Patronymic], [Document], [DocumentSeriesAndNumber], [Birthday], [Gender], [HomeAddress], [PhoneNumber]) VALUES (37, N'Олегов', N'Олегов', N'Олегович', N'Passport', N'4', CAST(N'2020-02-05' AS Date), N'М', NULL, N'0987654333')
SET IDENTITY_INSERT [dbo].[Clients] OFF
GO
SET IDENTITY_INSERT [dbo].[Numbers] ON 

INSERT [dbo].[Numbers] ([IDNumber], [Cost], [Floor], [PhoneNumber], [NumberName], [IsLux], [NumberOfRooms], [NumberOfPlaces], [NumberOfFreePlaces], [IsBusy], [Description]) VALUES (1, 1000.0000, 1, N'8999999', N'Ф1', NULL, 1, 2, 0, 1, NULL)
INSERT [dbo].[Numbers] ([IDNumber], [Cost], [Floor], [PhoneNumber], [NumberName], [IsLux], [NumberOfRooms], [NumberOfPlaces], [NumberOfFreePlaces], [IsBusy], [Description]) VALUES (2, 2000.0000, 2, N'89999999', N'Л1', 1, 2, 1, 0, 0, N'Люкс с видом во двор')
INSERT [dbo].[Numbers] ([IDNumber], [Cost], [Floor], [PhoneNumber], [NumberName], [IsLux], [NumberOfRooms], [NumberOfPlaces], [NumberOfFreePlaces], [IsBusy], [Description]) VALUES (3, 3000.0000, 3, N'98765432', N'Л3', 1, 2, 2, 2, 1, N'Люкс с видом на море')
INSERT [dbo].[Numbers] ([IDNumber], [Cost], [Floor], [PhoneNumber], [NumberName], [IsLux], [NumberOfRooms], [NumberOfPlaces], [NumberOfFreePlaces], [IsBusy], [Description]) VALUES (4, 5000.0000, 3, N'876543456', N'Л2', 1, 3, 2, 2, 1, N'Супер люкс')
INSERT [dbo].[Numbers] ([IDNumber], [Cost], [Floor], [PhoneNumber], [NumberName], [IsLux], [NumberOfRooms], [NumberOfPlaces], [NumberOfFreePlaces], [IsBusy], [Description]) VALUES (5, 1500.0000, 1, N'987654334', N'Ф2', NULL, 1, 1, 0, 1, N'Стандарт')
INSERT [dbo].[Numbers] ([IDNumber], [Cost], [Floor], [PhoneNumber], [NumberName], [IsLux], [NumberOfRooms], [NumberOfPlaces], [NumberOfFreePlaces], [IsBusy], [Description]) VALUES (6, 1300.0000, 2, N'987654325', N'Ф2', NULL, 1, 1, 0, 1, N'Стандарт')
INSERT [dbo].[Numbers] ([IDNumber], [Cost], [Floor], [PhoneNumber], [NumberName], [IsLux], [NumberOfRooms], [NumberOfPlaces], [NumberOfFreePlaces], [IsBusy], [Description]) VALUES (7, 2000.0000, 2, N'9876543345', N'Л4', 1, 2, 1, 0, 0, N'Люкс одноместный')
INSERT [dbo].[Numbers] ([IDNumber], [Cost], [Floor], [PhoneNumber], [NumberName], [IsLux], [NumberOfRooms], [NumberOfPlaces], [NumberOfFreePlaces], [IsBusy], [Description]) VALUES (8, 4500.0000, 3, N'9876543455', N'Л5', 1, 3, 3, 1, 0, N'Супер люкс')
INSERT [dbo].[Numbers] ([IDNumber], [Cost], [Floor], [PhoneNumber], [NumberName], [IsLux], [NumberOfRooms], [NumberOfPlaces], [NumberOfFreePlaces], [IsBusy], [Description]) VALUES (9, 4000.0000, 4, N'9876544543', N'Ф3', NULL, 1, 2, 0, 0, N'Стандарт двухместный')
INSERT [dbo].[Numbers] ([IDNumber], [Cost], [Floor], [PhoneNumber], [NumberName], [IsLux], [NumberOfRooms], [NumberOfPlaces], [NumberOfFreePlaces], [IsBusy], [Description]) VALUES (10, 3500.0000, 6, N'8546368383', N'С1', NULL, 2, 2, 1, 0, NULL)
SET IDENTITY_INSERT [dbo].[Numbers] OFF
GO
SET IDENTITY_INSERT [dbo].[PaymentCard] ON 

INSERT [dbo].[PaymentCard] ([IDPaymentCard], [ArrivalDate], [DepartureDate], [Payment]) VALUES (2, CAST(N'2021-05-05T00:00:00.000' AS DateTime), CAST(N'2021-05-10T00:00:00.000' AS DateTime), 10000.0000)
INSERT [dbo].[PaymentCard] ([IDPaymentCard], [ArrivalDate], [DepartureDate], [Payment]) VALUES (3, CAST(N'2021-05-05T00:00:00.000' AS DateTime), CAST(N'2021-05-05T00:00:00.000' AS DateTime), 1000.0000)
INSERT [dbo].[PaymentCard] ([IDPaymentCard], [ArrivalDate], [DepartureDate], [Payment]) VALUES (4, CAST(N'2021-05-05T00:00:00.000' AS DateTime), CAST(N'2021-05-05T00:00:00.000' AS DateTime), 3000.0000)
INSERT [dbo].[PaymentCard] ([IDPaymentCard], [ArrivalDate], [DepartureDate], [Payment]) VALUES (6, CAST(N'2021-05-05T00:00:00.000' AS DateTime), CAST(N'2021-05-05T00:00:00.000' AS DateTime), 2500.0000)
INSERT [dbo].[PaymentCard] ([IDPaymentCard], [ArrivalDate], [DepartureDate], [Payment]) VALUES (7, CAST(N'2021-05-05T00:00:00.000' AS DateTime), CAST(N'2021-05-05T00:00:00.000' AS DateTime), 1000.0000)
INSERT [dbo].[PaymentCard] ([IDPaymentCard], [ArrivalDate], [DepartureDate], [Payment]) VALUES (9, CAST(N'2021-05-05T00:00:00.000' AS DateTime), CAST(N'2021-05-05T00:00:00.000' AS DateTime), 2000.0000)
INSERT [dbo].[PaymentCard] ([IDPaymentCard], [ArrivalDate], [DepartureDate], [Payment]) VALUES (10, CAST(N'2021-05-05T00:00:00.000' AS DateTime), CAST(N'2021-05-05T00:00:00.000' AS DateTime), 3000.0000)
INSERT [dbo].[PaymentCard] ([IDPaymentCard], [ArrivalDate], [DepartureDate], [Payment]) VALUES (11, CAST(N'2021-05-05T00:00:00.000' AS DateTime), CAST(N'2021-05-05T00:00:00.000' AS DateTime), 1000.0000)
INSERT [dbo].[PaymentCard] ([IDPaymentCard], [ArrivalDate], [DepartureDate], [Payment]) VALUES (12, CAST(N'2021-05-05T00:00:00.000' AS DateTime), CAST(N'2021-05-05T00:00:00.000' AS DateTime), 4000.0000)
INSERT [dbo].[PaymentCard] ([IDPaymentCard], [ArrivalDate], [DepartureDate], [Payment]) VALUES (14, CAST(N'2021-05-05T00:00:00.000' AS DateTime), CAST(N'2021-05-05T00:00:00.000' AS DateTime), 5000.0000)
SET IDENTITY_INSERT [dbo].[PaymentCard] OFF
GO
SET IDENTITY_INSERT [dbo].[Reservation] ON 

INSERT [dbo].[Reservation] ([IDReserved], [IDClient], [EstimatedArrivalDate], [NumberDays], [EstimatedDepartureDate], [IsExist], [IsPaid], [Cost], [TypeNumber]) VALUES (2, 18, CAST(N'2021-05-05' AS Date), 5, CAST(N'2021-10-05T00:00:00.000' AS DateTime), 1, 1, 2000.0000, N'Улучшенный')
INSERT [dbo].[Reservation] ([IDReserved], [IDClient], [EstimatedArrivalDate], [NumberDays], [EstimatedDepartureDate], [IsExist], [IsPaid], [Cost], [TypeNumber]) VALUES (4, 1, CAST(N'2021-05-05' AS Date), 5, CAST(N'2021-05-10T00:00:00.000' AS DateTime), 0, NULL, 2000.0000, N'Улучшенный')
INSERT [dbo].[Reservation] ([IDReserved], [IDClient], [EstimatedArrivalDate], [NumberDays], [EstimatedDepartureDate], [IsExist], [IsPaid], [Cost], [TypeNumber]) VALUES (5, 3, CAST(N'2021-05-05' AS Date), 3, CAST(N'2021-05-05T00:00:00.000' AS DateTime), 1, 1, 3000.0000, N'Люкс')
INSERT [dbo].[Reservation] ([IDReserved], [IDClient], [EstimatedArrivalDate], [NumberDays], [EstimatedDepartureDate], [IsExist], [IsPaid], [Cost], [TypeNumber]) VALUES (8, 18, CAST(N'2021-05-05' AS Date), 18, CAST(N'2021-05-05T00:00:00.000' AS DateTime), 1, 1, 1111.0000, N'Стандартный')
INSERT [dbo].[Reservation] ([IDReserved], [IDClient], [EstimatedArrivalDate], [NumberDays], [EstimatedDepartureDate], [IsExist], [IsPaid], [Cost], [TypeNumber]) VALUES (9, 1, CAST(N'2021-05-05' AS Date), 4, CAST(N'2021-05-05T00:00:00.000' AS DateTime), 1, NULL, 6000.0000, N'Супер люкс')
INSERT [dbo].[Reservation] ([IDReserved], [IDClient], [EstimatedArrivalDate], [NumberDays], [EstimatedDepartureDate], [IsExist], [IsPaid], [Cost], [TypeNumber]) VALUES (12, 32, CAST(N'2021-05-05' AS Date), 3, CAST(N'2021-05-05T00:00:00.000' AS DateTime), 1, 1, 3000.0000, N'Люкс')
INSERT [dbo].[Reservation] ([IDReserved], [IDClient], [EstimatedArrivalDate], [NumberDays], [EstimatedDepartureDate], [IsExist], [IsPaid], [Cost], [TypeNumber]) VALUES (13, 32, CAST(N'2021-05-05' AS Date), 10, CAST(N'2021-05-05T00:00:00.000' AS DateTime), 1, NULL, 2900.0000, N'Улучшенный')
INSERT [dbo].[Reservation] ([IDReserved], [IDClient], [EstimatedArrivalDate], [NumberDays], [EstimatedDepartureDate], [IsExist], [IsPaid], [Cost], [TypeNumber]) VALUES (15, 3, CAST(N'2021-05-05' AS Date), 2, CAST(N'2021-05-05T00:00:00.000' AS DateTime), 1, 1, 2000.0000, N'Улучшенный')
INSERT [dbo].[Reservation] ([IDReserved], [IDClient], [EstimatedArrivalDate], [NumberDays], [EstimatedDepartureDate], [IsExist], [IsPaid], [Cost], [TypeNumber]) VALUES (16, 1, CAST(N'2021-05-05' AS Date), 1, CAST(N'2021-05-05T00:00:00.000' AS DateTime), 1, 1, 1500.0000, N'Стандартный')
INSERT [dbo].[Reservation] ([IDReserved], [IDClient], [EstimatedArrivalDate], [NumberDays], [EstimatedDepartureDate], [IsExist], [IsPaid], [Cost], [TypeNumber]) VALUES (17, 3, CAST(N'2021-05-05' AS Date), 3, CAST(N'2021-05-05T00:00:00.000' AS DateTime), 1, 1, 1500.0000, N'Стандартный')
SET IDENTITY_INSERT [dbo].[Reservation] OFF
GO
INSERT [dbo].[Reservation_Archive] ([IDReserved], [IDClient], [EstimatedArrivalDate], [NumberDays], [EstimatedDepartureDate], [IsExist], [IsPaid], [Cost], [TypeNumber]) VALUES (2, 18, CAST(N'2021-05-05' AS Date), 5, CAST(N'2021-10-05T00:00:00.000' AS DateTime), 1, 1, 2000.0000, N'Улучшенный')
INSERT [dbo].[Reservation_Archive] ([IDReserved], [IDClient], [EstimatedArrivalDate], [NumberDays], [EstimatedDepartureDate], [IsExist], [IsPaid], [Cost], [TypeNumber]) VALUES (5, 3, CAST(N'2021-05-05' AS Date), 3, CAST(N'2021-05-05T00:00:00.000' AS DateTime), 1, 1, 3000.0000, N'Люкс')
GO
INSERT [dbo].[Reservation_Number] ([IDNumber], [IDClient], [ArrivalDate], [IDReserved], [NumberDay], [NumberPeople]) VALUES (1, 1, CAST(N'2021-05-05T00:00:00.000' AS DateTime), 4, 5, 2)
INSERT [dbo].[Reservation_Number] ([IDNumber], [IDClient], [ArrivalDate], [IDReserved], [NumberDay], [NumberPeople]) VALUES (7, 1, CAST(N'2021-05-05T00:00:00.000' AS DateTime), 9, 4, 2)
INSERT [dbo].[Reservation_Number] ([IDNumber], [IDClient], [ArrivalDate], [IDReserved], [NumberDay], [NumberPeople]) VALUES (4, 18, CAST(N'2021-05-05T00:00:00.000' AS DateTime), 2, 5, 2)
INSERT [dbo].[Reservation_Number] ([IDNumber], [IDClient], [ArrivalDate], [IDReserved], [NumberDay], [NumberPeople]) VALUES (1, 32, CAST(N'2022-01-10T12:00:00.000' AS DateTime), 13, 10, 1)
GO
SET IDENTITY_INSERT [dbo].[Review] ON 

INSERT [dbo].[Review] ([IDReview], [IDClient], [Score], [Description]) VALUES (1, 18, N'5', N'Без балкона с окнами во двор')
INSERT [dbo].[Review] ([IDReview], [IDClient], [Score], [Description]) VALUES (3, 1, N'4', NULL)
INSERT [dbo].[Review] ([IDReview], [IDClient], [Score], [Description]) VALUES (4, 1, N'3', NULL)
INSERT [dbo].[Review] ([IDReview], [IDClient], [Score], [Description]) VALUES (5, 3, N'4', NULL)
INSERT [dbo].[Review] ([IDReview], [IDClient], [Score], [Description]) VALUES (7, 5, N'5', N'Без балкона с окнами во двор')
INSERT [dbo].[Review] ([IDReview], [IDClient], [Score], [Description]) VALUES (8, 18, N'4', NULL)
INSERT [dbo].[Review] ([IDReview], [IDClient], [Score], [Description]) VALUES (9, 18, N'5', N'Без балкона с окнами во двор')
INSERT [dbo].[Review] ([IDReview], [IDClient], [Score], [Description]) VALUES (10, 32, N'5', N'Без балкона с окнами во двор')
INSERT [dbo].[Review] ([IDReview], [IDClient], [Score], [Description]) VALUES (11, 34, N'2', NULL)
INSERT [dbo].[Review] ([IDReview], [IDClient], [Score], [Description]) VALUES (12, 3, N'3', NULL)
SET IDENTITY_INSERT [dbo].[Review] OFF
GO
/****** Object:  Index [IX_Accomodation_IDClient]    Script Date: 26.06.2024 13:28:55 ******/
CREATE NONCLUSTERED INDEX [IX_Accomodation_IDClient] ON [dbo].[Accomodation]
(
	[IDClient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Accomodation_IDReserved_IDPaymentCard_IDClient]    Script Date: 26.06.2024 13:28:55 ******/
CREATE NONCLUSTERED INDEX [IX_Accomodation_IDReserved_IDPaymentCard_IDClient] ON [dbo].[Accomodation]
(
	[IDReserved] ASC,
	[IDPaymentCard] ASC,
	[IDClient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UIX_Clients_DocumentSeriesAndNumber]    Script Date: 26.06.2024 13:28:55 ******/
ALTER TABLE [dbo].[Clients] ADD  CONSTRAINT [UIX_Clients_DocumentSeriesAndNumber] UNIQUE NONCLUSTERED 
(
	[DocumentSeriesAndNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Clients_Surname]    Script Date: 26.06.2024 13:28:55 ******/
CREATE NONCLUSTERED INDEX [IX_Clients_Surname] ON [dbo].[Clients]
(
	[Surname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Reservation_IDClient]    Script Date: 26.06.2024 13:28:55 ******/
CREATE NONCLUSTERED INDEX [IX_Reservation_IDClient] ON [dbo].[Reservation]
(
	[IDClient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Reservation_Number]    Script Date: 26.06.2024 13:28:55 ******/
CREATE NONCLUSTERED INDEX [IX_Reservation_Number] ON [dbo].[Reservation_Number]
(
	[IDReserved] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Reservation_Number_Covering]    Script Date: 26.06.2024 13:28:55 ******/
CREATE NONCLUSTERED INDEX [IX_Reservation_Number_Covering] ON [dbo].[Reservation_Number]
(
	[ArrivalDate] ASC,
	[IDClient] ASC
)
INCLUDE([IDNumber],[IDReserved],[NumberDay],[NumberPeople]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Reservation] ADD  CONSTRAINT [DF_Reservation_EstimatedArrivalDate]  DEFAULT (getdate()) FOR [EstimatedArrivalDate]
GO
ALTER TABLE [dbo].[Reservation] ADD  CONSTRAINT [DF_Reservation_TypeNumber]  DEFAULT ('Стандартный') FOR [TypeNumber]
GO
ALTER TABLE [dbo].[Accomodation]  WITH CHECK ADD  CONSTRAINT [FK_Accomodation_PaymentCard] FOREIGN KEY([IDPaymentCard])
REFERENCES [dbo].[PaymentCard] ([IDPaymentCard])
GO
ALTER TABLE [dbo].[Accomodation] CHECK CONSTRAINT [FK_Accomodation_PaymentCard]
GO
ALTER TABLE [dbo].[Accomodation]  WITH CHECK ADD  CONSTRAINT [FK_Accomodation_Reservation] FOREIGN KEY([IDReserved])
REFERENCES [dbo].[Reservation] ([IDReserved])
GO
ALTER TABLE [dbo].[Accomodation] CHECK CONSTRAINT [FK_Accomodation_Reservation]
GO
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD  CONSTRAINT [FK_Reservation_Client] FOREIGN KEY([IDClient])
REFERENCES [dbo].[Clients] ([IDClient])
GO
ALTER TABLE [dbo].[Reservation] CHECK CONSTRAINT [FK_Reservation_Client]
GO
ALTER TABLE [dbo].[Reservation_Number]  WITH CHECK ADD  CONSTRAINT [Client_reservation_number] FOREIGN KEY([IDClient])
REFERENCES [dbo].[Clients] ([IDClient])
GO
ALTER TABLE [dbo].[Reservation_Number] CHECK CONSTRAINT [Client_reservation_number]
GO
ALTER TABLE [dbo].[Reservation_Number]  WITH CHECK ADD  CONSTRAINT [FK_Reservation_Number_Reservation] FOREIGN KEY([IDReserved])
REFERENCES [dbo].[Reservation] ([IDReserved])
GO
ALTER TABLE [dbo].[Reservation_Number] CHECK CONSTRAINT [FK_Reservation_Number_Reservation]
GO
ALTER TABLE [dbo].[Reservation_Number]  WITH CHECK ADD  CONSTRAINT [Number_reservation_number] FOREIGN KEY([IDNumber])
REFERENCES [dbo].[Numbers] ([IDNumber])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reservation_Number] CHECK CONSTRAINT [Number_reservation_number]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [Client_review] FOREIGN KEY([IDClient])
REFERENCES [dbo].[Clients] ([IDClient])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [Client_review]
GO
ALTER TABLE [dbo].[Clients]  WITH CHECK ADD  CONSTRAINT [CK_Client_Documents] CHECK  (([Document]='Passport' OR [Document]='Birth certificate' OR [Document]='Drivers licence'))
GO
ALTER TABLE [dbo].[Clients] CHECK CONSTRAINT [CK_Client_Documents]
GO
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD  CONSTRAINT [CK_Reservation_TypeNumber] CHECK  (([TypeNumber]='Стандартный' OR [TypeNumber]='Улучшенный' OR [TypeNumber]='Супер люкс' OR [TypeNumber]='Люкс'))
GO
ALTER TABLE [dbo].[Reservation] CHECK CONSTRAINT [CK_Reservation_TypeNumber]
GO
/****** Object:  StoredProcedure [dbo].[Proc_NumbersStatistic]    Script Date: 26.06.2024 13:28:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[Proc_NumbersStatistic] (@StartDay date, @EndDay date)
as
select 
		Numbers.IDNumber,
		Count([dbo].[Reservation_Number].IDReserved) as CountNumber,
		Numbers.[Cost] * ISNULL( DATEDIFF(day, @StartDay, @EndDay), 0) as TotalCost,
		DATEDIFF(day, @StartDay, @EndDay) as TotalDays
from [dbo].[Numbers] left join [dbo].[Reservation_Number] on [dbo].[Numbers].IDNumber = [dbo].[Reservation_Number].IDNumber
group by 
Numbers.IDNumber,
Numbers.[Cost]
GO
EXEC [Hotel].sys.sp_addextendedproperty @name=N'Who', @value=N'Патычкина Елизавета Вадимовна' 
GO
USE [master]
GO
ALTER DATABASE [Hotel] SET  READ_WRITE 
GO
