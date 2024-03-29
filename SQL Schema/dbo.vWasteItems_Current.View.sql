USE [TestEHS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vWasteItems_Current]
AS
select * from WasteItems c
	WHERE Stamp = 
		(select max(Stamp) FROM WasteItems 
		WHERE WasteOriginID=c.WasteOriginID
		GROUP BY WasteOriginID) 
GO
