require './node'

class Tree
  attr_reader :root

  def initialize(arr)
    arr = arr.sort.uniq
    @root = build_tree(arr)
  end

  # def pretty_print(node = @root, prefix = '', is_left = true)
  #   if node.right
  #     pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false)
  #   end
  #   puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
  #   if node.left
  #     pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true)
  #   end
  # end

  def insert(value)
    new_node = Node.new(value)
    root = @root
    while root
      if new_node > root
        root.right ? root = root.right : (return root.right = new_node)
        # ternary operator can be replaced with:
        # return root.right = new_node unless root.right
        # root = root.right
      elsif new_node < root
        root.left ? root = root.left : (return root.left = new_node)
      else
        return puts 'The node already exists in the tree'
      end
    end
  end

  def delete(value, root = @root)
    return root if root.nil?

    if value > root.value
      root.right = delete(value, root.right)
    elsif value < root.value
      root.left = delete(value, root.left)
    else
      root = remove_node(root)
    end
    root
  end

  def find(value, root = @root)
    #  return root if root.nil?

    if value > root.value
      root.right = find(value, root.right)
    elsif value < root.value
      root.left = find(value, root.left)
    else
      return root
    end
  end



  private

  def remove_node(node)
    return node.right if node.left.nil?
    return node.left if node.right.nil?

    # Find the smallest node in the right subtree
    current = node.right
    current = current.left while current.left

    # Copy value of the smallest node
    node.value = current.value

    # Delete node with the smallest value
    node.right = delete(current.value, node.right)
    node
  end

  def build_tree(arr)
    return nil if arr.empty?

    middle = arr.size / 2
    root = Node.new(arr[middle])
    root.left = build_tree(arr[0...middle])
    root.right = build_tree(arr[middle + 1..-1])
    root
  end
end

tree = Tree.new([1, 2, 6.2, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
puts
tree.insert(68)
tree.insert(1)
tree.insert(30)
tree.insert(6)
tree.insert(5.3)
tree.insert(5.33)
tree.insert(5.31)
tree.insert(6.11)
tree.insert(4.8)
tree.insert(6.1)
# p tree.root
tree.pretty_print
puts puts
tree.delete(9999)
p tree.find(5)
puts
p tree.find(7)
puts
p tree.find(6345)
# tree.pretty_print
