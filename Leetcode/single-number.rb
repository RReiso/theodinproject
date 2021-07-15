#Given a non-empty array of integers nums, every element appears twice except for one.
#Find that single one.
def single_number(num)
  hash = num.tally #Returns a hash with the elements of the collection as keys and the corresponding counts as values.
  return hash.key(1)
end
puts single_number([4, 1, 2, 1, 2])

def single_number2(num)
  num.each { |n| return n if num.count(n) == 1 }
end
puts single_number2([1, 1, 2, 91, 2])

def single_number3(num)
  num.sort_by { |el| num.count(el) }[0]
end
puts single_number3([1, 1, 7, 2, 1, 2])

def single_number4(num)
  tally = num.each_with_object(Hash.new(0)) { |number, hash| hash[number] += 1 }
  tally.key(1)
end
puts single_number3([1, 1, 887, 2, 1, 2])

#bitwise solution works if the number of numbers that repeat are even
def single_num5(num)
  a = 0
  num.each { |i| a ^= i }
  a
end
puts single_num5([1, 1, 99, 2, 2, 1, 2, 1, 2])
