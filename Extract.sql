/****** Script for SelectTopNRows command from SSMS  ******/

DECLARE @extractdate varchar(10)
SELECT @extractdate= '2017-09-20' 

-- 2017-09-21
-- 2017-09-22
-- 2017-09-23
-- 2017-09-24
-- 2017-09-25
-- 2017-09-26
-- 2017-09-27
-- 2017-09-28
-- 2017-09-29
-- 2017-09-30
-- 2017-10-01
-- 2017-10-02
-- 2017-10-03 

-- INSERT IN LOG

TRUNCATE TABLE [Crescendo_Stg].[dbo].[wk_Sports]
INSERT INTO [Crescendo_Stg].[dbo].[wk_Sports]
	(
	 SysSportId, 
	 Sport_name ,
	 ExtractDate
	 )
SELECT distinct 
	sportid ,
	sport,
	@extractdate
  FROM [Crescendo_Source].[dbo].[soccer_sample]
WHERE @extractdate = SUBSTRING(offerTimeStampUTC,1,10)

--insert in log
--insert in log

TRUNCATE TABLE [Crescendo_Stg].[dbo].[wk_Leagues]
INSERT INTO [Crescendo_Stg].[dbo].[wk_Leagues]
	(
	LeagueName,
	SysLeagueId, 
	ExtractDate
	)
select distinct 
	League,  
	leagueid, 
	@extractdate
FROM [Crescendo_Source].[dbo].[soccer_sample] as a 
WHERE @extractdate = SUBSTRING(offerTimeStampUTC,1,10)


TRUNCATE TABLE [Crescendo_Stg].[dbo].[wk_Teams]
INSERT INTO [Crescendo_Stg].[dbo].[wk_Teams]
	(
	TeamName,
	ExtractDate
	)
SELECT hometeam, @extractdate
FROM [Crescendo_Source].[dbo].[soccer_sample] as a 
WHERE @extractdate = substring(offerTimeStampUTC,1,10)
UNION 
SELECT awayteam, @extractdate
FROM [Crescendo_Source].[dbo].[soccer_sample] as a 
WHERE @extractdate = substring(offerTimeStampUTC,1,10)


---
--- code for wk_Match and wk_Market
---
TRUNCATE TABLE [Crescendo_Stg].[dbo].[wk_Markets]
INSERT INTO [Crescendo_Stg].[dbo].[wk_Markets]
	(
	[ExtractDate],
	[SysMarketId],
	[MarketType],
	[SubmarketID],
	[isSubmarketAvailable],
	[Points]
	 )
SELECT  distinct 
	@extractdate,
	MarketId,
	MarketType,
	CAST(SubMarketId AS int),
	IsSubMarketAvailable,
	Points
  FROM [Crescendo_Source].[dbo].[soccer_sample]
WHERE @extractdate = SUBSTRING(offerTimeStampUTC,1,10)


TRUNCATE TABLE [Crescendo_Stg].[dbo].[wk_MATCHS]
INSERT INTO [Crescendo_Stg].[dbo].[wk_MATCHS]
	(
	[ExtractDate],
	sysMatchId,
	DateStamp
	 )
SELECT  distinct 
	@extractdate,
	MatchId,
	MatchTimeUtc
  FROM [Crescendo_Source].[dbo].[soccer_sample]
WHERE @extractdate = SUBSTRING(offerTimeStampUTC,1,10)

TRUNCATE TABLE [Crescendo_Stg].[dbo].[wk_Offers]
INSERT INTO [Crescendo_Stg].[dbo].[wk_Offers]
	(
	[ExtractDate],

	[SysOfferid],
	[OfferDateStamp],
	[SysMatchID],

	[SportName],
	[LeagueName],
	[HomeTeamName],
	[AwayTeamName],

	[SysMarketId],

	[OddsHome],
	[OddsAway],
	[OddsDraw]
	)
SELECT  
	@extractdate,

	OfferId,
	OfferTimeStampUtc,
	MatchId,

	Sport,
	League,
	HomeTeam,
	AwayTeam,

	MarketId,

	OddsHome,
	OddsAway,
	OddsDraw
FROM [Crescendo_Source].[dbo].[soccer_sample] as a 
WHERE @extractdate = substring(offerTimeStampUTC,1,10)
