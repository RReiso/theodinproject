require './node'

class Tree
  attr_reader :root

  def initialize(arr)
    arr = arr.sort.uniq
    @root = build_tree(arr)
  end

  

  def insert(value)
    new_node = Node.new(value)
    root = @root
    while root
      if new_node > root
        return root.right = new_node unless root.right

        root = root.right
      elsif new_node <= root
        return root.left = new_node unless root.left

        root = root.left
      end
    end
  end

  private

  def build_tree(arr)
    return nil if arr.empty?

    middle = arr.size / 2
    root = Node.new(arr[middle])
    root.left = build_tree(arr[0...middle])
    root.right = build_tree(arr[middle + 1..-1])
    root
  end
end

tree = Tree.new([1, 2, 6, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
# tree.pretty_print
puts
tree.insert(68)
tree.insert(1)
tree.insert(30)
tree.insert(0.1)
p tree.root
# tree.pretty_print
