USE [TestEHS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[GetWasteByID]
(
@ID nvarchar(50),
@Language nvarchar(20),
@ProcessComp nvarchar(50) null
)
	AS
	CREATE TABLE #temp(
	WasteID nvarchar(50),
	ItemCode nvarchar(50),
	MethodDescription nvarchar(255),	
	WasteDescription nvarchar(255),
	CompID nvarchar(50),
	MethodName nvarchar(50),
	Status int)
		BEGIN
			IF(@ID <> '' AND @ID IS NOT NULL)
				BEGIN
					INSERT INTO #temp exec GetWasteItem @Language
					SELECT * FROM #temp WHERE WasteID = @ID
					AND (@ProcessComp IS NULL OR @ProcessComp ='' OR @ProcessComp=CompID)
				END
			ELSE 
				BEGIN
				INSERT INTO #temp exec GetWasteItem @Language
				SELECT * FROM #temp WHERE (@ProcessComp IS NULL OR @ProcessComp ='' OR @ProcessComp=CompID)
				END
			IF OBJECT_ID('tempdb..#temp') IS NOT NULL DROP TABLE #temp
		END
GO
