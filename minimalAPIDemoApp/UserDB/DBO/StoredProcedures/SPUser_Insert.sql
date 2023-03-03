CREATE PROCEDURE [dbo].[spUser_Insert]
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@Age int,
	@EmailAddress nvarchar(50)
AS
begin
	insert into dbo.[User] (FirstName, LastName, Age, EmailAddress)
	values (@FirstName, @LastName,@Age, @EmailAddress);
end
