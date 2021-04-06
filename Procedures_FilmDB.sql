create procedure proc_AddGenre
(
	@newGenre varchar(50)
)
as
begin
	insert into DimGenre(genre_name)
	values(@newGenre);
end

create procedure proc_AddDirector
(
	@newDirector varchar(50)
)
as
begin
	insert into DimDirector(director_name)
	values(@newDirector);
end

create procedure proc_AddYear
(
	@newYear int
)
as
begin
	insert into DimYear(year_no)
	values(@newYear);
end

create procedure proc_AddCountry
(
	@newCountry varchar(50)
)
as
begin
	insert into DimCountry(country_name)
	values(@newCountry);
end

create procedure proc_AddMovie
(
	@newTitle varchar(50),
	@newYear int,
	@newGenre varchar(50),
	@newDuration int,
	@newCountry varchar(50),
	@newDirector varchar(50),
	@newActors varchar(100),
	@newAvgVote decimal(4,2),
	@votes int
)
as
begin
	begin try
		begin transaction
			-- if year already exists, grab the id and insert it into the year column
			-- if genre already exists, grab the id of that genre and insert it into the genre column
			-- if country already exists, grab the id and insert it into the country column
			-- if director already exists, grad id and insert it into the director column
			-- else for each column, insert the new value into the field and then grab that new id and insert into the movie table
		commit transaction
	end try
	begin catch
		rollback transaction
		print 'Error inserting Movie'
	end catch
end