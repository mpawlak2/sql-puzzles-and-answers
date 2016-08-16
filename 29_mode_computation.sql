use puzzles;

CREATE TABLE Payroll
(check_nbr INTEGER NOT NULL PRIMARY KEY,
check_amt DECIMAL(8,2) NOT NULL);

select check_amt
from Payroll
group by check_amt
having count(check_nbr) = (select max(a.cnt) from (select count(check_nbr) cnt from Payroll group by check_amt) a)

select *, count(check_nbr) over (partition by check_amt order by check_amt)
from Payroll