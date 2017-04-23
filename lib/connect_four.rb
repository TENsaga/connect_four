class ConnectFour
  def initialize
    @board = Board.new
    @printer = Printer.new
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
