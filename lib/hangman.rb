module BoardGenerator
  def create_board(score, word, letters, length)
    puts "             ----------"
    puts "            |          |"
    puts "            #{score[1]}          |"
    puts "           #{score[3]}#{score[2]}#{score[4]}         |"
    puts "           #{score[5]} #{score[6]}         |"
    puts "                       |"
    puts "                       |"
    puts " #{length[1]} #{length[2]} #{length[3]} #{length[4]} #{length[5]} #{length[6]} 
    #{length[7]} #{length[8]} #{length[9]} #{length[10]} #{length[11]} #{length[12]}"
    puts ""
    puts "used letters: #{letters[1]}#{letters[2]}#{letters[3]}#{letters[4]}#{letters[5]}#{letters[6]}"
  end
end

class Game
  include BoardGenerator

  def initialize
    @score = {}
    # get a word
    @word = "fox"
    @letters = {}
    @length = {}
    puts "Welcome to hangman! Your word to guess is #{@word.length} letters long."
  end
end

score = { 1 => "O", 2 => "|", 3 => "-", 4 => "-", 5 => "/", 6 => "\\" }
word = "fox"
letters = { 1 => "e" ", ", 2 => "g" ", ", 3 => "j" ", ", 4 => "k" ", ", 5 => "l" ", ", 6 => "m"}
length = { 1 => " ", 2 => " ", 3 => " ", 4 => " ", 5 => " ", 6 => " ", 
  7 => " ", 8 => " ", 9 => " ", 10 => " ", 11 => " ", 12 => " " }

new_game = Game.new
new_game.create_board(score, word, letters, length)
