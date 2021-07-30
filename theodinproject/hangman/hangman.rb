require "./dictionary"
class Hangman
  def initialize
    @dictionary = Dictionary.new("./5desk.txt")
    @secret_word = @dictionary.secret_word
    @letter_line = "- " * @secret_word.length
    @guesses = 10
    @used_letters = []
  end

  def play
    print_rules
      load_saved_game if  user_input == "2"
      loop do
        puts "\nGuesses left: #{@guesses}"
        puts "Letters you have guessed: #{@used_letters.join(" ")}\n\n"
        display_letter_line
        take_user_guess
        if winner?
          puts "Congratulations! You have guessed the secret word '#{@secret_word}'!"
          play_again?
        end
        @guesses-=1
        break if @guesses==0
      end 
      puts "\nYou lost! The secret word was '#{@secret_word}'!"
    end

    def print_rules
      puts "Welcome to the Hangman game!\nTry to guess the secret word.\nType one letter at each turn.\nYou can make 10 wrong guesses!\nGood luck!\n"
    end

    def user_input
      loop do
        puts 'Enter "1" to start a new game'
      puts 'Enter "2" to load a saved game'
      input = gets.chomp
      return input if input == "1" || input == "2"
      puts " \nInvalid input!"
      end
    end

    def load_saved_game
      puts "loading"
    end

    def display_letter_line
      # puts @secret_word
      
  
      puts @letter_line.to_s + "\n\n"
    end

    def take_user_guess
      loop do
        print "Enter a letter: "
      guess = gets.chomp.downcase
        if @used_letters.include?(guess)
          puts "The letter has already been chosen!\n\n"
        
      elsif ("a".."z").include?(guess) 
      
        @used_letters << guess
        return 
      else
      puts " \nInvalid input!"
      end
    end
    end

    def winner?
      update_letter_line
      !@letter_line.include?("-")
    end

    def update_letter_line
          @secret_word.each_char.with_index do |letter, i|
        if @used_letters.include?(letter.downcase)
          @letter_line[i*2]=@secret_word[i]
     
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
        play
      end
    end
  end

end

new_game = Hangman.new
new_game.play