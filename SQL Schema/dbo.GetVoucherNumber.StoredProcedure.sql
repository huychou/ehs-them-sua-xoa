USE [TestEHS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[GetVoucherNumber]
	AS
		Create table #temp 
		(VoucherID nvarchar(30),
		VoucherNO nvarchar(30))
		BEGIN
		Declare @ID varchar(30)
		,@NO  nvarchar(30)		
		SET @ID = (select dbo.fnVoucherID())
		SET @NO = (select dbo.fnVoucherNO())
		INSERT INTO #temp values(@ID,@NO)
		select * from #temp
			IF OBJECT_ID('tempdb..#temp') IS NOT NULL DROP TABLE #temp
		END
GO
