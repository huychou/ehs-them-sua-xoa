USE [TestEHS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE FUNCTION [dbo].[fnCompany]
(	
	
)
RETURNS TABLE 
AS

RETURN 
(
	select * from Company c
	WHERE Stamp = 
		(select max(Stamp) FROM Company 
		WHERE CompOriginID=c.CompOriginID
		GROUP BY CompOriginID) 
)
GO
