#Given a non-empty array of integers nums, every element appears twice except for one. 
#Find that single one.
def single_number(num)
  hash = num.tally #Returns a hash with the elements of the collection as keys and the corresponding counts as values.
  for key,value in hash
    return key if value == 1
  end
end
puts single_number([4,1,2,1,2])