USE [TestEHS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[ExportXLSData]
(
--string VoucherID, DateTime? dateFrom, DateTime? dateTo, string ProcessComp, string DepartProcess, string InternalPhone, string VoucherNumber, string DepartReq, string Status, string userID, int isCheck, string lang

	@VoucherID NVARCHAR(50) null,
	@From Datetime null,
	@To	Datetime null,
	@ProcessComp nvarchar(50) null,
	@DepartProcess nvarchar(50) null,
	@InternalPhone nvarchar(50) null,
	@VoucherNumber nvarchar(50) null,
	@DepartReq nvarchar(50) null,
	@Status nvarchar(50) null, -- null ('') / N / M / X
	@UserID nvarchar(50) null,
	@CheckMyOwn bit null, --null/0: all voucher; not null: Just that user
	@Lang nvarchar(50)
	
	/*
		EXEC [ExportXLSData] '','2018-01-01','2019-05-05','','','','','','','',1,'EN'
	*/
)
as	
	BEGIN	
	CREATE TABLE #temp_depart (CostCenter nvarchar(50), Specification nvarchar(255))
	INSERT INTO #temp_depart(CostCenter,Specification) exec GetBasic 'Department', @lang
	CREATE TABLE #temp_cdepart (CostCenter nvarchar(50), Specification nvarchar(255))
	INSERT INTO #temp_cdepart (CostCenter,Specification) exec GetBasic 'CenterDepartment', @lang
	Select 
			--ROW_NUMBER() OVER (ORDER BY v.VoucherID DESC) as row,
			v.VoucherID
			,v.VoucherNumber
			,o.CompName as OwnerComp
			--o.CompCode as OwnerCompCode
			--o.Address as OwnerCompAddress
			--o.Phone as OwnerCompPhon, 
			--o.Email as OwnerCompEmail
			,p.CompName as ProcessComp
			,pro.Specification as DepartProcess
			,req.Specification as DepartReq
			--p.CompCode as ProcessCompCode
			--p.Address as ProcessCompAddress
			,v.InternalPhone
			,v.Location
			,v.DateOut
			,v.DateComplete
			--v.ReturnReason
			,v.UserID
			,v.CreateTime
			,v.Stamp
			,v.Status
			,vd.WasteID
			--p.Email as ProcessCompEmail,	
			,[WasteDescription_EN] = w.Description_EN
			,w.Status
			,vd.Weight
			,[SumTotal]= SUM(vd.Weight) OVER (PARTITION BY v.VoucherID) 
			--,[SumQty] = sum(vd.Quantity) OVER (PARTITION BY v.VoucherID) 
			,vd.Quantity
			--,v.InternalPhone
			--,v.Location
			--,vd.Quantity
			
			--,w.ItemCode
			
			--,[WasteDescription_TW] = w.Description_TW
			--,[MethodProcess] = m.Description_EN
		
			FROM Voucher v
				LEFT JOIN Company o ON o.CompID=v.OwnerComp --to get real information 
				LEFT JOIN Company p ON p.CompID=v.ProcessComp --to get real information
				LEFT JOIN #temp_depart pro on pro.CostCenter = v.DepartProcess
				LEFT JOIN #temp_cdepart req on req.CostCenter = v.DepartReq
				LEFT JOIN VoucherDetail vd ON v.VoucherID=vd.VoucherID
				LEFT JOIN WasteItems w ON vd.WasteID = w.WasteID
				LEFT JOIN MethodProcess m ON m.MethodID = w.MethodID
			WHERE 
					(@VoucherID IS NULL or @VoucherID='' OR v.VoucherID = @VoucherID)
				AND (@From IS NULL OR @FROM='' OR CreateTime>= @From) 
				AND (@To IS NULL OR @TO='' OR CreateTime<=dateadd(day,1,@To))
				AND (@ProcessComp IS NULL OR @ProcessComp='' OR p.CompOriginID= (SELECT CompOriginID FROM fnCompany() WHERE CompOriginID=@ProcessComp)) --Origin Comp
				AND (@InternalPhone IS NULL OR @InternalPhone='' or InternalPhone LIKE '%'+@InternalPhone+'%')
				AND (@VoucherNumber IS NULL OR @VoucherNumber='' or VoucherNumber LIKE '%'+@VoucherNumber+'%')
				AND (@DepartReq IS NULL OR @DepartReq='' or v.DepartReq=@DepartReq)
				AND (@DepartProcess IS NULL OR @DepartProcess='' or v.DepartProcess=@DepartProcess)
				AND (@CheckMyOwn IS NULL OR @CheckMyOwn=0 OR v.UserID=@UserID)
				AND (@Status IS NULL OR @Status='' OR v.Status=@Status)
			
			drop table #temp_depart, #temp_cdepart
	END
	
GO
