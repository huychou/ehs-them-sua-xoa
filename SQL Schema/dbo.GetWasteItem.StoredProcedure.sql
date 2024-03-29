USE [TestEHS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*HEADER WASTEITEM*/
CREATE PROC [dbo].[GetWasteItem]
(
@Language nvarchar(20)
)
	AS
		BEGIN
			SELECT w.WasteID, w.ItemCode,
			CASE WHEN @Language ='VN' THEN m.Description_VN        
				 WHEN @Language ='EN' THEN m.Description_EN         
				 WHEN @Language ='TW' THEN m.Description_TW       
				 WHEN @Language ='CN' THEN m.Description_CN
				 ELSE ''
			END
				AS MethodDescription,
			CASE WHEN @Language ='VN' THEN w.Description_VN        
				 WHEN @Language ='EN' THEN w.Description_EN         
				 WHEN @Language ='TW' THEN w.Description_TW       
				 WHEN @Language ='CN' THEN w.Description_CN
				 ELSE ''
			END
				AS WasteDescription,
				w.CompID,
				m.MethodName,
				w.Status
							
				 FROM WasteItems w
				 JOIN MethodProcess m ON w.MethodID = m.MethodID
		END
GO
