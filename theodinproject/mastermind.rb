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
    @player = Human.new(COLORS)
    @guesses = 3
    @secret_combination = []
    # Is this necessary?
    # @role = 0
  end

  def play
    puts "\nrules will be here"
    loop do
      puts 'Choose your role: Press 1 for CODE BREAKER, press 2 for CODE CREATOR'
      @role = gets.chomp
      break if @role == '1' || @role == '2'
      puts " \nInvalid input!"
    end
    if @role == '1'
      # player = @players[0]
      create_secret_combination
      p @secret_combination

      loop do
        puts "\nGuesses left: #{@guesses}"
        @guesses -= 1
        combination = @player.type_combination
        print "\nYour combination: "
        print_combination(combination)

        if winner?(combination)
          puts yellow('Congratulations! You won!')
          play_again?
        elsif @guesses == 0
          puts red("\nNo more guesses. You lost!")
          puts 'The secret combination was: '
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
    combination.each { |color| print "#{color} " }
    puts "\n"
  end

  def winner?(combination)
    combination == @secret_combination
  end

  def check_for_clues(combination)
    clues = []

    secret_combo = @secret_combination.dup

    # Find and mark exact matches
    secret_combo.each_with_index do |color, i|
      if color == combination[i]
        secret_combo[i] = 'exact match'
        combination[i] = 'X'
        clues << red("\u26AB".encode('utf-8'))
      end
    end

    # Find and mark color matches
    secret_combo.each_with_index do |color, i|
      if combination.include?(color)
        clues << "\u26AB".encode('utf-8')
        combination[combination.index(color)] = 'X'
      end
    end
    # p secret_combo
    # p combination
    clues
  end

  def print_clues(clues)
    print 'Clues: '
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

# new_game = Mastermind.new
# new_game.play



#COMPUTER LOGIC
   def check_for_clues(combination)
  clues = []
  secret_combo = %w[BLUE YELLOW GREEN RED].dup

  # Find and mark exact matches
  secret_combo.each_with_index do |color, i|
    if color == combination[i]
      secret_combo[i] = 'exact match'
      combination[i] = 'X'
      clues << 'red'
    end
  end

  # Find and mark color matches
  secret_combo.each_with_index do |color, i|
    if combination.include?(color)
      clues << 'white'
      combination[combination.index(color)] = 'X'
    end
  end
  clues
end

all_combinations =
  %w[YELLOW BLUE RED GREEN PURPLE WHITE].repeated_permutation(4).to_a
count = 0
loop do
  count += 1
  if count == 1
    guess = %w[YELLOW YELLOW BLUE BLUE]
  else
    guess = all_combinations.sample
  end

  p "comp guess #{guess}"
  clues = check_for_clues(guess.dup)
  clues = clues.tally
  p clues
  red_pegs = clues['red'] #nil if none
  white_pegs = clues['white']

  if red_pegs == 4
    p guess
    p count
    exit
  end

  remaining_combinations = []
  
  if red_pegs
    possible_matching_positions = [0, 1, 2, 3].combination(red_pegs).to_a

    all_combinations.each_with_index do |combination, i|
      possible_matching_positions.each do |array_of_positions|
        match = []
        array_of_positions.each do |position|
          combination[position] == guess[position] ? match << '+' : match << '-'
        end

        if match.all? { |el| el == '+' }
          remaining_combinations << combination
          break
        end
      end
    end
  elsif white_pegs
    possible_matching_colors = guess.combination(white_pegs).to_a.uniq
    all_combinations.each_with_index do |combination, i|
      possible_matching_colors.each do |array_of_colors|
        match = []
        array_of_colors.each do |color|
          combination.include?(color) ? match << '+' : match << '-'
        end
        if match.all? { |el| el == '+' }
          remaining_combinations << combination
          break
        end
      end
    end
  else
    # no red pegs no white pegs. need to delete all combinations with the colors form the guess
    colors_not_in_secret_code = guess.tally.keys
    all_combinations.each_with_index do |combination, i|
      colors_not_in_secret_code.each do |color|
        if combination.include?(color)
          all_combinations[i] = nil
          counter += 1
          break # break if found one match, no need to go through all
        end
      end
    end
    remaining_combinations = all_combinations.compact
  end
  remaining_combinations.delete(guess)
  all_combinations = remaining_combinations
end
