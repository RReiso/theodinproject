# Given an array nums containing n distinct numbers in the range [0, n],
# return the only number in the range that is missing from the array.
def missing_number(nums)
    count = 0
    nums.sort!.each do |num| 
        if count != num
            return count
        end
        count+=1
    end
    count
end
p missing_number([9,6,4,2,3,5,7,0,1])

def missing_number2(nums)
  (0..nums.size).to_a.sum - nums.sum # fast
  # (0..nums.size).inject(:+) - nums.sum # slower
  # (0..nums.size).sum - nums.sum # very slow
end
missing_number2([9,6,4,2,3,5,7,0,1])