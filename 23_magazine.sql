use puzzles;

CREATE TABLE Titles
(product_id INTEGER NOT NULL PRIMARY KEY,
magazine_sku INTEGER NOT NULL,
issn INTEGER NOT NULL,
issn_year INTEGER NOT NULL);

CREATE TABLE Newsstands
(stand_nbr INTEGER NOT NULL PRIMARY KEY,
stand_name CHAR(20) NOT NULL);

CREATE TABLE Sales
(product_id INTEGER NOT NULL REFERENCES Titles(product_id),
stand_nbr INTEGER NOT NULL REFERENCES
Newsstands(stand_nbr),
net_sold_qty INTEGER NOT NULL,
PRIMARY KEY(product_id, stand_nbr));


INSERT INTO Titles
VALUES (1, 12345, 1, 2006), (2, 2667, 1, 2006), (3, 48632,
1, 2006),
(4, 1107, 1, 2006), (5, 12345, 2, 2006), (6, 2667, 2,
2006),
(7, 48632, 2, 2006), (8, 1107, 2, 2006);

insert into Newsstands(stand_nbr, stand_name)
values (1, 'a'), (2, 'b'), (3, 'c'), (4, 'd')

INSERT INTO Sales VALUES (1, 1, 1);
INSERT INTO Sales VALUES (2, 1, 4);
INSERT INTO Sales VALUES (3, 1, 1);
INSERT INTO Sales VALUES (4, 1, 1);
INSERT INTO Sales VALUES (5, 1, 1);
INSERT INTO Sales VALUES (6, 1, 2);
INSERT INTO Sales VALUES (7, 1, 1);
-- stand 2 meets the criteria
INSERT INTO Sales VALUES (4, 2, 5);
INSERT INTO Sales VALUES (8, 2, 6);
INSERT INTO Sales VALUES (3, 2, 1);
-- stand 3 meets the criteria
INSERT INTO Sales VALUES (1, 3, 1);
INSERT INTO Sales VALUES (2, 3, 3);
INSERT INTO Sales VALUES (3, 3, 3);
INSERT INTO Sales VALUES (4, 3, 1);
INSERT INTO Sales VALUES (5, 3, 1);
INSERT INTO Sales VALUES (6, 3, 3);
INSERT INTO Sales VALUES (7, 3, 3);
-- stand 4
INSERT INTO Sales VALUES (1, 4, 1);
INSERT INTO Sales VALUES (2, 4, 1);
INSERT INTO Sales VALUES (3, 4, 4);
INSERT INTO Sales VALUES (4, 4, 1);
INSERT INTO Sales VALUES (5, 4, 1);
INSERT INTO Sales VALUES (6, 4, 1);
INSERT INTO Sales VALUES (7, 4, 2);

select * from Titles


create view avg_sales
as
select t.magazine_sku, s.stand_nbr, sum(s.net_sold_qty) / count(*) avg_qty
from Sales s
inner join Titles t on t.magazine_sku in (1107, 2667, 48632) and t.product_id = s.product_id
group by t.magazine_sku, s.stand_nbr


select abc.stand_nbr
from (
	select *, count(*) over (partition by stand_nbr) cnt
	from avg_sales a
	where (a.magazine_sku = 1107 and a.avg_qty >= 5) or (a.magazine_sku in (2667, 48632) and a.avg_qty >= 2)) as abc
where abc.magazine_sku = 1107 or abc.cnt = 2
group by abc.stand_nbr