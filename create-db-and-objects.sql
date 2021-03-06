USE [master]
GO
/****** Object:  Database [EmpCon]    Script Date: 5/2/2018 1:28:34 PM ******/
CREATE DATABASE [EmpCon]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EmpCon', FILENAME = N'D:\SQLData\EmpCon.mdf' , SIZE = 74752KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'EmpCon_log', FILENAME = N'D:\SQLLogs\EmpCon_log.ldf' , SIZE = 23616KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [EmpCon] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EmpCon].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EmpCon] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EmpCon] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EmpCon] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EmpCon] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EmpCon] SET ARITHABORT OFF 
GO
ALTER DATABASE [EmpCon] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EmpCon] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EmpCon] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EmpCon] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EmpCon] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EmpCon] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EmpCon] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EmpCon] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EmpCon] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EmpCon] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EmpCon] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EmpCon] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EmpCon] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EmpCon] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EmpCon] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EmpCon] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EmpCon] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EmpCon] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [EmpCon] SET  MULTI_USER 
GO
ALTER DATABASE [EmpCon] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EmpCon] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EmpCon] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EmpCon] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [EmpCon] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'EmpCon', N'ON'
GO
USE [EmpCon]
GO
/****** Object:  User [ecdbuser]    Script Date: 5/2/2018 1:28:35 PM ******/
CREATE USER [ecdbuser] FOR LOGIN [ecdbuser] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [ecdbuser]
GO
ALTER ROLE [db_datareader] ADD MEMBER [ecdbuser]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [ecdbuser]
GO
/****** Object:  UserDefinedFunction [dbo].[ufn_WordSplit]    Script Date: 5/2/2018 1:28:35 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		rcooke
-- Create date: 4/19/2012
-- Description:	Split a comma-delimited list into a table of individual values.
-- Note: this UDF was originally written by Taketo Ito to support student search
-- in the Advising Portal application.
-- =============================================
CREATE FUNCTION [dbo].[ufn_WordSplit] 
(
	@text varchar(1000), 
	@delimiter varchar(5) = ','
)
RETURNS 
@Strings TABLE 
(
	position int IDENTITY PRIMARY KEY, 
	value varchar(50)
)
AS
BEGIN
-- @index is used to find a delimiter pattern in @text so that we can substring each word
DECLARE @index int
SET @index = -1

WHILE (LEN(@text) > 0)

  BEGIN 

    SET @index = CHARINDEX(@delimiter , @text) -- get the occurrence of @delimiter in text

    IF (@index = 0) AND (LEN(@text) > 0) 
    BEGIN  -- String not found. End operation
        INSERT INTO @Strings VALUES (@text)
        BREAK 
    END 

    IF (@index > 1) 
      BEGIN  -- @delimiter found. Insert values found into table.
        INSERT INTO @Strings VALUES (LEFT(@text, @index - 1))  
        SET @text = RIGHT(@text, (LEN(@text) - @index)) 
      END 
    ELSE
      SET @text = RIGHT(@text, (LEN(@text) - @index))
    END

  RETURN

END -- END OF WHILE



GO
/****** Object:  Table [dbo].[tblContract]    Script Date: 5/2/2018 1:28:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblContract](
	[record_id] [bigint] IDENTITY(1,1) NOT NULL,
	[sid] [varchar](9) NULL,
	[yrq] [varchar](4) NULL,
	[apptNo] [varchar](2) NULL,
	[contractText] [varchar](max) NOT NULL,
	[insertTime] [datetime] NOT NULL,
	[updateTime] [datetime] NULL,
 CONSTRAINT [PK_tblContract] PRIMARY KEY CLUSTERED 
(
	[record_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblLogins]    Script Date: 5/2/2018 1:28:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLogins](
	[record_id] [bigint] IDENTITY(1,1) NOT NULL,
	[SID] [varchar](9) NOT NULL,
	[lastLogin] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[vw_Employee]    Script Date: 5/2/2018 1:28:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_Employee]
AS

SELECT e.SID, LastName + ', ' + FirstName as EMP_NAME, PIN as EMP_PIN
FROM ODS2.dbo.Employee e INNER JOIN ODS2.dbo.PIN p 
ON e.SID = p.SID


GO
/****** Object:  View [dbo].[vw_ContractReport]    Script Date: 5/2/2018 1:28:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_ContractReport]
AS
SELECT DISTINCT e.EMP_NAME, c.sid, c.yrq, c.apptNo, SUBSTRING(c.contractText, 0, 28) + '...' AS contractText, COALESCE (c.updateTime, c.insertTime) AS updatedOn
FROM dbo.tblContract AS c LEFT JOIN dbo.vw_Employee AS e ON c.sid = e.SID


GO
/****** Object:  View [dbo].[vw_YRQ]    Script Date: 5/2/2018 1:28:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_YRQ]
AS
SELECT YearQuarterID as YRQ, Title as ABBR_TITLE
FROM ODS2.dbo.YearQuarter


GO
ALTER TABLE [dbo].[tblContract] ADD  CONSTRAINT [DF_tblContract_insertTime]  DEFAULT (getdate()) FOR [insertTime]
GO
ALTER TABLE [dbo].[tblLogins] ADD  CONSTRAINT [DF_tblLogins_lastLogin]  DEFAULT (getdate()) FOR [lastLogin]
GO
/****** Object:  StoredProcedure [dbo].[usp_AuthenticateUser_vw_Employee]    Script Date: 5/2/2018 1:28:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		RCooke
-- Create date: 2-08-2012
-- Description:	Authenticate users
-- =============================================
CREATE PROCEDURE [dbo].[usp_AuthenticateUser_vw_Employee] 
(
	@UserName as varchar(50),
	@UserPassword as varchar(50),
	@IsAuthenticated as bit = 0 OUTPUT
)
AS
BEGIN

	SET NOCOUNT ON;

    IF EXISTS(SELECT SID FROM vw_Employee WHERE SID = @UserName AND EMP_PIN = HashBytes('SHA1', Cast(@UserPassword as varchar(6))))
	BEGIN
		SET @IsAuthenticated =  1
		INSERT INTO tblLogins (SID, lastLogin) VALUES (@UserName, GETDATE())	
	END
	ELSE
		SET @IsAuthenticated =  0
END



GO
/****** Object:  StoredProcedure [dbo].[usp_GetEmpList_vwEmployee]    Script Date: 5/2/2018 1:28:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		RCooke
-- Create date: 4-13-2012
-- Description:	Get a list of employees
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetEmpList_vwEmployee] 
AS
BEGIN

	SET NOCOUNT ON;

    SELECT DISTINCT SID, EMP_NAME
    FROM vw_Employee e
    WHERE EXISTS (SELECT 1 FROM tblContract c WHERE c.sid = e.SID)
    ORDER BY EMP_NAME
END

GO
/****** Object:  StoredProcedure [dbo].[usp_GetRecord_tblContract]    Script Date: 5/2/2018 1:28:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		RCooke
-- Create date: 2/6/2012
-- Description:	Retrieve the most recent contract for the specified employee.
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetRecord_tblContract] 
	@sid varchar(9)
AS
BEGIN

	SET NOCOUNT ON;
    
    SELECT record_id, sid, yrq, apptNo, SUBSTRING(contractText, 0, 18) + '...' as contractText, insertTime, updateTime
    FROM tblContract
    WHERE sid = @sid
    ORDER BY insertTime, yrq DESC
    
    
END

GO
/****** Object:  StoredProcedure [dbo].[usp_GetRecordByID_tblContract]    Script Date: 5/2/2018 1:28:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Rcooke
-- Create date: 2-7-2012
-- Description:	Get contract record by id
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetRecordByID_tblContract] 
	@request_id nvarchar(32)
AS
BEGIN

	SET NOCOUNT ON;
    
    SELECT TOP 1 record_id ,
                 sid ,
                 yrq ,
                 apptNo ,
                 contractText ,
                 insertTime ,
                 updateTime
	FROM [EmpCon].[dbo].[tblContract]
	WHERE CONVERT(NVARCHAR(32), HASHBYTES('MD5', sid + yrq + apptNo), 2) = @request_id
    
 --   IF @@ROWCOUNT = 0 --this was just for debugging
 --   BEGIN
	--	PRINT @request_id
	--END
    
END

GO
/****** Object:  StoredProcedure [dbo].[usp_GetSearchResults_vwContractReport]    Script Date: 5/2/2018 1:28:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		RCooke
-- Create date: 4-18-2012
-- Description:	Retrieve available records for specified SID and YRQ
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetSearchResults_vwContractReport]
	@sid varchar(1000) = NULL,
	@yrq varchar(1000) = NULL
AS
BEGIN

	SET NOCOUNT ON;

    SELECT EMP_NAME ,
           sid ,
           yrq ,
           apptNo ,
           contractText ,
           updatedOn
    FROM vw_ContractReport
    WHERE 1 = 1
    AND (@sid IS NULL OR sid IN (SELECT value FROM dbo.ufn_WordSplit(@sid, ',')))
    AND (@yrq IS NULL OR yrq IN (SELECT value FROM dbo.ufn_WordSplit(@yrq, ',')))
    ORDER BY EMP_NAME, yrq, apptNo
END

GO
/****** Object:  StoredProcedure [dbo].[usp_GetYRQList_vwYRQ]    Script Date: 5/2/2018 1:28:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		RCooke
-- Create date: 4-18-2012
-- Description:	Get list of all YRQs available in tblContract.
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetYRQList_vwYRQ] 
AS
BEGIN

	SET NOCOUNT ON;

    SELECT y.YRQ, ABBR_TITLE
    FROM vw_YRQ y
    WHERE EXISTS (SELECT 1 FROM tblContract c WHERE y.YRQ = c.yrq)
    ORDER BY y.YRQ desc
END

GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_tblContract]    Script Date: 5/2/2018 1:28:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		RCooke
-- Create date: 2/6/2012
-- Description:	Add a new contract record to the table.
-- =============================================
CREATE PROCEDURE [dbo].[usp_Insert_tblContract] 
	@sid varchar(9) = NULL,
	@yrq varchar(4) = NULL,
	@apptNo varchar(2) = NULL,
	@contractText varchar(MAX)
AS

IF (@sid IS NOT NULL)
BEGIN

	SET NOCOUNT ON;
	
	UPDATE tblContract
	SET contractText = @contractText,
	updateTime = GETDATE()
	WHERE sid = @sid
	AND yrq = @yrq
	AND apptNo = @apptNo
	
	IF @@ROWCOUNT = 0

    INSERT INTO tblContract (sid, yrq, apptNo, contractText)
    VALUES (@sid, @yrq, @apptNo, @contractText)  
END

ELSE
BEGIN
	INSERT INTO tblContract (sid, yrq, apptNo, contractText)
    VALUES (@sid, @yrq, @apptNo, @contractText)
END

GO

USE [master]
GO
ALTER DATABASE [EmpCon] SET  READ_WRITE 
GO
