module Enumerable
  def my_each
    for el in self
      yield el
    end
  end

  def my_each_with_index
    index = 0
    for el in self
      yield el, index
      index+=1
    end
  end

  def my_select
    result = []
    for el in self
      result << el if yield el
    end
    result
  end

  def my_all?
    self.my_each do |el|
      return false unless yield el
    end
    true
  end

  def my_any?
     self.my_each do |el|
      return true if yield el
    end
    false
  end

  def my_none?
    self.my_each do |el|
      return false if yield el
    end
    true
  end

  def my_count
    counter = 0
    self.my_each do |el|
      counter+=1 if yield el
    end
    counter
  end

  def my_map
    array = []
    self.my_each {|el| array << (yield el)}
    array
  end

  def my_inject(start_value)
    acc = start_value
    self.my_each do |el|
      acc = (yield acc, el)
    end
    acc
  end
end
numbers = [1, 2, 3, 4]
proc = Proc.new {|el| el * 100}
p numbers.my_map(&proc) 
