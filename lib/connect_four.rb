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
    @marker
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
    # horizontal
    # @board[@marker[0]]
    # print !@board[@marker[0]].join.match(/([B|R])\1{3,}/).nil?

    # vertical
    # line = ''
    # 0.upto(5) do |i|
    #   line += @board[i][@marker[1]]
    # end
    # print !line.match(/([B|R])\1{3,}/).nil?

    # diagonal
    line = ''
    boundary_left = 0
    boundary_right = 6
    p boundary_right




  end

end
#Engine.new.run

# Engine.new.run

board = Board.new

# board.display_board
board.determine_location('R', 1)
# board.display_board
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


