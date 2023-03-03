CREATE PROCEDURE [dbo].[SPUser_GetAll]
AS
begin
	select Id, FirstName, LastName, Age, EmailAddress
	from dbo.[User]
end
