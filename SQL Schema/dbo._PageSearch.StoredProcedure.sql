USE [TestEHS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[_PageSearch]   
(   
	--1,参数的括号可要可不要,有默认值的参数,在调用的时候,可以不写出来   
	--2,调用：   
	--declare @i int   
	--exec _PagerSql2005_out_count 'list','id,title','id',3,4,1,'classid=6',@i out   
	@tblName varchar(100), -- 表名   
	@fldCow varchar(400)='*', -- 要查询的列   
	@fldName varchar(255), -- 排序列   
	@PageSize int = 10, -- 页尺寸   
	@PageIndex int = 1, -- 页码   
	@OrderType bit = 1, -- 设置排序类型, 1则降序   
	@strWhere nvarchar(2000) = '', -- 查询条件 (注意: 不要加 where)   
	@count int output --输入符合条件的记录的总数   
)   
AS  

declare @strSQL varchar(1000); -- 主语句   
declare @strOrder varchar(500) ; -- 排序类型   
declare @strTmp varchar(100) ; --临时变量   
declare @endIndex int; -- 结束的索引   
declare @startIndex int; -- 开始的索引   
declare @countSql nvarchar(500); --查询记录总数的ＳＱＬ   
--得到索引   
set @startIndex=(@PageIndex-1)*@PageSize + 1;--注意，这里要加１   
set @endIndex=@PageIndex*@PageSize;   
--生成排序语句   
--为了多表联合查询，这里要把表名字和排序字段的［］去掉-   
if @OrderType != 0   
--set @strOrder = ' order by ' + @fldName + ' desc'   
set @strOrder =@fldName  
else   
set @strOrder =@fldName  
--set @strOrder = ' order by ' + @fldName + ' asc'   
set @strSQL = '(select top ' + ltrim(str(@endIndex))   
+ 'row_number() over ('+ @strOrder +') as No '+', '+ ' '+@fldCow +' from '   
+ @tblName + '' ;   
set @countSql= 'select @count=count('+@fldName+') from '+ @tblName ;   
  
if @strWhere! = ''   
begin   
	set @strSQL =@strSQL+ ' where ('+ @strWhere + ') ';   
	set @countSql=@countSql + ' where ('+ @strWhere + ') ';   
end   
set @strSQL =@strSQL+ ') as tblTmp'   
--得到记录总数   
set @countSql=N'select @count=count(*) from ' + @tblName;   
if @strWhere! = ''   
set @countSql=@countSql+ N' where ' + @strWhere;   
  
EXEC sp_executesql @countSql,N'@count int out',@count out   
  
set @strSQL = 'select * from ' + @strSQL + ' where No between ' + ltrim(str(@startIndex)) + ' and '   
+ ltrim(str(@endIndex));   
--执行主语句   
set nocount on -- 防止显示有关受影响的行数的信息   
exec (@strSQL)   
--print @strSQL  
GO
