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
CASE
	WHEN pos LIKE '%OF%' THEN 'Outfield'
	WHEN pos ILIKE '%SS%' THEN 'Infield'
	WHEN pos ILIKE '%1B%' THEN 'Infield'
	WHEN pos ILIKE '%2B%' THEN 'Infield'
	WHEN pos ILIKE '%3b' THEN 'Infield'
	WHEN pos ILIKE '%P%' THEN 'Battery'
	WHEN post ILIKE '%C%' THEN 'Battery
ELSE 'Other'
END AS fielding_table
from fielding;

--5
SELECT (AVG(t.so))
FROM teams as t
INNER JOIN appearances as a
ON a.yearid = t.yearid
INNER JOIN people as p
on p.playerid = a.playerid
GROUP BY p.namegiven;

--6
SELECT (AVG(f.sb)/AVG(f.cs))
FROM fielding as f
INNER JOIN people as p 
ON f.playerid = p.playerid;

--7a (largest wins)
Select yearid, w, teamid, wcwin
FROM teams
WHERE yearid BETWEEN '1970' and '2016'
ORDER by w DESC;

--8
SELECT (AVG(attendance/games)), h.team, p.park_name
FROM homegames as h
INNER JOIN parks as p
ON h.park = p.park
WHERE year = '2016'
GROUP BY h.team, p.park_name
ORDER BY (AVG(attendance/games))
LIMIT 5;

--9
SELECT aw.playerid, aw.awardid
FROM awardsmanagers as aw
INNER JOIN people as p
ON p.playerid = aw.playerid
WHERE awardid = 'TSN Manager of the Year'
GROUP BY aw.playerid, aw.awardid
ORDER BY COUNT(aw.playerid);
--9bish
SELECT aw.playerid, aw.awardid
FROM awardsmanagers as aw
INNER JOIN people as p
ON p.playerid = aw.playerid
WHERE awardid = 'TSN Manager of the Year'
GROUP BY aw.playerid, aw.awardid
ORDER BY COUNT(aw.playerid);




