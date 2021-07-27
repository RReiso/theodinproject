module ComputerLogic
  
  def find_remaining_combinations(computer_guess, clues)
    red_pegs, white_pegs = nr_of_pegs(clues)
    if red_pegs + white_pegs == 4
      @all_combinations = computer_guess.permutation(4).to_a
    end
    if red_pegs > 0
      possible_correct_positions = [0, 1, 2, 3].combination(red_pegs).to_a # Ex: if red_pegs=2, then possible correct positions could be 0,1 or 0,2 or 1,3 etc
      remaining_combinations =
        check_red_pegs(possible_correct_positions, computer_guess)
    elsif white_pegs > 0
      possible_matching_colors =
        computer_guess.combination(white_pegs).to_a.uniq
      remaining_combinations =
        check_white_pegs(possible_matching_colors, computer_guess)
    else
      colors_not_in_secret_code = computer_guess.tally.keys
      remaining_combinations = delete_combinations(colors_not_in_secret_code)
    end
    remaining_combinations.delete(computer_guess)
    @all_combinations = remaining_combinations
  end

  def nr_of_pegs(clues)
    counts = Hash.new(0)
    clues.each { |clue| counts[clue] += 1 }
    red_pegs = counts["\e[31m\u25CF\e[0m"] 
    white_pegs = counts["\u25CF"]
    return red_pegs, white_pegs
  end

  def check_red_pegs(possible_correct_positions, computer_guess)
    remaining_combinations = []
    @all_combinations.each do |combination|
      possible_correct_positions.each do |positions|
        match = []
        positions.each do |position|
          if combination[position] == computer_guess[position]
            match << '+'
          else
            match << '-'
          end
        end
        if match?(match)
          remaining_combinations << combination
          break
        end
      end
    end
    remaining_combinations
  end

  def check_white_pegs(possible_matching_colors, computer_guess)
    remaining_combinations = []
    @all_combinations.each do |combination|
      possible_matching_colors.each do |colors|
        match = []
        colors.each do |color|
          combination.include?(color) ? match << '+' : match << '-'
        end
        if match?(match)
          remaining_combinations << combination
          break
        end
      end
    end
    remaining_combinations
  end

  def match?(match)
    match.all? { |el| el == '+' }
  end

  def delete_combinations(colors_not_in_secret_code)
    remaining_combinations = []
    @all_combinations.each_with_index do |combination, i|
      colors_not_in_secret_code.each do |color|
        if combination.include?(color)
          @all_combinations[i] = nil
          break # break if one match is found, no need to go through all colors
        end
      end
    end
    remaining_combinations = @all_combinations.compact
    remaining_combinations
  end
end
