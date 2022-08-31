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
SELECT p.playerid, f.teamid, f.yearid, f.po,
CASE WHEN pos ILIKE '%OF%' THEN 'Outfield'
	WHEN pos ILIKE '%SS%' THEN 'Infield'
	WHEN pos ILIKE '%1B%' THEN 'Infield'
	WHEN pos ILIKE '%2B%' THEN 'Infield'
	WHEN pos ILIKE '%3b' THEN 'Infield'
	WHEN pos ILIKE '%P%' THEN 'Battery'
	WHEN pos ILIKE '%C%' THEN 'Battery'
	END
from fielding as f
INNER JOIN people as p
on p.playerid = f.playerid
WHERE yearid = '2016'
GROUP BY f.pos, p.playerid, f.teamid, f.yearid, f.po
ORDER BY f.po DESC;

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
SELECT aw.playerid, COUNT(aw.awardid)
FROM awardsmanagers as aw
INNER JOIN people as p
ON p.playerid = aw.playerid
WHERE awardid = 'TSN Manager of the Year'
GROUP BY aw.playerid, aw.awardid
ORDER BY COUNT(aw.playerid) DESC;
--9bish

SELECT aw.playerid, COUNT(aw.awardid), t.lgid
FROM awardsmanagers as aw
INNER JOIN people as p
ON p.playerid = aw.playerid
INNER JOIN managershalf as mh
ON p.playerid = mh.playerid
INNER JOIN teams as t
ON mh.yearid = t.yearid
WHERE awardid = 'TSN Manager of the Year'
GROUP BY aw.playerid, aw.awardid, t.lgid
ORDER BY COUNT(aw.playerid) DESC;

--10
select playerid, yearid, h
FROM batting
ORDER by h DESC;

---11
SELECT t.w, s.salary
FROM salaries as s
INNER JOIN managers as m
on s.yearid = m.yearid
INNER JOIN teams as t
ON m.yearid=t.yearid
INNER JOIN managershalf as mh
ON  mh.yearid = t.yearid
INNER JOIN people as p
on p.playerid= mh.playerid
GROUP by s.salary, t.w
ORDER by s.salary;

SELECT s.salary, s.playerid, t.w, t.teamid, p.namegiven
FROM salaries as s
INNER JOIN teams as t
ON t.yearid = s.yearid
INNER JOIN people as p
ON s.playerid = p.playerid
GROUP by s.salary, t.teamid, t.w, s.playerid, p.namegiven
ORDER by s.salary DESC;

--12 A)
SELECT DISTINCT(ghome), t.attendance, t.w, hg.team
FROM teams as t
INNER JOIN homegames as hg
ON t.attendance = hg.attendance


--13
Select p.throws, pp.so, COUNT(DISTINCT p.namegiven)/(SELECT COUNT (DISTINCT p.namegiven)) as perc
FROM people p
INNER JOIN pitching as pp
on p.playerid= pp.playerid
WHERE p.throws = 'L'
GROUP BY p.throws, pp.so, p.namegiven
ORDER BY pp.so DESC;

Select p.throws, pp.so, p.namegiven
FROM people p
INNER JOIN pitching as pp
on p.playerid= pp.playerid
WHERE so >= '300'
GROUP BY p.throws, pp.so, p.namegiven
ORDER BY pp.so DESC
;
