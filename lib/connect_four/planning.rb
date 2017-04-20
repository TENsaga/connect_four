# 7 columns × 6 rows
# o o o o o o o
# o
# o
# o
# o
# o

# *Player one (black) takes a *turn, and places a *piece in any *column, the piece falls to the next available *location in that column, stacking ontop of other pieces if they exist below, if they manage to *connect 4 pieces in any direction (including diagonal), they *win.

# Engine
# init printer/@board
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

# [0 4 8]
#
# 0 1 2
# 3 4 5
# 6 R 8

@marker = [1, 1]

@marker_down = Array.new(@marker)
@marker_up = Array.new(@marker)


@board = [[0, 1, 2], [3, 4, 5], [6, 'R', 8]]

@diagonal_down = []
@diagonal_up = []


def diagonal_down_shift_marker
  (@marker_down[1]).upto(2) do
    break if @marker_down[1] == 2 || @marker_down[0][1] > 1
    @marker_down.map! { |x| x > 1 ? break : x + 1 }
  end
end

def diagonal_down_build_values
  (@marker_down[1]).downto(0).with_index do |col, index|
    next if (@marker_down[0] - index).negative?
    @diagonal_down << @board[@marker_down[0] - index][col]
  end
end

diagonal_down_shift_marker
diagonal_down_build_values
print @diagonal_down

def diagonal_up_shift_marker
  (@marker_up[1]).upto(2) do
    break if @marker_up[1] == 2 || @marker_up[0][1] > 1
     @marker_up.map!.with_index do |x, index|
      if index == 1 && x < 2
        x + 1
      elsif index == 0 && x > 0
        x - 1
      else break
      end
    end
  end
end

def diagonal_up_build_values
  (@marker_up[1]).downto(0).with_index do |col, index|
    next if (@marker_up[1] - index).negative? || (@marker_up[0] + index) > 2
    @diagonal_up << @board[@marker_up[0] + index][col]
  end
end

diagonal_up_shift_marker
diagonal_up_build_values
print @diagonal_up
