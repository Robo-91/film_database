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
	@newId int,
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
			set @newYear = (select year_no from DimYear where year_no = @newYear);
			set @newGenre = (select genre_name from DimGenre where genre_name = @newGenre);
			set @newCountry = (select country_name from DimCountry where country_name = @newCountry);
			set @newDirector = (select director_name from DimDirector where director_name = @newDirector);

			-- Variables for finding id's of each fields from dimension tables and for inserting into the fact_film table
			declare @yearId int = (select year_id from DimYear where year_no = @newYear);
			declare @genreId int = (select genre_id from DimGenre where genre_name = @newGenre);
			declare @countryId int = (select country_id from DimCountry where country_name = @newCountry);
			declare @directorId int = (select director_id from DimDirector where director_name = @newDirector);

			insert into fact_Film(filmtv_id,title,year,genre,duration,country,director,actors,avg_vote,votes)
			values(@newId,@newTitle,@yearId,@genreId,@newDuration,@countryId,@directorId,@newActors,@newAvgVote,@votes);
		commit transaction
	end try
	begin catch
		rollback transaction
		print 'Error inserting Movie'
	end catch
end


