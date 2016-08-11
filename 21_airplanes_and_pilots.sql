use puzzles;

CREATE TABLE PilotSkills
(pilot CHAR(15) NOT NULL,
plane CHAR(15) NOT NULL,
PRIMARY KEY (pilot, plane));

INSERT INTO PilotSkills
VALUES ('Celko', 'Piper Cub'),
('Higgins', 'B-52 Bomber'),
('Higgins', 'F-14 Fighter'),
('Higgins', 'Piper Cub'),
('Jones', 'B-52 Bomber'),
('Jones', 'F-14 Fighter'),
('Smith', 'B-1 Bomber'),
('Smith', 'B-52 Bomber'),
('Smith', 'F-14 Fighter'),
('Wilson', 'B-1 Bomber'),
('Wilson', 'B-52 Bomber'),
('Wilson', 'F-14 Fighter'),
('Wilson', 'F-17 Fighter');

CREATE TABLE Hangar
(plane CHAR(15) PRIMARY KEY);

INSERT INTO Hangar
VALUES ('B-1 Bomber'),
('B-52 Bomber'),
('F-14 Fighter');

-- who can fly every plane in hangar?
select p.pilot 
from PilotSkills p
inner join Hangar h on p.plane = h.plane
group by pilot
having count(*) = (select count(*) from Hangar)