class Human
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
      puts 'Create a 4 color secret combination (seperate colors with a space):'
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


class Computer
  def initialize
    
  end

  def make_guess(turns, all_combinations)
    if turns == 11
      %w[YELLOW YELLOW BLUE BLUE]
  else
    all_combinations.sample
  end
end
end

class Mastermind
  COLORS = %w[YELLOW BLUE RED GREEN PURPLE WHITE]

  def initialize
    @human_player = Human.new
    @secret_combination = []
    # Is this necessary?
    # @role = 0
    # @all_combinations
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
          
      set_secret_combination
      turns=3
      p @secret_combination

      loop do
        puts "\nTurns left: #{turns}"
        turns -= 1
        human_guess = @human_player.make_guess
        print "\nYour guess: "
        print_combination(human_guess)

        if winner?(human_guess)
          puts yellow('Congratulations! You won!')
          play_again?
        elsif turns == 0
          puts red("\nNo more turns. You lost!")
          puts 'The secret combination was: '
          print_combination(@secret_combination)
          play_again?
        else
          clues = check_for_clues(human_guess)
          print_clues(clues)
        end
      end
    else
      computer_player = Computer.new
      @all_combinations = Mastermind::COLORS.repeated_permutation(4).to_a
      @secret_combination = @human_player.create_secret_combination
      turns = 12
loop do
  turns -= 1
  computer_guess = computer_player.make_guess(turns, @all_combinations)
  p "comp guess #{computer_guess}"
  
if winner?(computer_guess)
          puts red('Computer won! You lost!')
          play_again?
elsif turns == 0
    puts yellow('Congratulations! You won! Computer could not break your code')
          play_again?
else
clues = check_for_clues(computer_guess.dup)
  print_clues(clues)

  find_remaining_combinations(computer_guess, clues)
  
end
    end
  end
end

  def set_secret_combination
    4.times { @secret_combination << COLORS.sample }
  end

  def print_combination(guess)
    guess.each { |color| print "#{color} " }
    puts "\n"
  end

  def winner?(guess)
    guess == @secret_combination
  end

  def check_for_clues(guess)
    clues = []
    secret_combo = @secret_combination.dup

    # Find and mark exact matches
    secret_combo.each_with_index do |color, i|
      if color == guess[i]
        secret_combo[i] = 'exact match'
        guess[i] = 'X'
        clues << red("\u26AB".encode('utf-8'))
      end
    end

    # Find and mark color matches
    secret_combo.each_with_index do |color, i|
      if guess.include?(color)
        clues << "\u26AB".encode('utf-8')
        guess[guess.index(color)] = 'X'
      end
    end
    clues
  end

  def print_clues(clues)
    print 'Clues: '
    clues.each { |clue| print clue }
    puts "\n"
  end

  def find_remaining_combinations(computer_guess, clues)
    red_pegs, white_pegs = nr_of_pegs(clues)
    
    p red_pegs
    p white_pegs
    if red_pegs
      p "in red"
      possible_matching_positions = [0, 1, 2, 3].combination(red_pegs).to_a
      remaining_combinations = check_red_pegs(possible_matching_positions, computer_guess)
    
    elsif white_pegs
      "in White"
      possible_matching_colors = computer_guess.combination(white_pegs).to_a.uniq
      remaining_combinations = check_white_pegs(possible_matching_colors, computer_guess)
    else
      p "in no"
      # no red pegs no white pegs. need to delete all combinations with the colors form the guess
      colors_not_in_secret_code = computer_guess.tally.keys
      remaining_combinations = delete_combinations(colors_not_in_secret_code)
    end
    remaining_combinations.delete(computer_guess)
    @all_combinations = remaining_combinations
    p @all_combinations

  end

def nr_of_pegs(clues)
    clues = clues.tally
    p clues
  red_pegs = clues["\e[31m⚫\e[0m"] #nil if none
  white_pegs = clues["⚫"]
  return red_pegs, white_pegs
end

def check_red_pegs(possible_matching_positions, computer_guess)
  p possible_matching_positions
  remaining_combinations = []
@all_combinations.each_with_index do |combination, i|
      possible_matching_positions.each do |array_of_positions|
       
        match = []
        array_of_positions.each do |position|
            p combination[position], computer_guess[position]
          combination[position] == computer_guess[position] ? match << '+' : match << '-'
        end

        if match.all? { |el| el == '+' }
          # p combination
          remaining_combinations << combination
          break
        end
      end
    end
    remaining_combinations
  end

  def check_white_pegs(possible_matching_colors,computer_guess)
    remaining_combinations=[]
    @all_combinations.each_with_index do |combination, i|
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
    remaining_combinations
  end

  def delete_combinations(colors_not_in_secret_code)
    p "Problem"
    # p @all_combinations
    remaining_combinations=[]
    @all_combinations.each_with_index do |combination, i|
      colors_not_in_secret_code.each do |color|
        if combination.include?(color)
          @all_combinations[i] = nil
          break # break if found one match, no need to go through all
        end
      end
    end
    # p @all_combinations
    remaining_combinations = @all_combinations.compact
    remaining_combinations
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


