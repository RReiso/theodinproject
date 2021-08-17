module Iterative
  
  def delete_with_iteration(value)
    current = @root
    while current
      if value > current.value
        if current.right.value == value
          current.right = remove_node(current.right)
          return @root
        else
          current = current.right
        end
      elsif value < current.value
        if current.left.value == value
          current.left = remove_node(current.left)
          return @root
        else
          current = current.left
        end
      else
        # Remove root node
        @root = remove_node(@root)
        return @root
      end
    end
    puts 'The tree does not contain the given value'
  end

  def level_order
    result = []
    queue = [@root]
    until queue.empty?
      node = queue.shift
      result << node.value
      queue << node.left if node.left
      queue << node.right if node.right
    end
    result
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
end
