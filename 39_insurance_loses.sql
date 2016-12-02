use puzzles;
go


create table losses (
	cust_nbr int not null primary key,
	a int,
	b int,
	c int,
	d int,
	e int,
	f int,
	g int,
	h int,
	i int,
	j int,
	k int,
	l int,
	m int,
	n int,
	o int)
go

insert into losses
values (99, 5, 10, 15, NULL, NULL, NULL,
NULL, NULL, NULL, NULL, NULL,
NULL, NULL, NULL, NULL)
go

create table policy_criteria (
	criteria_id int not null,
	criteria char(1) not null,
	crit_val int not null,
	constraint PK_PC primary key(criteria_id, criteria, crit_val))
go