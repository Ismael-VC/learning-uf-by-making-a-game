#!/usr/bin/env python


# avoid printing a new line at end with print
def show(s: str) -> None: print(s, end="")


# 9 constant #squares
squares = 9


# create board squares cells allot
board = [0 for i in range(1, squares+1)]


# : cells+ ( n --- n+cells )   cells +


# : square! ( square # --- )   board rot 1- cells ! ;
def set_square(i: int, value: int) -> None: board[i-1] = value


# : square@ ( square --- # )   board swap 1- cells @ ;
def get_square(i: int) -> int: return board[i-1]

def cr() -> None: show("\n")

# : 3-cr ( n --- )   3 mod 0= if cr then ;
def cr3(i: int) -> None:
    if i % 3 == 0:
        cr()


# : tab ( --- )   9 emit ;
def tab(): show("\t")


# : dashes ( --- )   cr tab ." ---------" cr ;
def dashes(): cr(); tab(); show("---------"); cr()


# : .square ( n --- )
#     dup square@
#          dup 0 = if
#         swap .
#     then dup 1 = if
#         ." X " drop
#     then dup 2 = if
#         ." O " drop
#     then
#         drop ;
def show_square(i: int) -> None:
    square = get_square(i)
    if     square == 0:
        show(i)
    elif square == 1:
        show("X")
    elif square == 2:
        show("O")


# : 3numbers ( a b c --- )
#     tab .square ." | "
#         .square ." | "
#         .square ;
def numbers3(a: int, b: int, c: int) -> int:
    tab()
    show_square(a); show(" | ")
    show_square(b); show(" | ")
    show_square(c)


# : .board ( --- )
#     9 8 7 6 5 4 3 2 1
#     3numbers dashes
#     3numbers dashes
#     3numbers cr ;
def show_board() -> None:
    idxs = range(1, 10)
    numbers3(*idxs[0:3]); dashes()
    numbers3(*idxs[3:6]); dashes()
    numbers3(*idxs[6:9]); cr()


# : clear-game ( --- )
#     #squares 1+ 1
#     do
#         i 0 square!
#     loop ;
def clear_game() -> None:
    for i, _ in enumerate(board):
        set_square(i+1, 0)


# 1 constant X   2 constant O
X = 1;   O = 2


# : X! X square! ;
def set_X(i: int) -> None: set_square(i, X)


# : O! O square! ;
def set_O(i: int) -> None: set_square(i, O)


# variable unplayed
unplayed: int = 0


# : current-player ( --- )   unplayed @ 1 and ;
def current_player() -> int: return unplayed & 1


# 48 constant zero
zero = 48


# : ascii># ( char --- n )   zero - ;
def ascii_to_num(char: int) -> int: return char - zero


# : range? ( n --- )   dup 1 <  swap 9 > or 0= ;
def in_range(n: int) -> bool: return 0 < n < 10


# : empty? ( n --- )   square@ 0= ;
def is_empty(n: int) -> bool: return get_square(n) == 0


# : place-symbol ( square --- )
#    current-player if
#        X!
#    else
#        O!
#    then
#    unplayed @ 1+ unplayed ! ;
def place_symbol(n: int) -> None:
    if current_player():
        set_X(n)
    else:
        set_O(n)
    global unplayed; unplayed += 1


# : ps ( --- )   place-symbol ;
def ps(n: int) -> None: place_symbol(n)


# 113 constant q-char
q_char = 113


# emulate UF's key word
def key(): return ord(input())


# : player-input ( --- )
#     begin
#         cr ." Square number for "
#
#         current-player
#         if
#             ." X: "
#         else
#             ." O: "
#         then
#
#         cr key   dup q-char =
#         if
#             drop cr ." Exiting " bye
#         then
#
#         ascii># dup range? over empty? and
#         if
#             place-symbol .board
#         else
#             drop ." Pick another square. "
#         then
#     while
#         true
#     repeat ;
def player_input() -> None:
    while True:
        cr(); show("Square number for ")
        if current_player():
            show("X:")
        else:
            show("O:")

        cr(); k = key()
        if k == q_char:
            show("Exiting"); quit()

        k = ascii_to_num(k)
        if in_range(k) and is_empty(k):
            place_symbol(k); show_board()
        else:
            show("Pick another square.")


# : next ( --- ) player-input
def nxt() -> None: player_input()


# : start ( --- )   clear-game #squares unplayed ! player-input ;
def start() -> None:
    clear_game()
    global unplayed; unplayed = squares
    player_input()


start()






