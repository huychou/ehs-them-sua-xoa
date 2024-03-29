USE [TestEHS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		j
-- Create date: 
-- Description:	
-- =============================================

CREATE PROCEDURE [dbo].[SearchWasteItem] 
	
	@MethodID nvarchar(50) , --NULL OR '' => GET ALL
	@State nvarchar(50),
	@ItemCode nvarchar(50),
	@Description nvarchar(50),
	@ProcessComp nvarchar(50),
	@Status nvarchar(1)
AS
BEGIN	
SET NOCOUNT ON;
			SELECT 
			w.WasteID,
			w.State,
			w.MethodID,
			m.MethodName,
			w.ItemCode,
			w.Description_VN,
			w.Description_TW,
			--w.Description_EN,
			--w.Description_CN,
			w.Status,
			c.CompName	
				 FROM (select * from fnWasteItem()) w
				 JOIN MethodProcess m ON w.MethodID = m.MethodID
				 JOIN fnCompany() c ON c.CompOriginID=w.CompOriginID
			WHERE (@MethodID is null or w.MethodID=@MethodID)
			AND (@State is null or @State='' or w.State=@State)
			AND (@ItemCode is null or @ItemCode='' or w.ItemCode LIKE '%'+@ItemCode+'%')
			AND (@Description is null or @Description='' 
				or w.Description_TW LIKE'%'+@Description+'%' OR 
				w.Description_VN LIKE '%'+@Description+'%')
			AND (@ProcessComp is null or @ProcessComp='' or w.CompOriginID LIKE '%'+@ProcessComp+'%')
			AND (@Status is null or @Status='' or CONVERT(int,@Status)=w.Status)
			ORDER BY Status DESC, CompName, Description_VN
END

GO
