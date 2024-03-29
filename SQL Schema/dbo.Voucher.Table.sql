USE [TestEHS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Voucher](
	[VoucherID] [nvarchar](50) NOT NULL,
	[OwnerComp] [nvarchar](50) NOT NULL,
	[ProcessComp] [nvarchar](50) NOT NULL,
	[VoucherNumber] [nvarchar](50) NULL,
	[DepartReq] [nvarchar](50) NULL,
	[DepartProcess] [nvarchar](50) NULL,
	[InternalPhone] [nvarchar](50) NULL,
	[Location] [nvarchar](50) NULL,
	[DateOut] [date] NULL,
	[DateComplete] [date] NULL,
	[ReturnReason] [nvarchar](50) NULL,
	[UserID] [nvarchar](50) NULL,
	[CreateTime] [datetime] NULL,
	[Stamp] [datetime] NULL,
	[Status] [nvarchar](50) NULL,
 CONSTRAINT [pk_voucher] PRIMARY KEY CLUSTERED 
(
	[VoucherID] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Voucher]  WITH CHECK ADD  CONSTRAINT [FK_Voucher_CenterDepartment] FOREIGN KEY([DepartReq])
REFERENCES [dbo].[CenterDepartment] ([CostCenter])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Voucher] CHECK CONSTRAINT [FK_Voucher_CenterDepartment]
GO
ALTER TABLE [dbo].[Voucher]  WITH CHECK ADD  CONSTRAINT [FK_Voucher_Department] FOREIGN KEY([DepartProcess])
REFERENCES [dbo].[Department] ([CostCenter])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Voucher] CHECK CONSTRAINT [FK_Voucher_Department]
GO
ALTER TABLE [dbo].[Voucher]  WITH CHECK ADD  CONSTRAINT [FK_Voucher_ownerCompany] FOREIGN KEY([OwnerComp])
REFERENCES [dbo].[Company] ([CompID])
GO
ALTER TABLE [dbo].[Voucher] CHECK CONSTRAINT [FK_Voucher_ownerCompany]
GO
ALTER TABLE [dbo].[Voucher]  WITH NOCHECK ADD  CONSTRAINT [fk_voucher_process_c_company] FOREIGN KEY([ProcessComp])
REFERENCES [dbo].[Company] ([CompID])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Voucher] NOCHECK CONSTRAINT [fk_voucher_process_c_company]
GO
