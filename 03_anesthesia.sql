use puzzles;
create table procedures(id integer primary key, name varchar(300))

insert into procedures(id, name)
values(10, 'proc #10'), (20, 'proc #20'), (30, 'proc #30'), (40, 'proc #40'), (50, 'proc #50'), (60, 'proc #60'), (70, 'proc #70'), (80, 'proc #80')

create table surgeons(code char(10) primary key, full_name varchar(100))

-- drop table surgeries
-- delete from surgeries
create table surgeries(proc_id int not null references procedures(id), anest_name char(10) not null references surgeons(code), start_time smalldatetime not null, end_time smalldatetime not null)


-- create view with every event (1 = start, -1 = end)
-- drop view events
create view events(proc_id, comparison_proc, anest_name, event_time, state)
as
select s.proc_id, s2.proc_id, s.anest_name, s2.start_time, +1 
from surgeries s
join surgeries s2 on s.anest_name = s2.anest_name and not (s2.end_time <= s.start_time or s2.start_time >= s.end_time)
union
select s.proc_id, s2.proc_id, s.anest_name, s2.end_time, -1 as state
from surgeries s
join surgeries s2 on s.anest_name = s2.anest_name and not (s2.end_time <= s.start_time or s2.start_time >= s.end_time)


select e1.proc_id, (select sum(e2.state) from events e2 where e2.proc_id = e1.proc_id and e2.event_time < e1.event_time)
from events e1
order by e1.proc_id, e1.event_time
-------------------^ book solution

-- 1. sum event states (+1/-1) when event time < end_time
create view working_periods
as
select s1.proc_id, s2.proc_id compare_to, s1.start_time, s2.end_time
from surgeries s1, surgeries s2
where not (s2.start_time >= s1.end_time or s2.end_time <= s1.start_time) and s1.anest_name = s2.anest_name

select * from events

select wp.proc_id, wp.compare_to, (select sum(e.state) from events e where e.proc_id = wp.proc_id and e.event_time < wp.end_time)
from working_periods wp
order by wp.proc_id

select * from surgeries