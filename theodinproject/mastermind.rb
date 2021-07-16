class Human
  def initialize(all_colors)
    @all_colors = all_colors
  end

  def type_combination
    loop do
      puts 'Type your 4 color combination (seperate colors with a space):'
      combo = gets.chomp.upcase.split(' ')
      return combo if valid_input?(combo)
      puts "\nInvalid input"
    end
  end

  def valid_input?(combination)
    # all_colors = Mastermind::COLORS
    combination.size == 4 &&
      combination.all? { |color| @all_colors.include?(color) }
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
    puts 'rules will be here'
    loop do
      puts 'Choose your role: Press 1 for CODE BREAKER, press 2 for CODE CREATOR'
      @role = gets.chomp
      break if @role == '1' || @role == '2'
      puts" \nInvalid input!"
    end
    if @role == '1'
      player = @players[0]
      create_secret_combination
      p @secret_combination

      loop do
        puts "\nGuesses left: #{@guesses}"
        @guesses -= 1
        combination = player.type_combination
        print "\nYour combination: "
        print_combination(combination)
        if winner?(combination)
          puts yellow("Congratulations! You won!")
          play_again?
        elsif @guesses == 0
          puts red("\nNo more guesses. You lost!")
          puts "The secret combination is: "
          print_combination(@secret_combination)
          play_again?
        else
          clues = check_for_clues(combination)
          print_clues(clues)
        end
      end
    end
  end

  def create_secret_combination
    4.times { @secret_combination << COLORS.sample }
  end

  def print_combination(combination)
    combination.each {|color| print "#{color} "}
    puts "\n"
  end

  def winner?(combination)
    combination == @secret_combination
  end

  def check_for_clues(combination)
    clues = []
    
secret_combo = @secret_combination.dup
secret_combo.each_with_index do |color, i|
  if color == combination[i]
    secret_combo[i] = "exact match"
    combination[i] = "found"
    clues << red("\u26AB".encode('utf-8'))
  end
end
secret_combo.each_with_index do |color, i|
  if combination.include?(color)
     clues << "\u26AB".encode('utf-8')
     combination[combination.index(color)] = "found"
  end
end
# p secret_combo
# p combination
clues
end




  def print_clues(clues)
    print "Clues: "
    clues.each { |clue| print clue }
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

  def yellow(text)
    colorize(text, "\e[33m")
  end
end

new_game = Mastermind.new
new_game.play
