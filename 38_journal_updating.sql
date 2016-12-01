use puzzles;
go


create table tx_journal (
	acct_nbr int not null,
	trx_date date not null,
	trx_amt decimal(10, 2) not null,
	duration int not null)
go

update t
set duration = 	isnull(datediff(day, t.trx_date, (select top 1 t2.trx_date from tx_journal t2 where t2.acct_nbr = t.acct_nbr and t2.trx_date > t.trx_date order by t2.trx_date asc)), 0)
from tx_journal t

select * from tx_journal