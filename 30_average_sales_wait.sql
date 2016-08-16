use puzzles;


CREATE TABLE Sales2
(customer_name CHAR(5) NOT NULL,
sale_date DATE NOT NULL,
PRIMARY KEY (customer_name, sale_date));

insert into sales2(customer_name, sale_date)
values ('Fred', '1994-06-01'),
('Mary', '1994-06-01'),
('Bill', '1994-06-01'),
('Fred', '1994-06-02'),
('Bill', '1994-06-02'),
('Bill', '1994-06-03'),
('Bill', '1994-06-04'),
('Bill', '1994-06-05'),
('Bill', '1994-06-06'),
('Bill', '1994-06-07'),
('Fred', '1994-06-07'),
('Mary', '1994-06-08')

select sales_diff.customer_name, sum(sales_diff.datedif) / count(sales_diff.datedif)
from
	(select s.customer_name, s.sale_date startd, s2.sale_date stopd, datediff(dd, s.sale_date, s2.sale_date) datedif 
	from sales2 s
	left join sales2 s2 on s.customer_name = s2.customer_name and s2.sale_date = (select min(s3.sale_date) from sales2 s3 where s3.sale_date > s.sale_date and s3.customer_name = s.customer_name)
	where s2.sale_date is not null) as sales_diff
group by sales_diff.customer_name


SELECT customer_name, datediff(dd, MIN(sale_date), MAX(sale_date)) / (count(sale_date) - 1)
FROM Sales2
GROUP BY customer_name
HAVING COUNT(*) > 1;