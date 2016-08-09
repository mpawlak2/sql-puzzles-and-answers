use puzzles;

-- personnel is already created.

CREATE TABLE Phones
(emp_id INTEGER NOT NULL,
phone_type CHAR(3) NOT NULL
CHECK (phone_type IN ('hom', 'fax')),
phone_nbr CHAR(12) NOT NULL,
PRIMARY KEY (emp_id, phone_type),
FOREIGN KEY (emp_id) REFERENCES Personnel(emp_id));

select * 
from personnel pr
left join Phones ph on ph.emp_id = pr.emp_id and ph.phone_type = 'fax'


-- 2 rows per emp_id
select prn.emp_id
from personnel prn, (select phone_type from Phones group by phone_type) a
left join phones ph on ph.emp_id = prn.emp_id and a.phone_type = ph.phone_type
-- using joins


-- below is wrong
select min(phn.phone_nbr) over (partition by both_ph.emp_id order by both_ph.phone_type), *
from (select pr.emp_id, pr.name, pt.phone_type
	 from personnel pr, (select phone_type from Phones group by phone_type) pt) both_ph
left join Phones phn on phn.emp_id = both_ph.emp_id and phn.phone_type = both_ph.phone_type

-- #2 - done
select prn.emp_id, prn.name, ph.phone_nbr as fax, ph2.phone_nbr as hom
from personnel prn
left join Phones ph on ph.emp_id = prn.emp_id and ph.phone_type = 'fax'
left join Phones ph2 on ph2.emp_id = prn.emp_id and ph2.phone_type = 'hom'