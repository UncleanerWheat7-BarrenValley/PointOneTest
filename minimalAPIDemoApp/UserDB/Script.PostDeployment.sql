if not exists (select 1 from dbo.[User])
begin
	insert into dbo.[User] (FirstName, LastName, Age, EmailAddress)
	values ('Tim', 'Corey', '50', 'asdfadsf@asdf'),
	('Sue', 'Storm', '50', 'asdfadsf@asdf'),
	('John', 'Smith', '50', 'asdfadsf@asdf'),
	('Mary', 'Jones', '50', 'asdfadsf@asdf');
end
