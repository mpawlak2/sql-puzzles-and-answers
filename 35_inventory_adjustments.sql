use puzzles;

create table inventoryadjustments(
	req_date date not null,
	req_qty int not null check(req_qty <> 0),
	constraint PK_IA primary key (req_date, req_qty))

/*
	Your job is to provide a running balance on the quantity-on-hand as
	an SQL column. Your results should look like this:
	Warehouse
	req_date req_qty onhand_qty
	================================
	'1994-07-01' 100 100
	'1994-07-02' 120 220
	'1994-07-03' -150 70
	'1994-07-04' 50 120
	'1994-07-05' -35 85
*/

select 
	i.req_date, 
	sum(i.req_qty) as req_qty,
	sum(i.req_qty) + (select isnull(sum(i2.req_qty), 0) from inventoryadjustments i2 where i2.req_date < i.req_date)
from inventoryadjustments i
group by i.req_date
order by i.req_date
