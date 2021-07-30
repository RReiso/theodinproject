require './dictionary'
require './colorize'
require 'yaml'

class Hangman
  def initialize
    @dictionary = Dictionary.new('./5desk.txt')
    @secret_word = @dictionary.secret_word
    @letter_line = '- ' * @secret_word.length
    @guesses = 10
    @used_letters = []
  end

  def start
    print_rules
    load_game if user_input == '2'
    play
  end

 protected

  def play
    loop do
      puts "\nGuesses left: #{@guesses}".green
      puts "Letters you have guessed: #{@used_letters.join(' ')}"
      display_letter_line
      prompt_user
      if winner?
        display_letter_line
        puts "\nCongratulations! You have guessed the secret word '#{@secret_word}'!".yellow
        play_again?
      end
      break if @guesses == 0
    end
    puts "\nYou lost! The secret word was '#{@secret_word}'!".red
    play_again?
  end

 private

  def print_rules
    puts "\nWelcome to the Hangman game!\nYou need to guess the secret word to win the game.\nType one letter at each turn.\nYou can make 10 wrong guesses.\nType 'save' when you want to save your game.\nGood luck!\n\n"
  end

  def user_input
    loop do
      puts 'Enter "1" to start a new game'.light_blue
      puts 'Enter "2" to load a saved game'.light_blue
      input = gets.chomp
      return input if input == '1' || input == '2'
      puts " \nInvalid input!"
    end
  end

  def load_game
    if !Dir.exist?('./saved_games/')
          loop do
            puts "\nNo saved games!"
            break if user_input == "1"
          end
    else
      loaded_game.play
  
  end

  end

  def loaded_game
    saved_games =  Dir.glob('saved_games/*')
    p saved_games
    loop do
      puts "Choose a game"
    file_name= gets.chomp
    break if saved_games.include?(file_name)
    end
  File.open("./saved_games/nini2.yml", 'r') {|file| YAML::load(file)}
  end


  def save_game
    file_name = prompt_user_for_file_name
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    File.open("./saved_games/#{file_name}.yml", 'w') { |f| f.write(YAML.dump(self)) }
    exit
  end

  def prompt_user_for_file_name
    saved_games = Dir.glob('saved_games/*')
    file_name = ''
    loop do
      puts 'Enter a name to save your game: '
      file_name = gets.chomp.strip
      if saved_games.include?("saved_games/#{file_name}.yml")
        puts "\nFile aready exists"
        next
      end
      break unless /\s+|^$/.match?(file_name)
    end
    file_name
  end

  def display_letter_line
    puts "\n#{@letter_line.to_s}".pink
  end

  def prompt_user
    prompt = ''
    loop do
      print "\nEnter a letter (or 'save' to save the game): "
      prompt = gets.chomp.downcase.strip
      save_game if prompt == 'save'
      if @used_letters.include?(prompt)
        puts "This letter has already been chosen!\n\n"
      elsif ('a'..'z').include?(prompt)
        @used_letters << prompt
        break
      else
        puts " \nInvalid input!"
      end
    end
    @guesses -= 1 unless @secret_word.downcase.include?(prompt)
  end

  def winner?
    update_letter_line
    !@letter_line.include?('-')
  end

  def update_letter_line
    @secret_word.each_char.with_index do |letter, i|
      if @used_letters.include?(letter.downcase)
        @letter_line[i * 2] = @secret_word[i]
      end
    end
  end

  def play_again?
    loop do
      print "\nPlay again? y/n: "
      answer = gets.chomp.downcase
      if answer == 'n'
        exit
      elsif answer == 'y'
        initialize
        start
      end
    end
  end
end

new_game = Hangman.new
new_game.start
