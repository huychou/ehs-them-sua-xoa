USE [TestEHS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROC [dbo].[GetBasic]
  (
	@Table nvarchar(50),
	@Lang nvarchar(5) 
  )

  /*
	EXEC [GetBasic] 'WasteItems','VN'
	EXEC [GetBasic] 'Company','VN'
  */
	AS
		BEGIN
			
			
			if (@table='WasteItems') -- WasteItems
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
			else if(@table='MethodProcess') --MethodProcess
				SELECT MethodID, Status,
				CASE WHEN @Lang ='VN' THEN Description_VN     
					WHEN @Lang ='EN' THEN Description_EN        
					WHEN @Lang ='TW' THEN Description_TW     
					WHEN @Lang ='CN' THEN Description_CN
					END as MethodDescription
				FROM MethodProcess
								
			else if (@table='Company') --Company
				select CompID,CompOriginID, CompName, Type, Status, Remark FROM fnCompany()

			else if (@table='Department') --Department
			BEGIN
				Select CostCenter,
				CASE WHEN @Lang ='VN'THEN Specification_VN     
					WHEN @Lang ='EN' THEN Specification_EN        
					WHEN @Lang ='TW' THEN Specification_TW     
					WHEN @Lang ='CN' THEN Specification_CN
					END as Specification		
				FROm Department

			END
			else if (@table='CenterDepartment') --CenterDepartment
			BEGIN
				SELECT CostCenter, 
				CASE WHEN @Lang ='VN'THEN Specification_VN     
					WHEN @Lang ='EN' THEN Specification_EN        
					WHEN @Lang ='TW' THEN Specification_TW     
					WHEN @Lang ='CN' THEN Specification_CN
					END as Specification	
				FROm CenterDepartment

			END
		END

GO
