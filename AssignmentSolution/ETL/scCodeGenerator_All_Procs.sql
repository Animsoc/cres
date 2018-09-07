
--creating st. procedures for extract and transform the data
USE [Crescendo_Stg]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.up_app_wk_Sports') AND type in (N'P', N'PC'))
    DROP PROCEDURE dbo.up_app_wk_Sports
GO
 
CREATE PROCEDURE dbo.up_app_wk_Sports (@Date varchar(10))
AS
BEGIN
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
--   Version 1
DECLARE @iError         int
,       @iRowcount      int
,       @sProgName      varchar(80)
,       @iStagingDateID int 
,       @bIsHistoricalRun bit
,       @sMessage		varchar(50)
 
DECLARE @ErrorMessage   NVARCHAR(4000)
,       @ErrorSeverity  INT
,       @ErrorState     INT
 
SELECT  @iError        = 0
,       @iRowcount     = 0
,       @sProgName     = OBJECT_NAME(@@PROCID)

/*    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @sMessage
*/
BEGIN TRY
/*    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @sMessage

 */
	TRUNCATE TABLE [dbo].[wk_Sports]

	INSERT INTO [wk_Sports]
		(
		 SysSportId, 
		 Sport_name ,
		 ExtractDate
		 )
	SELECT DISTINCT
		sportid ,
		sport,
		@Date
	  FROM [Crescendo_Source].[dbo].[soccer_sample]
	WHERE @Date = SUBSTRING(offerTimeStampUTC,1,10)

/* 
    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @sMessage
*/
END TRY
 
BEGIN CATCH
	/* --UPON ERROR CAPTURE ALL NECESSARY ERROR INFORMATION-- */
    SELECT  @ErrorMessage = N'!Failed! ' + ERROR_MESSAGE() + ' Line: ' + CONVERT(NVARCHAR(50), ERROR_LINE()),
            @ErrorSeverity = ERROR_SEVERITY(),
				    @ErrorState = ERROR_STATE(),
				    @iError = ERROR_NUMBER()
 
 
	/* --RAISE ERROR TO PROCEDURE CALLER-- */
    RAISERROR(
				@ErrorMessage, -- Message text.
				@ErrorSeverity, -- Severity.
				@ErrorState -- State.
				) WITH NOWAIT
 
END CATCH
 
END
 
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.up_app_wk_Teams') AND type in (N'P', N'PC'))
    DROP PROCEDURE dbo.up_app_wk_Teams
GO
 
CREATE PROCEDURE dbo.up_app_wk_Teams (@Date varchar(10))
AS
BEGIN
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
--   Version 1
DECLARE @iError         int
,       @iRowcount      int
,       @sProgName      varchar(80)
,       @iStagingDateID int 
,       @bIsHistoricalRun bit
,       @sMessage		varchar(50)
 
DECLARE @ErrorMessage   NVARCHAR(4000)
,       @ErrorSeverity  INT
,       @ErrorState     INT
 
SELECT  @iError        = 0
,       @iRowcount     = 0
,       @sProgName     = OBJECT_NAME(@@PROCID)

/*    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @sMessage
*/
BEGIN TRY
/*    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @sMessage

 */
	TRUNCATE TABLE [Crescendo_Stg].[dbo].[wk_Teams]
	INSERT INTO [Crescendo_Stg].[dbo].[wk_Teams]
		(
		TeamName,
		ExtractDate
		)
	SELECT hometeam, @Date
	FROM [Crescendo_Source].[dbo].[soccer_sample] as a 
	WHERE @Date = substring(offerTimeStampUTC,1,10)
	UNION 
	SELECT awayteam, @Date
	FROM [Crescendo_Source].[dbo].[soccer_sample] as a 
	WHERE @Date = substring(offerTimeStampUTC,1,10)


/* 
    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @sMessage
*/
END TRY
 
BEGIN CATCH
	/* --UPON ERROR CAPTURE ALL NECESSARY ERROR INFORMATION-- */
    SELECT  @ErrorMessage = N'!Failed! ' + ERROR_MESSAGE() + ' Line: ' + CONVERT(NVARCHAR(50), ERROR_LINE()),
            @ErrorSeverity = ERROR_SEVERITY(),
				    @ErrorState = ERROR_STATE(),
				    @iError = ERROR_NUMBER()
 
 
	/* --RAISE ERROR TO PROCEDURE CALLER-- */
    RAISERROR(
				@ErrorMessage, -- Message text.
				@ErrorSeverity, -- Severity.
				@ErrorState -- State.
				) WITH NOWAIT
 
END CATCH
 
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.up_app_wk_Leagues') AND type in (N'P', N'PC'))
    DROP PROCEDURE dbo.up_app_wk_Leagues
GO
 
CREATE PROCEDURE dbo.up_app_wk_Leagues (@Date varchar(10))
AS
BEGIN
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
--   Version 1
DECLARE @iError         int
,       @iRowcount      int
,       @sProgName      varchar(80)
,       @iStagingDateID int 
,       @bIsHistoricalRun bit
,       @sMessage		varchar(50)
 
DECLARE @ErrorMessage   NVARCHAR(4000)
,       @ErrorSeverity  INT
,       @ErrorState     INT
 
SELECT  @iError        = 0
,       @iRowcount     = 0
,       @sProgName     = OBJECT_NAME(@@PROCID)

/*    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @sMessage
*/
BEGIN TRY
/*    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @sMessage

 */
	TRUNCATE TABLE [Crescendo_Stg].[dbo].[wk_Leagues]
	INSERT INTO [Crescendo_Stg].[dbo].[wk_Leagues]
		(
		LeagueName,
		SysLeagueId, 
		ExtractDate
		)
	SELECT DISTINCT
		League,  
		leagueid, 
		@Date
	FROM [Crescendo_Source].[dbo].[soccer_sample] as a 
	WHERE @Date = SUBSTRING(offerTimeStampUTC,1,10)
/* 
    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @sMessage
*/
END TRY
 
BEGIN CATCH
	/* --UPON ERROR CAPTURE ALL NECESSARY ERROR INFORMATION-- */
    SELECT  @ErrorMessage = N'!Failed! ' + ERROR_MESSAGE() + ' Line: ' + CONVERT(NVARCHAR(50), ERROR_LINE()),
            @ErrorSeverity = ERROR_SEVERITY(),
				    @ErrorState = ERROR_STATE(),
				    @iError = ERROR_NUMBER()
 
 
	/* --RAISE ERROR TO PROCEDURE CALLER-- */
    RAISERROR(
				@ErrorMessage, -- Message text.
				@ErrorSeverity, -- Severity.
				@ErrorState -- State.
				) WITH NOWAIT
 
END CATCH
 
END
GO
 

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.up_app_wk_Markets') AND type in (N'P', N'PC'))
    DROP PROCEDURE dbo.up_app_wk_Markets
GO
 
CREATE PROCEDURE dbo.up_app_wk_Markets (@Date varchar(10))
AS
BEGIN
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
--   Version 1
DECLARE @iError         int
,       @iRowcount      int
,       @sProgName      varchar(80)
,       @iStagingDateID int 
,       @bIsHistoricalRun bit
,       @sMessage		varchar(50)
 
DECLARE @ErrorMessage   NVARCHAR(4000)
,       @ErrorSeverity  INT
,       @ErrorState     INT
 
SELECT  @iError        = 0
,       @iRowcount     = 0
,       @sProgName     = OBJECT_NAME(@@PROCID)

/*    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @sMessage
*/
BEGIN TRY
/*    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @sMessage

 */
	TRUNCATE TABLE [Crescendo_Stg].[dbo].[wk_Markets]
	INSERT INTO [Crescendo_Stg].[dbo].[wk_Markets]
		(
		[ExtractDate],
		[SysMarketId],
		[MarketType],
		[SubmarketID]
		 )
	SELECT  distinct 
		@Date,
		MarketId,
		MarketType,
		CAST(SubMarketId AS int)
	  FROM [Crescendo_Source].[dbo].[soccer_sample]
	WHERE @Date = SUBSTRING(offerTimeStampUTC,1,10)
	AND LEN([MarketId]) < 15

/* 
    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @sMessage
*/
END TRY
 
BEGIN CATCH
	/* --UPON ERROR CAPTURE ALL NECESSARY ERROR INFORMATION-- */
    SELECT  @ErrorMessage = N'!Failed! ' + ERROR_MESSAGE() + ' Line: ' + CONVERT(NVARCHAR(50), ERROR_LINE()),
            @ErrorSeverity = ERROR_SEVERITY(),
				    @ErrorState = ERROR_STATE(),
				    @iError = ERROR_NUMBER()
 
 
	/* --RAISE ERROR TO PROCEDURE CALLER-- */
    RAISERROR(
				@ErrorMessage, -- Message text.
				@ErrorSeverity, -- Severity.
				@ErrorState -- State.
				) WITH NOWAIT
 
END CATCH
 
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.up_app_wk_Matches') AND type in (N'P', N'PC'))
    DROP PROCEDURE dbo.up_app_wk_Matches
GO
 
CREATE PROCEDURE dbo.up_app_wk_Matches (@Date varchar(10))
AS
BEGIN
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
--   Version 1
DECLARE @iError         int
,       @iRowcount      int
,       @sProgName      varchar(80)
,       @iStagingDateID int 
,       @bIsHistoricalRun bit
,       @sMessage		varchar(50)
 
DECLARE @ErrorMessage   NVARCHAR(4000)
,       @ErrorSeverity  INT
,       @ErrorState     INT
 
SELECT  @iError        = 0
,       @iRowcount     = 0
,       @sProgName     = OBJECT_NAME(@@PROCID)

/*    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @sMessage
*/
BEGIN TRY
/*    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @sMessage

 */
	TRUNCATE TABLE [Crescendo_Stg].[dbo].[wk_MATCHeS]

	INSERT INTO [Crescendo_Stg].[dbo].[wk_MATCHeS]
		(
		[ExtractDate],
		sysMatchId,
		DateStamp,
		DateKey
		 )
	SELECT  distinct 
		@Date,
		MatchId,
		MatchTimeUtc,
		YEAR(convert(datetime, MatchTimeUtc, 121)) * 10000 +
		MONTH(convert(datetime, MatchTimeUtc, 121)) * 100 +
		DAY(convert(datetime, MatchTimeUtc, 121))
	FROM [Crescendo_Source].[dbo].[soccer_sample]
	WHERE @Date = SUBSTRING(offerTimeStampUTC,1,10)

/* 
    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @sMessage
*/
END TRY
 
BEGIN CATCH
	/* --UPON ERROR CAPTURE ALL NECESSARY ERROR INFORMATION-- */
    SELECT  @ErrorMessage = N'!Failed! ' + ERROR_MESSAGE() + ' Line: ' + CONVERT(NVARCHAR(50), ERROR_LINE()),
            @ErrorSeverity = ERROR_SEVERITY(),
				    @ErrorState = ERROR_STATE(),
				    @iError = ERROR_NUMBER()
 
 
	/* --RAISE ERROR TO PROCEDURE CALLER-- */
    RAISERROR(
				@ErrorMessage, -- Message text.
				@ErrorSeverity, -- Severity.
				@ErrorState -- State.
				) WITH NOWAIT
 
END CATCH
 
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.up_app_wk_Offers') AND type in (N'P', N'PC'))
    DROP PROCEDURE dbo.up_app_wk_Offers
GO
 
CREATE PROCEDURE dbo.up_app_wk_Offers (@Date varchar(10))
AS
BEGIN
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
--   Version 1
DECLARE @iError         int
,       @iRowcount      int
,       @sProgName      varchar(80)
,       @iStagingDateID int 
,       @bIsHistoricalRun bit
,       @sMessage		varchar(50)
 
DECLARE @ErrorMessage   NVARCHAR(4000)
,       @ErrorSeverity  INT
,       @ErrorState     INT
 
SELECT  @iError        = 0
,       @iRowcount     = 0
,       @sProgName     = OBJECT_NAME(@@PROCID)

/*    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @sMessage
*/
BEGIN TRY
/*    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @sMessage

 */
	TRUNCATE TABLE [Crescendo_Stg].[dbo].[wk_Offers]
	INSERT INTO [Crescendo_Stg].[dbo].[wk_Offers]
		(
		[ExtractDate],

		[SysOfferid],
		[OfferDateStamp],
		[SysMatchID],

		[SysSportId],
		[SysLeagueId],
		[HomeTeamName],
		[AwayTeamName],

		[SysMarketId],

		[OddsHome],
		[OddsAway],
		[OddsDraw],
		[isSubmarketAvailable],
		[Points]
		)
	SELECT  
		@Date,

		OfferId,
		OfferTimeStampUtc,
		MatchId,

		SportId,
		LeagueId,
		HomeTeam,
		AwayTeam,

		MarketId,

		OddsHome,
		OddsAway,
		OddsDraw,
		[isSubmarketAvailable],
		[Points]
	FROM [Crescendo_Source].[dbo].[soccer_sample] as a 
	WHERE @Date = substring(offerTimeStampUTC,1,10)
	AND LEN(offerid) < 11

/* 
    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @sMessage
*/
END TRY
 
BEGIN CATCH
	/* --UPON ERROR CAPTURE ALL NECESSARY ERROR INFORMATION-- */
    SELECT  @ErrorMessage = N'!Failed! ' + ERROR_MESSAGE() + ' Line: ' + CONVERT(NVARCHAR(50), ERROR_LINE()),
            @ErrorSeverity = ERROR_SEVERITY(),
				    @ErrorState = ERROR_STATE(),
				    @iError = ERROR_NUMBER()
 
 
	/* --RAISE ERROR TO PROCEDURE CALLER-- */
    RAISERROR(
				@ErrorMessage, -- Message text.
				@ErrorSeverity, -- Severity.
				@ErrorState -- State.
				) WITH NOWAIT
 
END CATCH
 
END
 GO
 -- creating the st. procedures for Dim and Fact tables 
USE [Crescendo_DW]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.up_app_Dim_Sports_du') AND type in (N'P', N'PC'))
    DROP PROCEDURE dbo.up_app_Dim_Sports_du
GO
 
CREATE PROCEDURE dbo.up_app_Dim_Sports_du
AS
BEGIN
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE @iError         int
,       @iRowcount      int
,       @sProgName      varchar(80)
,       @sMessage		varchar(50)
 
DECLARE @ErrorMessage   NVARCHAR(4000)
,       @ErrorSeverity  INT
,       @ErrorState     INT
 
SELECT  @iError        = 0
,       @iRowcount     = 0
,       @sProgName     = OBJECT_NAME(@@PROCID)

/*    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @sMessage
*/
BEGIN TRY
/*    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = 'Starting'

*/

	IF OBJECT_ID('[#tmp_Sports]') IS NOT NULL 
	BEGIN 
		DROP TABLE [#tmp_Sports]
	END

	SELECT DISTINCT
		  s.SysSportId 
		 ,s.Sport_name 
	INTO [#tmp_Sports]
	FROM [Crescendo_DW].[dbo].[vw_stg__dim_Sports] as s LEFT JOIN [dbo].[Dim_Sports] as ds
	  ON S.SysSportId = DS.sysSportid
   WHERE DS.SportName IS null

/* 
    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @sMessage
*/

	INSERT INTO Dim_Sports
	(
		 SysSportId
		,Sportname
	)
	SELECT  s.SysSportId 
		   ,s.Sport_name  
	  FROM #tmp_Sports as s

/* 
    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @sMessage
*/
END TRY
 
BEGIN CATCH
	/* --UPON ERROR CAPTURE ALL NECESSARY ERROR INFORMATION-- */
    SELECT  @ErrorMessage = N'!Failed! ' + ERROR_MESSAGE() + ' Line: ' + CONVERT(NVARCHAR(50), ERROR_LINE()),
            @ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE(),
			@iError = ERROR_NUMBER()
	/* --RAISE ERROR TO PROCEDURE CALLER-- */
    RAISERROR(
				@ErrorMessage, -- Message text.
				@ErrorSeverity, -- Severity.
				@ErrorState -- State.
				) WITH NOWAIT
END CATCH
END
 
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.up_app_dim_Leagues_du') AND type in (N'P', N'PC'))
    DROP PROCEDURE dbo.up_app_dim_Leagues_du
GO
 
CREATE PROCEDURE dbo.up_app_dim_Leagues_du
AS
BEGIN
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
 
DECLARE @iError         int
,       @iRowcount      int
,       @sProgName      varchar(80)
,       @iStagingDateID int 
,       @sMessage		varchar(50)
 
DECLARE @ErrorMessage   NVARCHAR(4000)
,       @ErrorSeverity  INT
,       @ErrorState     INT
 
SELECT  @iError        = 0
,       @iRowcount     = 0
,       @sProgName     = OBJECT_NAME(@@PROCID)
 
/* 
    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = 'Starting'
*/
BEGIN TRY
	IF OBJECT_ID('[#tmp_Leagues]') IS NOT NULL 
	BEGIN 
		DROP TABLE [#tmp_Leagues]
	END

	SELECT DISTINCT
		   l.SysLeagueId,
		   l.LeagueName 
	  INTO [#tmp_Leagues]
	  FROM [Crescendo_DW].[dbo].[vw_stg__dim_Leagues] as l LEFT JOIN [dbo].[Dim_Leagues] as ls
		ON l.SysLeagueId =ls.SysLeagueId
	 WHERE ls.LeagueName IS null

/* 
    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @sMessage
*/

	INSERT INTO Dim_Leagues
	(
		 SysLeagueId
		,LeagueName
	)
	SELECT  t.SysLeagueId
		   ,t.LeagueName  
	  FROM #tmp_Leagues as t
/*
     EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = 'Ending'
*/
END TRY
 
BEGIN CATCH
		/* --UPON ERROR CAPTURE ALL NECESSARY ERROR INFORMATION-- */
    SELECT  @ErrorMessage = N'!Failed! ' + ERROR_MESSAGE() + ' Line: ' + CONVERT(NVARCHAR(50), ERROR_LINE()),
            @ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE(),
			@iError = ERROR_NUMBER()
/*
     EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @ErrorMessage

*/
		/* --RAISE ERROR TO PROCEDURE CALLER-- */
    RAISERROR(
				@ErrorMessage, -- Message text.
				@ErrorSeverity, -- Severity.
				@ErrorState -- State.
				) WITH NOWAIT
 
END CATCH
 
END
 
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.up_app_dim_Markets_du') AND type in (N'P', N'PC'))
    DROP PROCEDURE dbo.up_app_dim_Markets_du
GO
 
CREATE PROCEDURE dbo.up_app_dim_Markets_du
AS
BEGIN
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
 
DECLARE @iError         int
,       @iRowcount      int
,       @sProgName      varchar(80)
,       @sMessage		varchar(50)
 
DECLARE @ErrorMessage   NVARCHAR(4000)
,       @ErrorSeverity  INT
,       @ErrorState     INT
 
SELECT  @iError        = 0
,       @iRowcount     = 0
,       @sProgName     = OBJECT_NAME(@@PROCID)
 
/* 
    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = 'Starting'
*/
BEGIN TRY

	IF OBJECT_ID('[#tmp_Markets]') IS NOT NULL 
	BEGIN 
		DROP TABLE #tmp_Markets
	END

	SELECT DISTINCT
		 s.SysMarketId 
		 ,s.MarketType
		 ,s.SubmarketId
	INTO [#tmp_Markets]
	FROM [Crescendo_DW].[dbo].[vw_stg__dim_Markets] as s LEFT JOIN [dbo].[Dim_Markets] as ds
	  ON S.SysMarketId = DS.SysMarketId
	WHERE DS.MarketType IS null

/* 
    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @sMessage
*/

	INSERT INTO Dim_Markets
	(
		 SysMarketId 
		,MarketType
		,SubmarketId
	)
	SELECT   t.SysMarketId ,
			 t.MarketType,
			 t.SubmarketId
	  FROM #tmp_Markets as t

 
/* 
    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @sMessage
*/
END TRY
 
BEGIN CATCH
		/* --UPON ERROR CAPTURE ALL NECESSARY ERROR INFORMATION-- */
    SELECT  @ErrorMessage = N'!Failed! ' + ERROR_MESSAGE() + ' Line: ' + CONVERT(NVARCHAR(50), ERROR_LINE()),
            @ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE(),
			@iError = ERROR_NUMBER()
 
/* 
    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @ErrorMessage
*/
 
		/* --RAISE ERROR TO PROCEDURE CALLER-- */
    RAISERROR(
				@ErrorMessage, -- Message text.
				@ErrorSeverity, -- Severity.
				@ErrorState -- State.
				) WITH NOWAIT
 
END CATCH
 
END
 
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.up_app_dim_Matches_du') AND type in (N'P', N'PC'))
    DROP PROCEDURE dbo.up_app_dim_Matches_du
GO
 
CREATE PROCEDURE dbo.up_app_dim_Matches_du
AS
BEGIN
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
 
DECLARE @iError         int
,       @iRowcount      int
,       @sProgName      varchar(80)
,       @sMessage		varchar(50)
 
DECLARE @ErrorMessage   NVARCHAR(4000)
,       @ErrorSeverity  INT
,       @ErrorState     INT
 
SELECT  @iError        = 0
,       @iRowcount     = 0
,       @sProgName     = OBJECT_NAME(@@PROCID)
 /* 
    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @sMessage
*/
BEGIN TRY
/* 
    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = 'Starting'
*/
	IF OBJECT_ID('[#tmp_Matches]') IS NOT NULL 
	BEGIN 
		DROP TABLE [#tmp_Matches]
	END

	SELECT DISTINCT
		   m.SysMatchId
		,  m.DateStamp
		,  m.datekey
	  INTO [#tmp_Matches]
	  FROM [Crescendo_DW].[dbo].[vw_stg__dim_Matches] as m LEFT JOIN [dbo].[Dim_Matches] as ds
	    ON m.SysMatchId = DS.SysMatchId
	 WHERE DS.SysMatchId IS null

/* 
    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @sMessage
*/

	INSERT INTO Dim_Matches
	(
		   SysMatchId
		,  DateStamp
		,  datekey
	)
	SELECT t.SysMatchId
		,  t.DateStamp
		,  t.datekey
	  FROM #tmp_Matches as t
END TRY
 
BEGIN CATCH
		/* --UPON ERROR CAPTURE ALL NECESSARY ERROR INFORMATION-- */
    SELECT  @ErrorMessage = N'!Failed! ' + ERROR_MESSAGE() + ' Line: ' + CONVERT(NVARCHAR(50), ERROR_LINE()),
            @ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE(),
			@iError = ERROR_NUMBER()
 
/* 
    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @ErrorMessage

*/
		/* --RAISE ERROR TO PROCEDURE CALLER-- */
    RAISERROR(
				@ErrorMessage, -- Message text.
				@ErrorSeverity, -- Severity.
				@ErrorState -- State.
				) WITH NOWAIT
 
END CATCH
 
END
 
GO
 
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.up_app_Dim_Teams_du') AND type in (N'P', N'PC'))
    DROP PROCEDURE dbo.up_app_Dim_Teams_du
GO
 
CREATE PROCEDURE dbo.up_app_Dim_Teams_du
AS
BEGIN
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
 
DECLARE @iError         int
,       @iRowcount      int
,       @sProgName      varchar(80)
,       @sMessage		varchar(50)
 
DECLARE @ErrorMessage   NVARCHAR(4000)
,       @ErrorSeverity  INT
,       @ErrorState     INT
 
SELECT  @iError        = 0
,       @iRowcount     = 0
,       @sProgName     = OBJECT_NAME(@@PROCID)
/* 
    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = 'Starting'
*/
BEGIN TRY

		IF OBJECT_ID('[#tmp_Teams]') IS NOT NULL 
		BEGIN 
			DROP TABLE [#tmp_Teams]
		END
		SELECT DISTINCT
			   t.Teamname 
		  INTO [#tmp_Teams]
		  FROM [Crescendo_DW].[dbo].[vw_stg__dim_Teams] as t LEFT JOIN [dbo].[Dim_Teams] as ds
			ON t.Teamname = DS.Teamname
		 WHERE DS.Teamname IS null

		INSERT INTO Dim_Teams
		(
			Teamname
		)
		SELECT t.Teamname  
		  FROM [#tmp_Teams] as t

/* 
    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @sMessage
*/
END TRY
 
BEGIN CATCH
		/* --UPON ERROR CAPTURE ALL NECESSARY ERROR INFORMATION-- */
    SELECT  @ErrorMessage = N'!Failed! ' + ERROR_MESSAGE() + ' Line: ' + CONVERT(NVARCHAR(50), ERROR_LINE()),
            @ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE(),
			@iError = ERROR_NUMBER()
 
/* 
    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @ErrorMessage
*/
 
		/* --RAISE ERROR TO PROCEDURE CALLER-- */
    RAISERROR(
				@ErrorMessage, -- Message text.
				@ErrorSeverity, -- Severity.
				@ErrorState -- State.
				) WITH NOWAIT
 
END CATCH
 
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.up_app_Fact_Offers_du') AND type in (N'P', N'PC'))
    DROP PROCEDURE dbo.up_app_Fact_Offers_du
GO
 
CREATE PROCEDURE dbo.up_app_Fact_Offers_du
AS
BEGIN
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
 
DECLARE @iError         int
,       @iRowcount      int
,       @sProgName      varchar(80)
,       @sMessage		varchar(50)
 
DECLARE @ErrorMessage   NVARCHAR(4000)
,       @ErrorSeverity  INT
,       @ErrorState     INT
 
SELECT  @iError        = 0
,       @iRowcount     = 0
,       @sProgName     = OBJECT_NAME(@@PROCID)
/* 
    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = 'Starting'
*/
BEGIN TRY

		IF OBJECT_ID('[#tmp_Offer]') IS NOT NULL 
		BEGIN 
			DROP TABLE [#tmp_Offer]
		END
		SELECT
				 CONVERT(int, CONVERT(char(8),o.Extractdate,112)) as DateKey
				,o.[SysOfferId] 
				,o.[OfferDateStamp] as DateStamp
			
				,o.[SysMatchID] 
				,M.Matchkey 
			
				,o.[SysSportid] 
				,S.SportKey 
			
				,o.[SysLeagueId] 
				,l.[LeagueKey] 
			
				,o.[HomeTeamName] 
				,t1.TeamKey  as HomeTeamKey
			
				,o.[AwayTeamName] 
				,t2.TeamKey as AwayTeamKey
			
				,o.[SysMarketId] 
				,m2.MarketKey
			
				,o.[OddsHome] as OddHome
				,o.[OddsAway] as OddAway
				,o.[OddsDraw] as OddDraw
				,o.[isSubmarketAvailable]
				,o.[Points]
     	  INTO [#tmp_Offer]
		  FROM [Crescendo_DW].[dbo].[vw_stg__Fact_Offers] as o INNER JOIN [Crescendo_DW].[dbo].[dim_Leagues] AS l
					ON o.[SysLeagueId] = l.sysLeagueId
				INNER JOIN [Crescendo_DW].[dbo].[dim_MAtches] AS m
					ON o.[SysMatchID] = m.SysMatchId
				INNER JOIN [Crescendo_DW].[dbo].[dim_Sports] AS s
					ON O.[SysSportid] = s.SysSportId
				INNER JOIN [Crescendo_DW].[dbo].[dim_Teams] AS t1 
					ON O.[HomeTeamName] = t1.TeamName
				INNER JOIN [Crescendo_DW].[dbo].[dim_teams] AS t2
					ON O.[AwayTeamName] = t2.TeamName
				INNER JOIN [Crescendo_DW].[dbo].[dim_Markets] AS m2
					ON o.SysMarketId = m2.SysMarketid

		INSERT INTO [dbo].[Fact_Offers]
		(
				 [Datekey]
			    ,[SysOfferid]
				,[DateStamp]
			
				,[MatchKey] 
			
				,[SportKey]
			
				,[LeagueKey]
			
				,[HomeTeamKey]
			
				,[AwayTeamKey]
			
				,[MarketKey]
			
				,[OddHome] 
				,[OddAway]
				,[OddDraw] 
				,[isSubmarketAvailable]
				,[Points]
		)
		SELECT  
				[DateKey]

				,[SysOfferId]
				,[DateStamp]
			
				,[MatchKey] 
			
				,[SportKey]
			
				,[LeagueKey]
			
				,[HomeTeamKey]
			
				,[AwayTeamKey]
			
				,[MarketKey]
			
				,[OddHome]
				,[OddAway]
				,[OddDraw] 
				,[isSubmarketAvailable]
				,[Points]
		  FROM [#tmp_Offer] as t

/* 
    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @sMessage
*/
END TRY
 
BEGIN CATCH
		/* --UPON ERROR CAPTURE ALL NECESSARY ERROR INFORMATION-- */
    SELECT  @ErrorMessage = N'!Failed! ' + ERROR_MESSAGE() + ' Line: ' + CONVERT(NVARCHAR(50), ERROR_LINE()),
            @ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE(),
			@iError = ERROR_NUMBER()
 
/* 
    EXEC dbo.up_sup_LogMessage 
        ,   @iErrorValue       = @@ERROR
        ,   @iRowcountValue    = @@ROWCOUNT
        ,   @sLocation         = @sProgName
        ,   @sMessage          = @ErrorMessage
*/
 
		/* --RAISE ERROR TO PROCEDURE CALLER-- */
    RAISERROR(
				@ErrorMessage, -- Message text.
				@ErrorSeverity, -- Severity.
				@ErrorState -- State.
				) WITH NOWAIT
 
END CATCH
 
END
