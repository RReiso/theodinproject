require "./dictionary"
class Hangman
  def initialize
    @dictionary = Dictionary.new("./5desk.txt")
    @secret_word = @dictionary.secret_word
    @letter_line = "- " * @secret_word.length
    @guesses = 10
    @used_letters = ["a","e", "u"]
  end

  def play
    print_rules
      load_saved_game if  user_input == "2"
      loop do
        puts "\nGuesses left: #{@guesses}"
        puts "Letters you have guessed: #{@used_letters.join(" ")}"
        display_letter_line
        take_user_guess
        if winner?
          puts "winner"
        end
        @guesses-=1
        break if @guesses==0
      end 
    end

    def print_rules
      puts "rules"
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
      puts @secret_word
      
      @secret_word.each_char.with_index do |letter, i|
        if @used_letters.include?(letter)
          @letter_line[i*2]=letter
     
        end
      end
      puts @letter_line
    end

    def take_user_guess
      loop do
        print "Enter a letter: "
      guess = gets.chomp.downcase
       if ("a".."z").include?(guess)
        @used_letters << guess
        return 
       end
      puts " \nInvalid input!"
      end
    end

    def winner?
      !@letter_line.include?("-")
    end


end

new_game = Hangman.new
new_game.play