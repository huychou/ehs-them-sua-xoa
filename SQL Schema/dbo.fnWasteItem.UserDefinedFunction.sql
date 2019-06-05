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
CREATE FUNCTION [dbo].[fnWasteItem]
(	
	
)
RETURNS TABLE 
AS

RETURN 
(
	select * from WasteItems c
	WHERE Stamp = 
		(select max(Stamp) FROM WasteItems 
		WHERE WasteOriginID=c.WasteOriginID
		GROUP BY WasteOriginID) 
)


GO
