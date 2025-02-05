use [film_DB]
go

CREATE NONCLUSTERED INDEX [_dta_index_fact_Film_22_338100245__K7_K4_K3_K6_2_5_8_9_10] ON [dbo].[fact_Film]
(
	[director] ASC,
	[genre] ASC,
	[year] ASC,
	[country] ASC
)
INCLUDE([title],[duration],[actors],[avg_vote],[votes]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
go

CREATE STATISTICS [_dta_stat_338100245_3_4] ON [dbo].[fact_Film]([year], [genre])
go

CREATE STATISTICS [_dta_stat_338100245_6_4_3] ON [dbo].[fact_Film]([country], [genre], [year])
go

