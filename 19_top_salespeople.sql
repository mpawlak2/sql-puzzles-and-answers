use puzzles;

CREATE TABLE SalesData
(district_nbr INTEGER NOT NULL,
sales_person CHAR(10) NOT NULL check (len(sales_person) > 0),
sales_id INTEGER NOT NULL,
sales_amt DECIMAL(5,2) NOT NULL check(sales_amt > 0));


select *
from (select row_number() over(partition by district_nbr order by sales_amt desc) top_rows, *
		from SalesData) tp
where tp.top_rows in (1,2,3)


-- books solution
SELECT *
FROM SalesData AS S0
WHERE s0.sales_amt IN (SELECT S1.sales_amt
FROM SalesData AS S1
WHERE S0.district_nbr = S1.district_nbr
AND S0.sales_amt <= S1.sales_amt
HAVING COUNT(*) <= 3)
ORDER BY S0.district_nbr, S0.sales_person, S0.sales_id,
S0.sales_amt;
