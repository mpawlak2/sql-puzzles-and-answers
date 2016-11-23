use puzzles;

create table machines
(machine_name char(20) not null primary key,
purchase_date date not null,
initial_cost decimal(10, 2) not null,
lifespan integer not null) -- Lifespan is expected lifespan of the equipment given in days.

-- Table of the cost of using a particular machine on a particular batch of work.
create table manufactcosts
(machine_name char(20) not null references machines(machine_name),
manu_date date not null,
batch_nbr integer not null,
manu_cost decimal(6, 2) not null,
manu_hrs decimal(4, 2) not null,
primary key (machine_name, manu_date, batch_nbr));

/* 
Your problem is to suggest a better design for the database. Then you
are to write a query that will give us the average hourly cost of each
machine to date for any day we choose.
*/

-- 1. Remove third table and put manu_hrs to manufactcosts since time is money.

create view total_hrs_costs(machine_name, total_cost, total_hrs, date)
as
select m.machine_name, 
	sum(mc.manu_cost), 
	sum(mc.manu_hrs),
	mc.manu_date
from machines m
left join manufactcosts mc on m.machine_name = mc.machine_name
group by m.machine_name, mc.manu_date


select 
	m.machine_name,
	m.initial_cost / m.lifespan * datediff(dd, m.purchase_date, getdate()) -- Amortized cost so far.
	+
	(select sum(thc.total_cost) / sum(thc.total_hrs) from total_hrs_costs thc where thc.machine_name = m.machine_name)
from machines m
