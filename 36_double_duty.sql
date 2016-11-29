use puzzles;

create table roles(
	person varchar(50) not null,
	role char(1) not null,
	constraint CK_DICT_ROLE check (role in ('O', 'D', 'X')))




insert into roles(person, role)
values ('Smith', 'O'), ('Smith', 'D'), ('Jones', 'O'), ('White', 'D'), ('Brown', 'X')

/*
	Result
	person combined_role
	=====================
	'Smith' 'B'
	'Jones' 'O'
	'White' 'D'
*/



select person, case when count(role) = 2 then 'B' else max(role) end as combined_role
from roles 
where role in ('O', 'D')
group by person