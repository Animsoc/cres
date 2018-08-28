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
	[SubmarketID],
	[isSubmarketAvailable],
	[Points]
	 )
SELECT  distinct 
	@Date,
	MarketId,
	MarketType,
	CAST(SubMarketId AS int),
	IsSubMarketAvailable,
	Points
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
 

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.up_app_wk_Matchs') AND type in (N'P', N'PC'))
    DROP PROCEDURE dbo.up_app_wk_Matchs
GO
 
CREATE PROCEDURE dbo.up_app_wk_Matchs (@Date varchar(10))
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
TRUNCATE TABLE [Crescendo_Stg].[dbo].[wk_MATCHS]
INSERT INTO [Crescendo_Stg].[dbo].[wk_MATCHS]
	(
	[ExtractDate],
	sysMatchId,
	DateStamp
	 )
SELECT  distinct 
	@Date,
	MatchId,
	MatchTimeUtc
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
	@Date,

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
 

