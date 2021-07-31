require './dictionary'
require './colorize'
require './file-manager'
require 'yaml'

class Hangman
  include FileManager

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
        puts "\nCongratulations! You have guessed the secret word '#{@secret_word}'!"
               .yellow
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

  def display_letter_line
    puts "\n#{@letter_line.to_s}".yellow
  end

  def prompt_user
    prompt = ''
    loop do
      print "\nEnter a letter (or 'save' to save the game): "
      prompt = gets.chomp.downcase.strip
      save_game if prompt == 'save'
      if @used_letters.include?(prompt)
        puts "\nThis letter has already been chosen!".red
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
