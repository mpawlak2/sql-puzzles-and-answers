use puzzles;

create table printers(id integer primary key identity(1,1), description varchar(500) not null)


create table users_printers(user_id integer not null references personnel(emp_id), printer_id integer not null references printers(id), constraint unique_ppl unique(user_id, printer_id))

-- if user can use more than 1 printer -> use one with less
create table printer_control(
		printer_id integer primary key references printers(id), 
		daily_uses integer not null, 
		user_id integer references personnel(emp_id), 
		in_use tinyint not null default(0) check (in_use in (0,1)))

insert into printer_control(printer_id, daily_uses, user_id, in_use)
select p.id, 0, null, 0 from printers p

select * from printer_control

--create
alter procedure print_document	
	@user_id integer
as
	declare @user_printer integer 
	;with cte_printers as (select up.printer_id from users_printers up where up.user_id = @user_id)
	
	select @user_printer = min(cp.printer_id) from cte_printers cp
	inner join printer_control pc on pc.printer_id = cp.printer_id and pc.in_use = 0
	group by daily_uses
	having pc.daily_uses = (select min(pc2.daily_uses) from printer_control pc2 where pc2.printer_id in (select cp2.printer_id from cte_printers cp2))

	if @user_printer is null
		raiserror('All printers are currently in use or you have no permissions - try later', 16, 1) with seterror

	update printer_control
	set daily_uses = daily_uses + 1,
		user_id = @user_id,
		in_use = 1
	where printer_id = @user_printer

	update printer_control
	set	in_use = 0
	where printer_id = @user_printer
go

insert into users_printers(user_id, printer_id)
values (7, 1), (7, 2), (7, 3), (7, 4), (7, 5), (7, 6), (7, 7)



exec print_document @user_id = 7

select * from printer_control
select * from users_printers

