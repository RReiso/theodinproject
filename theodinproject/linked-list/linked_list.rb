require './node'

class LinkedList
  attr_reader :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    return @head = @tail = Node.new(value) if @head.nil?

    curr = @head
    curr = curr.next_node until curr.next_node.nil?
    curr.next_node = Node.new(value)
    @tail = curr.next_node
  end

  def prepend(value)
    new_node = Node.new(value)
    new_node.next_node = @head
    @head = new_node
    @tail = new_node if @tail.nil?
  end

  def size
    counter = 0
    curr = @head
    until curr.nil?
      curr = curr.next_node
      counter += 1
    end
    counter
  end

  def at(index)
    counter = 0
    curr = @head
    until curr.nil?
      return curr if counter == index

      curr = curr.next_node
      counter += 1
    end
  end

  def pop
    return @head = @tail = nil if @head == @tail

    prev = @head
    prev = prev.next_node while prev.next_node != @tail
    prev.next_node = nil
    @tail = prev
  end

  def contains?(value)
    return false if @head.nil?

    curr = @head
    until curr.nil?
      return true if curr.value == value

      curr = curr.next_node
    end
    false
  end

  def find(value)
    curr = @head
    index = 0
    until curr.nil?
      return index if curr.value == value

      curr = curr.next_node
      index += 1
    end
    nil
  end

  def to_s
    return nil if @head.nil?

    list = ''
    curr = @head
    until curr.nil?
      list << pattern(curr.value)
      curr = curr.next_node
    end
    "#{list} nil"
  end

  def insert_at(value, index)
    return puts 'Index out of range' if index > size
    return prepend(value) if index.zero?
    return append(value) if index == size

    prev = at(index - 1)
    new_node = Node.new(value)
    new_node.next_node = prev.next_node
    prev.next_node = new_node
  end

  def remove_at(index)
    return puts 'Index out of range' if index > size - 1
    return @head = @head.next_node if index.zero?
    return pop if index == size - 1

    prev = at(index - 1)
    prev.next_node = prev.next_node.next_node
  end

  private

  def pattern(value)
    "( #{value} ) -> "
  end
end

new_list = LinkedList.new