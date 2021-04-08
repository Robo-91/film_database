create view v_Director
as
select director_name as [Director Name],
	   count(*) as [Number of Films],
	   cast(round(avg(avg_vote),2) as decimal(4,2)) as [Average Rating],
	   sum(votes) as [Total Votes]
	from DimDirector
	join fact_Film on DimDirector.director_id = fact_Film.director
	group by director_name;

create view v_Genre
as
select  genre_name as [Genre], 
		count(title) as [Film Count],
		sum(votes) [Total Votes],
		cast(round(avg(avg_vote),2)as decimal(4,2)) as [Average Rating]
	from DimGenre
	join fact_Film on DimGenre.genre_id = fact_Film.genre
	group by genre_name;

create view v_Country
as
select	country_name as [Name of Country],
		count(title) as [Movie Count],
		sum(votes) as [Total Votes],
		cast(round(avg(avg_vote),2)as decimal(4,2)) as [Average Rating]
	from DimCountry
	join fact_Film on DimCountry.country_id = fact_Film.country
	group by country_name;
		
create view v_Year
as
select	year_no as [Year],
		count(title) as [Movie Count],
		sum(votes) as [Total Votes],
		cast(round(avg(avg_vote),2)as decimal(4,2)) as [Average Rating]
	from DimYear
	join fact_Film on DimYear.year_id = fact_Film.year
	group by year_no;

create view v_Movie_Info
as
select	title as [Film Title],
		year_no as [Year Released],
		genre_name as [Film Genre],
		duration as Duration,
		country_name as [Location(s)],
		director_name as [Director(s)],
		actors as [Cast],
		cast(avg_vote as decimal(4,2)) as [Average Vote],
		votes as [Total Votes]
	from fact_Film
	join DimYear on fact_Film.year = DimYear.year_id
	join DimGenre on fact_Film.genre = DimGenre.genre_id
	join DimCountry on fact_Film.country = DimCountry.country_id
	join DimDirector on fact_Film.director = DimDirector.director_id
		where title is not null;