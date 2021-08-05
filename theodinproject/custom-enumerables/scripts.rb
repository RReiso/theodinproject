require "./enumerable"

puts "my_each vs. each"
numbers = [1, 2, 3, 4, 5]
hash = {A: 1, B: 2, C: 3}

numbers.my_each  { |item| print "#{item} " }
puts
numbers.each  { |item| print "#{item} "}
puts
hash.my_each  { |key, value| puts "Key: #{key}, Value: #{value}" }
hash.each  { |key, value| puts "Key: #{key}, Value: #{value}" }
puts


puts "my_each_with_index vs. each_with_index"
numbers.my_each_with_index  { |item, index| puts "item: #{item}, index: #{index}" }
numbers.each_with_index  { |item, index| puts "item: #{item}, index: #{index}" }
hash.my_each_with_index  {|(key, value), i| puts "Key: #{key}, Value: #{value}, Index: #{i}" }
hash.each_with_index  { |(key, value), i| puts "Key: #{key}, Value: #{value}, Index: #{i}" }
puts

puts "my_select vs. select"
p numbers.my_select { |item| item % 2 == 0 }
p numbers.select { |item| item % 2 == 0 }
puts


puts "my_all? vs. all?"
p numbers.my_all? { |item| item % 2 == 0 }
p numbers.all? { |item| item % 2 == 0 }
puts


puts "my_any? vs. any?"
p numbers.my_any? { |item| item % 2 == 0 }
p numbers.any? { |item| item % 2 == 0 }
puts


puts "my_none? vs. none?"
p numbers.my_none? { |item| item % 2 == 0 }
p numbers.none? { |item| item % 2 == 0 }
puts

puts "my_count vs. count"
p numbers.my_count { |item| item % 2 == 0 }
p numbers.count { |item| item % 2 == 0 }
puts

puts "my_map vs. map"
p numbers.my_map { |item| item.to_s + "XX" }
p numbers.map { |item| item.to_s + "XX"}
puts

proc = Proc.new {|el| el * 100}
p numbers.my_map(&proc) 
puts

puts "my_inject vs. inject"
p numbers.my_inject(100){|acc, el| acc + el}
p numbers.inject(100){|acc, el| acc + el}
puts

def multiply_els(arr)
  arr.my_inject(1) { |product, item| product * item }
end
p multiply_els([2,4,5])
