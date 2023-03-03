﻿/*
Deployment script for MinimalAPIUserDB

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "MinimalAPIUserDB"
:setvar DefaultFilePrefix "MinimalAPIUserDB"
:setvar DefaultDataPath "C:\Users\Sam-D\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"
:setvar DefaultLogPath "C:\Users\Sam-D\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
/*
The column [dbo].[User].[Age] on table [dbo].[User] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.

The column [dbo].[User].[EmailAddress] on table [dbo].[User] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.
*/

IF EXISTS (select top 1 1 from [dbo].[User])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
PRINT N'Altering Table [dbo].[User]...';


GO
ALTER TABLE [dbo].[User]
    ADD [Age]          INT           NOT NULL,
        [EmailAddress] NVARCHAR (50) NOT NULL;


GO
PRINT N'Altering Procedure [dbo].[spUser_Get]...';


GO
ALTER PROCEDURE [dbo].[spUser_Get]
	@Id int
AS
begin
	select Id, FirstName, LastName, Age, EmailAddress
	from dbo.[User]
	where Id = @Id
end
GO
PRINT N'Altering Procedure [dbo].[SPUser_GetAll]...';


GO
ALTER PROCEDURE [dbo].[SPUser_GetAll]
AS
begin
	select Id, FirstName, LastName, Age, EmailAddress
	from dbo.[User]
end
GO
PRINT N'Altering Procedure [dbo].[spUser_Insert]...';


GO
ALTER PROCEDURE [dbo].[spUser_Insert]
	@FirstName nvarchar(50),
	@LastName nvarchar(50)
AS
begin
	insert into dbo.[User] (FirstName, LastName, Age, EmailAddress)
	values (@FirstName, @LastName);
end
GO
PRINT N'Altering Procedure [dbo].[spUser_Update]...';


GO
ALTER PROCEDURE [dbo].[spUser_Update]
	@Id int,
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@Age int,
	@EmailAddress nvarchar(50)
AS
begin
	update dbo.[User]
	set FirstName = @FirstName, LastName = @LastName, Age = @Age, EmailAddress = @EmailAddress
	where Id = @Id
end
GO
PRINT N'Refreshing Procedure [dbo].[spUser_Delete]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spUser_Delete]';


GO
if not exists (select 1 from dbo.[User])
begin
	insert into dbo.[User] (FirstName, LastName, Age, EmailAddress)
	values ('Tim', 'Corey', '50', 'asdfadsf@asdf'),
	('Sue', 'Storm', '50', 'asdfadsf@asdf'),
	('John', 'Smith', '50', 'asdfadsf@asdf'),
	('Mary', 'Jones', '50', 'asdfadsf@asdf');
end
GO

GO
PRINT N'Update complete.';


GO