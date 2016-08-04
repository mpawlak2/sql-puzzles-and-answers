-- ensure a coulm will have single alphabetic-character-only string. No spaces, numbers, special characters

use puzzles;

drop table alpha_data;

create table alpha_data(alpha_data varchar(6) collate SQL_Latin1_General_CP1_CS_AS not null check(lower(alpha_data) between 'a' and 'z'))

insert into alpha_data(alpha_data) values('Aaa'), ('AAa'), ('aaa')

-- note: when used constraint check(lower(alpha_data) between 'aaaaaa' and 'zzzzzz') - value 'Aaa' was not valid, because it was less than 'aaaaaa' (6x'a')