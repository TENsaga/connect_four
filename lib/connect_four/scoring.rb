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

  private

  def reset
    @diagonal_down = []
    @diagonal_up = []
    @vertical_line = []
    @results = []
    @marker_down = Array.new(@marker)
    @marker_up = Array.new(@marker)
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

  # Gathers values from @marker reverse to boundary
  def diagonal_down_values
    (@marker_down[1]).downto(0).with_index do |col, index|
      break if (@marker_down[0] - index).negative?
      @diagonal_down << @board[@marker_down[0] - index][col]
    end
    @diagonal_down
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

  # Gathers values from @marker reverse to boundary
  def diagonal_up_values
    (@marker_up[1]).downto(0).with_index do |col, index|
      break if (@marker_up[1] - index).negative? || (@marker_up[0] + index) == 6
      @diagonal_up << @board[@marker_up[0] + index][col]
    end
    @diagonal_up
  end
end
