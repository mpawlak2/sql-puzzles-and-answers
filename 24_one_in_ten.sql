use puzzles;

CREATE TABLE MyTable
(keycol INTEGER NOT NULL,
f1 INTEGER NOT NULL,
f2 INTEGER NOT NULL,
f3 INTEGER NOT NULL,
f4 INTEGER NOT NULL,
f5 INTEGER NOT NULL,
f6 INTEGER NOT NULL,
f7 INTEGER NOT NULL,
f8 INTEGER NOT NULL,
f9 INTEGER NOT NULL,
f10 INTEGER NOT NULL);


select * 
from MyTable
where  (f1 > 0 and (f2 + f3 + f4 + f5 + f6 + f7 + f8 + f9 + f10) = 0)
	or (f2 > 0 and (f1 + f3 + f4 + f5 + f6 + f7 + f8 + f9 + f10) = 0)
	or (f3 > 0 and (f1 + f2 + f4 + f5 + f6 + f7 + f8 + f9 + f10) = 0)
	or (f4 > 0 and (f2 + f3 + f1 + f5 + f6 + f7 + f8 + f9 + f10) = 0)
	or (f5 > 0 and (f2 + f3 + f4 + f1 + f6 + f7 + f8 + f9 + f10) = 0)
	or (f6 > 0 and (f2 + f3 + f4 + f5 + f1 + f7 + f8 + f9 + f10) = 0)
	or (f7 > 0 and (f2 + f3 + f4 + f5 + f6 + f1 + f8 + f9 + f10) = 0)
	or (f8 > 0 and (f2 + f3 + f4 + f5 + f6 + f7 + f1 + f9 + f10) = 0)
	or (f9 > 0 and (f2 + f3 + f4 + f5 + f6 + f7 + f8 + f1 + f10) = 0)
	or (f10 > 0 and (f2 + f3 + f4 + f5 + f6 + f7 + f8 + f9 + f1) = 0)

select *
from MyTable
where sign(f1) + sign(f2) + sign(f3) + sign(f4) + sign(f5) + sign(f6) + sign(f7) + sign(f8) + sign(f9) + sign(f10) = 1


insert into MyTable(keycol, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10)
values(4, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0)

SELECT *
FROM MyTable
WHERE ((f1+1)*(f2+1)*(f3+1)*(f4+1)*(f5+1)*(f6+1)*(f7+1)*(f8+1)*(f9+1)*(f10+1) - 1) in (f1, f2, f3, f4, f5, f6, f7, f8, f9, f10) 
	and f1 + f2 + f3 + f4 + f5 + f6 + f7 + f8 + f9 + f10 > 0