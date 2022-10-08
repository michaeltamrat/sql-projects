BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;

UPDATE Persons p 
SET personID = pc1.personID, address = pc1.address, salary = pc1.salary, canBePlayer = FALSE, canBeCoach = FALSE
FROM PersonChanges pc1
WHERE pc1.personID = p.personID;


INSERT INTO Persons(personID, name, address, salary, canBePlayer, canBeCoach)
SELECT pc.personID, pc.name, pc.address, pc.salary, TRUE, NULL
FROM PersonChanges pc
WHERE pc.personID NOT IN (SELECT p.personID
			  FROM Persons p);
COMMIT;
