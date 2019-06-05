USE [TestEHS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[GetVoucherDetail]
(
@VoucherID nvarchar(50)
)
	AS
		BEGIN
				
			SELECT detail.ID,
				   company.CompName,
					waste.Description_VN,
					waste.Description_TW,
					waste.Description_CN,
					waste.ItemCode,
					waste.State,
					method.MethodName,
					detail.Quantity,
					detail.Weight
					FROM Voucher voucher 
					JOIN VoucherDetail detail ON voucher.VoucherID = detail.VoucherID
					JOIN WasteItems waste ON waste.WasteID = detail.WasteID
					JOIN MethodProcess method ON method.MethodID = waste.MethodID
					JOIN Company company ON voucher.ProcessComp = company.CompID
					WHERE voucher.VoucherID =@VoucherID

		END
GO
