-- create database puzzles;
use puzzles;

create table fiscalYear(
	fiscal_year integer primary key,
	start_date date not null unique,
	end_date date not null unique,
	constraint valid_dates check (start_date < end_date),
	constraint valid_years check (year(start_date) + 1 = year(end_date)),
	constraint valid_day check(dateadd(dd, -1, start_date) = dateadd(year, -1, end_date)))

insert into fiscalYear(fiscal_year, start_date, end_date)
values(1, '2015-08-01', '2016-07-31')

insert into fiscalYear(fiscal_year, start_date, end_date)
values(2, '2016-08-02', '2017-07-31') -- conflict with valid_day constraint



