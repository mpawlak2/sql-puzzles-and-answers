use puzzles;

CREATE TABLE TaxAuthorities
(tax_authority CHAR(10) NOT NULL,
tax_area CHAR(10) NOT NULL,
PRIMARY KEY (tax_authority, tax_area));

CREATE TABLE TaxRates
(tax_authority CHAR(10) NOT NULL,
effect_date DATE NOT NULL,
tax_rate DECIMAL (8,2) NOT NULL,
PRIMARY KEY (tax_authority, effect_date));

insert into TaxAuthorities(tax_authority, tax_area)
values('city1', 'city1'),
('city2', 'city2'),
('city3', 'city3'),
('county1', 'city1'),
('county1', 'city2'),
('county2', 'city3'),
('state1', 'city1'),
('state1', 'city2'),
('state1', 'city3')

insert into TaxRates(tax_authority, effect_date, tax_rate) 
values ('city1', '1993-01-01', 1.0),
('city1', '1994-01-01', 1.5),
('city2', '1993-09-01', 1.5),
('city2', '1994-01-01', 2.0),
('city2', '1995-01-01', 2.0),
('city3', '1993-01-01', 1.7),
('city3', '1993-07-01', 1.9),
('county1', '1993-01-01', 2.3),
('county1', '1994-10-01', 2.5),
('county1', '1995-01-01', 2.7),
('county2', '1993-01-01', 2.4),
('county2', '1994-01-01', 2.7),
('county2', '1995-01-01', 2.8),
('state1', '1993-01-01', 0.5),
('state1', '1994-01-01', 0.8),
('state1', '1994-07-01', 0.9),
('state1', '1994-10-01', 1.1)

alter view tax_rates_periods
as
select t.tax_authority, t.effect_date start_date, t2.effect_date end_date, isnull(t.tax_rate, t2.tax_rate) tax_rate
from TaxRates t
left join TaxRates t2 on t.tax_authority = t2.tax_authority and t2.effect_date = (select min(t3.effect_date) from TaxRates t3 where t3.tax_authority = t.tax_authority and t3.effect_date > t.effect_date)



declare @date date = '1994-11-01'

select sum(tax_rate) 
from tax_rates_periods
where @date between start_date and isnull(end_date, getdate())
and tax_authority in (select tax_authority
from TaxAuthorities
where tax_area = 'city2')