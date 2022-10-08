#! /usr/bin/env python

#  runVolleyballApplication skeleton, to be modified by students

import psycopg2, sys

# usage()
# Print error messages to stderr
def usage():
    print("Usage:  python3 runVolleyballApplication.py userid pwd", file=sys.stderr)
    sys.exit(-1)
# end usage

# The three Python functions that for Lab4 should appear below.
# Write those functions, as described in Lab4 Section 4 (and Section 5,
# which describes the Stored Function used by the third C function).
#
# Write the tests of those function in main, as described in Section 6
# of Lab4.


 # teamPlayerCount(myConn, name):
 # The teamPlayerCount Python function returns the number of players who are the team with a
 # specified name.  The arguments for teamPlayerCount are the database connection and the name
 # of the team.
 #
 # It is not an error if there is no team with that name in the Teams table. It is also not an
 # error if there is a team with that name, but there are no players on that team.  In both of
 # these circumstances, teamPlayerCount should return 0.

def teamPlayerCount(myConn, name):

    # Python function to be supplied by students
    # You'll need to figure out value to return.
    stmt = "SELECT COUNT(*) FROM Players p, Teams t WHERE p.teamID = t.teamID AND t.name = '" + name + "' GROUP BY t.name;"
    try:
        myCursor = myConn.cursor()
        myCursor.execute(stmt)
    except:
        print("Statement", stmt, "is bad", file=sys.stderr)
        myCursor.close()
        myConn.close()
        sys.exit(-1)

    rows = myCursor.fetchone()
    print("Count of players on team", name, "is", rows[0])
    myCursor.close()
    return



# end teamPlayerCount


# updateTeamCity(myConn, :
# teamCity is an attribute of the Teams table.  Sometimes a team moves to a different city.

# Besides the database connection, the updateTeamCity Python function has two arguments, an
# integer argument theTeamID and a string argument, newTeamCity.  For every team in the Teams
# table (if any) whose teamID equals theTeamID, updateTeamCity should change that team’s
# teamCity to be newTeamCity.
#
#There might be no team whose teamCity equals theTeamID (that’s not an error), and there also
# might be one team whose teamCity equals theTeamID, since teamCity is the Primary Key of the
# Teams table.  updateTeamCity should return the number of teams whose teamCity was updated.

def updateTeamCity(myConn, theTeamID, newTeamCity):
    
    # Python function to be supplied by students
    myCursor = myConn.cursor()

    try:
        stmt = """UPDATE Teams t SET teamCity = %s WHERE t.teamID = %s"""
        myCursor.execute(stmt,(newTeamCity, theTeamID))
        k = myCursor.rowcount
    except:
        print ("Update is bad", file = sys.stderr)
        myCursor.close()
        myConn.close()
        sys.exit(-1)
    print("Number of teams with teamID", theTeamID, "who moved to city", newTeamCity, "is", k)
    myCursor.close()
    return

# end updateTeamCity


# fireSomePlayers(myConn, maxFired):
# Besides the database connection, this Python function has one integer parameters, maxFired.
# A value of maxFired that’s not positive is invalid, and you should call sys.exit(-1) from
# fireSomePlayers if an invalid maxFired value has been provided.
#
# fireSomePlayers invokes a Stored Function, fireSomePlayersFunction, that you will need to
# implement and store in the database according to the description in Section 5.  The Stored
# Function fireSomePlayersFunction should just have one parameter, maxFired, so don’t the
# database connection is not a parameter for this Stored Function.
#
# Section 5 explains what “firing” means, and also tells you which Players should be fired,
# The fireSomePlayers Python function should return the same integer result that the
# fireSomePlayersFunction Stored Function returns.
#
# The fireSomePlayers function must only invoke the Stored Function fireSomePlayersFunction,
# which does all of the work for this part of the assignment; fireSomePlayers should not do
# the work itself.

def fireSomePlayers(myConn, maxFired):

# We're gving you the code for fireSomePlayers, but you'll have to write the Stored Function
# fireSomePlayersFunction yourselves in a PL/pgSQL file named fireSomePlayersFunction.pgsql

    if maxFired <= 0:
        print(maxFired, "is an illegal value for maxFired")
        sys.exit(-1)
        
    try:
        myCursor = myConn.cursor()
        myCursor.execute("SELECT fireSomePlayersFunction(%s)", (maxFired, ))
    except:
        print("Call of fireSomePlayersFunction on", maxFired, "had error", file=sys.stderr)
        myCursor.close()
        myConn.close()
        sys.exit(-1)
    
    row = myCursor.fetchone()
    print("Number of player fired in fireSomePlayers when maxFired equals", maxFired, "is", row[0])
    myCursor.close()
    return(row[0])

#end fireSomePlayers


def main():

    if len(sys.argv)!=3:
       usage()

    hostname = "cse182-db.lt.ucsc.edu"
    userID = sys.argv[1]
    pwd = sys.argv[2]

    # Try to make a connection to the database
    try:
        myConn = psycopg2.connect(host=hostname, user=userID, password=pwd)
    except:
        print("Connection to database failed", file=sys.stderr)
        sys.exit(-1)
        
    # We're making every SQL statement a transaction that commits.
    # Don't need to explicitly begin a transaction.
    # Could have multiple statement in a transaction, using myConn.commit when we want to commit.
    myConn.autocommit = True
  
  
    # Perform the calls to teamPlayerCount described in Section 6 of Lab4, and print their outputs.
    # You have to write this yourselves.
    teamPlayerCount(myConn, "Birds")
    teamPlayerCount(myConn, "Skyscrapers")

    # Perform the calls to updateTeamCity described in Section 6 of Lab4, and print their outputs.
    # You have to write this yourselves.
    updateTeamCity(myConn, 202, "Las Vegas")
    updateTeamCity(myConn, 208, "Toronto")

    
    # Perform the calls to fireSomePlayers described in Section 6 of Lab4, and print their outputs.
    # You have to write this yourselves.
    fireSomePlayers(myConn, 2)
    fireSomePlayers(myConn, 3)
    myConn.close()
    sys.exit(0)
#end

#------------------------------------------------------------------------------
if __name__=='__main__':

    main()

# end
