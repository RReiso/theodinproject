require './enumerable'

numbers = [1, 2, 3, 4, 5]
hash = { A: 1, B: 2, C: 3 }

puts 'my_each vs. each'
numbers.my_each { |item| print "#{item} " }
puts
numbers.each { |item| print "#{item} " }
puts
hash.my_each { |key, value| puts "Key: #{key}, Value: #{value}" }
hash.each { |key, value| puts "Key: #{key}, Value: #{value}" }
puts

puts 'my_each_with_index vs. each_with_index'
numbers.my_each_with_index do |item, index|
  puts "item: #{item}, index: #{index}"
end
numbers.each_with_index { |item, index| puts "item: #{item}, index: #{index}" }
hash.my_each_with_index do |(key, value), i|
  puts "Key: #{key}, Value: #{value}, Index: #{i}"
end
hash.each_with_index do |(key, value), i|
  puts "Key: #{key}, Value: #{value}, Index: #{i}"
end
puts

puts 'my_select vs. select'
p numbers.my_select { |item| item.even? }
p numbers.select { |item| item.even? }
p hash.my_select { |_key, value| value > 1 }
p hash.select { |_key, value| value > 1 }
puts

puts 'my_all? vs. all?'
p numbers.my_all? { |item| item.even? }
p numbers.all? { |item| item.even? }
p hash.my_all? { |_key, value| value >= 1 }
p hash.all? { |_key, value| value >= 1 }
puts

puts 'my_any? vs. any?'
p numbers.my_any? { |item| item.even? }
p numbers.any? { |item| item.even? }
p hash.my_any? { |_key, value| value > 5 }
p hash.any? { |_key, value| value > 5 }
puts

puts 'my_none? vs. none?'
p numbers.my_none? { |item| item.even? }
p numbers.none? { |item| item.even? }
p hash.none? { |_key, value| value > 5 }
p hash.none? { |_key, value| value > 5 }
puts

puts 'my_count vs. count'
p numbers.my_count { |item| item.even? }
p numbers.count { |item| item.even? }
p hash.count { |_key, value| value > 1 }
p hash.count { |_key, value| value > 1 }
puts

puts 'my_map vs. map'
p numbers.my_map { |item| item.to_s + 'XX' }
p numbers.map { |item| item.to_s + 'XX' }
p hash.my_map { |k, v| [k, v.to_s] }.to_h
p hash.map { |k, v| [k, v.to_s] }.to_h
puts

puts 'my_inject vs. inject'
p numbers.my_inject(100) { |acc, el| acc + el }
p numbers.inject(100) { |acc, el| acc + el }
p hash.my_inject(100) { |acc, (_key, value)| acc + value }
p hash.inject(100) { |acc, (_key, value)| acc + value }
puts

def multiply_els(arr)
  arr.my_inject(1) { |product, item| product * item }
end
p multiply_els([2, 4, 5])

my_proc = Proc.new { |el| el * 100 }
p numbers.my_map(&my_proc)

# my_map can take a proc and a block as arguments, if both given, executes proc
p numbers.my_map(my_proc) { |el| el + 1 }
