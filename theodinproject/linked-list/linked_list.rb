require "./node"

class LinkedList
  attr_accessor :head

  def initialize(head)
    @head = head
    @tail = head
  end

  def append(value)
    curr = @head
    while curr.next_node != nil
      curr = curr.next_node
    end
    curr.next_node = Node.new(value)
    @tail = curr.next_node
  end

  def prepend(value)
    new_node = Node.new(value)
    new_node.next_node = @head
    @head = new_node
  end

  def size
    counter = 0
    curr = @head
    while curr != nil
      curr = curr.next_node
      counter += 1
    end
      counter 
  end

  def head
    @head
  end

  def tail
    @tail
  end

  def at(index)
    counter = 0
    curr = @head
    while curr != nil
     return curr if counter == index
      curr = curr.next_node
      counter += 1
    end
  end

end

new_list = LinkedList.new(Node.new(10))
new_list.append(7)
new_list.prepend(9)
# p new_list
# p new_list.size
# p new_list.head
new_list.append(77)
new_list.append(788)
p new_list
puts
p new_list.at(5)