CREATE VIEW winsDisagree AS
SELECT t.teamID, t.name, t.totalWins, COUNT (*) as computedWins
FROM Teams t, Games g
WHERE t.teamID = g.homeTeam
AND g.homePoints > g.visitorPoints
GROUP BY t.teamID, t.name, t.totalWins
HAVING COUNT(*) <> t.totalWins

	UNION ALL

SELECT t.teamID, t.name, t.totalWins, COUNT (*) as computedWins
FROM Teams t, Games g
WHERE t.teamID = g.visitorTeam
AND g.homePoints < g.visitorPoints
GROUP BY t.teamID, t.name, t.totalWins
HAVING COUNT(*) <> t.totalWins;

CREATE VIEW lossesDisagree AS
SELECT t.teamID, t.name, t.totalLosses, COUNT (*) as computedLosses
FROM Teams t, Games g
WHERE t.teamID = g.homeTeam
AND g.homePoints < g.visitorPoints
AND g.homePoints is NOT NULL
AND g.visitorPoints is NOT NULL
GROUP BY t.teamID, t.name, t.totalLosses
HAVING COUNT(*) <> t.totalLosses

	UNION ALL

SELECT t.teamID, t.name, t.totalLosses, COUNT (*) as computedLosses
FROM Teams t, Games g
WHERE t.teamID = g.visitorTeam
AND g.homePoints > g.visitorPoints
AND g.homePoints is NOT NULL
AND g.visitorPoints is NOT NULL
GROUP BY t.teamID, t.name, t.totalLosses
HAVING COUNT (*) <> t.totalLosses;
