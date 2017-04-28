class Scoring
  def determine_win(marker, board)
    @marker = marker
    @board = board
    reset
    values = [horizontal_values,
              vertical_values,
              diagonal_values('down', @marker_down[0], @marker_down[1]),
              diagonal_values('up', @marker_up[0], @marker_up[1])]
    values.each { |v| @results << check_sequence(v) }
    @results.any?
  end

  private

  def reset
    @results = []
    @diagonal = []
    @vertical_line = []
    @marker_down = Array.new(@marker)
    @marker_up = Array.new(@marker)
    diagonal_down_shift_marker
    diagonal_up_shift_marker
  end

  # Check for 4 in a row match of B|R
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

  # Primer for diagonal down values - Moves marker down diagonally
  def diagonal_down_shift_marker
    (@marker_down[1]).upto(6) do
      break if @marker_down[1] == 6 || @marker_down[0] == 5
      @marker_down.map! { |x| x + 1 }
    end
  end

  # Primer for diagonal up values - Moves marker up diagonally
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

  # Gather values from marker row/col and stop at boundary, based on direction
  def diagonal_values(dir, m_row, m_col)
    m_col.downto(0).with_index do |col, index|
      if dir == 'down'
        break if (m_row - index).negative?
        char = @board[m_row - index][col]
      else
        break if (m_col - index).negative? || (m_row + index) == 6
        char = @board[m_row + index][col]
      end
      @diagonal << char
    end
    @diagonal
  end
end
