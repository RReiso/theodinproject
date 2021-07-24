require './colorize'
require './human'
require './computer'

class Mastermind
  include Colorize
  include Human
  include Computer

  COLORS = %w[YELLOW BLUE RED GREEN PURPLE WHITE]

  def initialize
    @human_player = HumanPlayer.new
    @secret_combination = []
    # Is this necessary?
    # @role = 0
    # @all_combinations
  end

  def play
    print_rules
    loop do
      puts 'Choose your role: Press 1 for CODE BREAKER, press 2 for CODE CREATOR'
      @role = gets.chomp
      break if @role == '1' || @role == '2'
      puts " \nInvalid input!"
    end

    if @role == '1'
      set_secret_combination
      turns = 12

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
          print red("\nNo more turns. You lost! ")
          puts 'The secret combination was: '
          print_combination(@secret_combination)
          play_again?
        else
          clues = check_for_clues(human_guess)
          print_clues(clues)
        end
      end

    else
      computer_player = ComputerPlayer.new
      @all_combinations = Mastermind::COLORS.repeated_permutation(4).to_a
      @secret_combination = @human_player.create_secret_combination

      print 'Secret combination: '
      print_combination(@secret_combination)
      turns = 12

      loop do
        sleep(1)
        puts "\nTurns left: #{turns}"
        turns -= 1
        computer_guess = computer_player.make_guess(turns, @all_combinations)
        print "Computer's guess: "
        print_combination(computer_guess)

        if winner?(computer_guess)
          sleep(0.5)
          puts red("\nComputer won! You lost!")
          play_again?
        elsif turns == 0
          sleep(0.5)
          puts yellow(
                 "\nCongratulations! You won! Computer could not break your code!"
               )
          play_again?
        else
          clues = check_for_clues(computer_guess.dup)
          print_clues(clues)
          find_remaining_combinations(computer_guess, clues)
        end
      end
    end
  end

  def print_rules
    puts "\nWelcome to Mastermind!\n\nRules:\nYou can choose to be a code MAKER or a code BREAKER.\nCode maker creates a four color secret combination.\nCode breaker tries to guess the secret combination.\n\nThe colors can repeat in the secret combination.\nYou or computer can make up to 12 guesses.\n\nAfter each guess, there will be up to four clues:\nRed peg #{red("\u25CF".encode('utf-8'))} means there is a correct color in the correct position.\nWhite peg #{"\u25CF".encode('utf-8')} means there is a correct color in the wrong position.\n\nColors to choose from: #{red('RED')}, #{blue('BLUE')}, #{green('GREEN')}, WHITE, #{yellow('YELLOW')} and #{purple('PURPLE')}.\n\nGood luck!\n\n"
  end

  def set_secret_combination
    4.times { @secret_combination << COLORS.sample }
  end

  def print_combination(guess)
    guess.each do |color|
      case color
      when 'RED'
        print red(color)
      when 'BLUE'
        print blue(color)
      when 'YELLOW'
        print yellow(color)
      when 'GREEN'
        print green(color)
      when 'PURPLE'
        print purple(color)
      else
        print color
      end
      print ' '
    end
    puts "\n"
  end

  def print_clues(clues)
    print 'Clues: '
    clues.each { |clue| print clue + " "}
    puts "\n"
  end

  def winner?(guess)
    guess == @secret_combination
  end

  def check_for_clues(guess)
    clues = []
    secret_combo = @secret_combination.dup
    # Find and mark exact matches:
    secret_combo.each_with_index do |color, i|
      if color == guess[i]
        secret_combo[i] = 'exact match'
        guess[i] = 'X'
        clues << red("\u25CF".encode('utf-8'))
      end
    end
    # Find and mark color matches:
    secret_combo.each_with_index do |color, i|
      if guess.include?(color)
        clues << "\u25CF".encode('utf-8')
        guess[guess.index(color)] = 'X'
      end
    end
    clues
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

new_game = Mastermind.new
new_game.play
