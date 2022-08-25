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



