USE [TestEHS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WasteItems](
	[WasteID] [nvarchar](50) NOT NULL,
	[WasteOriginID] [nvarchar](50) NULL,
	[MethodID] [nvarchar](50) NULL,
	[State] [nvarchar](50) NULL,
	[ItemCode] [nvarchar](50) NULL,
	[Description_EN] [nvarchar](255) NULL,
	[Description_TW] [nvarchar](255) NULL,
	[Description_CN] [nvarchar](255) NULL,
	[Description_VN] [nvarchar](255) NULL,
	[CompOriginID] [nvarchar](50) NULL,
	[Status] [int] NULL,
	[Stamp] [datetime] NULL,
	[Remark] [nvarchar](50) NULL,
	[UserID] [nvarchar](50) NULL,
 CONSTRAINT [pk_WasteItems] PRIMARY KEY CLUSTERED 
(
	[WasteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[WasteItems]  WITH CHECK ADD  CONSTRAINT [fk_waste_it_methodID_method_p] FOREIGN KEY([MethodID])
REFERENCES [dbo].[MethodProcess] ([MethodID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[WasteItems] CHECK CONSTRAINT [fk_waste_it_methodID_method_p]
GO
ALTER TABLE [dbo].[WasteItems]  WITH NOCHECK ADD  CONSTRAINT [FK_WasteItems_Company] FOREIGN KEY([CompOriginID])
REFERENCES [dbo].[Company] ([CompID])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[WasteItems] NOCHECK CONSTRAINT [FK_WasteItems_Company]
GO
