use puzzles;



-- timestamp when to use?


create table samples(
	sample_time datetime2 not null,
	load real not null,
	constraint PK_SAMPLES primary key(sample_time));


-- Get average
select 
	*, 
	(	select avg(s2.load) 
		from samples s2 
		where 
			convert(date, s.sample_time) = convert(date, s2.sample_time) 
			and abs(datediff(minute, s.sample_time, s2.sample_time)) < 60)
from samples s