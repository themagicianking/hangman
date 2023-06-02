module BoardGenerator
  def create_board(score, guess, letters, length)
    puts "              __________"
    puts "            |           |"
    puts "            #{score[0]}           |"
    puts "           #{score[2]}#{score[1]}#{score[3]}          |"
    puts "           #{score[4]} #{score[5]}          |"
    puts "                        |"
    puts "#{guess[0]} #{guess[1]} #{guess[2]} #{guess[3]} #{guess[4]} #{guess[5]} #{guess[6]} #{guess[7]} #{guess[8]} #{guess[9]} #{guess[10]} #{guess[11]} |"
    puts "#{length[0]} #{length[1]} #{length[2]} #{length[3]} #{length[4]} #{length[5]} #{length[6]} #{length[7]} #{length[8]} #{length[9]} #{length[10]} #{length[11]}"
    puts ""
    puts "used letters: #{letters[0]}#{letters[1]}#{letters[2]}#{letters[3]}#{letters[4]}#{letters[5]}"
  end

  def get_word
    # get word from downloaded dictionary
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
    @guess = {}
    puts "Welcome to hangman! Your word to guess is #{@word.length} letters long."
  end

  def turn(word)
    puts "Please enter a letter."
    choice = gets.chomp.downcase
    if word.include? choice
      puts "That's correct!"
      word.split("").each_with_index do |letter, index|
        @guess[index + (12 - word.length)] = letter if letter == choice
      end
      puts @guess
    elsif @guess.values.include? choice
      puts "You have already guessed that!"
    elsif !choice.match("[a-z]")
      puts "Invalid input! Please only select letters."
    else
      puts "Incorrect. You have #{} guesses remaining."
      # get number of guessses from letters remaining
    end
  end
end

score = { 0 => "O", 1 => "|", 2 => "-", 3 => "-", 4 => "/", 5 => "\\" }
word = "fox"
guess = { 0 => " ", 1 => " ", 2 => " ", 3 => " ", 4 => " ", 5 => " ", 
  6 => " ", 7 => " ", 8 => " ", 9 => " ", 10 => " ", 11 => "t" }
letters = { 0 => "e" ", ", 1 => "g" ", ", 2 => "j" ", ", 3 => "k" ", ", 4 => "l" ", ", 5 => "m" }
length = { 0 => "-", 1 => "-", 2 => "-", 3 => "-", 4 => "-", 5 => "-", 
  6 => "-", 7 => "-", 8 => "-", 9 => "-", 10 => "-", 11 => "-" }

new_game = Game.new
new_game.create_board(score, guess, letters, length)
new_game.turn("fox")
