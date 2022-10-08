CREATE OR REPLACE FUNCTION fireSomePlayersFunction(maxFired INTEGER) RETURNS INTEGER
AS $$

DECLARE count INTEGER := 0;
DECLARE salary NUMERIC(7,2);
DECLARE playerID INTEGER;
DECLARE teamID INTEGER;
DECLARE c CURSOR FOR
	SELECT p.playerID, pe.salary, p.teamID
	FROM Players p, Persons pe
	WHERE p.playerID = pe.personID
	AND p.teamID IS NOT NULL
	AND p.rating = 'L'
	AND 60 < (SELECT SUM(g.minutesPlayed)
          	FROM GamePlayers g
         	 WHERE p.playerID = g.playerID
          	GROUP BY g.playerID)
	ORDER BY pe.salary;
BEGIN
    OPEN c;
    LOOP
    IF count >= maxFired
    THEN RETURN count;
    END IF;
	FETCH c INTO playerID, teamID, salary;
        EXIT WHEN NOT FOUND;
	UPDATE Players SET teamID = NULL;
	count := count + 1;
    END LOOP;
CLOSE c;
RETURN count;
END;

$$ LANGUAGE plpgsql;
