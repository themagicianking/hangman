module GameHelper
  require "yaml"

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
    dictionary = []
    word = ""
    file = File.open("google-10000-english-no-swears.txt").readlines.each do |line|
      dictionary.push(line)
    end
    until word.length < 13 && word.length > 4
      word = dictionary.sample.chomp
    end
    word
  end
end

class Game
  include GameHelper
  attr_reader :score, :word, :letters, :length, :guess, :man
  @@times_played = -1

  def initialize
    @score = { 0 => " ", 1 => " ", 2 => " ", 3 => " ", 4 => " ", 5 => " " }
    @word = get_word
    @letters = { 0 => " ", 1 => " ", 2 => " ", 3 => " ", 4 => " ", 5 => " " }
    @length = length = { 0 => " ", 1 => " ", 2 => " ", 3 => " ", 4 => " ", 5 => " ", 
      6 => " ", 7 => " ", 8 => " ", 9 => " ", 10 => " ", 11 => " " }    
    @guess = { 0 => " ", 1 => " ", 2 => " ", 3 => " ", 4 => " ", 5 => " ", 
      6 => " ", 7 => " ", 8 => " ", 9 => " ", 10 => " ", 11 => " " }
    @man = ["O", "|", "-", "-", "/", "\\"]
    @length.map do |key, value|
      if key + word.length >= 12
        @length[key] = "-"
      end
    end
  end

  def turn(word)
    if 1
      puts "Welcome to hangman! Your word to guess is #{@word.length} letters long."
    end
    puts "Please enter a letter."
    choice = gets.chomp.downcase
    if word.include?(choice) && !@letters.values.include?(choice) && !@guess.values.include?(choice)
      puts "That's correct!"
      word.split("").each_with_index do |letter, index|
        @guess[index + (12 - word.length)] = letter if letter == choice
      end
    elsif @letters.values.include?(choice) || @guess.values.include?(choice)
      puts "You have already guessed that!"
    elsif !choice.match("[a-z]")
      puts "Invalid input! Please only select letters."
    else
      @letters[@letters.key(" ")] = choice
      @score[@score.key(" ")] = man[0]
      man.delete_at(0)
      puts "Incorrect. You have #{@letters.values.count(" ")} guesses remaining."
    end
  end

  def win_lose_continue?(guess, word, score)
    if score[5] == "\\"
      create_board(@score, @guess, @letters, @length)
      puts "You lose!"
      puts "The word was #{word}."
      false
    elsif guess.values[(12 - word.length)..11].join("") == word
      create_board(@score, @guess, @letters, @length)
      puts "You win!"
      false
    else
      true
    end
  end

  def save_game?
    puts "Would you like to save your game? Enter Y to save and anything to continue."
    gets.chomp.upcase == "Y" ? true : false
  end

  def save_game_file
    YAML.dump ({
      :score => @score,
      :word => @word,
      :letters => @letters,
      :length => @length,
      :guess => @guess,
      :man => @man
    })
  end
end

class GameSaver
  def initialize
    if File.exists?("gameone.txt")
      puts "Hello! Would you like to play a saved game or start a new one?"
      puts "Select the number of the game you would like to load, or type NEW."
    else
      puts "Hello! would you like to start a new game?"
    end
  end

  def play_game(game)
    game.create_board(game.score, game.guess, game.letters, game.length)
    while game.win_lose_continue?(game.guess, game.word, game.score)
      game.turn(game.word)
      game.create_board(game.score, game.guess, game.letters, game.length)
      if game.save_game?
        write_game_to_file(game.save_game_file)
        break
      else
      end
    end
  end

  def write_game_to_file(game)
    if File.exists?("gamethree.text")
      puts "Error--you can only save three games!"
    elsif File.exists?("gametwo.txt")
      file = File.open("gamethree.txt", "w")
      file.puts game
      file.close
    elsif File.exists?("gameone.txt")
      file = File.open("gametwo.txt", "w")
      file.puts game
      file.close
    else
      file = File.open("gameone.txt", "w")
      file.puts game
      file.close
    end
  end
end

test = GameSaver.new
test.play_game(Game.new)
