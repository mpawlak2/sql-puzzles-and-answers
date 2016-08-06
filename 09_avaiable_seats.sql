-- 1000 seats goal is to track 

create table taken_seats(seat_id integer primary key)

declare @startnum integer = 1
declare @endnum integer = 1000

-- recursive cte.
;with nrange as(
	select @startnum as number
	union all
	select number + 1 from nrange where number + 1 <= @endnum
)


select *
from nrange nr
where nr.number not in (select seat_id from taken_seats)
option (maxrecursion 1000) 


-- option?