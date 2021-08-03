module ComputerLogic
  def find_remaining_combinations(computer_guess, clues)
    red_pegs, white_pegs = number_of_pegs(clues)
    @all_combinations = computer_guess.permutation(4).to_a if red_pegs + white_pegs == 4
    remaining_combinations = check_red_and_white_pegs(computer_guess, red_pegs, white_pegs)
    remaining_combinations.delete(computer_guess)
    @all_combinations = remaining_combinations
  end

  def number_of_pegs(clues)
    counts = Hash.new(0)
    clues.each { |clue| counts[clue] += 1 }
    red_pegs = counts["\e[31m\u25CF\e[0m"]
    white_pegs = counts["\u25CF"]
    [red_pegs, white_pegs]
  end

  def check_red_and_white_pegs(computer_guess, red_pegs, white_pegs)
    if red_pegs.positive?
      check_red_pegs(computer_guess, red_pegs)
    elsif white_pegs.positive?
      check_white_pegs(computer_guess, white_pegs)
    else
      colors_not_in_secret_code = computer_guess.tally.keys
      delete_combinations(colors_not_in_secret_code)
    end
  end

  def check_red_pegs(computer_guess, red_pegs)
    possible_matching_positions = [0, 1, 2, 3].combination(red_pegs).to_a
    search_all_combinations_for_position_matches(possible_matching_positions, computer_guess)
  end

  def search_all_combinations_for_position_matches(possible_matching_positions, computer_guess)
    remaining_combinations = []
    @all_combinations.each do |combination|
      find_position_matches(
        possible_matching_positions,
        remaining_combinations,
        computer_guess,
        combination
      )
    end
    remaining_combinations
  end

  def find_position_matches(
    possible_matching_positions,
    remaining_combinations,
    computer_guess,
    combination
  )
    possible_matching_positions.each do |positions|
      position_matches = []
      positions.each do |position|
        position_matches << if combination[position] == computer_guess[position]
                              '+'
                            else
                              '-'
                            end
      end
      if match?(position_matches)
        remaining_combinations << combination
        break
      end
    end
  end

  def check_white_pegs(computer_guess, white_pegs)
    possible_matching_colors = computer_guess.combination(white_pegs).to_a.uniq
    search_all_combinations_for_color_matches(possible_matching_colors)
  end

  def search_all_combinations_for_color_matches(possible_matching_colors)
    remaining_combinations = []
    @all_combinations.each do |combination|
      find_color_matches(possible_matching_colors, combination, remaining_combinations)
    end
    remaining_combinations
  end

  def find_color_matches(possible_matching_colors, combination, remaining_combinations)
    possible_matching_colors.each do |colors|
      color_matches = []
      colors.each do |color|
        color_matches << (combination.include?(color) ? '+' : '-')
      end
      if match?(color_matches)
        remaining_combinations << combination
        break
      end
    end
  end

  def match?(arr)
    arr.all? { |el| el == '+' }
  end

  def delete_combinations(colors_not_in_secret_code)
    @all_combinations.each_with_index do |combination, i|
      colors_not_in_secret_code.each do |color|
        if combination.include?(color)
          @all_combinations[i] = nil
          break # break if one match is found, no need to go through all
        end
      end
    end
    @all_combinations.compact
  end
end
