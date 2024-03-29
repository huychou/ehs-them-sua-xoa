USE [TestEHS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SearchVoucher]
(
	@VoucherID NVARCHAR(50) null,
	@From Datetime null,
	@To	Datetime null,
	@ProcessComp nvarchar(50) null,
	@DepartProcess nvarchar(50) null,
	@InternalPhone nvarchar(50) null,
	@VoucherNumber nvarchar(50) null,
	@DepartReq nvarchar(50) null,
	@Status nvarchar(50) null, -- null ('') / N / M / X
	@CheckMyOwn bit null, --null/0: all voucher; not null: Just that user
	@UserID nvarchar(50) null, --always required
	@PageSize int = 50, -- 页尺寸   
	@PageIndex int = 1 ,-- 页码   ,
	@Lang nvarchar(50),
	@count int output --输入符合条件的记录的总数  
	/*
		DECLARE @count int
		EXEC [SearchVoucher] '','','','872898D1-FC4F-4ACE-89A1-578C3A049994','','','','','','','',50,1,'VN',@count
	*/
)
as	
	BEGIN	
	CREATE TABLE #temp_depart (CostCenter nvarchar(50), Specification nvarchar(255))
	INSERT INTO #temp_depart(CostCenter,Specification) exec GetBasic 'Department', @lang
	CREATE TABLE #temp_cdepart (CostCenter nvarchar(50), Specification nvarchar(255))
	INSERT INTO #temp_cdepart (CostCenter,Specification) exec GetBasic 'CenterDepartment', @lang
			Select 
			ROW_NUMBER() OVER (ORDER BY v.VoucherID DESC) as row,
			v.VoucherID,
			v.VoucherNumber,
			o.CompName as OwnerComp,
			--o.CompCode as OwnerCompCode,
			--o.Address as OwnerCompAddress,
			--o.Phone as OwnerCompPhone, 
			--o.Email as OwnerCompEmail,
			p.CompName as ProcessComp,		
			--p.CompCode as ProcessCompCode,
			--p.Address as ProcessCompAddress,
			--p.Phone as ProcessCompPhone,
			--p.Email as ProcessCompEmail,		
			pro.Specification as DepartProcess,
			req.Specification as DepartReq,
			sum(vd.Weight) as SumTotal,
			sum(vd.Quantity) as SumQty,
			v.InternalPhone,
			v.Location,
			v.DateOut,
			v.DateComplete,
			--v.ReturnReason,
			v.UserID,
			v.CreateTime,
			v.Stamp,
			v.Status
			INTO tbl
			FROM Voucher v
				LEFT JOIN Company o ON o.CompID=v.OwnerComp --to get real information 
				LEFT JOIN Company p ON p.CompID=v.ProcessComp --to get real information
				LEFT JOIN #temp_depart pro on pro.CostCenter = v.DepartProcess
				LEFT JOIN #temp_cdepart req on req.CostCenter = v.DepartReq
				LEFT JOIN VoucherDetail vd ON v.VoucherID=vd.VoucherID
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
			GROUP BY
			v.VoucherID,
			v.VoucherNumber,
			o.CompName ,
			--o.CompCode ,
			--o.Address ,
			--o.Phone ,
			--o.Email ,
			p.CompName,
			--p.CompCode,
			--p.Address ,
			--p.Phone ,
			--p.Email,
			pro.Specification,
			req.Specification,
			v.InternalPhone,
			v.Location,
			v.DateOut,
			v.DateComplete,
			--v.ReturnReason,
			v.UserID,
			v.CreateTime,
			v.Stamp,
			v.Status
			
			select 
				VoucherID ,
				VoucherNumber,
				OwnerComp,
				--OwnerCompCode,
				--OwnerCompAddress,
				--OwnerCompPhone,
				--OwnerCompEmail,
				ProcessComp,		
				--ProcessCompCode,
				--ProcessCompAddress,
				--ProcessCompPhone,
				--ProcessCompEmail,		
				DepartProcess,
				DepartReq,
				SumTotal,
				SumQty,
				InternalPhone,
				Location,
				DateOut,
				DateComplete,
				--ReturnReason,
				UserID,
				CreateTime,
				Stamp,
				Status 

				from tbl WHERE (row>@PageSize*(@PageIndex-1) AND row<=@PageIndex*@PageSize)
			SET @count = (select max(row) as TotalItems from tbl )
			drop table tbl, #temp_depart, #temp_cdepart
	END
	
GO
