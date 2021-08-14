class Node
  include Comparable

  # attr_reader :value
  attr_accessor :left, :right, :value
  
    def initialize(value)
      @value = value
      @left = nil
      @right = nil
    end

    def <=>(other_node)
      value <=> other_node.value 
    end
end
