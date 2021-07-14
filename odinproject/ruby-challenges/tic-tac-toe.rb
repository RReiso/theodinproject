class Player
  attr_reader :marker, :num

  def initialize (tictactoe, marker, num)
    @tictactoe = tictactoe
    @marker = marker
    @num = num
  end

  def choose_position
    loop do
      puts "Choose a number from available positions"
      chosen_position = gets.chomp.to_i
      p chosen_position
      return chosen_position if @tictactoe.available_positions.include?(chosen_position)
    end
  end
end

class TicTacToe
  WIN_COMBINATIONS = [[1,2,3],[4,5,6],[7,8,9],[1,5,9],[3,5,7],[1,4,7],[2,5,8],[3,6,9]]

  attr_reader :available_positions, :current_player

  def initialize
    @players = [Player.new(self,"x", 1), Player.new(self, "o", 2)]
    @current_player = @players[0]
    @board = %w(1 2 3 4 5 6 7 8 9)
    @available_positions = [1,2,3,4,5,6,7,8,9]
  end

  def play
    loop do
      draw_board
      chosen_position = @current_player.choose_position
      update_available_positions(chosen_position)
      @board[chosen_position - 1] = @current_player.marker
      # draw_board
      # if statements
      switch_player
    end
  end

def draw_board
  divider = "--+---+--"
  puts "#{@board[0]} | #{@board[1]} | #{@board[2]}"
  puts divider
  puts "#{@board[3]} | #{@board[4]} | #{@board[5]}"
  puts divider
  puts "#{@board[6]} | #{@board[7]} | #{@board[8]}"
end

  def update_available_positions(pos)
    @available_positions.delete(pos)
    p "available positions" + @available_positions.to_s
  end

  def switch_player
    @current_player = @current_player == @players[0]? @players[1] : @players[0]
    p "curr_player " + @current_player.num.to_s
  end

end

new_game = TicTacToe.new
new_game.play