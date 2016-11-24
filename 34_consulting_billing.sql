use puzzles;


create table consultants(
	emp_id int not null,
	emp_name char(10) not null)

insert into consultants(emp_id, emp_name)
values(1, 'Larry'), (2, 'Moe'), (3, 'Curly')

create table billings(
	emp_id int not null,
	bill_date date not null,
	bill_rate decimal(5, 2))

insert into billings
values (1, '1990-01-01', 25.00),
(2, '1989-01-01', 15.00),
(3, '1989-01-01', 20.00),
(1, '1991-01-01', 30.00)

create table hoursworked(
	job_id int not null,
	emp_id int not null,
	work_date date not null,
	bill_hrs decimal(5, 2))

insert into hoursworked
values (4, 1, '1990-07-01', 3),
(4, 1, '1990-08-01', 5),
(4, 2, '1990-07-01', 2),
(4, 1, '1991-07-01', 4)


/*
He wanted a single query that would show a list of names and total
charges for a given job. Total charges are calculated for each employee as
the hours worked multiplied by the applicable hourly billing rate. For
example, the sample data shown would give the following answer:

Results
name totalcharges
===================
'Larry' 320.00
'Moe' 30.00
*/

select * from consultants

select * from billings

select * from hoursworked

create view summary(name, total_charges)
as
select c.emp_name, sum(hw.bill_hrs) * BL.bill_rate
from hoursworked hw
left join consultants c on c.emp_id = hw.emp_id
cross apply (select b.bill_rate from billings b where b.emp_id = hw.emp_id and b.bill_date = (select max(b2.bill_date) from billings b2 where b2.emp_id = hw.emp_id and b2.bill_date < hw.work_date)) BL
group by hw.emp_id, c.emp_name, year(hw.work_date), BL.bill_rate

select name, sum(total_charges) as totalcharges
from summary
group by name


select 
	c.emp_name, sum(hw.bill_hrs * b.bill_rate)
from hoursworked hw, consultants c, billings b
where 
	c.emp_id = hw.emp_id 
	and c.emp_id = b.emp_id
	and b.bill_date = (select max(b2.bill_date) from billings b2 where b2.emp_id = b.emp_id and b2.bill_date <= hw.work_date)
group by c.emp_id, c.emp_name