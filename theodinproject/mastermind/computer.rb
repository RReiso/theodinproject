require './computer_logic'

module Computer
  include ComputerLogic
  class ComputerPlayer
    def make_guess(turns, all_combinations)
      turns == 11 ? %w[YELLOW YELLOW BLUE BLUE] : all_combinations.sample
    end
  end
end
