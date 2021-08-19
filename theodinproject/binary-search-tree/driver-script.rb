require "./node"
require "./tree"

array = Array.new(15) { rand(1..100) }
tree = Tree.new(array)
tree.pretty_print
p "Is the tree balanced? - #{tree.balanced?}"

p "Level order traversal: #{tree.level_order}"
p "Pre order traversal: #{tree.preorder}"
p "Post order traversal: #{tree.postorder}"

5.times do
 p tree.insert(rand(100..200))
end
tree.pretty_print

p "Is the tree balanced? - #{tree.balanced?}"

tree.rebalance
p "Is the tree balanced? - #{tree.balanced?}"

p "Level order traversal: #{tree.level_order}"
p "Pre order traversal: #{tree.preorder}"
p "Post order traversal: #{tree.postorder}"

tree.pretty_print