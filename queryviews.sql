SELECT DISTINCT  l.teamID, l.name
FROM Teams t, winsDisagree w, lossesDisagree l
WHERE w.teamID = l.teamID
AND w.name = l.name;

DELETE FROM Games
WHERE gameID = 10005
OR gameID = 10001;

SELECT DISTINCT l.teamID, l.name
FROM Teams t, winsDisagree w, lossesDisagree l
WHERE w.teamID = l.teamID
AND w.name = l.name;
/*SELECT DISTINCT winsDisagree, computedWins
FROM winsDisagree;

SELECT DISTINCT lossesDisagree, computedLosses
FROM lossesDisagree;

From the first run we get 203 peaches and 209 lone stars
second run s 201 birds and 209 lone starts */
