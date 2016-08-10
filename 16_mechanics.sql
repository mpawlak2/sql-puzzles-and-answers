use puzzles;

CREATE TABLE Jobs
(job_id INTEGER NOT NULL PRIMARY KEY,
start_date DATE NOT NULL);

-- there is already personnel table

CREATE TABLE Teams
(job_id INTEGER NOT NULL,
mech_type INTEGER NOT NULL,
emp_id INTEGER NOT NULL,
constraint fk_teams_personnel foreign key(emp_id) references personnel(emp_id),
constraint fk_teams_jobs foreign key(job_id) references jobs(job_id),
constraint pk_teams primary key(job_id, emp_id, mech_type),
constraint valid_mech_type check(mech_type in (0,1)));



select j.job_id, j.start_date, t.emp_id as primary_mechanic, t2.emp_id as assistant_mechanic
from jobs j
left join teams t on t.job_id = j.job_id and t.mech_type = 1
left join teams t2 on t2.job_id = j.job_id and t2.mech_type = 0