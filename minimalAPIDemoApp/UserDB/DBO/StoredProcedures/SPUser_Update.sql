CREATE PROCEDURE [dbo].[spUser_Update]
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
