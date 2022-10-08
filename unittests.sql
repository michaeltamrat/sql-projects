INSERT INTO Teams(teamID, name, coachID, teamCity, teamColor, totalWins, totalLosses)
VALUES (999,'Kerri Walsh Jennings', 9999999, 'san jose', 'red', 5, 5);

INSERT INTO GamePlayers(gameID, playerID, minutesPlayed)
VALUES (99999, 1234, 213);

INSERT INTO GamePlayers(gameID, playerID, minutesPlayed)
VALUES (10001, 99999, 213); 

UPDATE GamePlayers
SET minutesPlayed = 2000;

UPDATE GamePlayers
SET minutes Played = -3;*/

UPDATE Players
SET rating = 'G';

UPDATE Players 
SET rating = 'M';

UPDATE Games
SET homePoints = NULL
AND visitorPoints = NOT NULL;

UPDATE Games
SET homePoints = NULL
AND visitorPoints = NULL;
