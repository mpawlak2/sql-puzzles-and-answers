-- book's query
CREATE TABLE Hotel
(room_nbr INTEGER NOT NULL,
arrival_date DATE NOT NULL,
departure_date DATE NOT NULL,
guest_name CHAR(30) NOT NULL,
PRIMARY KEY (room_nbr, arrival_date),
CHECK (departure_date >= arrival_date));

-- goal is to prevent double reservations
create procedure add_reservation
	@room_number integer,
	@arrival_date date,
	@departure_date date,
	@guest_name char(30)
as
	if exists(select * from hotel where room_nbr = @room_number and @arrival_date between arrival_date and departure_date)
		raiserror('Could not create reservation', 16, 1) with seterror
	else
	 insert into Hotel(room_nbr, arrival_date, departure_date, guest_name)
	 values (@room_number, @arrival_date, @departure_date, @guest_name)
go

exec add_reservation
	@room_number = 1,
	@arrival_date = '1959-12-29',
	@departure_date = '1959-12-30',
	@guest_name = 'Dracula'

	select * from Hotel