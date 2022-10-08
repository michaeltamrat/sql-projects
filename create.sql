DROP SCHEMA lab1 CASCADE;
CREATE SCHEMA lab1;

CREATE TABLE Persons(

personID INT,
name VARCHAR(30),
address VARCHAR(30),
salary DECIMAL(7,2),
canBePlayer BOOLEAN,
canBeCoach BOOLEAN,
PRIMARY KEY (personID)
);

CREATE TABLE Teams(

teamID INT PRIMARY KEY,
name VARCHAR(30),
coachID INT,
teamCity VARCHAR(30),
teamColor VARCHAR(6),
totalWins INT,
totalLosses INT,
FOREIGN KEY (coachID) REFERENCES Persons (personID)
);

CREATE TABLE Players(

playerID INT PRIMARY KEY,
teamID INT,
joinDate DATE,
rating CHAR(1),
isStarter BOOLEAN,
FOREIGN KEY (playerID) REFERENCES Persons (personID),
FOREIGN KEY (teamID) REFERENCES Teams (teamID)
);

CREATE TABLE Games(

gameID INT PRIMARY KEY,
gameDate DATE,
homeTeam INT,
visitorTeam INT,
homePoints INT,
visitorPoints INT,
FOREIGN KEY (homeTeam) REFERENCES Teams (teamID),
FOREIGN KEY (visitorTeam) REFERENCES Teams (teamID)
);

CREATE TABLE GamePlayers(

gameID INT,
playerID INT,
minutesPlayed INT,
PRIMARY KEY (gameID, playerID),
FOREIGN KEY (gameID) REFERENCES Games (gameID),
FOREIGN KEY (playerID) REFERENCES Players (playerID)
);
