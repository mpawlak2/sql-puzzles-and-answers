use puzzles;

CREATE TABLE Projects
(workorder_id CHAR(5) NOT NULL,
step_nbr INTEGER NOT NULL CHECK (step_nbr BETWEEN 0 AND
1000),
step_status CHAR(1) NOT NULL
CHECK (step_status IN ('C', 'W')), -- complete, waiting
PRIMARY KEY (workorder_id, step_nbr));

-- example data from book
insert into Projects(workorder_id, step_nbr, step_status)
values	('AA100', 0, 'C'),
		('AA100', 1, 'W'),
		('AA100', 2, 'W'),
		('AA200', 0, 'W'),
		('AA200', 1, 'W'),
		('AA300', 0, 'C'),
		('AA300', 1, 'C')

-- it answers: how many statuses 'C' (or 'W') are there for workorder_id = whatever
create view statuses_number(no_status, step_status, workorder_id, step_nbr) 
as
select count(workorder_id) over(partition by workorder_id, step_status), step_status, workorder_id, step_nbr
from Projects


-- answer
select workorder_id from statuses_number where no_status = 1 and step_nbr = 0 and step_status = 'C'