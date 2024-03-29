USE [TestEHS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[CostCenter] [nvarchar](50) NOT NULL,
	[Specification_EN] [nvarchar](150) NULL,
	[Specification_VN] [nvarchar](150) NULL,
	[Specification_TW] [nvarchar](150) NULL,
	[Specification_CN] [nvarchar](150) NULL,
	[Center] [nvarchar](50) NULL,
 CONSTRAINT [PK__Departme__123ED45B97EC486B] PRIMARY KEY CLUSTERED 
(
	[CostCenter] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Department]  WITH NOCHECK ADD  CONSTRAINT [FK_Department_CenterDepartment] FOREIGN KEY([Center])
REFERENCES [dbo].[CenterDepartment] ([CostCenter])
GO
ALTER TABLE [dbo].[Department] NOCHECK CONSTRAINT [FK_Department_CenterDepartment]
GO
