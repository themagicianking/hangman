module BoardGenerator
  def create_static_board
    puts "     ----------"
    puts "    |          |"
    puts "    O          |"
    puts "   -|-         |"
    puts "   / \\         |"
    puts "               |"
    puts "               |"
    puts "  _ _ _ _ _ _ _"
  end

  def create_scoreboard
  end

  def create_used_letters
  end

  def create_guess
  end
end

class Game
  include BoardGenerator

  def initialize
  end
end

new_game = Game.new

new_game.create_static_board