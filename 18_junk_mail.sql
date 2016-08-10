use puzzles;

create table consumers(
	con_name char(30) not null check(len(con_name) > 2),
	address char(1) not null check(len(address) = 1),
	con_id integer not null unique check(con_id > 0),
	fam integer);

-- puzzle says to delete all rows with fam is null but why shouldnt we do this the other way around
-- that way we delete only where fam is not null -> leaves us with only separate families
delete from consumers where fam is not null


-- or as stated in puzzle
delete from consumers where con_id in (select fam from consumers where fam is not null)

