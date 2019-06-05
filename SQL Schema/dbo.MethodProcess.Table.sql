USE [TestEHS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MethodProcess](
	[MethodID] [nvarchar](50) NOT NULL,
	[MethodName] [nvarchar](50) NULL,
	[Description_EN] [nvarchar](255) NULL,
	[Description_TW] [nvarchar](255) NULL,
	[Description_CN] [nvarchar](255) NULL,
	[Description_VN] [nvarchar](255) NULL,
	[Status] [int] NULL,
	[MethodNumID] [nvarchar](50) NULL,
	[Stamp] [datetime] NULL,
 CONSTRAINT [PK_MethodProcess] PRIMARY KEY CLUSTERED 
(
	[MethodID] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
