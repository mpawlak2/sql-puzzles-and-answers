use puzzles;

CREATE TABLE TestResults
(test_name CHAR(20) NOT NULL,
test_step INTEGER NOT NULL check (test_step > 0),
comp_date DATE, -- null means incomplete
PRIMARY KEY (test_name, test_step));

-- we want all the test that have been completed

insert into TestResults(test_name, test_step, comp_date)
values ('aba', 1, getdate()),
		('aba', 2, getdate()), 
		('aba', 3, getdate()),
		('aba2', 1, getdate()),
		('aba2', 2, null),
		('aba2', 3, getdate())


select *
from TestResults
where test_name not in (select tr.test_name from TestResults tr where tr.comp_date is null)

select test_name
from TestResults
group by test_name
having count(*) = count(comp_date)


-- how complete a task is
select test_name, count(*) as total_tasks, count(comp_date) as completed_tasks
from TestResults
group by test_name
having count(*) <> count(comp_date)