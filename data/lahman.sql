--1
SELECT yearid
FROM teams;
--2
SELECT namegiven, height
FROM people
order by height ASC
LIMIT 1;
--3
SELECT DISTINCT(p.namegiven), s.schoolid, p.playerid, s.schoolname
FROM collegeplaying as c
INNER JOIN schools s
on s.schoolid = c.schoolid
INNER JOIN people as  p
on s.schoolid = c.schoolid
WHERE s.schoolname = 'Vanderbilt University';
--4 
SELECT pos
from fielding;

--5
SELECT AVG(so)
FROM batting;

--6
SELECT (AVG(f.sb)/AVG(f.cs))
FROM fielding as f
INNER JOIN people as p 
ON f.playerid = p.playerid;

--7
SELECT 



