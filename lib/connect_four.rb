require 'connect_four/version'

class Engine
  def initialize
    @printer = Printer.new
    @board = Board.new
  end

  def run
    p 'test'
  end


end

class Printer

end

class Board

end

Engine.new.run