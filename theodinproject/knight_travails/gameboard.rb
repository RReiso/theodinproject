require "./knight"

class GameBoard
  def initialize; end

  def knight_moves(start_position, end_position)
    knight = Knight.new(start_position, end_position)
    parent = find_parent_of_ending_node(knight, end_position)
    path = get_path(parent, start_position)
    print_result(end_position, path)
  end

  def find_parent_of_ending_node(knight, end_position)
    queue = [knight]
    node = queue.shift
    while queue
      node.find_possible_moves.each do |position|
        return node if position == end_position

        child = Knight.new(position, end_position, node)
        node.child_nodes << child
        queue << child
      end
      node = queue.shift
    end
  end

  def get_path(node, start_position)
    path = []
    # Traverse up the chain:
    until node.current_position == start_position
      path.unshift(node.current_position)
      node = node.parent
    end
    path.unshift(start_position)
    path
  end

  def print_result(end_position, path)
    puts "You made it in #{path.size} moves!  Here's your path:"
    path.each { |position| puts position.to_s }
    puts end_position.to_s
  end
end

new_game = GameBoard.new
new_game.knight_moves([0, 3], [8, 7])
