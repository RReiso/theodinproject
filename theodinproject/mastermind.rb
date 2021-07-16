class Human
  def initialize(all_colors)
    @all_colors = all_colors
  end

  def choose_combination
    loop do
      puts "Choose your color combination (seperate colors with a space):"
      combo = gets.chomp.upcase.split(" ")
      return combo if valid_input?(combo)
      puts "Invalid input"
    end
      
  end

  def valid_input?(combination)
    # all_colors = Mastermind::COLORS
    combination.size == 4 && combination.all? { |color| @all_colors.include?(color) }
  end
end

class Mastermind
  COLORS = %w[YELLOW BLUE RED GREEN PURPLE WHITE]

  def initialize
    #How to pass COLORS? Or access in Human class -  Mastermind::COLORS
    @players = [Human.new(COLORS)]
    @guesses = 3
    @secret_combination = []
    # Is this necessary?
    # @role = 0
  end

  def play
    puts "rules will be here"
    loop do
      puts "Choose your role: Press 1 for CODE BREAKER, press 2 for CODE CREATOR"
      @role = gets.chomp
      break if @role == "1" || @role == "2"
      puts "Invalid input!"
    end
    if @role == "1"
      player = @players[0]
      create_secret_combination
      p @secret_combination

      loop do
        puts "Guesses left: #{@guesses}"
        @guesses-=1
        combination = player.choose_combination

        if winner?(combination)
          puts "Congratulations! You won!"
          play_again?
        elsif @guesses == 0
          puts "No more guesses. You lost!"
          play_again?
        else
          hints = find_matches(combination)
          p hints
        end
      end
    end
  end


      # def valid_input?(combination)
      #   p "chosen combo " + combination.to_s
      #   combination.size == 4 && combination.all? { |color| COLORS.include?(color) }
      # end

      def create_secret_combination
        4.times {@secret_combination << COLORS.sample}
      end

      def winner?(combination)
        combination == @secret_combination
      end

      def find_matches(combination)
        hints = []
        @secret_combination.each_with_index do |color, i|
          if color == combination[i]
            hints <<"X"
          elsif @secret_combination.include?(combination[i])
            hints << "O"
          end
        end
        hints
      end

      def play_again?
        loop do
      print "\nPlay again? y/n:"
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

new_game = Mastermind.new
new_game.play






