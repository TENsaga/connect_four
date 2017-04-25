class Printer
  TITLE  = '~~| Ruby Connect 4 |~~'.freeze
  FOOTER = '----------------------'.freeze

  def clear
    system 'clear'
  end

  def display_error(error)
    puts error unless error.empty?
  end

  def display_title
    puts TITLE
  end

  def display_board(board)
    board.to_s
  end

  def display_footer
    puts FOOTER
  end

  def display_turn(player)
    puts "    #{player}, your turn:"
  end

  def display_win(player)
    puts "    #{player}, you Win!"
  end
end
