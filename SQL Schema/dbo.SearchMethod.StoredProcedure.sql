USE [TestEHS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jang 
-- Create date:  8/2018
-- Description:	procedure for searching in Method processing page
-- =============================================
CREATE PROCEDURE [dbo].[SearchMethod] 
	
	@MethodID nvarchar(50) , --NULL OR '' => GET ALL
	@MethodName nvarchar(50),
	@Description nvarchar(255),
	@Status nvarchar(1)
AS
BEGIN	
SET NOCOUNT ON;
			SELECT *
				 FROM  MethodProcess
			WHERE (@MethodID is null or @MethodID='' or MethodID LIKE '%'+@MethodID+'%')
			AND (@MethodName is null or @MethodName='' or MethodName LIKE '%'+@MethodName+'%')
			AND (@Description is null or Description_TW LIKE'%'+@Description+'%' OR 
										Description_VN LIKE '%'+@Description+'%')
			AND (@Status is null or @Status='' or Status=CONVERT(int,@Status))
			ORDER BY Status DESC, Description_VN
END
GO
