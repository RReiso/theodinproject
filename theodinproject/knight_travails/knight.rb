$visited_positions=[]

# DIRECTIONS = [[1,2],[2,1],[2,-1]]
# DIRECTIONS = [[1,2],[2,1],[2,-1],[-1,2],[1,-2]]
DIRECTIONS = [[1,2],[2,1],[2,-1],[-1,2],[1,-2],[-2,1],[-1,-2],[-2,-1]]
starting_position = [0,3]
class Knight
  attr_reader :possible_moves,  :current_position
  attr_accessor :parent, :child_nodes
  def initialize(current_position, destination,parent=nil)
    @current_position = current_position
    @destination = destination
    @parent = parent
     @possible_moves = find_possible_moves 
     @child_nodes = []
    
  end

  def play
   
    
    find_child_nodes 
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

def find_child_nodes
  $visited_positions << @current_position
  # p "Possible moves #{@possible_moves} of node #{@current_position}"
  queue = [self]
    knight = queue.shift
    until knight.current_position == @destination
      p "cure pose #{knight.current_position}"
      p "moves #{knight.possible_moves}"
      knight.possible_moves.each do |move|
    # p "I am move #{move}"
        if move != @destination
          knight.child_nodes << a = Knight.new(move, @destination,knight)
          queue<<a
        else
      # p knight
      get_path(knight)
    end

  end
  knight=queue.shift
  #  queue = [Knight.new(start)]
  #   knight = queue.shift
  #   until knight.current_position == destination
  #     knight.possible_moves.each do |move|
  #       knight.children << a = Knight.new(move, current)
  #       queue << a
  #     end
  #     knight = queue.shift
  #   end
  #   knight
end
end

def traverse
  queue = [self]
  knight = queue.shift
 
  path = [@destination]
  while knight && (knight.current_position !=@destination)
    # p "this is parent #{knight.current_position}"
    # puts
    knight.child_nodes.each do |child|
      p "CHILD #{child.current_position}"
      queue << child
    end
    queue.each do |node|
      if node.current_position == @destination
        p "yey"
        # p node
        get_path(node)
      end
    end
   
    knight = queue.shift
  end
end

def get_path(node)

  path =[@destination]
  # p node
  p @current_position
  while node.current_position !=@current_position
    path.unshift(node.current_position)
    node = node.parent
  end
  path.unshift(@current_position)
  p path
  exit
end

end

knight = Knight.new([0,3],[8,7])
# p knight
# p "I am #{knight} "
knight.play




