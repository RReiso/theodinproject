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
      index += 1
    end
  end

  def my_select
    result = is_a?(Hash) ? {} : []
    for el in self
      if yield el
        is_a?(Hash) ? result.store(el[0], el[1]) : result << el
      end
    end
    result
  end

  def my_all?
    my_each { |el| return false unless yield el }
    true
  end

  def my_any?
    my_each { |el| return true if yield el }
    false
  end

  def my_none?
    my_each { |el| return false if yield el }
    true
  end

  def my_count
    counter = 0
    my_each { |el| counter += 1 if yield el }
    counter
  end

   def my_map(my_proc = nil)
    array = []
    my_each { |el| array << (my_proc ? my_proc.call(el) : (yield el)) }
    array
  end

  def my_inject(start_value)
    acc = start_value
    my_each { |el| acc = (yield acc, el) }
    acc
  end
end
