require "./enumerable"

puts "my_each vs. each"
numbers = [1, 2, 3, 4, 5]
numbers.my_each  { |item| puts item }
numbers.each  { |item| puts item }

puts "my_each_with_index vs. each_with_index"
numbers = [1, 2, 3, 4, 5]
numbers.my_each_with_index  { |item, index| puts "item: #{item}, index: #{index}" }
numbers.each_with_index  { |item, index| puts "item: #{item}, index: #{index}" }

puts "my_select vs. select"
numbers = [1, 2, 3, 4, 5, 7, 10]
p numbers.my_select { |item| item % 2 == 0 }
p numbers.select { |item| item % 2 == 0 }


puts "my_all? vs. all?"
numbers = [1, 2, 3, 4, 5, 7, 10]
p numbers.my_all? { |item| item % 2 == 0 }
p numbers.all? { |item| item % 2 == 0 }


puts "my_any? vs. any?"
numbers = [1, 3, 5, 6, 7]
p numbers.my_any? { |item| item % 2 == 0 }
p numbers.any? { |item| item % 2 == 0 }


puts "my_none? vs. none?"
numbers = [1, 3, 5, 7]
p numbers.my_none? { |item| item % 2 == 0 }
p numbers.none? { |item| item % 2 == 0 }

puts "my_count vs. count"
numbers = [1, 2, 3, 5, 7, 8]
p numbers.my_count { |item| item % 2 == 0 }
p numbers.count { |item| item % 2 == 0 }

puts "my_map vs. map"
numbers = [1, 2, 3, 5, 7, 8]
p numbers.my_map { |item| item.to_s + "XX" }
p numbers.map { |item| item.to_s + "XX"}

proc = Proc.new {|el| el * 100}
p numbers.my_map(&proc) 

puts "my_inject vs. inject"
numbers = [1, 2, 3, 5, 7, 8]
p numbers.my_inject(100){|acc, el| acc + el}
p numbers.inject(100){|acc, el| acc + el}

def multiply_els(arr)
  arr.my_inject(1) { |product, item| product * item }
end
p multiply_els([2,4,5])
