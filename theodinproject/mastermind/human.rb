module Human
  class HumanPlayer
    def initialize
      @all_colors = Mastermind::COLORS
    end

    def make_guess
      loop do
        puts 'Type your 4 color combination (seperate colors with a space):'
        guess = gets.chomp.upcase.split(' ')
        return guess if valid_input?(guess)
        puts "\nInvalid input"
      end
    end

    def create_secret_combination
      loop do
        puts "\nCreate a 4 color secret combination (seperate colors with a space):"
        secret_combination = gets.chomp.upcase.split(' ')
        return secret_combination if valid_input?(secret_combination)
        puts "\nInvalid input"
      end
    end

    private

    def valid_input?(color_array)
      color_array.size == 4 &&
        color_array.all? { |color| @all_colors.include?(color) }
    end
  end
end
