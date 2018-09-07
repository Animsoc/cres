USE [master]
GO

-- Creating  3 databases
CREATE DATABASE [Crescendo_Source]
CREATE DATABASE [Crescendo_Stg]
CREATE DATABASE [Crescendo_DW]
GO

-- Creating working tables
USE [Crescendo_Stg]
GO

IF OBJECT_ID('[dbo].[wk_Leagues]') IS NOT NULL 
	DROP TABLE [dbo].[wk_Leagues]
GO
CREATE TABLE [dbo].[wk_Leagues](
	[ExtractDate] [date] NOT NULL,
	[SysLeagueId] [int] NOT NULL,
	[LeagueName] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO

IF OBJECT_ID('[dbo].[wk_Markets]') IS NOT NULL 
	DROP TABLE [dbo].[wk_Markets]
GO
CREATE TABLE [dbo].[wk_Markets](
	[ExtractDate] [date] NOT NULL,
	[SysMarketId] [nvarchar](50) NOT NULL,
	[MarketType] [nvarchar](50) NOT NULL,
	[SubmarketID] [int] NOT NULL
) ON [PRIMARY]
GO

IF OBJECT_ID('[dbo].[wk_Matches]') IS NOT NULL 
	DROP TABLE [dbo].[wk_Matches]
GO
CREATE TABLE [dbo].[wk_Matches](
	[ExtractDate] [date] NOT NULL,
	[SysMatchId] [int] NOT NULL,
	[DateKey] [int] NOT NULL,
	[DateStamp] [datetime] NOT NULL
) ON [PRIMARY]
GO

IF OBJECT_ID('[dbo].[wk_Sports]') IS NOT NULL 
	DROP TABLE [dbo].[wk_Sports]
GO
CREATE TABLE [dbo].[wk_Sports](
	[ExtractDate] [date] NOT NULL,
	[SysSportId] [int] NOT NULL,
	[Sport_name] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO

IF OBJECT_ID('[dbo].[wk_Teams]') IS NOT NULL 
	DROP TABLE [dbo].[wk_Teams]
GO
CREATE TABLE [dbo].[wk_Teams](
	[ExtractDate] [date] NOT NULL,
	[TeamName] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO

IF OBJECT_ID('[dbo].[wk_Offers]') IS NOT NULL 
	DROP TABLE [dbo].[wk_Offers]
GO
CREATE TABLE [dbo].[wk_Offers](
	[ExtractDate] [date] NOT NULL,
	[SysOfferid] [int] NOT NULL,
	[OfferDateStamp] [datetime] NOT NULL,
	[SysMatchID] [int] NOT NULL,
	[MatchKey] [int] NULL,
	[SysSportid] [nvarchar](50) NOT NULL,
	[SportKey] [int] NULL,
	[SysLeagueId] [nvarchar](50) NOT NULL,
	[LeagueKey] [int] NULL,
	[HomeTeamName] [nvarchar](50) NOT NULL,
	[HomeTeamKey] [int] NULL,
	[AwayTeamName] [nvarchar](50) NOT NULL,
	[AwayTeamKey] [int] NULL,
	[SysMarketId] [nvarchar](50) NOT NULL,
	[MarketKey] [int] NULL,
	[OddsHome] [float] NULL,
	[OddsAway] [float] NULL,
	[OddsDraw] [float] NULL,
	[isSubmarketAvailable] [bit] NOT NULL,
	[Points] [float] NOT NULL
) ON [PRIMARY]
GO

-- creating views on each working table
USE [Crescendo_DW]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.vw_stg__dim_Leagues') AND type in (N'V'))
    DROP VIEW dbo.vw_stg__dim_Leagues

GO
CREATE VIEW dbo.vw_stg__dim_Leagues as
SELECT *  
FROM [Crescendo_Stg].[dbo].wk_Leagues as a;
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.vw_stg__dim_Markets') AND type in (N'V'))
    DROP VIEW dbo.vw_stg__dim_Markets

GO
CREATE VIEW dbo.vw_stg__dim_Markets as
SELECT *  
FROM [Crescendo_Stg].[dbo].wk_Markets as a;
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.vw_stg__dim_Matches') AND type in (N'V'))
    DROP VIEW dbo.vw_stg__dim_Matches

GO
CREATE VIEW dbo.vw_stg__dim_Matches as
SELECT 	*   
FROM [Crescendo_Stg].[dbo].wk_Matches as a;
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.vw_stg__dim_Sports') AND type in (N'V'))
    DROP VIEW dbo.vw_stg__dim_Sports

GO
CREATE VIEW dbo.vw_stg__dim_Sports as
SELECT *  
FROM [Crescendo_Stg].[dbo].wk_Sports as a;
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.vw_stg__dim_Teams') AND type in (N'V'))
    DROP VIEW dbo.vw_stg__dim_Teams

GO
CREATE VIEW dbo.vw_stg__dim_Teams as
SELECT *  
FROM [Crescendo_Stg].[dbo].wk_Teams as a;
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.vw_stg__fact_Offers') AND type in (N'V'))
    DROP VIEW dbo.vw_stg__fact_Offers

GO
CREATE VIEW dbo.vw_stg__Fact_Offers as
SELECT *  
FROM [Crescendo_Stg].[dbo].wk_Offers as a;
GO

-- creating Dim and Fact tables
USE [Crescendo_DW]
GO


IF OBJECT_ID('[dbo].[Fact_Offers]') IS NOT NULL 
	DROP TABLE [dbo].[Fact_Offers]
GO
CREATE TABLE [dbo].[Fact_Offers](
	[OfferKey] [int] IDENTITY(1,1) NOT NULL,
	[DAteStamp] [datetime] NOT NULL,
	[DateKey] [int] NOT NULL,
	[SysOfferId] [int] NOT NULL,
	[HomeTeamKey] [int] NOT NULL,
	[AwayTeamKey] [int] NOT NULL,
	[MarketKey] [int] NOT NULL,
	[OddHome] [float] NOT NULL,
	[OddAway] [float] NOT NULL,
	[OddDraw] [float] NOT NULL,
	[LeagueKey] [int] NOT NULL,
	[SportKey] [int] NOT NULL,
	[MatchKey] [int] NOT NULL,
	[isSubmarketAvailable] [bit] NOT NULL,
	[Points] [float] NOT NULL,
 CONSTRAINT [PK_Fact_Offers] PRIMARY KEY CLUSTERED 
(
	[OfferKey] ASC
)) ON [PRIMARY]

GO



IF OBJECT_ID('[dbo].[Dim_Matches]') IS NOT NULL 
	DROP TABLE [dbo].[Dim_Matches]
GO
CREATE TABLE [dbo].[Dim_Matches](
	[MatchKey] [int] IDENTITY(1,1) NOT NULL,
	[SysMatchId] [int] NOT NULL,
	[DateKey] [int] NOT NULL,
	[DateStamp] [datetime] NOT NULL,
 CONSTRAINT [PK_Dim_Match] PRIMARY KEY CLUSTERED 
(
	[MatchKey] ASC
)
) ON [PRIMARY]

GO

IF OBJECT_ID('[dbo].[Dim_Teams]') IS NOT NULL 
	DROP TABLE [dbo].[Dim_Teams]
GO
CREATE TABLE [dbo].[Dim_Teams](
	[TeamKey] [int] IDENTITY(1,1) NOT NULL,
	[TeamName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Dim_Teams] PRIMARY KEY CLUSTERED 
(
	[TeamKey] ASC
)
) ON [PRIMARY]
GO

IF OBJECT_ID('[dbo].[Dim_Markets]') IS NOT NULL 
	DROP TABLE [dbo].[Dim_Markets]
GO
CREATE TABLE [dbo].[Dim_Markets](
	[MarketKey] [int] IDENTITY(1,1) NOT NULL,
	[SysMarketid] [nvarchar](50) NOT NULL,
	[MarketType] [nvarchar](50) NOT NULL,
	[SubmarketId] [int] NOT NULL,
 CONSTRAINT [PK_Dim_Market] PRIMARY KEY CLUSTERED 
(
	[MarketKey] ASC
)
) ON [PRIMARY]

GO

IF OBJECT_ID('[dbo].[Dim_Sports]') IS NOT NULL 
	DROP TABLE [dbo].[Dim_Sports]
GO
CREATE TABLE [dbo].[Dim_Sports](
	[SportKey] [int] IDENTITY(1,1) NOT NULL,
	[sysSportid] [int] NOT NULL,
	[SportName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Dim_Sports] PRIMARY KEY CLUSTERED 
(
	[SportKey] ASC
)
) ON [PRIMARY]
GO

IF OBJECT_ID('[dbo].[Dim_Leagues]') IS NOT NULL 
	DROP TABLE [dbo].[Dim_Leagues]
GO
CREATE TABLE [dbo].[Dim_Leagues](
	[LeagueKey] [int] IDENTITY(1,1) NOT NULL,
	[sysLeagueid] [int] NOT NULL,
	[LeagueName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Dim_Leagues] PRIMARY KEY CLUSTERED 
(
	[LeagueKey] ASC
)) ON [PRIMARY]
GO

IF OBJECT_ID('[dbo].[Dim_Date]') IS NOT NULL 
	DROP TABLE [dbo].[Dim_Date]
GO
CREATE TABLE [dbo].[Dim_Date](
	[DateKey] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[DayOfWeek] [tinyint] NOT NULL,
	[DayOfMonth] [tinyint] NOT NULL,
	[DayOfYear] [smallint] NOT NULL,
	[CalendarMonth] [tinyint] NOT NULL,
	[CalendarQuater] [tinyint] NOT NULL,
	[Calendar Year] [smallint] NOT NULL,
	[Calendar Semester] [tinyint] NOT NULL,
 CONSTRAINT [PK_Dim_Date] PRIMARY KEY CLUSTERED 
(
	[DateKey] ASC
)
) ON [PRIMARY]
GO

--Creating constraints on Dim and Fact tables
ALTER TABLE [dbo].[Dim_Matches]  WITH CHECK ADD  CONSTRAINT [FK_Dim_Matches_Dim_Date] FOREIGN KEY([DateKey])
REFERENCES [dbo].[Dim_Date] ([DateKey])
GO

ALTER TABLE [dbo].[Dim_Matches] CHECK CONSTRAINT [FK_Dim_Matches_Dim_Date]
GO



ALTER TABLE [dbo].[Fact_Offers]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Offers_Dim_Date] FOREIGN KEY([DateKey])
REFERENCES [dbo].[Dim_Date] ([DateKey])
GO

ALTER TABLE [dbo].[Fact_Offers] CHECK CONSTRAINT [FK_Fact_Offers_Dim_Date]
GO

ALTER TABLE [dbo].[Fact_Offers]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Offers_Dim_Leagues] FOREIGN KEY([LeagueKey])
REFERENCES [dbo].[Dim_Leagues] ([LeagueKey])
GO

ALTER TABLE [dbo].[Fact_Offers] CHECK CONSTRAINT [FK_Fact_Offers_Dim_Leagues]
GO

ALTER TABLE [dbo].[Fact_Offers]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Offers_Dim_Markets] FOREIGN KEY([MarketKey])
REFERENCES [dbo].[Dim_Markets] ([MarketKey])
GO

ALTER TABLE [dbo].[Fact_Offers] CHECK CONSTRAINT [FK_Fact_Offers_Dim_Markets]
GO

ALTER TABLE [dbo].[Fact_Offers]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Offers_Dim_Matches] FOREIGN KEY([MatchKey])
REFERENCES [dbo].[Dim_Matches] ([MatchKey])
GO

ALTER TABLE [dbo].[Fact_Offers] CHECK CONSTRAINT [FK_Fact_Offers_Dim_Matches]
GO

ALTER TABLE [dbo].[Fact_Offers]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Offers_Dim_Sports] FOREIGN KEY([SportKey])
REFERENCES [dbo].[Dim_Sports] ([SportKey])
GO

ALTER TABLE [dbo].[Fact_Offers] CHECK CONSTRAINT [FK_Fact_Offers_Dim_Sports]
GO

ALTER TABLE [dbo].[Fact_Offers]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Offers_Dim_Teams] FOREIGN KEY([HomeTeamKey])
REFERENCES [dbo].[Dim_Teams] ([TeamKey])
GO

ALTER TABLE [dbo].[Fact_Offers] CHECK CONSTRAINT [FK_Fact_Offers_Dim_Teams]
GO

ALTER TABLE [dbo].[Fact_Offers]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Offers_Dim_Teams1] FOREIGN KEY([AwayTeamKey])
REFERENCES [dbo].[Dim_Teams] ([TeamKey])
GO

ALTER TABLE [dbo].[Fact_Offers] CHECK CONSTRAINT [FK_Fact_Offers_Dim_Teams1]
GO

--	Inserting data from 2017-09-20 to 2017-10-03 in Dim_Date table
INSERT INTO [dbo].[Dim_Date]
           ([DateKey]
           ,[Date]
           ,[DayOfWeek]
           ,[DayOfMonth]
           ,[DayOfYear]
           ,[CalendarMonth]
           ,[CalendarQuater]
           ,[Calendar Year]
           ,[Calendar Semester])
     VALUES
			(20170920,'2017-09-20',3,20,DATEPART(WEEKDAY,  '2017-09-20'),9,DATEPART(QUARTER,  '2017-09-20'),2017,2)
		   ,(20170921,'2017-09-21',4,21,DATEPART(WEEKDAY,  '2017-09-21'),9,DATEPART(QUARTER,  '2017-09-21'),2017,2)
           ,(20170922,'2017-09-22',5,22,DATEPART(WEEKDAY,  '2017-09-22'),9,DATEPART(QUARTER,  '2017-09-22'),2017,2)
		   ,(20170923,'2017-09-23',6,23,DATEPART(WEEKDAY,  '2017-09-23'),9,DATEPART(QUARTER,  '2017-09-23'),2017,2)
		   ,(20170924,'2017-09-24',7,24,DATEPART(WEEKDAY,  '2017-09-24'),9,DATEPART(QUARTER,  '2017-09-24'),2017,2)
		   ,(20170925,'2017-09-25',1,25,DATEPART(WEEKDAY,  '2017-09-25'),9,DATEPART(QUARTER,  '2017-09-25'),2017,2)
		   ,(20170926,'2017-09-26',2,26,DATEPART(WEEKDAY,  '2017-09-26'),9,DATEPART(QUARTER,  '2017-09-26'),2017,2)
		   ,(20170927,'2017-09-27',3,27,DATEPART(WEEKDAY,  '2017-09-27'),9,DATEPART(QUARTER,  '2017-09-27'),2017,2)
		   ,(20170928,'2017-09-28',4,28,DATEPART(WEEKDAY,  '2017-09-28'),9,DATEPART(QUARTER,  '2017-09-28'),2017,2)
		   ,(20170929,'2017-09-29',5,29,DATEPART(WEEKDAY,  '2017-09-29'),9,DATEPART(QUARTER,  '2017-09-29'),2017,2)
		   ,(20170930,'2017-09-30',6,30,DATEPART(WEEKDAY,  '2017-09-30'),9,DATEPART(QUARTER,  '2017-09-30'),2017,2)

		   ,(20171001,'2017-10-01',7,1,DATEPART(WEEKDAY,  '2017-09-01'),10,DATEPART(QUARTER,  '2017-09-01'),2017,2)
		   ,(20171002,'2017-10-02',1,2,DATEPART(WEEKDAY,  '2017-09-02'),10,DATEPART(QUARTER,  '2017-09-02'),2017,2)
		   ,(20171003,'2017-10-03',2,3,DATEPART(WEEKDAY,  '2017-09-03'),10,DATEPART(QUARTER,  '2017-09-03'),2017,2)
GO



