use puzzles;

CREATE TABLE Register
(course_nbr INTEGER NOT NULL,
student_name CHAR(10) NOT NULL,
teacher_name CHAR(10) NOT NULL);

select course_nbr, student_name, min(teacher_name) teacher_one, case count(teacher_name) when 2 then max(teacher_name) when 1 then null else '--more--' end
from Register
group by course_nbr, student_name
order by course_nbr asc