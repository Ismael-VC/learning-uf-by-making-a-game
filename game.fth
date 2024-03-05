\ Learning Forth by Programming a Game
\ * https://youtu.be/QO3fiIhRuOg

9 constant #squares

create action #squares 1 , 2 , 3 , 4 , 5 , 6 , 7 , 8 , 9 ,

( ." " is not defined even though it is in Uf's glossary:
  https://gitlab.com/b2495/uf/-/blob/master/GLOSSARY?ref_type=heads#L26 )

.( #squares dump: )
action #squares cells dump

( cell+ did not work! )

: cells+ ( n -- )
\ Adds cells to n.
	cells + ;

: square! ( square # -- )
\ Write a symbol into a square.
	action rot 1- cells+ ! ;

: square@ ( square -- # )
\ Read a symbol from a square.
	action swap 1- cells+ @ ;

.( Test square! and square@: )
4 77 square! 5 88 square! 6 99 square!
4 square@ . 5 square@ . 6 square@ .

: 3-cr ( n -- )
\ Insert cr every 3 squares.
	3 mod 0= if cr then ;

: .game ( -- )
\ Prints the game squares.
	#squares 1+ 1
	do
		i 3-cr i square@ .
	loop ;

.( Printing game squares: )
.game

(
	Prints:
	1 2
	3 77 88
	99 7 8
	9  ok

	Instead of:
	 1  2  3
	77 88 99
	 7  8  9
)
