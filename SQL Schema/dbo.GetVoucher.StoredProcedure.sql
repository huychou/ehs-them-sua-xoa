USE [TestEHS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GetVoucher]
@VoucherID nvarchar(50)
	AS
		BEGIN
		SELECT 
			v.VoucherID,
			v.VoucherNumber,
			o.CompName as OwnerComp,
			o.CompCode as OwnerCompCode,
			o.Address as OwnerCompAddress,
			o.Phone as OwnerCompPhone,
			o.Email as OwnerCompEmail,
			p.CompName as ProcessComp,		
			p.CompCode as ProcessCompCode,
			p.Address as ProcessCompAddress,
			p.Phone as ProcessCompPhone,
			p.Email as ProcessCompEmail,		
			v.InternalPhone,
			v.Location,
			Sum(detail.Weight) as SumTotal,
			Sum(detail.Quantity) as SumQty,
			v.DateOut,
			v.DateComplete,
			v.ReturnReason,
			v.UserID,
			v.CreateTime,
			v.Stamp,
			v.Status 
		 FROM Voucher v
			LEFT JOIN VoucherDetail detail on v.VoucherID = detail.VoucherID
			LEFT JOIN Company o on v.OwnerComp = o.CompID
			LEFT JOIN Company p on v.ProcessComp = p.CompID
			LEFT JOIN WasteItems w on w.WasteID = detail.WasteID
			LEFT JOIN MethodProcess m on m.MethodID = w.MethodID
			LEFT JOIN dbo.Department pro on pro.CostCenter = v.DepartProcess
			LEFT JOIN dbo.Department req on req.CostCenter = v.DepartReq
			WHERE v.VoucherID=@VoucherID
			GROUP BY 
			v.VoucherID,
			v.VoucherNumber,
			o.CompName,
			o.CompCode,
			o.Address ,
			o.Phone ,
			o.Email,
			p.CompName ,		
			p.CompCode,
			p.Address ,
			p.Phone,
			p.Email,
			v.DepartReq,
			v.DepartProcess,
			v.InternalPhone,
			v.Location,
		    v.DateOut,
			v.DateComplete,
			v.ReturnReason,
			v.UserID,
			v.CreateTime,
			v.Stamp,
			v.Status
			
		END
	
GO
