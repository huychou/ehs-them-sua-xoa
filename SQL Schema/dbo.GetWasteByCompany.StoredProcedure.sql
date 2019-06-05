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
CREATE PROCEDURE [dbo].[GetWasteByCompany] 
	@CompID nvarchar(50),
	@Lang nvarchar(50)
	/*
		EXEC [GetWasteByCompany] '872898D1-FC4F-4ACE-89A1-578C3A049994','VN'
	*/
AS
BEGIN
	SET NOCOUNT ON;

	SELECT w.WasteID, w.ItemCode,
			CASE WHEN @Lang ='VN' THEN m.Description_VN        
				 WHEN @Lang ='EN' THEN m.Description_EN         
				 WHEN @Lang ='TW' THEN m.Description_TW       
				 WHEN @Lang ='CN' THEN m.Description_CN
				 ELSE ''
			END
				AS MethodDescription,
			CASE WHEN @Lang ='VN' THEN w.Description_VN        
				 WHEN @Lang ='EN' THEN w.Description_EN         
				 WHEN @Lang ='TW' THEN w.Description_TW       
				 WHEN @Lang ='CN' THEN w.Description_CN
				 ELSE ''
			END
				AS WasteDescription,
				w.CompOriginID,
				m.MethodName,
				w.Status
		 FROM fnWasteItem() w  JOIN MethodProcess m ON w.MethodID=m.MethodID
	WHERE 
		(CompOriginID = (SELECT d.CompOriginID FROM fnCompany() d WHERE d.CompID=@CompID) OR @CompID is null OR @CompID='')
	AND w.Status=1
END


GO
