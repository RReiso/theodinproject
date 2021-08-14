require './node'

class Tree
  attr_reader :root

  def initialize(arr)
    arr = arr.sort.uniq
    @root = build_tree(arr)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
  pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
  puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
  pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
end

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
        return puts "The node already exists in the tree"
      end
    end
  end

  def delete(value)
    root = @root
    while root
      if  value > root.value 
        if root.right.value == value
          root.right = remove_node(root.right)
          return
        else
          root = root.right
        end
      elsif value < root.value
        p root.value
         if root.left.value == value
          root.left = remove_node(root.left)
          return
         else
          root = root.left
         end
      else
        p "you want to delete root node"
        root = remove_node(root)
        p root
      end
    end
    pretty_print(@root)
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

  def remove_node(node)
    p node
    if node.left.nil?
      node.right
    elsif node.right.nil?
      node.left
    else
      node = node.right
      while node.left
        node = node.left
      end
      node
    end
  end
end

tree = Tree.new([1, 2, 6, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
# tree.pretty_print
puts
tree.insert(68)
tree.insert(1)
tree.insert(30)
tree.insert(0.1)
# p tree.root
puts puts
tree.delete(9)
tree.pretty_print
