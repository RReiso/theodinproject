class Knight
  DIRECTIONS = [
    [1, 2],
    [2, 1],
    [2, -1],
    [-1, 2],
    [1, -2],
    [-2, 1],
    [-1, -2],
    [-2, -1]
  ].freeze

  attr_reader :current_position, :parent
  attr_accessor :child_nodes

  def initialize(current_position, end_position, parent = nil)
    @current_position = current_position
    @end_position = end_position
    @parent = parent
    @child_nodes = []
  end

  def find_possible_moves
    possible_moves = []
    DIRECTIONS.each do |x_coordinate, y_coordinate|
      current = @current_position.dup
      current[0] += x_coordinate
      current[1] += y_coordinate
      next if current[0].negative? || current[1].negative? || current[0] > 8 || current[1] > 8

      possible_moves << current
    end
    possible_moves
  end
end