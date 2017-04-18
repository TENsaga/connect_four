# 7 columns × 6 rows
# o o o o o o o
# o
# o
# o
# o
# o

# *Player one (black) takes a *turn, and places a *piece in any *column, the piece falls to the next available *location in that column, stacking ontop of other pieces if they exist below, if they manage to *connect 4 pieces in any direction (including diagonal), they *win.

# Engine
# init printer/board
# run
# validate_entry
# valid_entry
# invalid_entry
# win?

# Printer
# welcome
# board
# turn
# turn_success
# turn_fail
# win
# loss

# Board
# init: board array, piece symbol
# display_board
# determine_location
# update_board
