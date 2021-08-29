
class Knight
  DIRECTIONS = [[1,2],[2,1],[2,-1],[-1,2],[1,-2],[-2,1],[-1,-2],[-2,-1]]

  attr_reader :possible_moves,  :current_position
  attr_accessor :parent, :child_nodes

  def initialize(current_position, end_position, parent=nil)
    @current_position = current_position
    @end_position = end_position
    @parent = parent
    @child_nodes = []
    
  end
  
  def play
    
    
    # @possible_moves = find_possible_moves 
    parent = find_parent_of_ending_node
    get_path(parent, @current_position)
    # p self.parent
    # p "visited positions #{$visited_positions}"
  end

  def find_possible_moves
   
possible_moves = []
# p " curr pos #{@current_position}"
DIRECTIONS.each do |x_coordinate, y_coordinate|
  current = @current_position.dup
  current[0] += x_coordinate
  current[1] += y_coordinate
  next if current[0].negative? || current[1].negative? || current[0]>8 ||current[1]>8
  possible_moves << current
end
# p "poss moves #{possible_moves}"
possible_moves
end

def find_parent_of_ending_node

  queue = [self]
    node = queue.shift
    while queue
    
      node.find_possible_moves.each do |position|
 
        if position != @end_position
          node.child_nodes << a = Knight.new(position, @end_position,node)
          queue<<a
        else
          return node

      
    end

  end
  node=queue.shift
  
end
end


def get_path(node,start_position )
# Given node's child is the end_position
  path =[@end_position]
  while node.current_position !=start_position
    path.unshift(node.current_position)
    node = node.parent
  end
  path.unshift(start_position)
  p path
  # exit
end

end

knight = Knight.new([0,3],[8,7])
# p knight
# p "I am #{knight} "
knight.play
# 



