use puzzles;

CREATE TABLE ServicesSchedule
(shop_id CHAR(3) NOT NULL,
order_nbr CHAR(10) NOT NULL,
sch_seq INTEGER NOT NULL CHECK (sch_seq IN (1,2,3)),
service_type CHAR(2) NOT NULL,
sch_date DATE,
PRIMARY KEY (shop_id, order_nbr, sch_seq));

insert into ServicesSchedule(shop_id, order_nbr, sch_seq, service_type, sch_date)
values
('002', 4155526710, 1, '01', '1994-07-16'),
('002', 4155526710, 2, '01', '1994-07-30'),
('002', 4155526710, 3, '01', '1994-10-01')

select s.shop_id, s.order_nbr, s2.sch_date as processed, s3.sch_date as completed, s4.sch_date as confirmed
from ServicesSchedule s
left join ServicesSchedule s2 on s.shop_id = s2.shop_id and s.order_nbr = s2.order_nbr and s2.sch_seq = 1
left join ServicesSchedule s3 on s.shop_id = s3.shop_id and s.order_nbr = s3.order_nbr and s3.sch_seq = 2
left join ServicesSchedule s4 on s.shop_id = s4.shop_id and s.order_nbr = s4.order_nbr and s4.sch_seq = 3

SELECT order_nbr,
(CASE WHEN sch_seq = 1
THEN sch_date
ELSE NULL END) AS processed,
(CASE WHEN sch_seq = 2
THEN sch_date
ELSE NULL END) AS completed,
(CASE WHEN sch_seq = 3
THEN sch_date
ELSE NULL END) AS confirmed
FROM ServicesSchedule
WHERE service_type = '01'
AND order_nbr = 4155526710;


select
	order_nbr, 
	max(case when sch_seq = 1 then sch_date else null end) as processed, 
	max(case when sch_seq = 2 then sch_date else null end) as completed,
	max(case when sch_seq = 3 then sch_date else null end) as confirmed
from ServicesSchedule
group by order_nbr, service_type