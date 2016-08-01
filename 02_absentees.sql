use puzzles;

create table personnel(emp_id integer primary key, name varchar(100) not null)
create table excuselist(reason_code char(40) primary key, description varchar(200) not null)

-- drop table absenteeism;
CREATE TABLE Absenteeism
(emp_id INTEGER NOT NULL REFERENCES Personnel (emp_id),
absent_date DATE NOT NULL,
reason_code CHAR (40) NOT NULL REFERENCES ExcuseList
(reason_code),
severity_points INTEGER NOT NULL CHECK (severity_points
BETWEEN 0 AND 4), -- changed to 0 so that we can track long term absenteeism
PRIMARY KEY (emp_id, absent_date));

-- example data
insert into dbo.personnel(emp_id, name)
values(1, 'bob'), (2, 'paul')

insert into dbo.excuselist(reason_code, description)
values('bhd', 'bad hair day'), ('sick', 'illness'), ('ltr', 'long term illness')

delete from Absenteeism
insert into Absenteeism(emp_id, absent_date, reason_code, severity_points)
values(1, DATEADD(dd, -5, getdate()), 'bhd', 2), (1, DATEADD(dd, -4, getdate()), 'bhd', 2), (1, DATEADD(dd, -3, getdate()), 'bhd', 2), (1, DATEADD(dd, -2, getdate()), 'bhd', 2)
-- / example data


select * from Absenteeism

-- update long term absenteeism (using self join)
update ab
set ab.reason_code = 'ltr',
	ab.severity_points = 0
from absenteeism ab
join Absenteeism a2 on ab.emp_id = a2.emp_id and ab.absent_date = dateadd(dd, +1, a2.absent_date)

select emp_id from Absenteeism group by emp_id having sum(severity_points) > 40