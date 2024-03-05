\ Learning Forth by Programming a Game
\ * https://youtu.be/QO3fiIhRuOg

9 constant #squares
create action #squares cells allot

: cells+ ( n -- ) cells + ;

: square! ( square # -- )	action rot 1- cells+ ! ;

: square@ ( square -- # ) action swap 1- cells+ @ ;

: 3-cr ( n -- )	3 mod 0= if cr then ;

: tab ( -- ) 9 emit ;

: dashes ( -- ) cr tab ." ---------" cr ;

: .square ( n -- )
	square@
	     dup 0 = if
		."   "
	then dup 1 = if
		." X "
	then dup 2 = if
		." O "
	then
		drop ;

: 3numbers ( square -- square+1 )
	tab .square ." | "
	    .square ." | "
	    .square ;

: .game ( -- )
	9 8 7 6 5 4 3 2 1
	3numbers dashes
	3numbers dashes
	3numbers cr ;

: clear-game ( -- )
	#squares 1+ 1
	do
		i 0 square!
	loop ;

1 constant X   2 constant O

: X! X square! ;
: O! O square! ;

variable unplayed

: current-player ( -- ) unplayed @ 1 and ;

: start ( -- ) clear-game #squares unplayed ! ;

