# Given an integer array nums, move all 0's to the end of it
# while maintaining the relative order of the non-zero elements.
# Note that you must do this in-place without making a copy of the array.

def move_zeroes(nums) #runtime 56ms
  nums.size.times do |num|
    if nums[num] == 0
      nums[num] = nil
      nums.push(0)
    end
  end
  p nums.compact!
end

move_zeroes([0, 1, 0, 3, 12])
move_zeroes([0])

def move_zeroes2(nums) #runtime 68ms
  counter = 0
  nums.each { |num| counter += 1 if nums[num] == 0 }
  nums.delete(0)
  counter.times { nums.push(0) }
  p nums
end

move_zeroes2([0, 1, 0, 3, 12])
move_zeroes2([0, 0, 1])

def move_zeroes3(nums) #runtime 52ms but more memory
  num_of_zeroes = nums.tally.fetch(0, 0) # returns value for the key (first argument), if not found, returns second arg
  nums.delete(0)
  num_of_zeroes.times { nums.push(0) }
  p nums
end

move_zeroes3([0, 1, 0, 3, 12])
move_zeroes3([1])
