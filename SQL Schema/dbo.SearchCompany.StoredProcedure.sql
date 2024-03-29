USE [TestEHS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		jang
-- Create date: 8/2018
-- Description:	searching company page
-- =============================================
CREATE PROCEDURE [dbo].[SearchCompany] 
	@CompName nvarchar(50)	,
	@Type nvarchar(50)		,
	@CompCode nvarchar(50)	,
	@Status nvarchar(1)		
	
AS
BEGIN
	/*
		EXEC [SearchCompany] '','','',''
	*/
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT CompID,
	 --IIF(Remark is not null AND Remark<>'',QUOTENAME(Remark,'(')+ ' ','')
	 Remark,
	 CompName as CompName, CompCode, Type, Phone, Address, Email, Status
	
	
	FROM fnCompany()

	WHERE (@CompName IS NULL OR CompName LIKE '%'+@CompName+'%')
	AND  (@Type IS NULL OR @Type='')
	AND  (@CompCode is null OR CompCode LIKE '%'+@CompCode+'%')
	AND (@Status is null or @status='' OR status = convert(int,@status))
	--AND Remark IS NULL -- Old Address problem (2019-01-24)
	ORDER BY Status DESC, Type, CompName
END
GO
