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
()
as
begin
end