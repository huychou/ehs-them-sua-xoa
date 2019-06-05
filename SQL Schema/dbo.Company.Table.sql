USE [TestEHS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Company](
	[CompID] [nvarchar](50) NOT NULL,
	[CompOriginID] [nvarchar](50) NULL,
	[CompName] [nvarchar](255) NULL,
	[CompCode] [nvarchar](50) NULL,
	[Type] [nvarchar](50) NULL,
	[Phone] [nvarchar](50) NULL,
	[Address] [nvarchar](255) NULL,
	[Email] [nvarchar](50) NULL,
	[Status] [int] NULL,
	[Remark] [nvarchar](50) NULL,
	[Stamp] [datetime] NULL,
	[UserID] [nvarchar](50) NULL,
 CONSTRAINT [PK_COMPANY] PRIMARY KEY CLUSTERED 
(
	[CompID] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
