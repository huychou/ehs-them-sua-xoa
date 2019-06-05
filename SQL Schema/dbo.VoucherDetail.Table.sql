USE [TestEHS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VoucherDetail](
	[ID] [nvarchar](50) NOT NULL,
	[WasteID] [nvarchar](50) NOT NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[Quantity] [int] NULL,
	[Weight] [real] NULL,
 CONSTRAINT [PK_VoucherDetail_1] PRIMARY KEY CLUSTERED 
(
	[WasteID] ASC,
	[VoucherID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[VoucherDetail]  WITH NOCHECK ADD  CONSTRAINT [fk_voucher__voucherID_voucher] FOREIGN KEY([VoucherID])
REFERENCES [dbo].[Voucher] ([VoucherID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[VoucherDetail] CHECK CONSTRAINT [fk_voucher__voucherID_voucher]
GO
ALTER TABLE [dbo].[VoucherDetail]  WITH NOCHECK ADD  CONSTRAINT [FK_VoucherDetail_WasteItems] FOREIGN KEY([WasteID])
REFERENCES [dbo].[WasteItems] ([WasteID])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[VoucherDetail] NOCHECK CONSTRAINT [FK_VoucherDetail_WasteItems]
GO
