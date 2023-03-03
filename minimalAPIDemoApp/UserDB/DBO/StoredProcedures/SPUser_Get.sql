CREATE PROCEDURE [dbo].[spUser_Get]
	@Id int
AS
begin
	select Id, FirstName, LastName, Age, EmailAddress
	from dbo.[User]
	where Id = @Id
end
