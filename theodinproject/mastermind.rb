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
          hints = create_hints(combination)
          print_hints(hints)
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

      def create_hints(combination)
        hints = []
        secret_combo = @secret_combination.dup
      
        # Find exact (color and position) matches:
        @secret_combination.each_with_index do |color, i|
        
          if color == combination[i]
            hints << red("\u26AB".encode('utf-8'))
            
            secret_combo.delete_at(secret_combo.index(color)) # DELETE FIRST OCCURance of color
          end
        
          end

          #Find color matches
      combination.each do |color|
            if secret_combo.include?(color)
              hints << "\u26AB".encode('utf-8')
              secret_combo.delete_at(secret_combo.index(color))
            end
          end
            p secret_combo
        hints.sort
      end

      def print_hints(hints)
        hints.each {|hint| print hint}
          puts "\n"
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


      def colorize(text, color_code)
  "#{color_code}#{text}\e[0m"
end

def red(text)
  colorize(text, "\e[31m")
end

end

new_game = Mastermind.new
new_game.play






