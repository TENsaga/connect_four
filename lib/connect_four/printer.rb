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
