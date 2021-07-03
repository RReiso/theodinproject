#Given a non-empty array of integers nums, every element appears twice except for one. 
#Find that single one.
def single_number(num)
  hash = num.tally #Returns a hash with the elements of the collection as keys and the corresponding counts as values.
  for key,value in hash
    return key if value == 1
  end
end
puts single_number([4,1,2,1,2])

def single_number2(num)
  num.each do |n|
    return n if num.count(n) == 1
  end
end
puts single_number2([1,1,2,91,2])

def single_number3(num)
  num.sort_by {|el| num.count(el)}[0]
end
puts single_number3([1,1,7,2,1,2])