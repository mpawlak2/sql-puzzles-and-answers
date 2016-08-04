use puzzles;

select * from personnel

-- badges table - active with 0/1 value
create table security_badges(
	badge_id integer primary key, 
	emp_id integer not null references personnel(emp_id), 
	issue_date smalldatetime not null,
	active tinyint not null default(0),
	constraint valid_active check (active in (0, 1))
	);

-- mark last issued badges as active
update security_badges
set active = 0

update sb
set sb.active = 1
from security_badges sb
where sb.issue_date = (select max(sb2.issue_date) from security_badges sb2 where sb2.emp_id = sb.emp_id)

select * from security_badges where active = 1