use puzzles;

CREATE TABLE DataFlowDiagrams
(diagram_name CHAR(10) NOT NULL,
bubble_name CHAR(10) NOT NULL,
flow_name CHAR(10) NOT NULL,
PRIMARY KEY (diagram_name, bubble_name, flow_name));


insert into DataFlowDiagrams(diagram_name, bubble_name, flow_name)
values ('Proc1', 'input', 'guesses'),
('Proc1', 'input', 'opinions'),
('Proc1', 'crunch', 'facts'),
('Proc1', 'crunch', 'guesses'),
('Proc1', 'crunch', 'opinions'),
('Proc1', 'output', 'facts'),
('Proc1', 'output', 'guesses'),
('Proc2', 'reckon', 'guesses'),
('Proc2', 'reckon', 'opinions')

select flow_name, count(bubble_name)
from DataFlowDiagrams
group by flow_name
having count(bubble_name) < (select count(distinct bubble_name) from DataFlowDiagrams)

