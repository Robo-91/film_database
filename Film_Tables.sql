USE [master]
GO
/****** Object:  Database [film_DB]    Script Date: 4/8/2021 3:42:46 PM ******/
CREATE DATABASE [film_DB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'film_DB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.LEARNINGSERVER\MSSQL\DATA\film_DB.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'film_DB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.LEARNINGSERVER\MSSQL\DATA\film_DB_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [film_DB] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [film_DB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [film_DB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [film_DB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [film_DB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [film_DB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [film_DB] SET ARITHABORT OFF 
GO
ALTER DATABASE [film_DB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [film_DB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [film_DB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [film_DB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [film_DB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [film_DB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [film_DB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [film_DB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [film_DB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [film_DB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [film_DB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [film_DB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [film_DB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [film_DB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [film_DB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [film_DB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [film_DB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [film_DB] SET RECOVERY FULL 
GO
ALTER DATABASE [film_DB] SET  MULTI_USER 
GO
ALTER DATABASE [film_DB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [film_DB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [film_DB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [film_DB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [film_DB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'film_DB', N'ON'
GO
ALTER DATABASE [film_DB] SET QUERY_STORE = OFF
GO
USE [film_DB]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [film_DB]
GO
/****** Object:  Table [dbo].[fact_Film]    Script Date: 4/8/2021 3:42:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fact_Film](
	[filmtv_id] [int] NOT NULL,
	[title] [int] NULL,
	[year] [int] NULL,
	[genre] [int] NULL,
	[duration] [int] NULL,
	[country] [int] NULL,
	[director] [int] NULL,
	[actors] [varchar](255) NULL,
	[avg_vote] [decimal](18, 0) NULL,
	[votes] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[filmtv_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimDirector]    Script Date: 4/8/2021 3:42:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimDirector](
	[director_id] [int] IDENTITY(1,1) NOT NULL,
	[director_name] [varchar](255) NULL,
 CONSTRAINT [PK__DimDirec__F5205E49E1D4A115] PRIMARY KEY CLUSTERED 
(
	[director_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_Director]    Script Date: 4/8/2021 3:42:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[v_Director]
as
select director_name as [Director Name],
	   count(*) as [Number of Films],
	   cast(round(avg(avg_vote),2) as decimal(4,2)) as [Average Rating],
	   sum(votes) as [Total Votes]
	from DimDirector
	join fact_Film on DimDirector.director_id = fact_Film.director
	group by director_name;
GO
/****** Object:  Table [dbo].[DimGenre]    Script Date: 4/8/2021 3:42:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimGenre](
	[genre_id] [int] IDENTITY(1,1) NOT NULL,
	[genre_name] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[genre_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_Genre]    Script Date: 4/8/2021 3:42:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[v_Genre]
as
select  genre_name as [Genre], 
		count(title) as [Film Count],
		sum(votes) [Total Votes],
		cast(round(avg(avg_vote),2)as decimal(4,2)) as [Average Rating]
	from DimGenre
	join fact_Film on DimGenre.genre_id = fact_Film.genre
	group by genre_name;
GO
/****** Object:  Table [dbo].[DimCountry]    Script Date: 4/8/2021 3:42:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimCountry](
	[country_id] [int] IDENTITY(1,1) NOT NULL,
	[country_name] [varchar](255) NULL,
 CONSTRAINT [PK__DimCount__7E8CD0552998E090] PRIMARY KEY CLUSTERED 
(
	[country_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_Country]    Script Date: 4/8/2021 3:42:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[v_Country]
as
select	country_name as [Name of Country],
		count(title) as [Movie Count],
		sum(votes) as [Total Votes],
		cast(round(avg(avg_vote),2)as decimal(4,2)) as [Average Rating]
	from DimCountry
	join fact_Film on DimCountry.country_id = fact_Film.country
	group by country_name;
GO
/****** Object:  Table [dbo].[DimYear]    Script Date: 4/8/2021 3:42:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimYear](
	[year_id] [int] IDENTITY(1,1) NOT NULL,
	[year_no] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[year_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[year_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_Year]    Script Date: 4/8/2021 3:42:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[v_Year]
as
select	year_no as [Year],
		count(title) as [Movie Count],
		sum(votes) as [Total Votes],
		cast(round(avg(avg_vote),2)as decimal(4,2)) as [Average Rating]
	from DimYear
	join fact_Film on DimYear.year_id = fact_Film.year
	group by year_no;
GO
/****** Object:  View [dbo].[v_Movie_Info]    Script Date: 4/8/2021 3:42:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[v_Movie_Info]
as
select	title as [Film Title],
		year_no as [Year Released],
		genre_name as [Film Genre],
		duration as Duration,
		country_name as [Location(s)],
		director_name as [Director(s)],
		actors as [Cast],
		cast(avg_vote as decimal(4,2)) as [Average Vote],
		votes as [Total Votes]
	from fact_Film
	join DimYear on fact_Film.year = DimYear.year_id
	join DimGenre on fact_Film.genre = DimGenre.genre_id
	join DimCountry on fact_Film.country = DimCountry.country_id
	join DimDirector on fact_Film.director = DimDirector.director_id
		where title is not null;
GO
ALTER TABLE [dbo].[fact_Film]  WITH CHECK ADD  CONSTRAINT [FK__fact_Film__count__3C69FB99] FOREIGN KEY([country])
REFERENCES [dbo].[DimCountry] ([country_id])
GO
ALTER TABLE [dbo].[fact_Film] CHECK CONSTRAINT [FK__fact_Film__count__3C69FB99]
GO
ALTER TABLE [dbo].[fact_Film]  WITH CHECK ADD  CONSTRAINT [FK__fact_Film__direc__3D5E1FD2] FOREIGN KEY([director])
REFERENCES [dbo].[DimDirector] ([director_id])
GO
ALTER TABLE [dbo].[fact_Film] CHECK CONSTRAINT [FK__fact_Film__direc__3D5E1FD2]
GO
ALTER TABLE [dbo].[fact_Film]  WITH CHECK ADD FOREIGN KEY([genre])
REFERENCES [dbo].[DimGenre] ([genre_id])
GO
ALTER TABLE [dbo].[fact_Film]  WITH CHECK ADD FOREIGN KEY([year])
REFERENCES [dbo].[DimYear] ([year_id])
GO
/****** Object:  StoredProcedure [dbo].[proc_AddCountry]    Script Date: 4/8/2021 3:42:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[proc_AddCountry]
(
	@newCountry varchar(50)
)
as
begin
	insert into DimCountry(country_name)
	values(@newCountry);
end
GO
/****** Object:  StoredProcedure [dbo].[proc_AddDirector]    Script Date: 4/8/2021 3:42:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[proc_AddDirector]
(
	@newDirector varchar(50)
)
as
begin
	insert into DimDirector(director_name)
	values(@newDirector);
end
GO
/****** Object:  StoredProcedure [dbo].[proc_AddGenre]    Script Date: 4/8/2021 3:42:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[proc_AddGenre]
(
	@newGenre varchar(50)
)
as
begin
	insert into DimGenre(genre_name)
	values(@newGenre);
end
GO
/****** Object:  StoredProcedure [dbo].[proc_AddYear]    Script Date: 4/8/2021 3:42:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[proc_AddYear]
(
	@newYear int
)
as
begin
	insert into DimYear(year_no)
	values(@newYear);
end
GO
USE [master]
GO
ALTER DATABASE [film_DB] SET  READ_WRITE 
GO


-- Film Title table
create table DimTitle
(
	film_id int identity primary key,
	film_name varchar(255)
);

