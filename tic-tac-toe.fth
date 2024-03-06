\ Learning Forth by Programming a Game
\ * https://youtu.be/QO3fiIhRuOg

9 constant squares

create board squares cells allot

: cells+ ( n --- n+cells )   cells + ;

: square! ( square # --- )   board rot 1- cells+ ! ;

: square@ ( square --- # )   board swap 1- cells+ @ ;

: 3-cr ( n --- )   3 mod 0= if cr then ;

: tab ( --- )   9 emit ;

: dashes ( --- )   cr tab ." ---------" cr ;


: .square ( n --- )
	dup square@
	     dup 0 = if
		swap .
	then dup 1 = if
		." X " drop
	then dup 2 = if
		." O " drop
	then
		drop ;

: 3numbers ( square --- square+1 )
	tab .square ." | "
	    .square ." | "
	    .square ;

: .board ( --- )
	9 8 7 6 5 4 3 2 1
	3numbers dashes
	3numbers dashes
	3numbers cr ;

: clear-game ( --- )
	#squares 1+ 1
	do
		i 0 square!
	loop ;

1 constant X   2 constant O

: X! X square! ;
: O! O square! ;

variable unplayed

: current-player ( --- )   unplayed @ 1 and ;

48 constant zero

: ascii># ( char --- n )   zero - ;

: range? ( n --- )   dup 1 <  swap 9 > or 0= ;

: empty? ( n --- )   square@ 0= ;

: place-symbol ( square --- )
	current-player if
		X!
	else
		O!
	then
	unplayed @ 1+ unplayed ! ;

: ps ( --- )   place-symbol ;

113 constant q-char

: player-input ( --- )
	begin
		cr ." Square number for "

		current-player
		if
			." X: "
		else
			." O: "
		then

		cr key   dup q-char =
		if
			drop cr ." Exiting " bye
		then

		ascii># dup range? over empty? and
		if
			place-symbol .board
		else
			drop ." Pick another square. "
		then
	while
		true
	repeat ;

: next ( --- ) player-input ;

: start ( --- )   clear-game #squares unplayed ! player-input ;
