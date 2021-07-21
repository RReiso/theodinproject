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
        clues << "red"
      end
    end

    # Find and mark color matches
    secret_combo.each_with_index do |color, i|
      if combination.include?(color)
        clues << "white"
        combination[combination.index(color)] = 'X'
      end
    end
    # p secret_combo
    # p combination
    clues
  end


  all_combinations = %w[YELLOW BLUE RED GREEN PURPLE WHITE].repeated_permutation(4).to_a
  count = 0
loop do
  count +=1
# all_combinations = [%w[YELLOW BLUE RED]]
# p all_combinations
if count ==1
  guess = %w[GREEN GREEN WHITE WHITE]
else
guess =all_combinations.sample
# guess = gets.chomp.split(" ")
end
# guess = %w[GREEN GREEN WHITE WHITE]
p "comp guess #{guess}"
clues = check_for_clues(guess.dup)
p clues
# if clues == []
#   guess.each {|color| all_combinations.delete(color)}
# end
clues = clues.tally
p clues
red_pegs = clues["red"] #nil of none
p red_pegs
white_pegs = clues["white"]
# 4.times do |i|
#   all_combinations.each do |combinaton, index|
#     if combination[i] == guess[i]
#       remaining_combinations << combination
#     end
#   end
# end
if red_pegs == 4
    p guess
    p count
exit
  end

remaining_combinations = []

if red_pegs
possible_matching_indexes = [0,1,2,3].combination(red_pegs).to_a
p possible_matching_indexes

# p all_combinations
all_combinations.each_with_index do |combination, i|
    # p combination
    
    possible_matching_indexes.each do |array_of_indexes|
      # p subarray
      match=[]
      array_of_indexes.each do |index|
        # p combination, guess
        # p "comb #{combination[index_nr]}"
        # p "guess  #{guess[index_nr]}"
        if combination[index] == guess[index]
          match <<"+"
        else
          match << "-"
        end
      end
      # p bool

      if match.all? { |el| el == "+" }
        # p subarray 
        # p "bool ", bool
        remaining_combinations << combination
        remaining_combinations.delete(guess)
        # p all_combinations[i]
        # all_combinations[i] = "X"
        break
      end
    end
  end

elsif white_pegs
  all_combinations.each do |combination|
    guess.each do |color|
      if combination.include?(color)
        remaining_combinations << combination
        break
      end
    end
  end
  # remaining_combinations = all_combinations


  # no red pegs no white pegs. need to delete all combinations with the colors form the guess
else
  colors_not_in_secret_code = guess.tally.keys
  p colors_not_in_secret_code
  p all_combinations.size
  counter = 0
  all_combinations.each_with_index do |combination, i| 
    colors_not_in_secret_code.each do |color|
      if combination.include?(color)
      # if combination.include?(color)
        all_combinations[i] = nil 
        counter +=1
        break # break if found one match, no need to go through all
      end
    end
  end
  remaining_combinations = all_combinations.compact
  p counter
  p remaining_combinations.size
  p remaining_combinations
  # exit
end

  
  p remaining_combinations
  all_combinations = remaining_combinations
end

