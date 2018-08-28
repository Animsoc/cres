USE [Crescendo_Stg]
GO

SET NOCOUNT ON

/*
	Script for extract & transform the source data for one day @extractdate
*/

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

EXEC dbo.up_app_wk_Sports @Date = @ExtractDate

EXEC dbo.up_app_wk_Leagues @Date = @ExtractDate

EXEC dbo.up_app_wk_Teams @Date = @ExtractDate

EXEC dbo.up_app_wk_Markets @Date = @ExtractDate

EXEC dbo.up_app_wk_Matchs @Date = @ExtractDate

EXEC dbo.up_app_wk_Offers @Date = @ExtractDate
