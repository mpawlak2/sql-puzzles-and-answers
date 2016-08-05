use puzzles;


-- from book
create table portfolios(fid integer primary key, creation_date date not null, portfolio_id integer not null references portfolios(fid));
drop table portfolios
-- we can track changing files in groups meaning:
-- add orginal file with group = 1, next orginal files will take groups 2, 3, 4, etc.
-- when you add new file to group 1 just retain that information
-- lookup newest file by date
create table portfolios(fid integer primary key, issue_date smalldatetime not null, portfolio_instance integer not null, constraint positive check (portfolio_instance > 0))

select max(fid), max(issue_date) from portfolios
group by portfolio_instance

-- nested sets