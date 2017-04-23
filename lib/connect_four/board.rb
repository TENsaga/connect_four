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
