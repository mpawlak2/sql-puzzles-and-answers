use puzzles;

CREATE TABLE Pensions
(sin CHAR(10) NOT NULL,
pen_year INTEGER NOT NULL,
month_cnt INTEGER DEFAULT 0 NOT NULL
CHECK (month_cnt BETWEEN 0 AND 12),
earnings DECIMAL (8,2) DEFAULT 0.00 NOT NULL);

alter table pensions add constraint PK_penyear_sin primary key(sin, pen_year)

select *, (select isnull(sum(month_cnt), 0) from pensions pp where pp.sin = p.sin and pp.pen_year > p.pen_year) as monts_so_far
from pensions p
left join pensions p2 on p.sin = p2.sin and p.pen_year > p2.pen_year
order by p.sin, p.pen_year desc

create view pension_periods(sin, from_year, month_cnt, sixty_earnings)
as
select pensions_m.sin, pensions_m.pen_year, pensions_m.month_cnt, pensions_m.earningsT + (pensions_m.earnings / pensions_m.month_cnt) * (month_cnt - (monts_so_far - 60))
from(
select 
	p.sin, 
	p.pen_year, 
	max(p.month_cnt) month_cnt,
	max(p.month_cnt) + (select isnull(sum(pp.month_cnt), 0) from pensions pp where pp.sin = p.sin and pp.pen_year > p.pen_year) as monts_so_far, 
	(select isnull(sum(pp.earnings), 0) from pensions pp where pp.sin = p.sin and pp.pen_year > p.pen_year) earningsT,
	(select pp.earnings from pensions pp where pp.sin = p.sin and pp.pen_year = p.pen_year) earnings
from pensions p
left join pensions p2 on p.sin = p2.sin and p.pen_year > p2.pen_year
group by p.sin, p.pen_year
--order by p.sin, p.pen_year desc
) pensions_m
where (pensions_m.monts_so_far > 60) and (pensions_m.monts_so_far - pensions_m.month_cnt <= 60)


select * from pension_periods
