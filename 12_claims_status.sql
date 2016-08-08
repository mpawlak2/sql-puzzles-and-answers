use puzzles;

create table claims(
	claim_id integer primary key, 
	patient_name varchar(100) not null)

create table defendants(
	claim_id integer not null references claims(claim_id),
	defendant_name varchar(100) not null,
	constraint pk_cid_dfnm primary key(claim_id, defendant_name))

create table claim_status_codes(
	claim_status char(2) primary key,
	claim_status_desc varchar(200) not null,
	claim_seq integer not null unique check(claim_seq > 0))

create table legal_events(
	claim_id integer not null,
	defendant_name varchar(100) not null,
	claim_status char(2) not null references claim_status_codes(claim_status),
	change_date date not null,
	constraint fk_cid_dfnm foreign key(claim_id, defendant_name) references defendants(claim_id, defendant_name))

alter table legal_events add constraint pk_le_cid_dfnm primary key (claim_id, defendant_name, claim_status)
alter table legal_events drop constraint pk_le_cid_dfnm 

-- example data from book
insert into claims(claim_id, patient_name)
values (10, 'smith'), (20, 'jones'), (30, 'brown')

insert into defendants(claim_id, defendant_name)
values (10, 'johnson'), (10, 'meyer'), (10, 'dow'), (20, 'baker'), (20, 'meyer'), (30, 'johnson')

insert into claim_status_codes(claim_status, claim_status_desc, claim_seq)
values	('AP', 'Awaiting review panel', 1),
		('OR', 'Panel opinion rendered', 2),
		('SF', 'Suit filed', 3),
		('CL', 'Closed', 4)

insert into legal_events(claim_id, defendant_name, claim_status, change_date)
values	(10, 'johnson', 'AP', '1994-01-01'),
		(10, 'johnson', 'OR', '1994-02-01'),
		(10, 'johnson', 'SF', '1994-03-01'),
		(10, 'johnson', 'CL', '1994-04-01'),
		(10, 'meyer', 'AP', '1994-01-01'),
		(10, 'meyer', 'OR', '1994-02-01'),
		(10, 'meyer', 'SF', '1994-03-01'),
		(10, 'dow', 'AP', '1994-01-01'),
		(10, 'dow', 'OR', '1994-02-01'),
		(20, 'meyer', 'AP', '1994-01-01'),
		(20, 'meyer', 'OR', '1994-02-01'),
		(20, 'baker', 'AP', '1994-01-01'),
		(30, 'johnson', 'AP', '1994-01-01')


create view claims_seq(claim_id, defendant_name, seq)
as
select le.claim_id, le.defendant_name, max(css.claim_seq) seq
from legal_events le
left join claim_status_codes css on le.claim_status = css.claim_status
group by le.claim_id, le.defendant_name



-- answer
select c.claim_id, c.patient_name, css.claim_status
from claims c
left join	(select claim_id, min(seq) seq
			from claims_seq
			group by claim_id) as cs on c.claim_id = cs.claim_id
left join claim_status_codes css on css.claim_seq = cs.seq