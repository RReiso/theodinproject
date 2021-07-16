class Human
  def initialize(mastermind)
    @mastermind = mastermind
  end

  def choose_combination
    loop do
      puts "Choose your color combination (seperate colors with a space):"
      combo = gets.chomp.upcase
      return combo if @mastermind.valid_input?(combo)
      puts "Invalid input"
    end
      
  end
end

class Mastermind
  COLORS = %w[YELLOW BLUE RED GREEN PURPLE WHITE]

  def initialize
    @players = [Human.new(self)]
    @guesses = 12
    # Is this necessary?
    # @role = 0
    # @secret_combination = []
  end

  def play
    puts "rules"
    puts "Choose your role: Press 1 for CODE BREAKER, press 2 for CODE CREATOR"
    loop do
      @role = gets.chomp
      break if @role == "1" || @role == "2"
      puts "Invalid input"
    end
    if @role == "1"
      player = @players[0]
      @secret_combination = COLORS.shuffle.first(4)
      p @secret_combination
      combination = player.choose_combination
      if combination == @secret_combination
        puts "Congratulations! You won!"
      elsif @guesses == 0
        puts "I am sorry. You lost!"
      else
        # hints = find_matches
        # p hints
      end
    end
  end


      def valid_input?(combination)
        combination = combination.split(" ")
        p "chosen combo " + combination.to_s
        combination.size == 4 && combination.all? { |color| COLORS.include?(color) }
      end
end

new_game = Mastermind.new
new_game.play





