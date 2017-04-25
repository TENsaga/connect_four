class ConnectFour
  def initialize
    @board = Board.new
    @printer = Printer.new
    @scoring = Scoring.new
    @player = %w[B R]
    @error = ''
  end

  def run
    until @win
      @win = turn
      @player.rotate!
      @error.clear
    end
    win
  end

  def turn
    input = user_input
    @marker = @board.update_board(@player.first, input)
    @scoring.determine_win(@marker, @board.board)
  end

  def user_input
    loop do
      display_full
      input = gets.chomp.to_i - 1
      user_input_validate(input)
      return input if @error.empty?
    end
  end

  def user_input_validate(input)
    @error.clear
    @error = 'Columns 1-8, try again' unless input.between?(0, 6)
    @error = 'Column Full, try again' unless @board.check_column(input)
  end

  def win
    display_full
    @printer.display_win(@player.last)
  end

  def display_full
    @printer.clear
    @printer.display_title
    @printer.display_board(@board)
    @printer.display_footer
    @printer.display_error(@error)
    @printer.display_turn(@player.first)
  end
end
