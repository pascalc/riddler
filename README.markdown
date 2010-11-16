# The Riddle #

Suppose that Alice, Bob, Cathy, and David need to cross a narrow bridge at night. They
are on the left side of the river and they all need to get to the right side. They have one
lantern, and they cannot walk without it. In addition, the bridge is narrow; at most two
of them can cross at one time. Thus, after the first two people cross the bridge, one of
them must return with the lantern; then two more people can cross the bridge. hl
general, they will be crossing the bridge in groups of one or two, carrying the lantern
back and forth.

Different people walk with different speeds: Alice can cross in one minute, Bob takes
two minutes, Cathy needs five minutes, and David spends ten. When two cross the
bridge together their speed is determined by the slower walker. For example, if Alice
and Cathy cross the bridge together, they spend five minutes. The task is to find a
sequence of moves that enables these four people to cross the bridge in the minimal
possible time.

# The Answer #

A and B cross, running cost = 2

B crosses, running cost = 4

C and D cross, running cost = 14

A crosses, running cost = 15

A and B cross, running cost = 17

Succeeded after 63 node expansions.

# Algorithm Performance #

## A\* search ##

For A\* search we have a variety of heuristics to choose from:
	+ Number of people on the left bank: 1794 node expansions.
	+ Average travel time for people on the left bank: 526 node expansions.
	+ Maximum travel time for people on the left bank: 63 node expansions.

## Uniform Cost Search ##

If we choose to forgo the heuristic altogether, replacing it with "return 0", we get a uniform cost search, which gives us:
	+ Uniform Cost Search: 7367 node expansions.

## Greedy Best First Search ##

Moving on to Greedy Best First search, which is the same as A\* search, except it only considers the heuristic value instead of running cost + heuristic. Using the best heuristic from A\* search, we get:
	+ Final running cost = 20. Succeeded after 9 node expansions.
This shows that Greedy Best First search is not optimal, but it is very quick.

## Hill Climbing Search ##

A solution using Hill Climbing search, which does not "look ahead" but only considers the successors of the current state, with the best heuristic, gives us:
	+ Final running cost = 24. Succeeded after 6 node expansions.
This is obviously the worst performance, so we can conclude that although Hill Climbing search is the quickest algorithm, it is nearly useless for solving problems of this type.
