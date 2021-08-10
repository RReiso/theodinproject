class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, _next_node = nil)
    @value = value
    @next_node = _next_node
  end
end