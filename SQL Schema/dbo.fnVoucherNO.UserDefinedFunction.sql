USE [TestEHS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnVoucherNO]()
RETURNS NVARCHAR(50)
	AS
		BEGIN
		Declare @VoucherNO Nvarchar(50), 
				@Count int =0, @Year int, 
				@NewVoucherNO nvarchar(50)
			SET @VoucherNO = (SELECT VoucherNumber from Voucher WHERE VoucherID=(select max(VoucherID) from Voucher))
			SET @Year = (select value from string_split(@VoucherNO,'/') order by (SELECT NULL) OFFSET 1 ROWS   -- Skip this number of rows
			FETCH NEXT 1 ROW ONLY)  -- Return this number of rows)	
			IF(@VoucherNO IS NULL)
				SET @Count = 368;  --Get the present voucher
				else
			IF(@Year < YEAR(getdate())) -- Reset for NewVoucherNO
				BEGIN
					SET @Count = @Count + 1				
				END
			ELSE
				BEGIN
					SET @Count = (select value from string_split(@VoucherNO,'/') order by (SELECT NULL) OFFSET 0 ROWS   -- Skip this number of rows
					FETCH NEXT 1 ROW ONLY) +1  -- Return this number of rows)				
				END

			SET @Year = YEAR(getdate())
			SET @NewVoucherNO =  CONCAT(CONVERT(NVARCHAR(10), @Count),'/', CONVERT(NVARCHAR(10),@Year),'/74.003329.T')
			RETURN @NewVoucherNO
		END
GO
