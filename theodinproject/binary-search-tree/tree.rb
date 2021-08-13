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

tree = Tree.new([1,2,6, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree.pretty_print
