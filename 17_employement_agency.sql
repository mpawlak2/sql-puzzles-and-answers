use puzzles;

CREATE TABLE CandidateSkills
(candidate_id INTEGER NOT NULL,
skill_code CHAR(15) NOT NULL,
PRIMARY KEY (candidate_id, skill_code));


select cs.candidate_id
from CandidateSkills cs
where cs.skill_code in ('Airports', 'Chemicals')
group by cs.candidate_id
having count(cs.skill_code) = 2


-- TODO