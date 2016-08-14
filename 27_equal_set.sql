use puzzles;

CREATE TABLE SupParts
(sno CHAR(2) NOT NULL,
pno CHAR(2) NOT NULL,
PRIMARY KEY (sno, pno));

insert into SupParts(sno, pno)
values
('ab', 'a1'),
('ab', 'a2'),
('ab', 'a3'),
('ac', 'a1'),
('ac', 'a3'),
('bb', 'a1'),
('bb', 'a2'),
('bb', 'a3')

create view pcount
as
select s1.sno, count(*) as pcnt
from SupParts s1
group by s1.sno


select s1.sno
from SupParts s1, SupParts s2
where s1.sno <> s2.sno and s1.pno = s2.pno and 
	s1.sno in (	select p.sno
					from pcount p
					where p.pcnt in (select pcnt from pcount p2 where p2.sno <> p.sno))
	and s2.sno in (	select p.sno
					from pcount p
					where p.pcnt in (select pcnt from pcount p2 where p2.sno <> p.sno))
group by s1.sno
having count(s2.sno) = (select pcnt from pcount p where p.sno = s1.sno)