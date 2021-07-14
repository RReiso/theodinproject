class Player
  attr_reader :marker, :tictactoe

  def initialize (tictactoe, marker)
    @tictactoe = tictactoe
    @marker = marker
  end

  def choose_position
    loop do
      puts "Choose a number from available positions"
      chosen_position = gets.chomp.to_i
      p chosen_position
      return chosen_position if tictactoe.available_positions.include?(chosen_position)
    end
  end
end

class TicTacToe
  WIN_COMBINATIONS = [[1,2,3],[4,5,6],[7,8,9],[1,5,9],[3,5,7],[1,4,7],[2,5,8],[3,6,9]]

  attr_accessor :current_player
  attr_reader :available_positions

  def initialize
    @players = [Player.new(self,"x"), Player.new(self, "o")]
    @current_player = @players[0]
    @board = %w(1, 2, 3, 4, 5, 6, 7, 8, 9)
    @available_positions = [1,2,3,4,5,6,7,8,9]
  end

  def play(current_player)
    loop do
      # draw_board
      chosen_position = current_player.choose_position
      update_available_positions(chosen_position)
      @board[chosen_position] = current_player.marker
      # draw_board
      # if statements
      switch_player
    end
  end

  def update_available_positions(pos)
    available_positions.delete(pos)
    p @available_positions
  end

  def switch_player
    self.current_player = self.current_player == @players[0]? @players[1] : @players[0]
  end

end

new_game = TicTacToe.new
new_game.play(new_game.current_player)