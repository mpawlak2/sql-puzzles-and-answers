use puzzles;

CREATE TABLE Salaries
(emp_name CHAR(10) NOT NULL,
sal_date DATE NOT NULL,
sal_amt DECIMAL (8,2) NOT NULL,
PRIMARY KEY (emp_name, sal_date));


INSERT INTO Salaries
VALUES ('Tom', '1996-06-20', 500.00),
('Tom', '1996-08-20', 700.00),
('Tom', '1996-10-20', 800.00),
('Tom', '1996-12-20', 900.00),
('Dick', '1996-06-20', 500.00),
('Harry', '1996-07-20', 500.00),
('Harry', '1996-09-20', 700.00);

select row_number() over(partition by emp_name order by sal_date desc), *
from salaries

create view max_sal_dates(emp_name, sal_date, sal_amt)
as
select s.emp_name, s.sal_date, s.sal_amt
from salaries s
where s.sal_date = (select max(s2.sal_date) from salaries s2 where s2.emp_name = s.emp_name)


select ms.emp_name, ms.sal_date as current_sal_date, ms.sal_amt as current_amt, ms2.sal_date as prev_date, ms2.sal_amt as prev_amt
from max_sal_dates ms
left join
	(select s.emp_name, s.sal_date, s.sal_amt
	from salaries s
	where s.sal_date = (select max(s2.sal_date) from salaries s2 where s2.emp_name = s.emp_name and s2.sal_date not in (select s3.sal_date from max_sal_dates s3 where s3.emp_name = s2.emp_name))) as ms2 on ms.emp_name = ms2.emp_name
