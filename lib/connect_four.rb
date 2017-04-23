require_relative 'connect_four/version'
require 'pry'

class Engine
  def initialize
    @printer = Printer.new
    @board = Board.new
    @scoring = Scoring.new
    @player_turn = ['B', 'R']
  end

  def run
    until @win
      @win = turn
      @player_turn.rotate!
    end
    win
  end

  def turn
    display_full
    loop do
      col_choice = @printer.display_turn(@player_turn)
      marker = @board.update_board(@player_turn.first, col_choice)
      if marker == false
        display_full
        @printer.display_invalid_choice
      else
        break @scoring.determine_win(marker, @board.board)
      end
    end
  end

  def win
    display_full
    @printer.display_win(@player_turn)
  end

  def display_full
    clear
    @printer.display_title
    @board.display_board
    @printer.display_footer
  end

  def clear
    system 'clear'
  end
end

class Printer
  def display_title
    puts '~~| Ruby Connect 4 |~~'
  end

  def display_win(player)
    puts "    #{player.last}, you Win!"
  end

  def display_turn(player)
    puts "    #{player.first}, your turn:"
    gets.chomp.to_i - 1
  end

  def display_footer
    puts '----------------------'
  end

  def display_invalid_choice
    puts 'Column full, try again'
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

  def update_board(player, col_choice)
    5.downto(0) do |row|
      next unless @board[row][col_choice] == '_'
      @board[row][col_choice] = player
      return @marker = [row, col_choice]
    end
    false
  end
end

class Scoring
  def determine_win(marker, board)
    @marker = marker
    @board = board

    reset
    diagonal_down_shift_marker
    diagonal_up_shift_marker

    @results << check_sequence(horizontal_values)
    @results << check_sequence(vertical_values)
    @results << check_sequence(diagonal_down_values)
    @results << check_sequence(diagonal_up_values)
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
      break if @marker_up[1] == 6 #|| @marker_up[0][1] > 1
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

