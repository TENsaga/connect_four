class Board
  attr_accessor :board

  def initialize
    @row = 6
    @col = 7
    @board = Array.new(@row) { Array.new(@col, '_') }
  end

  def check_column(col_input)
    @board[0][col_input] == '_' ? col_input : false
  end

  def update_board(player, col_input)
    (@row - 1).downto(0) do |row|
      next unless @board[row][col_input] == '_'
      @board[row][col_input] = player
      return @marker = [row, col_input]
    end
  end

  def to_s
    @col.times { |i| print " C#{i + 1}" }
    print "\n"
    @row.times do |row|
      @col.times do |col|
        print "|#{board[row][col]} "
        print '|' if col == @row
      end
      print "\n"
    end
  end
end
