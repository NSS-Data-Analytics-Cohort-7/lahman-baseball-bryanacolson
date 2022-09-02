--1
SELECT DISTINCT(yearid)
FROM teams;
--2
SELECT p.namegiven, p.height, a.G_all
FROM people as p 
INNER JOIN appearances as a
ON p.playerid = a.playerid
order by p.height ASC
LIMIT 1;

--3
SELECT DISTINCT(p.namegiven), s.schoolname, sa.salary
FROM collegeplaying as c
INNER JOIN schools s
on s.schoolid = c.schoolid
INNER JOIN people as  p
on s.schoolid = c.schoolid
INNER JOIN salaries as sa
on sa.playerid = p.playerid
WHERE s.schoolname = 'Vanderbilt University'
ORDER BY sa.salary DESC;
--4 
SELECT p.playerid, f.teamid, f.yearid, f.po,
CASE WHEN pos ILIKE '%OF%' THEN 'Outfield'
	WHEN pos ILIKE '%SS%' THEN 'Infield'
	WHEN pos ILIKE '%1B%' THEN 'Infield'
	WHEN pos ILIKE '%2B%' THEN 'Infield'
	WHEN pos ILIKE '%3b' THEN 'Infield'
	WHEN pos ILIKE '%P%' THEN 'Battery'
	WHEN pos ILIKE '%C%' THEN 'Battery'
	END as Position
from fielding as f
INNER JOIN people as p
on p.playerid = f.playerid
WHERE yearid = '2016'
GROUP BY f.pos, p.playerid, f.teamid, f.yearid, f.po
ORDER BY f.po DESC;



--5
SELECT AVG(p.so),
    COUNT(t.yearid),
    CONCAT(
        FLOOR(t.YEARid / 10) * 10, 
        '-', 
        (CEIL(t.YEARid / 10) * 10) - 1)
FROM teams as t
INNER JOIN pitching as p
ON p.yearid = t.yearid
GROUP BY
    CONCAT(
        FLOOR(t.YEARid / 10) * 10,
        '-', 
        (CEIL(t.YEARid / 10) * 10) - 1);
	
--6
SELECT COALESCE(b.sb / NULLIF(b.cs,0), 0 ), p.namegiven
FROM batting as b
INNER JOIN people as p
on p.playerid = b.playerid
GROUP BY b.sb, b.cs, p.namegiven
ORDER by coalesce DESC
LIMIT 1;

SELECT sb, cs, playerid,
CASE 
WHEN cs <> 0 THEN (sb/cs) ELSE 0 END
FROM batting
WHERE sb >= 20
GROUP BY sb, cs, playerid
ORDER by sb DESC;

select sb / nullif(cs, 0), playerid
from batting
WHERE (sb / nullif(cs,0)) >= 20
ORDER BY (sb / nullif(cs,0)) DESC;

--7a (largest wins)
Select yearid, w, teamid, wcwin
FROM teams
WHERE yearid BETWEEN '1970' and '2016'
ORDER by w DESC;

SELECT DISTINCT (yearid), w ,teamid, wcwin
FROM teams
WHERE yearid BETWEEN '1970' and '2016' and wcwin = 'Y' 
EXCEPT (Select yearid, w, teamid, wcwin from teams where yearid = '1995')
ORDER BY w ASC;

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
SELECT aw.playerid, COUNT(aw.awardid), p.namegiven
FROM awardsmanagers as aw
INNER JOIN people as p
ON p.playerid = aw.playerid
WHERE awardid = 'TSN Manager of the Year'
GROUP BY aw.playerid, aw.awardid, p.namegiven
ORDER BY COUNT(aw.playerid) DESC;
--9bish

SELECT (p.namegiven), aw.playerid, COUNT(aw.awardid), t.lgid
FROM awardsmanagers as aw
INNER JOIN people as p
ON p.playerid = aw.playerid
INNER JOIN managershalf as mh
ON p.playerid = mh.playerid
INNER JOIN teams as t
ON mh.yearid = t.yearid
WHERE awardid = 'TSN Manager of the Year'
GROUP BY aw.playerid, aw.awardid, t.lgid, p.namegiven
ORDER BY p.namegiven DESC;

SELECT p.namegiven, aw.playerid, COUNT(aw.awardid), t.lgid
FROM awardsmanagers as aw
INNER JOIN 
managershalf as mh
ON aw.playerid = mh.playerid
INNER JOIN teams as t
ON mh.yearid = t.yearid
INNER JOIN people as p
ON p.playerid = mh.playerid
WHERE aw.awardid = 'TSN Manager of the year'
GROUP BY aw.playerid, aw.awardid, t.lgid, p.namegiven
ORDER BY p.namegiven DESC;

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
Select DISTINCT(p.namegiven)/(COUNT(p.namegiven) p.throws, pp.so as perc
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
