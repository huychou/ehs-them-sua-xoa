USE [TestEHS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CenterDepartment](
	[CostCenter] [nvarchar](50) NOT NULL,
	[Specification_EN] [nvarchar](150) NULL,
	[Specification_VN] [nvarchar](150) NULL,
	[Specification_TW] [nvarchar](150) NULL,
	[Specification_CN] [nvarchar](150) NULL,
 CONSTRAINT [PK_CenterDepartment] PRIMARY KEY CLUSTERED 
(
	[CostCenter] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
