USE [TestEHS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vCompany_Current]
AS
	select * from Company c
	WHERE Stamp = 
		(select max(Stamp) FROM Company 
		WHERE CompOriginID=c.CompOriginID
		GROUP BY CompOriginID) 
GO
