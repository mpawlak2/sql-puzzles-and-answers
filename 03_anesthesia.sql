use puzzles;
create table procedures(id integer primary key, name varchar(300))

insert into procedures(id, name)
values(10, 'proc #10'), (20, 'proc #20'), (30, 'proc #30'), (40, 'proc #40'), (50, 'proc #50'), (60, 'proc #60'), (70, 'proc #70'), (80, 'proc #80')

create table surgeons(code char(10) primary key, full_name varchar(100))

-- drop table surgeries
-- delete from surgeries
create table surgeries(proc_id int not null references procedures(id), anest_name char(10) not null references surgeons(code), start_time smalldatetime not null, end_time smalldatetime not null)


-- create view with every event (1 = start, -1 = end)
create view events
as
select proc_id, anest_name, 1 as event_type, start_time as event_time from surgeries
union
select proc_id, anest_name, -1, end_time from surgeries


-- assuming proc_id is unique
select 
	ee.proc_id, 
	(select count(proc_id) from events ev where ev.event_time >= min(ee.event_time) and ev.event_time <= max(ee.event_time) and ev.proc_id <> ee.proc_id order by) 
from events ee
group by proc_id

