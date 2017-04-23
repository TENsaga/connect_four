require_relative 'connect_four/version'
require 'pry'

class Engine
  def initialize
    @printer = Printer.new
    @board = Board.new
    @scoring = Scoring.new
    @player_turn = ['B', 'R']
    @error = ''
  end

  def run
    until @win
      @win = turn
      @player_turn.rotate!
      @error.clear
    end
    win
  end

  def turn
    loop do
      if !input = @board.check_column(user_input)
        @error = 'Column Full, try again'
      else
        @marker = @board.update_board(@player_turn.first, input)
        break
      end
    end
    @scoring.determine_win(@marker, @board.board)
  end

  def user_input
    loop do
      display_full
      puts @error unless @error.empty?
      @printer.display_turn(@player_turn)
      @input = gets.chomp.to_i - 1
      @input.between?(0, 6) ? break : @error = 'Columns 1-8, try again'
    end
    @input
  end

  def win
    display_full
    @printer.display_win(@player_turn)
  end

  def display_full
    @printer.clear
    @printer.display_title
    @printer.display_board(@board.board)
    @printer.display_footer
  end
end

class Printer
  def clear
    system 'clear'
  end

  def display_title
    puts '~~| Ruby Connect 4 |~~'
  end

  def display_board(board)
    display_board_header
    display_playable_space(board)
  end

  def display_footer
    puts '----------------------'
  end

  def display_turn(player)
    puts "    #{player.first}, your turn:"
  end

  def display_win(player)
    puts "    #{player.last}, you Win!"
  end

  def display_board_header
    7.times { |i| print " C#{i + 1}" }
    print "\n"
  end

  def display_playable_space(board)
    6.times do |row|
      7.times do |col|
        print "|#{board[row][col]} "
        print '|' if col == 6
      end
      print "\n"
    end
  end
end

class Board
  attr_accessor :board

  def initialize
    @board = create_board
  end

  def create_board
    @board = Array.new(6) { Array.new(7, '_') }
  end

  def check_column(col_input)
    @board[0][col_input] == '_' ? col_input : false
  end

  def update_board(player, col_input)
    5.downto(0) do |row|
      next unless @board[row][col_input] == '_'
      @board[row][col_input] = player
      return @marker = [row, col_input]
    end
  end
end

class Scoring
  def determine_win(marker, board)
    @marker = marker
    @board = board

    reset
    diagonal_down_shift_marker
    diagonal_up_shift_marker

    values = [horizontal_values,
              vertical_values,
              diagonal_down_values,
              diagonal_up_values]

    values.each { |v| @results << check_sequence(v) }

    @results.any?
  end

  def reset
    @diagonal_down = []
    @diagonal_up = []
    @vertical_line = []
    @results = []
    @marker_down = Array.new(@marker)
    @marker_up = Array.new(@marker)
  end

  def check_sequence(input)
    !input.join.match(/([B|R])\1{3,}/).nil?
  end

  def horizontal_values
    @board[@marker[0]]
  end

  def vertical_values
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

  def diagonal_down_values
    (@marker_down[1]).downto(0).with_index do |col, index|
      break if (@marker_down[0] - index).negative?
      @diagonal_down << @board[@marker_down[0] - index][col]
    end
    @diagonal_down
  end

  def diagonal_up_shift_marker
    (@marker_up[1]).upto(6) do
      break if @marker_up[1] == 6
      @marker_up.map!.with_index do |x, index|
        if    index == 1 && x < 6 then x + 1
        elsif index.zero? && x > 0 then x - 1
        else break
        end
      end
    end
  end

  def diagonal_up_values
    (@marker_up[1]).downto(0).with_index do |col, index|
      break if (@marker_up[1] - index).negative? || (@marker_up[0] + index) == 6
      @diagonal_up << @board[@marker_up[0] + index][col]
    end
    @diagonal_up
  end
end

Engine.new.run

