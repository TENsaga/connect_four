require_relative 'connect_four/version'

class Engine
  def initialize
    @printer = Printer.new
    @board = Board.new
  end

  def run
    @printer.welcome
    @board.display_board
    turn
  end

  def turn
    print 'test'
  end

end

class Printer
  def welcome
    puts "~~~ Welcome to C4! ~~~"
  end
end

class Board
  attr_accessor :board

  def initialize
    @board ||= create_board
    @marker = [1, 1]
  end

  def create_board
    @board = Array.new(6) { Array.new(7, '_') }
  end

  def display_board
    display_board_header
    display_playable_space
  end

  def display_board_header
    7.times { |i| print " C#{i + 1}" }
    print "\n"
  end

  def display_playable_space
    6.times do |row|
      7.times do |col|
        print "|#{@board[row][col]} "
        print '|' if col == 6
      end
      print "\n"
    end
  end

  def determine_location(player, col_choice)
    5.downto(0) do |row|
      next unless @board[row][col_choice] == '_'
      @board[row][col_choice] = player
      break @marker = [row, col_choice]
    end
    false
  end

  def determine_win
    p @marker # [5, 1]
    @diagonal_down = []
    @diagonal_up = []
    @vertical_line = []
    @marker_down = Array.new(@marker)
    @marker_up = Array.new(@marker)

    determine_sequence(horizontal)
    #print !@board[@marker[0]].join.match(/([B|R])\1{3,}/).nil?

    determine_sequence(vertical)
    # vertical
    # line = ''
    # 0.upto(5) do |i|
    #   line += @board[i][@marker[1]]
    # end
    # print !line.match(/([B|R])\1{3,}/).nil?

    # diagonal
    diagonal_down_shift_marker
    determine_sequence(diagonal_down_build_values)
    diagonal_up_shift_marker
    determine_sequence(diagonal_up_build_values)
  end

  def determine_sequence(input)
    p !input.join.match(/([B|R])\1{3,}/).nil?
  end

  def horizontal
    @board[@marker[0]]
  end

  def vertical
    0.upto(5) do |i|
      @vertical_line << @board[i][@marker[1]]
    end
    @vertical_line
  end

  def diagonal_down_shift_marker
    (@marker_down[1]).upto(6) do
      break if @marker_down[1] == 6 || @marker_down[0] == 5
      @marker_down.map! { |x| x + 1 }
    end
  end

  def diagonal_down_build_values
    (@marker_down[1]).downto(0).with_index do |col, index|
      break if (@marker_down[0] - index).negative?
      @diagonal_down << @board[@marker_down[0] - index][col]
    end
    @diagonal_down
  end

  def diagonal_up_shift_marker
    (@marker_up[1]).upto(6) do
      break if @marker_up[1] == 6 #|| @marker_up[0][1] > 1
      @marker_up.map!.with_index do |x, index|
        if    index == 1 && x < 6 then x + 1
        elsif index.zero? && x > 0 then x - 1
        else break
        end
      end
    end
  end

  def diagonal_up_build_values
    (@marker_up[1]).downto(0).with_index do |col, index|
      break if (@marker_up[1] - index).negative? || (@marker_up[0] + index) == 6
      @diagonal_up << @board[@marker_up[0] + index][col]
    end
    @diagonal_up
  end
end

# Engine.new.run

# Engine.new.run

board = Board.new

# board.display_board
board.determine_location('R', 2)
board.display_board
board.determine_win
# board.determine_location('B', 1)
# board.display_board
# board.determine_location('R', 1)
# board.display_board
# board.determine_location('B', 1)
# board.display_board
# board.determine_location('R', 1)
# board.display_board
# p board.determine_location('R', 1)
# board.display_board
# p board.determine_location('B', 1)


