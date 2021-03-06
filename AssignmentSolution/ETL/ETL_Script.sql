/*
	Script for extract, transform & load the source data for one day @extractdate
*/

USE [Crescendo_Stg]
GO
SET NOCOUNT ON

DECLARE @extractdate varchar(10)
SELECT @extractdate= '2017-09-20' 
--SELECT @extractdate= '2017-09-21'
--SELECT @extractdate= '2017-09-22'
--SELECT @extractdate= '2017-09-23'
--SELECT @extractdate= '2017-09-24'
--SELECT @extractdate= '2017-09-25'
--SELECT @extractdate= '2017-09-26'
--SELECT @extractdate= '2017-09-27'
--SELECT @extractdate= '2017-09-28'
--SELECT @extractdate= '2017-09-29'
--SELECT @extractdate= '2017-09-30'
--SELECT @extractdate= '2017-10-01'
--SELECT @extractdate= '2017-10-02'
--SELECT @extractdate= '2017-10-03' 


/* Extracting and transforming the data from source [Crescendo_Source] to staging database [Crescendo_Stg]*/

EXEC dbo.up_app_wk_Sports  @Date = @ExtractDate
EXEC dbo.up_app_wk_Leagues @Date = @ExtractDate
EXEC dbo.up_app_wk_Teams   @Date = @ExtractDate
EXEC dbo.up_app_wk_Markets @Date = @ExtractDate
EXEC dbo.up_app_wk_Matches @Date = @ExtractDate
EXEC dbo.up_app_wk_Offers  @Date = @ExtractDate

/* loading the data in destination database Crescendo_DW */

USE [Crescendo_DW]

EXEC [dbo].[up_app_Dim_Sports_du]
EXEC [dbo].[up_app_Dim_Teams_du]

EXEC [dbo].[up_app_Dim_Leagues_du]
EXEC [dbo].[up_app_Dim_Matches_du]

EXEC [dbo].[up_app_Dim_Markets_du]
EXEC [dbo].[up_app_Fact_Offers_du]
