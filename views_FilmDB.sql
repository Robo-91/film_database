create view v_Director
as
select count(*) as [Number of Films],round(avg(avg_vote),2) as [Average Rating],sum(votes) as [Total Votes]
	from DimDirector
	join fact_Film on DimDirector.director_id = fact_Film.director
	group by director